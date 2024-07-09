#include "..\script_component.hpp"
/*
 * Author: commy2, johnb43
 * Puts weapon on safety, or take it off safety if safety is already put on.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Weapon <STRING>
 * 2: Muzzle <STRING>
 * 3: Show hint <BOOL> (default: true)
 *
 * Return Value:
 * None
 *
 * Example:
 * [ACE_player, currentWeapon ACE_player, currentMuzzle ACE_player] call ace_safemode_fnc_lockSafety
 *
 * Public: No
 */

params ["_unit", "_weapon", "_muzzle", ["_hint", true]];

private _safedWeapons = _unit getVariable QGVAR(safedWeapons);

if (isNil "_safedWeapons") then {
    _safedWeapons = createHashMap;

    _unit setVariable [QGVAR(safedWeapons), _safedWeapons];
};

// See if the current weapon has locked muzzled
private _safedWeaponMuzzles = _safedWeapons getOrDefault [_weapon, createHashMap, true];

// If muzzle is locked, unlock it (toggle)
if (_muzzle in _safedWeaponMuzzles) exitWith {
    [_unit, _weapon, _muzzle, _hint] call FUNC(unlockSafety);
};

private _firemode = (_unit weaponState _muzzle) select 2;

// This syntax of selectWeapon doesn't mess with gun lights and lasers
_unit selectWeapon [_weapon, _muzzle, _firemode];

// Store new muzzle & firemode
_safedWeaponMuzzles set [_muzzle, _firemode];

// Lock muzzle
if (isNil {_unit getVariable QGVAR(actionID)}) then {
    _unit setVariable [QGVAR(actionID), [
        _unit, "DefaultAction", {
            params ["", "_unit"];

            if (
                _unit call CBA_fnc_canUseWeapon && {
                    (weaponState _unit) params ["_currentWeapon", "_currentMuzzle"];

                    // Block firing the muizzle in safe mode
                    if (_currentMuzzle in ((_unit getVariable [QGVAR(safedWeapons), createHashMap]) getOrDefault [_currentWeapon, createHashMap])) then {
                        if (inputAction "nextWeapon" > 0 || {inputAction "prevWeapon" > 0}) exitWith {
                            [_unit, _currentWeapon, _currentMuzzle] call FUNC(unlockSafety);

                            false
                        };

                        true
                    } else {
                        false
                    }
                }
            ) then {
                // Player hud
                false call FUNC(setSafeModeVisual);

                true
            } else {
                // Player hud
                true call FUNC(setSafeModeVisual);

                false
            };
        }, {}
    ] call EFUNC(common,addActionEventHandler)];
};

// Play fire mode selector sound
[_unit, _weapon, _muzzle] call FUNC(playChangeFiremodeSound);

// Show info box unless disabled
if (_hint) then {
    [LLSTRING(PutOnSafety), getText (configFile >> "CfgWeapons" >> _weapon >> "picture")] call EFUNC(common,displayTextPicture);
};
