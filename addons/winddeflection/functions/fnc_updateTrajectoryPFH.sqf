/*
 * Author: Glowbal, Ruthberg
 * Handles wind deflection for projectiles.
 *
 * Arguments:
 * 0: bullet - Object the event handler is assigned to <OBJECT>
 * 1: airFriction - air friction of the bullet <NUMBER>
 *
 * Return Value:
 * Nothing
 *
 * Example:
 *
 * Public: No
 */
// #define ENABLE_PERFORMANCE_COUNTERS
#include "script_component.hpp"

[{
    // BEGIN_COUNTER(pfeh);
    private["_accel", "_accelRef", "_bulletSpeed", "_bulletVelocity", "_deleted", "_deltaT", "_drag", "_dragRef", "_isWind", "_trueSpeed", "_trueVelocity"];

    params ["_args"];
    _args params ["_lastTime"];
    _deltaT = CBA_missionTime - _lastTime;
    _args set [0, CBA_missionTime];
    _deleted = 0;
    _isWind = (vectorMagnitude ACE_wind > 0);

    GVAR(trackedBullets) = GVAR(trackedBullets) select {
        _x params ["_bullet", "_airFriction"];

        _bulletVelocity = velocity _bullet;
        _bulletSpeed = vectorMagnitude _bulletVelocity;

        if ((!alive _bullet) || {(_bullet isKindOf "BulletBase") && {_bulletSpeed < 100}}) then {
            false
        } else {
            if (_isWind) then {
                _trueVelocity = _bulletVelocity vectorDiff ACE_wind;
                _trueSpeed = vectorMagnitude _trueVelocity;

                _dragRef = _deltaT * _airFriction * _bulletSpeed * _bulletSpeed;
                _accelRef = (vectorNormalized _bulletVelocity) vectorMultiply (_dragRef);
                _bulletVelocity = _bulletVelocity vectorDiff _accelRef;

                _drag = _deltaT * _airFriction * _trueSpeed;
                _accel = _trueVelocity vectorMultiply (_drag);
                _bulletVelocity = _bulletVelocity vectorAdd _accel;
            };
            _bullet setVelocity _bulletVelocity;
            true
        };
    };
    // END_COUNTER(pfeh);
}, GVAR(simulationInterval), [CBA_missionTime]] call CBA_fnc_addPerFrameHandler;
