#include "script_component.hpp"
/*
 * Author: commy2
 * Check if unit can carry the object. Doesn't check weight.
 *
 * Arguments:
 * 0: Unit that should do the carrying <OBJECT>
 * 1: Object to carry <OBJECT>
 *
 * Return Value:
 * Can the unit carry the object? <BOOL>
 *
 * Example:
 * [player, cursorTarget] call ace_dragging_fnc_canCarry
 *
 * Public: No
 */

params ["_unit", "_target"];

if !([_unit, _target, []] call EFUNC(common,canInteractWith)) exitWith {false};

//#2644 - Units with injured legs cannot bear the extra weight of carrying an object
//The fireman carry animation does not slow down for injured legs, so you could carry and run
if ((_unit getHitPointDamage "HitLegs") >= 0.5) exitWith {false};

private _targetClass = typeOf _target;

// a static weapon has to be empty for dragging (ignore UAV AI)
if (
    _targetClass isKindOf "StaticWeapon"
    && {-1 < crew _target findIf {(getText (configFile >> "CfgVehicles" >> (typeOf _x) >> "simulation")) != "UAVPilot"}}
) exitWith {false};

alive _target
&& {vehicle _target == _target}
&& {_target getVariable [QGVAR(canCarry), false]}
&& {
    animationState _target in ["", "unconscious"]
    || {_target getVariable ["ACE_isUnconscious", false]}
    || {_target isKindOf "CAManBase" && {(_target getHitPointDamage "HitLegs") > 0.4}}
}
&& { // check max items without box
    -1 == ["WeaponHolder", "WeaponHolderSimulated"] findIf {_targetClass isKindOf _x}
    || {MAX_DRAGGED_ITEMS >= count (weaponCargo _target + magazineCargo _target + itemCargo _target)}
}
