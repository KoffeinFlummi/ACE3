/*
 * artillerytables.hpp
 * Author: PabstMirror
 */

#include <iomanip>
#include <future>
#include <sstream>

#include "artillerytables.hpp"


// Constants
static const double timeStep = 1.0 / 60;
static const double rangeSearchErrorMax = 0.001; // ratio * distance
static const double rangeSearchAngleConvergance = 0.000025;
static const double gravityABS = 9.8066;
static const ace::vector3<double> gravityAccl(0, 0, -1 * gravityABS);

// Globals:
std::vector<std::future<std::string>> fWorkers;
unsigned int getLineIndex = 0;

std::tuple<double, double, double> simulateShot(const double _fireAngleRad, const double _muzzleVelocity, const double _heightOfTarget, const double _crossWind, const double _tailWind, const double _temperature, const double _airDensity, double _airFriction) {
    // returns: dist traveled to the side (crosswind), dist traveled foward (headwind), time of flight
    // note: if shot never reaches height of target, then results are undefined (use negative)
    const double kCoefficient = -1.0 * _airDensity * _airFriction;
    const double powderEffects = (_airFriction) ? ((_temperature + 273.13) / 288.13 - 1) / 40 + 1 : 1.0;

    double currentTime = 0;
    ace::vector3<double> currentPosition(0, 0, 0);
    ace::vector3<double> lastPosition(currentPosition);
    ace::vector3<double> currentVelocity(0, powderEffects * _muzzleVelocity * cos(_fireAngleRad), powderEffects * _muzzleVelocity * sin(_fireAngleRad));
    const ace::vector3<double> wind(_crossWind, _tailWind, 0);

    while ((currentVelocity.z() > 0) || (currentPosition.z() >= _heightOfTarget)) {
        lastPosition = currentPosition;
        ace::vector3<double> apparentWind = wind - currentVelocity;
        ace::vector3<double> changeInVelocity = gravityAccl + apparentWind * (kCoefficient * apparentWind.magnitude());
        currentVelocity += changeInVelocity * timeStep;
        currentPosition += currentVelocity * timeStep;
        currentTime += timeStep;
    }

    const double lastCurrentRatio((_heightOfTarget - currentPosition.z()) / (lastPosition.z() - currentPosition.z()));
    ace::vector3<double> finalPos = lastPosition.lerp(currentPosition, lastCurrentRatio);

    return { finalPos.x(), finalPos.y(), currentTime };
}

std::tuple<double, double> findMaxAngle(const double _muzzleVelocity, const double _airFriction, const double _temperature, const double _density, const double _crosswind, const double _tailwind) {
    // retrns: angle that goes the furthest, max distance traveled
    if (_airFriction == 0) {
        return { M_PI_4, _muzzleVelocity * _muzzleVelocity / gravityABS };
    }
    // With air resitsnce, max distance angle won't be 45 degrees
    double bestAngle = M_PI_4;
    double bestDistance = -1;
    double testResultDist;
    for (double testAngle = M_PI_4; testAngle > 0; testAngle -= (M_PI_4 / 100.0)) {
        std::tie(std::ignore, testResultDist, std::ignore) = simulateShot(testAngle, _muzzleVelocity, 0, _crosswind, _tailwind, _temperature, _density, _airFriction);
        if (testResultDist > bestDistance) {
            bestAngle = testAngle;
            bestDistance = testResultDist;
        }
    }
    return { bestAngle, bestDistance };
}

