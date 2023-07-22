#include "script_component.hpp"
/*
 * Author: commy2
 * Drop a carried object.
 *
 * Arguments:
 * 0: Unit that carries the other object <OBJECT>
 * 1: Carried object to drop <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorTarget] call ace_dragging_fnc_dropObject_carry;
 *
 * Public: No
 */

params ["_unit", "_target", ["_tryLoad", false]];
TRACE_1("params",_this);

// remove drop action
[_unit, "DefaultAction", _unit getVariable [QGVAR(ReleaseActionID), -1]] call EFUNC(common,removeActionEventHandler);

private _inBuilding = [_unit] call FUNC(isObjectOnObject);
private _isClone = _target isKindOf QGVAR(clone);

// Drop cloned dead units
if (_isClone) then {
    _target = [_unit, _target, _inBuilding] call FUNC(dropClone);
};

// prevent collision damage
[QEGVAR(common,fixCollision), _unit] call CBA_fnc_localEvent;
[QEGVAR(common,fixCollision), _target, _target] call CBA_fnc_targetEvent;

// release object
detach _target;

// fix anim when aborting carrying persons
if (_target isKindOf "CAManBase" || {animationState _unit in CARRY_ANIMATIONS}) then {
    if (vehicle _unit == _unit && {!(_unit getVariable ["ACE_isUnconscious", false])}) then {
        [_unit, "", 2] call EFUNC(common,doAnimation);
    };

    if (_target getVariable ["ACE_isUnconscious", false]) then {
        [_target, "unconscious", 2] call EFUNC(common,doAnimation);
    } else {
        [_target, "", 2] call EFUNC(common,doAnimation);  //@todo
    };
};

// properly remove fake weapon
_unit removeWeapon "ACE_FakePrimaryWeapon";

// reselect weapon and re-enable sprint
private _previousWeaponIndex = _unit getVariable [QGVAR(previousWeapon), -1];
_unit setVariable [QGVAR(previousWeapon), nil, true];

if (_previousWeaponIndex != -1) then {
    _unit action ["SwitchWeapon", _unit, _unit, _previousWeaponIndex];
};

[_unit, "forceWalk", QUOTE(ADDON), false] call EFUNC(common,statusEffect_set);
[_unit, "blockSprint", QUOTE(ADDON), false] call EFUNC(common,statusEffect_set);
[_unit, "blockThrow", QUOTE(ADDON), false] call EFUNC(common,statusEffect_set);

// prevent object from flipping inside buildings
if (_inBuilding && {!_isClone}) then {
    _target setPosASL (getPosASL _target vectorAdd [0, 0, 0.05]);
    TRACE_2("setPos",getPosASL _unit,getPosASL _target);
};

_unit setVariable [QGVAR(isCarrying), false, true];
_unit setVariable [QGVAR(carriedObject), objNull, true];

// make object accesable for other units
[objNull, _target, true] call EFUNC(common,claim);

if !(_target isKindOf "CAManBase") then {
    [QEGVAR(common,fixPosition), _target, _target] call CBA_fnc_targetEvent;
    [QEGVAR(common,fixFloating), _target, _target] call CBA_fnc_targetEvent;
};

// recreate UAV crew
if (_target getVariable [QGVAR(isUAV), false]) then {
    createVehicleCrew _target;
};

// reset mass
private _mass = _target getVariable [QGVAR(originalMass), 0];

if (_mass != 0) then {
    [QEGVAR(common,setMass), [_target, _mass]] call CBA_fnc_globalEvent; // force global sync
};

// reset temp direction
_target setVariable [QGVAR(carryDirection_temp), nil];

// try loading into vehicle
if (_tryLoad && {!isNull cursorObject} && {([ACE_player, cursorObject, ["isNotCarrying"]] call EFUNC(common,canInteractWith))}) then {
    if (_target isKindOf "CAManBase") then {
        private _vehicles = [cursorObject, 0, true] call EFUNC(common,nearestVehiclesFreeSeat);
        if ([cursorObject] isEqualTo _vehicles) then {
            if (["ACE_Medical"] call EFUNC(common,isModLoaded)) then {
                [_unit, _target, cursorObject] call EFUNC(medical_treatment,loadUnit);
            } else {
                [_unit, _target, cursorObject] call EFUNC(common,loadPerson);
            };
        };
    } else {
        if (
            ["ace_cargo"] call EFUNC(common,isModLoaded) &&
            {[_target, cursorObject] call EFUNC(cargo,canLoadItemIn)}
        ) then {
            [player, _target, cursorObject] call EFUNC(cargo,startLoadIn);
        };
    };
};
