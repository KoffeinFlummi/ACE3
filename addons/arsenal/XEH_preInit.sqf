#include "script_component.hpp"
#include "defines.hpp"

#define TOOLS_TAB_ICON "\A3\ui_f\data\igui\cfg\actions\repair_ca.paa"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

#include "initSettings.inc.sqf"

// Arsenal events
[QGVAR(statsChangePage), LINKFUNC(buttonStatsPage)] call CBA_fnc_addEventHandler;
[QGVAR(displayStats), LINKFUNC(handleStats)] call CBA_fnc_addEventHandler;
[QGVAR(actionsChangePage), LINKFUNC(buttonActionsPage)] call CBA_fnc_addEventHandler;
[QGVAR(displayActions), LINKFUNC(handleActions)] call CBA_fnc_addEventHandler;

[QGVAR(filtersToggle), {
    params ["_display", "_showFilters"];

    private _filtersCtrlGroupCtrl = _display displayCtrl IDC_filtersBox;

    _filtersCtrlGroupCtrl ctrlShow (GVAR(showFilters) && {_showFilters});
}] call CBA_fnc_addEventHandler;

call FUNC(compileActions);
call FUNC(compileSorts);
call FUNC(compileStats);
call FUNC(compileFilters);

[QUOTE(ADDON), {!isNil QGVAR(camera)}] call CBA_fnc_registerFeatureCamera;

// Compatibility with CBA scripted optics and disposable framework
[QGVAR(displayOpened), {
    "CBA_optics_arsenalOpened" call CBA_fnc_localEvent;
    "CBA_disposable_arsenalOpened" call CBA_fnc_localEvent;
    EGVAR(common,blockItemReplacement) = true;
}] call CBA_fnc_addEventHandler;

[QGVAR(displayClosed), {
    "CBA_optics_arsenalClosed" call CBA_fnc_localEvent;
    "CBA_disposable_arsenalClosed" call CBA_fnc_localEvent;
    EGVAR(common,blockItemReplacement) = false;
}] call CBA_fnc_addEventHandler;

[QGVAR(cargoChanged), {
    params ["_display"];
    // Only update actions if necessary, this can get performance-intensive using the arrow keys
    if (!GVAR(updateActionsOnCargoChange)) exitWith {};
    private _actionInfo = [_display];
    _actionInfo append GVAR(actionInfo);
    [QGVAR(displayActions), _actionInfo] call CBA_fnc_localEvent;
}] call CBA_fnc_addEventHandler;

// Setup Tools tab
[keys (uiNamespace getVariable [QGVAR(configItemsTools), createHashMap]), LLSTRING(toolsTab), TOOLS_TAB_ICON, -1, true] call FUNC(addRightPanelButton);

ADDON = true;
