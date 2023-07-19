#include "script_component.hpp"
/*
 * Author: commy2
 * Carry PFH
 *
 * Arguments:
 * 0: Arguments <ARRAY>
 *  0.0: Unit <OBJECT>
 *  0.1: Target <OBJECT>
 *  0.2: Timeout <NUMBER>
 * 1: PFEH Id <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [[player, cursorObject, 10], _idPFH] call ace_dragging_fnc_startCarryPFH;
 *
 * Public: No
 */

#ifdef DEBUG_ENABLED_DRAGGING
    systemChat format ["%1 startCarryPFH running", CBA_missionTime];
#endif

params ["_args", "_idPFH"];
_args params ["_unit", "_target", "_timeOut"];

// Handle aborting carry
if !(_unit getVariable [QGVAR(isCarrying), false]) exitWith {
    TRACE_4("carry false",_unit,_target,_timeOut,CBA_missionTime);
    _idPFH call CBA_fnc_removePerFrameHandler;
};

// Same as dragObjectPFH, checks if object is deleted or dead OR (target moved away from carrier (weapon disasembled))
if (!alive _target || {_unit distance _target > 10}) then {
    TRACE_4("dead/distance",_unit,_target,_timeOut,CBA_missionTime);
    [_unit, _target] call FUNC(dropObject_carry);

    _idPFH call CBA_fnc_removePerFrameHandler;
};

// Handle persons vs objects
if (_target isKindOf "CAManBase") then {
    if (CBA_missionTime > _timeOut) exitWith {
        TRACE_4("Start carry person",_unit,_target,_timeOut,CBA_missionTime);
        [_unit, _target] call FUNC(carryObject);

        _idPFH call CBA_fnc_removePerFrameHandler;
    };
} else {
    if (CBA_missionTime > _timeOut) exitWith {
        TRACE_4("timeout",_unit,_target,_timeOut,CBA_missionTime);
        _idPFH call CBA_fnc_removePerFrameHandler;

        // Drop if in timeout
        private _draggedObject = _unit getVariable [QGVAR(draggedObject), objNull];
        [_unit, _draggedObject] call FUNC(dropObject_carry);
    };

    // Wait for the unit to stand up
    if (stance _unit isEqualto "STAND") exitWith {
        TRACE_4("Start carry object",_unit,_target,_timeOut,CBA_missionTime);
        [_unit, _target] call FUNC(carryObject);

        _idPFH call CBA_fnc_removePerFrameHandler;
    };
};
