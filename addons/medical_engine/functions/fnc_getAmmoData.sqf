#include "script_component.hpp"
/*
 * Author: Salluci
 * Returns base damage value, cross-section, penetration factor, and expected muzzle velocity of a given round, either from a cache or by reading the ammo config.
 *
 * Arguments:
 * 0: Ammo <STRING>
 *
 * Return Value:
 * Base damage value, cross-section, penetration factor, muzzle velocity <ARRAY of NUMBER>
 *
 * Example:
 * ["B_556x45_Ball"] call ace_medical_engine_fnc_getAmmoHit
 *
 * Public: No
 */

params ["_ammo"];

private _return = GVAR(ammoCache) get _ammo;
if (isNil "_return") then {
    TRACE_1("Cache miss",_ammo);
    private _ammoConfig = configFile >> "CfgAmmo" >> _ammo;
    private _hit = getNumber (_ammoConfig >> "hit");
    private _caliber = (getNumber (_ammoConfig >> "caliber"));
    private _penFactor = _caliber * ARMOR_PENETRABILITY;
    private _typicalSpeed = getNumber (_ammoConfig >> "typicalSpeed");
    _return = [_hit, _caliber^(1/3), _penFactor, _typicalSpeed];
    GVAR(ammoCache) set [_ammo, _return];
};

_return // return