std::tuple<double, double, double> simulateFindSolution(const double _rangeToHit, const double _heightToHit, const double _muzzleVelocity, const double _airFriction, const double _minElev, const double _maxElev, const bool _highArc, const double _temperature, const double _airDensity, const double _crosswind, const double _tailwind) {
    // returns: actual distance traveled, elevation, time of flight
    double searchMin = _minElev;
    double searchMax = _maxElev;

    if (!_airFriction) {
        // can do trivial ballistics physics to get angle, could compute tof as well, but run through sim once to ensure consistancy (uses positive value of g)
        double radicand = pow(_muzzleVelocity, 4) - gravityABS * (gravityABS * pow(_rangeToHit, 2) + 2 * _heightToHit * pow(_muzzleVelocity, 2));
        if ((!_rangeToHit) || (radicand < 0)) { // radican't
            return { -1, -1, -1 };
        }
        radicand = sqrt(radicand);
        double angleRoot = atan((pow(_muzzleVelocity, 2) + radicand) / (gravityABS * _rangeToHit));
        if ((angleRoot > _maxElev) || (angleRoot < _minElev)) {
            angleRoot = atan((pow(_muzzleVelocity, 2) - radicand) / (gravityABS * _rangeToHit));
        }
        if ((angleRoot > _maxElev) || (angleRoot < _minElev)) {
            return { -1, -1, -1 };
        };
        const double tof = _rangeToHit / (_muzzleVelocity * cos(angleRoot));
        return { _rangeToHit, angleRoot, tof };
    }


    int numberOfAttempts = 0;
    double resultDistance = -1;
    double resultTime = -1;
    double currentError = 9999;
    double currentElevation = -1;
    do {
        if (numberOfAttempts++ > 50) break; // for safetey, min/max should converge long before
        currentElevation = (searchMin + searchMax) / 2.0;
        std::tie(std::ignore, resultDistance, resultTime) = simulateShot(currentElevation, _muzzleVelocity, _heightToHit, _crosswind, _tailwind, _temperature, _airDensity, _airFriction);
        currentError = _rangeToHit - resultDistance;
        // printf("elev %f [%f, %f]range%f\n goes %f [%f]\n", currentElevation, searchMin, searchMax, (searchMax - searchMin), resultDistance, currentError);
        if ((currentError > 0) ^ (!_highArc)) {
            searchMax = currentElevation;
        } else {
            searchMin = currentElevation;
        }
    } while ((searchMax - searchMin) > rangeSearchAngleConvergance);

    // printf("[%f, %f] Actuall [%f] err [%f of %f]\n", _rangeToHit, _heightToHit, resultDistance, currentError, (_rangeToHit * rangeSearchErrorMax * (_highArc ? 1.0 : 2.0)));
    // On some low angle shots, it will really struggle to converge because of precision issues
    if ((abs(currentError) > (_rangeToHit * rangeSearchErrorMax * (_highArc ? 1.0 : 2.0)))) {
        return { -1, -1, -1 };
    }
    return { resultDistance, currentElevation, resultTime };
}

void writeNumber(std::stringstream & ss, double _num, const int _widthInt, const int _widthDec) {
    if ((_num < 0) && (_num > -0.05)) { // hard coded fix -0.0 rounding errors
        _num = 0;
    }
    if (_widthInt > 1) {
        ss << std::setfill('0');
    }
    ss << std::fixed << std::setw(_widthInt) << std::setprecision(_widthDec) << _num;
}

