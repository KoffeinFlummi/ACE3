/*
 * Author: commy2
 * Checks if the vehicles class already has the actions initialized, otherwise add all available repair options. Calleed from init EH.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [vehicle] call ace_repair_fnc_addRepairActions
 *
 * Public: No
 */

#include "script_component.hpp"

params ["_vehicle"];
TRACE_1("params", _vehicle);

private ["_type", "_initializedClasses", "_condition", "_statement", "_action", "_duplicateHitpointName", "_processedHitPoints", "_selectionName", "_hitPointsAddedNames", "_hitPointsAddedStrings", "_hitPointsAddedAmount"];

_type = typeOf _vehicle;

_initializedClasses = GETMVAR(GVAR(initializedClasses),[]);

// do nothing if the class is already initialized
if (_type in _initializedClasses) exitWith {};

// get all hitpoints and selections
(getAllHitPointsDamage _vehicle) params [["_hitPoints", []], ["_hitPointsSelections", []]];

if (_hitPoints isEqualTo []) exitWith {ACE_LOGERROR_1("No Hitpoints on %1", _type);};

// get hitpoints of wheels with their selections
([_vehicle] call FUNC(getWheelHitPointsWithSelections)) params ["_wheelHitPoints", "_wheelHitPointSelections"];

_hitPointsAddedNames = [];
_hitPointsAddedStrings = [];
_hitPointsAddedAmount = [];

_processedHitPoints = [];

