#include "script_component.hpp"
/*
 * Author: Alganthe
 * Create the internal stat arrays when needed for the first time.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Public: No
*/

if (!isNil QGVAR(statsListLeftPanel)) exitWith {};

private _fnc_addToTabs = {
    params ["_tabsList", "_tabsToAddTo", "_sideString"];

    {
        private _currentTab = _tabsList select _x;
        private _availablePagesCount = {count _x < 5} count _currentTab;

        private _arrayToSave = +_finalArray;
        _arrayToSave set [0, ([_class, _sideString, [str _x, format ["0%1", _x]] select (_x < 10)] joinString "")];

        if (_availablePagesCount > 0) then {

            {
                if (count _x < 5) exitWith {
                    (_currentTab select _forEachIndex) append [_arrayToSave];
                };
            } forEach _currentTab;
        } else {
            _currentTab pushBack [_arrayToSave];
        };
    } forEach _tabsToAddTo;
};

private _fnc_sortLists = {
    params ["_tabsList"];

    {
        private _page = _x;
        {
            {
                reverse _x;
            } forEach _x;

            _x sort false;

            {
                reverse _x;
            } forEach _x;
        } forEach _page;
    } forEach _tabsList;
};

private _statsListLeftPanel = [
    [[]], // Primary 0
    [[]], // Handgun 1
    [[]], // Launcher 2
    [[]], // Uniform 3
    [[]], // Vests 4
    [[]], // Backpacks 5
    [[]], // Headgear 6
    [[]], // Goggles 7
    [[]], // NVGs 8
    [[]], // Binoculars 9
    [[]], // Map 10
    [[]], // GPS 11
    [[]], // Radio 12
    [[]], // Compass 13
    [[]]  // Watch 14
];

private _statsListRightPanel = [
    [[]], // Optics 0
    [[]], // Side accs 1
    [[]], // Muzzle 2
    [[]], // Bipod 3
    [[]], // Mag 4
    [[]], // Throw 5
    [[]], // Put 6
    [[]]  // Misc 7
];

//------------------------- Config handling
private _configEntries = "(getNumber (_x >> 'scope')) == 2" configClasses (configFile >> QGVAR(stats));

{
    private _finalArray = [];

    private _class = configName _x;
    private _stats = getArray (_x >> "stats");
    private _displayName = getText (_x >> "displayName");
    private _showBar = getNumber (_x >> "showBar") == 1;
    private _showText = getNumber (_x >> "showText") == 1;
    private _condition = getText (_x >> "condition");
    private _priority = getNumber (_x >> "priority");
    (getArray (_x >> "tabs")) params ["_leftTabsList", "_rightTabsList"];

    if (_condition != "") then {
        _condition = compile _condition;
    };

    _finalArray = ["", _stats, _displayName, [_showBar, _showText], [{}, {}, _condition], _priority];

    if (_showBar) then {
        (_finalArray select 4) set [0, compile (getText (_x >> "barStatement"))];
    };

    if (_showText) then {
        (_finalArray select 4) set [1, compile (getText (_x >> "textStatement"))];
    };

    TRACE_3("stats array", _finalArray, _leftTabsList, _rightTabsList);

    if (_leftTabsList isNotEqualTo []) then {
        [_statsListLeftPanel, _leftTabsList, "L"] call _fnc_addToTabs;
    };

    if (_rightTabsList isNotEqualTo []) then {
        [_statsListRightPanel, _rightTabsList, "R"] call _fnc_addToTabs;
    };
} forEach _configEntries;

[_statsListLeftPanel] call _fnc_sortLists;
[_statsListRightPanel] call _fnc_sortLists;

//------------------------- Config Handling

missionNamespace setVariable [QGVAR(statsListLeftPanel), _statsListLeftPanel];
missionNamespace setVariable [QGVAR(statsListRightPanel), _statsListRightPanel];