std::string simulateCalcRangeTableLine(const double _rangeToHit, const double _muzzleVelocity, const double _airFriction, const double _minElev, const double _maxElev, const bool _highArc) {
    double actualDistance, lineElevation, lineTimeOfFlight;
    std::tie(actualDistance, lineElevation, lineTimeOfFlight) = simulateFindSolution(_rangeToHit, 0, _muzzleVelocity, _airFriction, _minElev, _maxElev, _highArc, 15, 1, 0, 0);
    if (lineTimeOfFlight < 0) {
        return "";
    }
    double actualDistanceHeight, lineHeightElevation, lineHeightTimeOfFlight;
    std::tie(actualDistanceHeight, lineHeightElevation, lineHeightTimeOfFlight) = simulateFindSolution(_rangeToHit, -100, _muzzleVelocity, _airFriction, _minElev, _maxElev, _highArc, 15, 1, 0, 0);


    std::stringstream returnSS;

    returnSS << "[\"";
    writeNumber(returnSS, _rangeToHit, 0, 0);
    returnSS << "\",\"";
    writeNumber(returnSS, lineElevation * 3200.0 / M_PI, 0, 0);
    returnSS << "\",\"";

    if (lineHeightElevation > 0) {
        const double drElevAdjust = lineHeightElevation - lineElevation;
        const double drTofAdjust = lineHeightTimeOfFlight - lineTimeOfFlight;
        writeNumber(returnSS, drElevAdjust * 3200.0 / M_PI, 0, 0);
        returnSS << "\",\"";
        writeNumber(returnSS, drTofAdjust, 0, 1);
    } else {
        // low angle shots won't be able to adjust down further
        returnSS << "-\",\"-";
    }
    returnSS << "\",\"";
    writeNumber(returnSS, lineTimeOfFlight, 0, ((lineTimeOfFlight < 99.945) ? 1 : 0)); // round TOF when high
    returnSS << "\",\"";

    if (_airFriction) {
        // Calc corrections:
        double xOffset, yOffset;
        // Crosswind
        std::tie(xOffset, std::ignore, std::ignore) = simulateShot(lineElevation, _muzzleVelocity, 0, 10, 0, 15, 1, _airFriction);
        const double crosswindOffsetRad = atan2(xOffset, actualDistance) / 10;
        // Headwind
        std::tie(std::ignore, yOffset, std::ignore) = simulateShot(lineElevation, _muzzleVelocity, 0, 0, -10, 15, 1, _airFriction);
        const double headwindOffset = (actualDistance - yOffset) / 10;
        // Tailwind
        std::tie(std::ignore, yOffset, std::ignore) = simulateShot(lineElevation, _muzzleVelocity, 0, 0, 10, 15, 1, _airFriction);
        const double tailwindOffset = (actualDistance - yOffset) / 10;
        // Air Temp Dec
        std::tie(std::ignore, yOffset, std::ignore) = simulateShot(lineElevation, _muzzleVelocity, 0, 0, 0, 5, 1, _airFriction);
        const double tempDecOffset = (actualDistance - yOffset) / 10;
        // Air Temp Inc
        std::tie(std::ignore, yOffset, std::ignore) = simulateShot(lineElevation, _muzzleVelocity, 0, 0, 0, 25, 1, _airFriction);
        const double tempIncOffset = (actualDistance - yOffset) / 10;
        // Air Density Dec
        std::tie(std::ignore, yOffset, std::ignore) = simulateShot(lineElevation, _muzzleVelocity, 0, 0, 0, 15, 0.9, _airFriction);
        const double airDensityDecOffset = (actualDistance - yOffset) / 10;
        // Air Density Inc
        std::tie(std::ignore, yOffset, std::ignore) = simulateShot(lineElevation, _muzzleVelocity, 0, 0, 0, 15, 1.1, _airFriction);
        const double airDensityIncOffset = (actualDistance - yOffset) / 10;

        writeNumber(returnSS, crosswindOffsetRad * 3200.0 / M_PI, 1, 1);
        returnSS << "\",\"";
        writeNumber(returnSS, headwindOffset, 1, (abs(headwindOffset) > 9.949) ? 0 : 1);
        returnSS << "\",\"";
        writeNumber(returnSS, tailwindOffset, 1, (abs(tailwindOffset) > 9.949) ? 0 : 1);
        returnSS << "\",\"";
        writeNumber(returnSS, tempDecOffset, 1, (abs(tempDecOffset) > 9.949) ? 0 : 1);
        returnSS << "\",\"";
        writeNumber(returnSS, tempIncOffset, 1, (abs(tempIncOffset) > 9.949) ? 0 : 1);
        returnSS << "\",\"";
        writeNumber(returnSS, airDensityDecOffset, 1, (abs(airDensityDecOffset) > 9.949) ? 0 : 1);
        returnSS << "\",\"";
        writeNumber(returnSS, airDensityIncOffset, 1, (abs(airDensityIncOffset) > 9.949) ? 0 : 1);
        returnSS << "\"]";
    } else {
        returnSS << "-\",\"-\",\"-\",\"-\",\"-\",\"-\",\"-\"]"; // 7 dashes
    }
    return (returnSS.str());
}

