#include "script_component.hpp"
/*
 * Author: commy2, Dystopian
 * Check if unit can drag the object. Doesn't check weight.
 *
 * Arguments:
 * 0: Unit that should do the dragging <OBJECT>
 * 1: Object to drag <OBJECT>
 *
 * Return Value:
 * Can the unit drag the object? <BOOL>
 *
 * Example:
 * [player, cursorTarget] call ace_dragging_fnc_canDrag
 *
 * Public: No
 */

params ["_unit", "_target"];

if !(alive _target && {_target getVariable [QGVAR(canDrag), false]} && {isNull objectParent _target}) exitWith {false};

if !([_unit, _target, ["isNotSwimming"]] call EFUNC(common,canInteractWith)) exitWith {false};

// Static weapons need to be empty for dragging (ignore UAV AI)
if (_target isKindOf "StaticWeapon") exitWith {
    crew _target findIf {getText (configOf _x >> "simulation") != "UAVPilot"} == -1
};

// Units need to be unconscious or be limping
if (_target isKindOf "CAManBase") exitWith {
    lifeState _target isEqualTo "INCAPACITATED"
    || {_target getHitPointDamage "HitLegs" > 0.4}
};

// Check max items for WeaponHolders
if (["WeaponHolder", "WeaponHolderSimulated"] findIf {_target isKindOf _x} != -1) exitWith {
    (count (weaponCargo _target + magazineCargo _target + itemCargo _target)) <= MAX_DRAGGED_ITEMS
};

true // return
