/*
 * Author: KoffeinFlummi, esteldunedain, Ruthberg
 * Adjusts the flight path of the bullet according to the zeroing. Called from the unified fired EH only for local and non-local players on foot.
 *
 * Arguments:
 * None. Parameters inherited from EFUNC(common,firedEH)
 *
 * Return Value:
 * None
 *
 * Public: No
 */
#include "script_component.hpp"

//IGNORE_PRIVATE_WARNING ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_vehicle", "_gunner", "_turret"];
TRACE_10("firedEH:",_unit, _weapon, _muzzle, _mode, _ammo, _magazine, _projectile, _vehicle, _gunner, _turret);

private _adjustment = _unit getVariable [QGVAR(Adjustment), []];
if (_adjustment isEqualTo []) exitWith {};

private _weaponIndex = [_unit, currentWeapon _unit] call EFUNC(common,getWeaponIndex);
if (_weaponIndex < 0) exitWith {};

private _zeroing = +(_adjustment select _weaponIndex);
TRACE_1("Adjusting With",_zeroing);
if (_zeroing isEqualTo []) exitWith {};

// Convert zeroing from mils to degrees
_zeroing = _zeroing vectorMultiply 0.05625;

if (_ammo isKindOf "BulletBase") then {
    private _advancedBallistics = missionNamespace getVariable [QEGVAR(advanced_ballistics,enabled), false];
    private _boreHeight = GVAR(boreHeight) select _weaponIndex;
    private _oldZeroRange = currentZeroing _unit;
    private _newZeroRange = [_unit] call FUNC(getCurrentZeroRange);
    private _zeroCorrection = missionNamespace getVariable format[QGVAR(%1_%2_%3_%4_%5_%6_%7), _oldZeroRange, _newZeroRange, _boreHeight, _weapon, _ammo, _magazine, _advancedBallistics];
    if (isNil "_zeroCorrection") then {
         _zeroCorrection = [_oldZeroRange, _newZeroRange, _boreHeight, _weapon, _ammo, _magazine, _advancedBallistics] call FUNC(calculateZeroAngleCorrection);
    };
    _zeroing = _zeroing vectorAdd [0, 0, _zeroCorrection];
};

if (_zeroing isEqualTo [0, 0, 0]) exitWith {};

_zeroing params ["_elevation", "_windage", "_zero"];

[_projectile, _windage, _elevation + _zero, 0] call EFUNC(common,changeProjectileDirection);