std::tuple<double, double, double> simulateShotReverse(const double _velocityAngleRad, const double _velocityMagnitude, const double _heightAboveLaunch, const double _crossWind, const double _tailWind, const double _temperature, const double _airDensity, double _airFriction) {
    // returns: dist traveled to the side (crosswind), dist traveled foward (headwind), time of flight
    // note: if shot never reaches height of target, then results are undefined (use negative)
    const double kCoefficient = -1.0 * _airDensity * _airFriction;

    double currentTime = 0;
    ace::vector3<double> currentPosition(0, 0, _heightAboveLaunch);
    ace::vector3<double> earlierPosition(currentPosition);
    ace::vector3<double> currentVelocity(0, _velocityMagnitude * cos(_velocityAngleRad), _velocityMagnitude * sin(_velocityAngleRad));
    ace::vector3<double> earlierVelocity(currentVelocity);
    const ace::vector3<double> wind(_crossWind, _tailWind, 0);

    while ((currentVelocity.z() <= 0) || currentPosition.z() >= 0) {
        currentPosition = earlierPosition;
        currentVelocity = earlierVelocity;
        ace::vector3<double> apparentWind = wind - currentVelocity;
        ace::vector3<double> changeInVelocity = gravityAccl + (apparentWind * (kCoefficient * apparentWind.magnitude()));
        earlierVelocity = currentVelocity - (changeInVelocity * timeStep);
        earlierPosition = currentPosition - (earlierVelocity * timeStep);
        currentTime += timeStep;
    }

    const double lastCurrentRatio((currentPosition.z()) / (currentPosition.z() - earlierPosition.z()));
    ace::vector3<double> finalPos = earlierPosition.lerp(currentPosition, lastCurrentRatio);

    return {finalPos.x(), finalPos.y(), currentTime};
}

