#include "script_component.hpp"
/*
 * Author: Kingsley
 * Gets placeable object classnames and values.
 *
 * Arguments:
 * 0: Size <STRING>
 * 1: Get sub categories from preset[] config <BOOL> (default: true)
 *
 * Return Value:
 * Pairs of classnames and costs <ARRAY>
 *
 * Example:
 * ["small"] call ace_fortify_fnc_getPlaceableSet
 *
 * Public: No
 */

params ["_preset", ["_gatherSubCategories", true]];
TRACE_2("getPlaceableSet",_preset,_gatherSubCategories);

private _config = missionConfigFile >> "ACEX_Fortify_Presets" >> _preset;
if (!isClass _config) then {
    _config = configfile >> "ACEX_Fortify_Presets" >> _preset;
};
if (!isClass _config) exitWith {
    private _msg = format ["Could not find [%1]", _preset];
    ERROR_WITH_TITLE("Preset not found",_msg);
    []
};

private _objects = getArray (_config >> "objects");

// Attempt to filter bad input
_objects = _objects select {
    if ((_x  isEqualTypeParams ["", 0])) then {
        _x params [["_classname", "#", [""]], ["_cost", -1, [0]]];
        if (isClass (configFile >> "CfgVehicles" >> _classname)) then {
            true
        } else {
            ERROR_2("Preset [%1] - Classname does not exist",_preset,_classname);
        };
    } else {
        ERROR_2("Preset [%1] - Bad data in objects array %2",_preset,_x);
        false
    };
};

if (_gatherSubCategories) then {
    {
        private _category = _x;
        private _pObjects = [_category, false] call FUNC(getPlaceableSet);
        _pObjects apply { _x set [2, _category] };
        _objects append _pObjects;
    } forEach getArray (_config >> "presets");
};

_objects
