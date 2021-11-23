#include "script_component.hpp"
/*
 * Author: Brett Mayson
 * Adds the child actions for placing flags
 *
 * Arguments:
 * 0: Player <OBJECT>
 *
 * Return Value:
 * Actions <ARRAY>
 *
 * Example:
 * [player] call ace_marker_flags_addActions
 *
 * Public: No
 */

params ["_unit"];

private _actions = [];

{
    _actions pushBack ([
        [
            _x,
            getText (configFile >> "CfgWeapons" >> _x >> "displayName"),
            "",
            {[_this select 0, _this select 2] call FUNC(placeFlag)},
            {true},
            {},
            _x
        ] call EFUNC(interact_menu,createAction),
        [],
        _unit
    ]);
} forEach (call FUNC(getFlags));

_actions
