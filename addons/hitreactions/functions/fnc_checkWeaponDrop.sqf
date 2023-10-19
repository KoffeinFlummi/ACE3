#include "..\script_component.hpp"
/*
 * Author: KJW
 * Checks if unit should drop weapon based on projectile hit info
 *
 * Arguments:
 * 0: surfaceType <STRING>
 * 1: components <ARRAY>
 * 2: position <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * ["", [], [1,1,1]] call ACE_hitreactions_fnc_checkWeaponDrop
 *
 * Public: No
 */

params ["_surfaceType", "_components", "_position"];

if (!(_surfaceType isEqualTo "" && _components isEqualTo [])) exitWith {}; // Could be potential for edge cases here however couldn't find any from testing.

private _weapon = currentWeapon _unit;
private _unit = nearestObject [_pos, "CAManBase"];
private _thrownGun = _unit call ace_common_fnc_throwWeapon;
[
    {
        params ["_thrownGun", "_weapon", "_unit"];
        _unit action ["TakeWeapon", _thrownGun, _weapon];
    },
    [_thrownGun, _weapon, _unit],
    random [1,2,3]
] call CBA_fnc_waitAndExecute;
