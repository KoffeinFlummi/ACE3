/*
 * Author: commy2
 *
 * Start the carrying process.
 *
 * Argument:
 * 0: Unit that should do the carrying (Object)
 * 1: Object to carry (Object)
 *
 * Return value:
 * NONE.
 */
#include "script_component.hpp"

private ["_unit", "_target"];

_unit = _this select 0;
_target = _this select 1;

// check weight
private "_weight";
_weight = [_target] call FUNC(getWeight);

if (_weight > GETMVAR(ACE_maxWeightCarry,1E11)) exitWith {
    [localize LSTRING(UnableToDrag)] call EFUNC(common,displayTextStructured);
};

private "_timer";
_timer = ACE_time + 5;

// handle objects vs persons
if (_target isKindOf "CAManBase") then {

    // add a primary weapon if the unit has none.
    if (primaryWeapon _unit == "") then {
        _unit addWeapon "ACE_FakePrimaryWeapon";
    };

    // select primary, otherwise the drag animation actions don't work.
    _unit selectWeapon primaryWeapon _unit;

    // move a bit closer and adjust direction when trying to pick up a person
    _target setDir (getDir _unit + 180);
    _target setPosASL (getPosASL _unit vectorAdd (vectorDir _unit));

    [_unit, "AcinPknlMstpSnonWnonDnon_AcinPercMrunSnonWnonDnon", 2, true] call EFUNC(common,doAnimation);
    [_target, "AinjPfalMstpSnonWrflDnon_carried_Up", 2, true] call EFUNC(common,doAnimation);

    _timer = ACE_time + 15;

} else {

    // select no weapon and stop sprinting
    _unit action ["SwitchWeapon", _unit, _unit, 99];
    [_unit, "AmovPercMstpSnonWnonDnon", 0] call EFUNC(common,doAnimation);

    [_unit, "isDragging", true] call EFUNC(common,setforceWalkStatus);

};

// prevent multiple players from accessing the same object
[_unit, _target, true] call EFUNC(common,claim);


// prevents draging and carrying at the same ACE_time
_unit setVariable [QGVAR(startCarrying), true, true];

// required for aborting animation
_unit setVariable [QGVAR(carriedObject), _target, true];

[FUNC(startCarryPFH), 0.2, [_unit, _target, _timer]] call CBA_fnc_addPerFrameHandler;
