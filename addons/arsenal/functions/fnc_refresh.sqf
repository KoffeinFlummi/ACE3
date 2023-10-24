#include "..\script_component.hpp"
#include "..\defines.hpp"
/*
 * Author: Brett Mayson, johnb43
 * Refreshes the arsenal to show external changes.
 *
 * Arguments:
 * 0: Update current and unique items lists <BOOL> (default: true)
 * 1: Update virtual items list <BOOL> (default: false)
 *
 * Return Value:
 * None
 *
 * Example:
 * call ace_arsenal_fnc_refresh
 *
 * Public: Yes
*/
params [["_updateItems", true, [true]], ["_updateVirtualItems", false, [false]]];

TRACE_2("",_updateItems,_updateVirtualItems);

// Don't execute in scheduled environment
if (canSuspend) exitWith {
    [{_this call FUNC(refresh)}, _this] call CBA_fnc_directCall;
};

if (_updateItems) then {
    // Update current item list
    call FUNC(updateCurrentItemsList);

    // This takes care of unique inventory items (arsenal doesn't have it whitelisted)
    if (!_updateVirtualItems) then {
        call FUNC(updateUniqueItemsList);
    };
};

private _virtualItems = GVAR(currentBox) getVariable QGVAR(virtualItems);
if (isNil "_virtualItems") exitWith {
    [LLSTRING(noVirtualItems), false, 5, 1] call EFUNC(common,displayText);
    // Delay a frame in case this is running on display open
    [{(findDisplay IDD_ace_arsenal) closeDisplay 0}] call CBA_fnc_execNextFrame;
};

if (_updateVirtualItems) then {
    GVAR(virtualItems) = +_virtualItems;
    call FUNC(updateVirtualItemsFlat);

    // Gotta update this regardless of condition to prevent desync
    call FUNC(updateUniqueItemsList);
};

// Don't refresh left panel if in loadout tab
if (!isNull findDisplay IDD_loadouts_display) exitWith {};

private _display = findDisplay IDD_ace_arsenal;

[_display, _display displayCtrl GVAR(currentLeftPanel), false] call FUNC(fillLeftPanel);
