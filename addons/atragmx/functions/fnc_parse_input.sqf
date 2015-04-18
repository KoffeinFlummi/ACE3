/*
 * Author: Ruthberg
 * Parses all input fields in the gun, atmosphere and target column and the result input fields
 *
 * Arguments:
 * Nothing
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * call ace_atragmx_parse_input
 *
 * Public: No
 */
#include "script_component.hpp"

GVAR(altitude) = -1000 max parseNumber(ctrlText 130030) min 20000;
GVAR(temperature) = -50 max parseNumber(ctrlText 130040) min 160;
GVAR(barometricPressure) = 0 max parseNumber(ctrlText 130050) min 1350;
GVAR(relativeHumidity) = (0 max parseNumber(ctrlText 130060) min 100) / 100;
if (GVAR(currentUnit) == 1) then {
    GVAR(altitude) = GVAR(altitude) * 0.3048;
    GVAR(temperature) = (GVAR(temperature) - 32) / 1.8;
    GVAR(barometricPressure) = GVAR(barometricPressure) * 33.86389;
};

GVAR(latitude) set [GVAR(currentTarget), -90 max Round(parseNumber(ctrlText 140000)) min 90];
GVAR(directionOfFire) set [GVAR(currentTarget), 0 max abs(Round(parseNumber(ctrlText 140010))) min 359];
GVAR(windSpeed1) set [GVAR(currentTarget), 0 max abs(parseNumber(ctrlText 140020)) min 50];
GVAR(windSpeed2) set [GVAR(currentTarget), 0 max abs(parseNumber(ctrlText 140021)) min 50];
GVAR(windDirection) set [GVAR(currentTarget), 1 max Round(parseNumber(ctrlText 140030)) min 12];
GVAR(inclinationAngle) set [GVAR(currentTarget), -60 max parseNumber(ctrlText 140040) min 60];
GVAR(targetSpeed) set [GVAR(currentTarget), 0 max abs(parseNumber(ctrlText 140050)) min 50];
GVAR(targetRange) set [GVAR(currentTarget), 0 max abs(parseNumber(ctrlText 140060)) min 4000];

private ["_boreHeight", "_bulletMass", "_bulletDiameter", "_airFriction", "_rifleTwist", "_muzzleVelocity", "_zeroRange"];
_boreHeight = parseNumber(ctrlText 120000);
_bulletMass = parseNumber(ctrlText 120010);
_bulletDiameter = parseNumber(ctrlText 120020);
if ((missionNamespace getVariable [QEGVAR(advanced_ballistics,enabled), false]) && (missionNamespace getVariable [QEGVAR(advanced_ballistics,AdvancedAirDragEnabled), false])) then {
    _airFriction = 0.1 max parseNumber(ctrlText 120030) min 2;
} else {
    _airFriction = parseNumber(ctrlText 120030) / -1000;
};
_rifleTwist = parseNumber(ctrlText 120040);
_muzzleVelocity = parseNumber(ctrlText 120050);
_zeroRange = parseNumber (ctrlText 120060);
if (GVAR(currentUnit) != 2) then {
    _boreHeight = _boreHeight * 2.54;
    _bulletMass = _bulletMass * 0.06479891;
    _bulletDiameter = _bulletDiameter * 10 * 2.54;
    _rifleTwist = _rifleTwist * 2.54;
    _muzzleVelocity = _muzzleVelocity / 3.2808399;
};
if (GVAR(currentUnit) == 1) then {
    _zeroRange = _zeroRange / 1.0936133;
};
_boreHeight = 0.1 max _boreHeight min 10;
_bulletMass = 1 max _bulletMass min 100;
_bulletDiameter = 1 max _bulletDiameter min 25;
_muzzleVelocity = 100 max _muzzleVelocity min 1400;
_zeroRange = 0 max _zeroRange min 1000;
GVAR(workingMemory) set [5, _boreHeight];
GVAR(workingMemory) set [12, _bulletMass];
GVAR(workingMemory) set [13, _bulletDiameter];
GVAR(workingMemory) set [14, _rifleTwist];
if ((missionNamespace getVariable [QEGVAR(advanced_ballistics,enabled), false]) && (missionNamespace getVariable [QEGVAR(advanced_ballistics,AdvancedAirDragEnabled), false])) then {
    GVAR(workingMemory) set [15, _airFriction];
} else {
    GVAR(workingMemory) set [4, _airFriction];
};
GVAR(workingMemory) set [1, _muzzleVelocity];
GVAR(workingMemory) set [2, _zeroRange];

private ["_elevationCur", "_windageCur", "_elevationScopeStep", "_windageScopeStep"];
_elevationCur = parseNumber(ctrlText 402);
_windageCur = parseNumber(ctrlText 412);

switch (GVAR(currentScopeUnit)) do {
    case 0: {
        _elevationCur = _elevationCur * 3.38;
        _windageCur = _windageCur * 3.38;
    };
    case 2: {
        _elevationCur = _elevationCur / 1.047;
        _windageCur = _windageCur / 1.047;
    };
    case 3: {
        _elevationScopeStep = (GVAR(workingMemory) select 7);
        _windageScopeStep = (GVAR(workingMemory) select 8);
        
        _elevationCur = _elevationCur * _elevationScopeStep;
        _windageCur = _windageCur * _windageScopeStep;
    };
};

GVAR(workingMemory) set [10, _elevationCur];
GVAR(workingMemory) set [11, _windageCur];

[] call FUNC(update_gun);
[] call FUNC(update_gun_ammo_data);
[] call FUNC(update_atmosphere);
[] call FUNC(update_atmo_env_data);
[] call FUNC(update_target);

[] call FUNC(store_user_data);
