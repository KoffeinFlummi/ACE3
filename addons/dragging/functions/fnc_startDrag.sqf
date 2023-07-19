#include "script_component.hpp"
/*
 * Author: commy2, PiZZADOX, Malbryn
 * Starts the dragging process.
 *
 * Arguments:
 * 0: Unit that should do the dragging <OBJECT>
 * 1: Object to drag <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject] call ace_dragging_fnc_startDrag;
 *
 * Public: No
 */

params ["_unit", "_target"];
TRACE_2("params",_unit,_target);

// Exempt from weight check if object has override variable set
if (!(_target getVariable [QGVAR(ignoreWeightDrag), false]) && {
    private _weight = _target call FUNC(getWeight);
    _weight > GETMVAR(ACE_maxWeightDrag,1E11)
}) exitWith {
    // Exit if object weight is over global var value
    [LLSTRING(UnableToDrag)] call EFUNC(common,displayTextStructured);
};

// Create clone for dead units
if (!alive _target) then {
    _target = _target call FUNC(createClone);
};

private _primaryWeapon = primaryWeapon _unit;

// Add a primary weapon if the unit has none
if !(GVAR(dragAndFire)) then {
    if (_primaryWeapon isEqualto "") then {
        _unit addWeapon "ACE_FakePrimaryWeapon";
        _primaryWeapon = "ACE_FakePrimaryWeapon";
    };

    _unit selectWeapon _primaryWeapon;
} else { // Making sure the unit is holding a primary weapon or handgun
    private _handgunWeapon = handgunWeapon _unit;

    if !(currentWeapon _unit in [_primaryWeapon, _handgunWeapon]) then {
        if (_primaryWeapon != "") then {
            // Use primary if possible
            _unit selectWeapon _primaryWeapon;
        } else {
            if (_handgunWeapon != "") then {
                // Use pistol if unit has no primary
                _unit selectWeapon _handgunWeapon;
            } else {
                // Add fake weapon if no weapons besides launcher are available
                _unit addWeapon "ACE_FakePrimaryWeapon";
                _unit selectWeapon "ACE_FakePrimaryWeapon";
            };
        };
    };
};

// Save the weapon so we can monitor if it changes
_unit setVariable [QGVAR(currentWeapon), currentWeapon _unit];

[_unit, "blockThrow", "ACE_dragging", true] call EFUNC(common,statusEffect_set);

// Prevent multiple players from accessing the same object
[_unit, _target, true] call EFUNC(common,claim);

// Can't play action that depends on weapon if it was added the same frame
if !(_unit call EFUNC(common,isSwimming)) then {
    [{
        private _unitWeapon = _this getVariable [QGVAR(currentWeapon), ""];

        if (_unitWeapon isKindOf ["Pistol", configFile >> "CfgWeapons"]) then {
            [_this, "ACE_dragWithPistol"] call EFUNC(common,doGesture);
        } else {
            [_this, "ACE_dragWithRifle"] call EFUNC(common,doGesture);
        };
    }, _unit] call CBA_fnc_execNextFrame;
};

// Move a bit closer and adjust direction when trying to pick up a person
if (_target isKindOf "CAManBase") then {
    [QEGVAR(common,setDir), [_target, getDir _unit + 180], _target] call CBA_fnc_targetEvent;
    _target setPosASL (getPosASL _unit vectorAdd (vectorDir _unit vectorMultiply 1.5));

    [_target, "AinjPpneMrunSnonWnonDb_grab", 2] call EFUNC(common,doAnimation);
};

// Prevents dragging and carrying at the same time
_unit setVariable [QGVAR(isDragging), true, true];

[FUNC(startDragPFH), 0.2, [_unit, _target, CBA_missionTime + 5]] call CBA_fnc_addPerFrameHandler;

// Disable collisions by setting the physx mass to almost zero
private _mass = getMass _target;

if (_mass > 1) then {
    _target setVariable [QGVAR(originalMass), _mass, true];
    [QEGVAR(common,setMass), [_target, 1e-12]] call CBA_fnc_globalEvent; // Force global sync
};
