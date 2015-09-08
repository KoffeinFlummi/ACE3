/*
 * Author: commy2
 * Add an addAction event to a unit. Used to handle multiple addAction events and add a action to the mouse wheel menu. Global arguments, local effects. Does only work for player controlled units.
 *
 * Arguments:
 * 0: Unit the action should be assigned to <OBJECT>
 * 1: Menu title of the action <STRING>
 * 2: Name of the action, e.g. "DefaultAction" <STRING>
 * 3: Condition <CODE, STRING>
 * 4: Code to execute by the action <CODE, STRING>
 * 5: Condition for the menu action <CODE, STRING>
 * 6: Code to execute from the menu <CODE, STRING>
 * 7: Priority of the action (default: 0) <NUMBER>
 *
 * Return Value:
 * ID of the action (used to remove it later) <NUMBER>
 *
 * Public: No
 */
#include "script_component.hpp"

private ["_name", "_actionsVar", "_id", "_actionIDs", "_actions", "_nameVar", "_addAction", "_actionID"];

params ["_unit", "_displayName", "_action", "_condition", "_statement", "_condition2", "_statement2", "_priority"];

if (isNil "_priority") then {_priority = 0};

if (typeName _condition == "STRING") then {
    _condition = compile _condition;
};

if (typeName _statement == "STRING") then {
    _statement = compile _statement;
};

if (typeName _condition2 == "STRING") then {
    _condition2 = compile _condition2;
};

if (typeName _statement2 == "STRING") then {
    _statement2 = compile _statement2;
};

_name = format ["ACE_ActionMenu_%1", _action];

_actionsVar = _unit getVariable [_name, [-1, [], []]];

_actionsVar params ["_id", "_actionIDs", "_actions"];
_id = _id + 1;

_nameVar = format ["%1_ID%2", _name, _id];
missionNamespace setVariable [_nameVar, [_condition, _statement, _condition2, _statement2]];

_actionIDs pushBack _id;

_addAction = call compile format [
    "[
      '%2',
      {if (inputAction '%1' == 0) then {if (_this call (%3 select 2)) then {_this call (%3 select 3)}} else {_this call (%3 select 1)}},
      nil,
      %4,
      false,
      true,
      '%1',
      ""if (_this != ACE_player || {vehicle _this != _target}) exitWith {false}; [_target, _this] call (%3 select 0)""
    ]",
    _action,
    _displayName,
    _nameVar,
    _priority
];

_actionID = _unit addAction _addAction;

_actions pushBack [_actionID, _nameVar];

_unit setVariable [_name, [_id, _actionIDs, _actions], false];

_id