// add repair events to this vehicle class
{
    _duplicateHitpointName = (_x in _processedHitPoints);
    _processedHitPoints pushBack _x;
    _selectionName = _hitPointsSelections select _forEachIndex;

    if (_x in _wheelHitPoints) then {
        // add wheel repair action

        if (_duplicateHitpointName) exitWith {TRACE_3("Duplicate Wheel",_x,_forEachIndex,_selectionName);}; //Wheels should always be unique
        if (isNil {_vehicle getHit _selectionName}) exitWith {TRACE_3("No Selection",_x,_forEachIndex,_selectionName);}; //Not a real hitpoint

        private ["_icon", "_selection", "_name", "_text"];

        // _icon = QUOTE(PATHTOF(ui\tire_ca.paa));
        _icon = "A3\ui_f\data\igui\cfg\actions\repair_ca.paa";
        _selection = _wheelHitPointSelections select (_wheelHitPoints find _x);

        // remove wheel action
        _name = format ["Remove_%1_%2", _forEachIndex, _x];
        _text = localize LSTRING(RemoveWheel);

        TRACE_5("Adding Wheel Actions",_name,_forEachIndex,_selectionName,_text,_selection);

        _condition = {[_this select 1, _this select 0, _this select 2 select 0, "RemoveWheel"] call DFUNC(canRepair)};
        _statement = {[_this select 1, _this select 0, _this select 2 select 0, "RemoveWheel"] call DFUNC(repair)};

        _action = [_name, _text, _icon, _statement, _condition, {}, [_x], _selection, 2] call EFUNC(interact_menu,createAction);
        [_type, 0, [], _action] call EFUNC(interact_menu,addActionToClass);

        // replace wheel action
        _name = format ["Replace_%1_%2", _forEachIndex, _x];
        _text = localize LSTRING(ReplaceWheel);

        _condition = {[_this select 1, _this select 0, _this select 2 select 0, "ReplaceWheel"] call DFUNC(canRepair)};
        _statement = {[_this select 1, _this select 0, _this select 2 select 0, "ReplaceWheel"] call DFUNC(repair)};

        _action = [_name, _text, _icon, _statement, _condition, {}, [_x], _selection, 2] call EFUNC(interact_menu,createAction);
        [_type, 0, [], _action] call EFUNC(interact_menu,addActionToClass);

    } else {
        // exit if the hitpoint is in the blacklist, e.g. glasses
        if (_x in IGNORED_HITPOINTS) exitWith {TRACE_3("Ignored Hitpoint",_x,_forEachIndex,_selectionName);};
        if (_x == "") exitWith {TRACE_3("Hitpoint Empty",_x,_forEachIndex,_selectionName);};
        if (isNil {_vehicle getHit _selectionName}) exitWith {TRACE_3("No Selection",_x,_forEachIndex,_selectionName);}; //Not a real hitpoint

        private ["_hitpointGroupConfig", "_inHitpointSubGroup", "_currentHitpoint"];

        // Get hitpoint groups if available
        _hitpointGroupConfig = configFile >> "CfgVehicles" >> _type >> QGVAR(hitpointGroups);
        _inHitpointSubGroup = false;
        if (isArray _hitpointGroupConfig) then {
            // Set variable if current hitpoint is in a sub-group (to be excluded from adding action)
            _currentHitpoint = _x;
            {
                {
                    if (_x == _currentHitpoint) exitWith {
                        _inHitpointSubGroup = true;
                    };
                } forEach (_x select 1);
            } forEach (getArray _hitpointGroupConfig);
        };

        // Exit if current hitpoint is in sub-group (only main hitpoints get actions)
        if (_inHitpointSubGroup) exitWith {TRACE_3("inHitpointSubGroup",_x,_forEachIndex,_selectionName);};

        // exit if the hitpoint is virtual
        if (isText (configFile >> "CfgVehicles" >> _type >> "HitPoints" >> _x >> "depends")) exitWith {TRACE_3("Depends",_x,_forEachIndex,_selectionName);};

        // add misc repair action
        private ["_name", "_icon", "_selection", "_customSelectionsConfig"];

        _name = format ["Repair_%1_%2", _forEachIndex, _x];

        // Find localized string and track those added for numerization
        ([_x, "%1", _x, [_hitPointsAddedNames, _hitPointsAddedStrings, _hitPointsAddedAmount]] call FUNC(getHitPointString)) params ["_text", "_trackArray"];
        _hitPointsAddedNames = _trackArray select 0;
        _hitPointsAddedStrings = _trackArray select 1;
        _hitPointsAddedAmount = _trackArray select 2;

        _icon = "A3\ui_f\data\igui\cfg\actions\repair_ca.paa";

        _selection = "";

        // Get custom position if available
        _customSelectionsConfig = configFile >> "CfgVehicles" >> _type >> QGVAR(hitpointPositions);
        if (isArray _customSelectionsConfig) then {
            // Loop through custom hitpoint positions array
            _currentHitpoint = _x;
            {
                _x params ["_hitpoint", "_position"];
                // Exit with supplied custom position when same hitpoint name found or print RPT error if it's invalid
                if (_hitpoint == _currentHitpoint) exitWith {
                    if (typeName _position == "ARRAY") exitWith {
                        _selection = _position; // Position in model space
                    };
                    if (typeName _position == "STRING") exitWith {
                        _selection = _vehicle selectionPosition _position; // Selection name
                    };
                    ACE_LOGERROR_3("Invalid custom position %1 of hitpoint %2 in vehicle %3.",_position,_hitpoint,_vehicle);
                };
            } forEach (getArray _customSelectionsConfig);
        };

        // If position still empty (not a position array or selection name) try extracting from model
        if (typeName _selection == "STRING" && {_selection == ""}) then {
            _selection = _vehicle selectionPosition _selectionName;
        };

        if (_x in TRACK_HITPOINTS) then {
            if (_duplicateHitpointName) exitWith {TRACE_3("Duplicate Track",_x,_forEachIndex,_selectionName);}; //Tracks should always be unique
            if (_x == "HitLTrack") then {
                _selection = [-1.75, 0, -1.75];
            } else {
                _selection = [1.75, 0, -1.75];
            };
            TRACE_5("Adding RepairTrack",_name,_forEachIndex,_selectionName,_text,_selection);
            _condition = {[_this select 1, _this select 0, _this select 2 select 0, "RepairTrack"] call DFUNC(canRepair)};
            _statement = {[_this select 1, _this select 0, _this select 2 select 0, "RepairTrack"] call DFUNC(repair)};
            _action = [_name, _text, _icon, _statement, _condition, {}, [_x], _selection, 4] call EFUNC(interact_menu,createAction);
            [_type, 0, [], _action] call EFUNC(interact_menu,addActionToClass);
        } else {
            TRACE_5("Adding MiscRepair",_name,_forEachIndex,_selectionName,_text,_selection);
            _condition = {[_this select 1, _this select 0, _this select 2 select 0, "MiscRepair"] call DFUNC(canRepair)};
            _statement = {[_this select 1, _this select 0, _this select 2 select 0, "MiscRepair"] call DFUNC(repair)};
            _action = [_name, _text, _icon, _statement, _condition, {}, [_forEachIndex], _selection, 5] call EFUNC(interact_menu,createAction);
            // Put inside main actions if no other position was found above
            if (_selection isEqualTo [0, 0, 0]) then {
                [_type, 0, ["ACE_MainActions", QGVAR(Repair)], _action] call EFUNC(interact_menu,addActionToClass);
            } else {
                [_type, 0, [], _action] call EFUNC(interact_menu,addActionToClass);
            };
        };
    };
} forEach _hitPoints;

_condition = {[_this select 1, _this select 0, "", "fullRepair"] call DFUNC(canRepair)};
_statement = {[_this select 1, _this select 0, "", "fullRepair"] call DFUNC(repair)};
_action = [QGVAR(fullRepair), localize LSTRING(fullRepair), "A3\ui_f\data\igui\cfg\actions\repair_ca.paa", _statement, _condition, {}, [], "", 4] call EFUNC(interact_menu,createAction);
[_type, 0, ["ACE_MainActions", QGVAR(Repair)], _action] call EFUNC(interact_menu,addActionToClass);

// set class as initialized
_initializedClasses pushBack _type;

SETMVAR(GVAR(initializedClasses),_initializedClasses);