void __stdcall RVExtensionVersion(char* output, int outputSize) {
    strncpy(output, ACE_FULL_VERSION_STR, outputSize - 1);
}
void __stdcall RVExtension(char* output, int outputSize, const char* function) {
    if (!strcmp(function, "version")) {
        RVExtensionVersion(output, outputSize);
        return;
    }
    strncpy(output, "error - use args version of callExtension", outputSize - 1);
}
int __stdcall RVExtensionArgs(char* output, int outputSize, const char* function, const char** args, int argsCnt) {
    if (!strcmp(function, "version")) {
        RVExtensionVersion(output, outputSize);
        return 0;
    }

    if (!strcmp(function, "start")) {
        if (argsCnt != 5) { return -2; } // Error: not enough args
        const double muzzleVelocity = strtod(args[0], NULL);
        const double airFriction = strtod(args[1], NULL);
        double minElev = (M_PI / 180.0) * strtod(args[2], NULL);
        double maxElev = (M_PI / 180.0) * strtod(args[3], NULL);
        const bool highArc = !strcmp(args[4], "true");

        // Reset workers:
        fWorkers.clear();
        getLineIndex = 0;

        double bestAngle, bestDistance;
        std::tie(bestAngle, bestDistance) = findMaxAngle(muzzleVelocity, airFriction, 15, 1, 0, 0);

        minElev = std::max(minElev, 2 * (M_PI / 180.0)); // cap min to 2 degrees (negative elev might get messy)
        maxElev = std::min(maxElev, 88 * (M_PI / 180.0)); // cap max to 88 degrees (mk6)
        if (highArc) {
            minElev = std::max(minElev, bestAngle);
        } else {
            maxElev = std::min(maxElev, bestAngle);
        }
        const double loopStart = (bestDistance < 4000) ? 50 : 100;
        const double loopInc = (bestDistance < 5000) ? 50 : 100; // simplify when range gets high
        const double loopMaxRange = std::min(bestDistance, 30000.0); // with no air resistance, max range could go higher than 60km

        if (maxElev > minElev) { // don't bother if we can't hit anything (e.g. mortar in low mode)
            for (double range = loopStart; range < loopMaxRange; range += loopInc) {
                fWorkers.emplace_back(std::async(&simulateCalcRangeTableLine, range, muzzleVelocity, airFriction, minElev, maxElev, highArc));
            }
        }

        std::stringstream outputStr; // debug max distance and thead count
        outputStr << "[" << bestDistance << "," << fWorkers.size() << "]";
        strncpy(output, outputStr.str().c_str(), outputSize - 1);
        return 0;
    }

    if (!strcmp(function, "getline")) {
        // 1 = data on line, 2 - data not ready, 3 - done
        std::string result = "";
        std::future_status workerStatus;

        while (result.empty()) {
            if (getLineIndex >= fWorkers.size()) {
                return 3;
            }
            workerStatus = fWorkers[getLineIndex].wait_for(std::chrono::seconds(0));
            if (workerStatus != std::future_status::ready) {
                return 2;
            }
            result = fWorkers[getLineIndex].get();
            getLineIndex++;
        }
        strncpy(output, result.c_str(), outputSize - 1);
        return 1;
    }

    if (!strcmp(function, "simulateShot")) {
        if (argsCnt < 4) { return -2; }  // Error: not enough args
        const double fireAngleRad = strtod(args[0], NULL);
        const double heightOfTarget = strtod(args[1], NULL);
        const double muzzleVelocity = strtod(args[2], NULL);
        double airFriction = 0;
        double temperature = 15;
        double airDensity = 1;
        double crossWind = 0;
        double tailWind = 0;

        if (argsCnt > 3) { airFriction = strtod(args[3], 0); };
        if (argsCnt > 4) { temperature = strtod(args[4], 0); };
        if (argsCnt > 5) { airDensity = strtod(args[5], 0); };
        if (argsCnt > 6) { crossWind = strtod(args[6], 0); };
        if (argsCnt > 7) { tailWind = strtod(args[7], 0); };

        double finalPosX, finalPosY, timeOfFlight;
        std::tie(finalPosX, finalPosY, timeOfFlight) =
            simulateShot(fireAngleRad, muzzleVelocity, heightOfTarget, crossWind, tailWind, temperature, airDensity, airFriction);
        std::stringstream outputStr;
        outputStr << "[" << finalPosX << "," << finalPosY << "," << timeOfFlight << "]";
        strncpy(output, outputStr.str().c_str(), outputSize - 1);
        return 1;
    };

    if (!strcmp(function, "simulateShotReverse")) {
        if (argsCnt < 4) { return -2; }  // Error: not enough args
        const double velocityAngleRad = strtod(args[0], NULL);
        const double heightAboveLaunch = strtod(args[1], NULL);
        const double velocityMagnitude = strtod(args[2], NULL);
        double airFriction = 0;
        double temperature = 15;
        double airDensity = 1;
        double crossWind = 0;
        double tailWind = 0;

        if (argsCnt > 3) { airFriction = strtod(args[3], 0); };
        if (argsCnt > 4) { temperature = strtod(args[4], 0); };
        if (argsCnt > 5) { airDensity = strtod(args[5], 0); };
        if (argsCnt > 6) { crossWind = strtod(args[6], 0); };
        if (argsCnt > 7) { tailWind = strtod(args[7], 0); };

        double finalPosX, finalPosY, timeOfFlight;
        std::tie(finalPosX, finalPosY, timeOfFlight) =
            simulateShotReverse(velocityAngleRad, velocityMagnitude, heightAboveLaunch, crossWind, tailWind, temperature, airDensity, airFriction);
        std::stringstream outputStr;
        outputStr << "[" << finalPosX << "," << finalPosY << "," << timeOfFlight << "]";
        strncpy(output, outputStr.str().c_str(), outputSize - 1);
        return 1;
    };

    if (!strcmp(function, "findMaxAngle")) {
        if (argsCnt < 1) { return -2; }  // Error: not enough args
        const double muzzleVelocity = strtod(args[0], NULL);
        const double airFriction = strtod(args[1], NULL);
        double temperature = 15;
        double airDensity = 1;
        double crossWind = 0;
        double tailWind = 0;

        if (argsCnt > 2) { temperature = strtod(args[2], 0); };
        if (argsCnt > 3) { airDensity = strtod(args[3], 0); };
        if (argsCnt > 4) { crossWind = strtod(args[4], 0); };
        if (argsCnt > 5) { tailWind = strtod(args[5], 0); };


        double bestAngle, bestDistance;
        std::tie(bestAngle, bestDistance) =
            findMaxAngle(muzzleVelocity, airFriction, temperature, airDensity, crossWind, tailWind);
        std::stringstream outputStr;
        outputStr << "[" << bestAngle << "," << bestDistance << "]";
        strncpy(output, outputStr.str().c_str(), outputSize - 1);
        return 1;
    }

    if (!strcmp(function, "simulateFindSolution")) {
        if (argsCnt < 3) { return -2; }  // Error: not enough args
        const double rangeToHit = strtod(args[0], 0);
        const double heightToHit = strtod(args[1], 0); //relative to launch pos
        const double muzzleVelocity = strtod(args[2], 0);
        double airFriction = 0;
        bool highArc = true;
        double minElev = 0;  // 0 degrees in rad
        double maxElev = 1.5708;   // 90 degrees in rad
        double temperature = 15;
        double airDensity = 1;
        double crosswind = 0;
        double tailwind = 0;

        if (argsCnt > 3) { airFriction = strtod(args[3], 0); };
        if (argsCnt > 4) { highArc = !strcmp(args[4], "true"); };
        if (argsCnt > 5) { minElev = strtod(args[5], 0); };
        if (argsCnt > 6) { maxElev = strtod(args[6], 0); };
        if (argsCnt > 7) { temperature = strtod(args[7], 0); };
        if (argsCnt > 8) { airDensity = strtod(args[8], 0); };
        if (argsCnt > 9) { crosswind = strtod(args[9], 0); };
        if (argsCnt > 10) { tailwind = strtod(args[10], 0); };

        double resultDistance, resultElevation, timeOfFlight;

        std::tie(resultDistance, resultElevation, timeOfFlight) =
            simulateFindSolution(rangeToHit, heightToHit, muzzleVelocity, airFriction, minElev, maxElev, highArc, temperature, airDensity, crosswind, tailwind);

        std::stringstream outputStr;
        outputStr << "[" << resultDistance << "," << resultElevation << "," << timeOfFlight << "]";
        strncpy(output, outputStr.str().c_str(), outputSize - 1);
        return 1;
    };

    if (!strcmp(function, "getSolution")) {
        // 0 = no solution; 1 - solution get!
        if (argsCnt < 4) { return -2; } // Error: not enough args
        const double range = strtod(args[0], NULL);
        const double height = strtod(args[1], NULL);
        const double muzzleVel = strtod(args[2], NULL);
        const double airFriction = strtod(args[3], NULL);
        bool highArc = true;
        double crosswind = 0;
        double tailwind = 0;
        double temperature = 15; //15 default; deg C
        double airDensity = 1; //1 default; bar

        if (argsCnt > 4) { highArc = !strcmp(args[4], "true"); };
        if (argsCnt > 5) { crosswind = strtod(args[5], 0); };
        if (argsCnt > 6) { tailwind = strtod(args[6], 0); };
        if (argsCnt > 7) { temperature = strtod(args[7], 0); };
        if (argsCnt > 8) { airDensity = strtod(args[8], 0); };

        double solutionDistance, solutionElevation, solutionTimeOfFlight;
        std::tie(solutionDistance, solutionElevation, solutionTimeOfFlight) = simulateFindSolution(range, height, muzzleVel, airFriction, , 1.5708, highArc, temperature, airDensity, crosswind, tailwind);

        if (solutionDistance == -1) {
            strncpy(output, "[-1, -1, -1]", outputSize - 1); //this is without wind helping/hindering
            return 0;
        };

        double xSimulated, ySimulated,  timeOfFlight;
        double xOffset, yOffset, yCorrection;
        yCorrection = 0;

        std::tie(xSimulated, ySimulated, timeOfFlight) = simulateShot(solutionElevation, muzzleVel, height, crosswind, tailwind, temperature, airDensity, airFriction);
        xOffset = xSimulated;
        yOffset = range - ySimulated;
        yCorrection = yCorrection - yOffset;

        while (abs((solutionDistance + yOffset) - range) > 1) {
            std::tie(solutionDistance, solutionElevation, solutionTimeOfFlight) =
                simulateFindSolution(range + yCorrection, height, muzzleVel, airFriction, -1.5708, 1.5708, highArc, temperature, airDensity, crosswind, tailwind);
            std::tie(xSimulated, ySimulated, timeOfFlight) =
                simulateShot(solutionElevation, muzzleVel, height, crosswind, tailwind, temperature, airDensity, airFriction);
            xOffset = xSimulated;
            yOffset = range - ySimulated;
            yCorrection = yCorrection - yOffset;
        }

        double angleCorrection = -atan(xSimulated / ySimulated);

        // Solution Elevation, Solution Time of Flight, BearingCorrection
        std::stringstream outputStr;
        outputStr << "[" << solutionElevation << "," << timeOfFlight << "," << angleCorrection << "]";
        strncpy(output, outputStr.str().c_str(), outputSize - 1);
        return 1;
    };

    strncpy(output, "error - invalid function", outputSize - 1);
    return RETURN_INVALID_FUNCTION; // Error: function not valid
}
