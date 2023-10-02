#include "..\script_component.hpp"
/*
 * Author: Glowbal
 * Assign a repair facility.
 *
 * Arguments:
 * 0: The module logic <OBJECT>
 * 1: Synchronized units <ARRAY>
 * 2: Activated <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [logic] call ace_repair_fnc_moduleAssignRepairFacility
 *
 * Public: No
 */

params ["_logic"];

if (!isNull _logic) then {
    private _list = _logic getVariable ["EnableList", ""];
    private _setting = _logic getVariable ["role", 0];

    [_list, "ACE_isRepairFacility", _setting, true] call EFUNC(common,assignObjectsInList);
    [synchronizedObjects _logic, "ACE_isRepairFacility", _setting, true] call EFUNC(common,assignObjectsInList);
 };
