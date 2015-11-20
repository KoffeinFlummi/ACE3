/*
 * Author: commy2, SilentSpike
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

private ["_type", "_initializedClasses", "_condition", "_statement", "_action", "_processedHitPoints", "_hitPointsAddedNames", "_hitPointsAddedStrings", "_hitPointsAddedAmount"];

_type = typeOf _vehicle;

_initializedClasses = GETMVAR(GVAR(initializedClasses),[]);

// do nothing if the class is already initialized
if (_type in _initializedClasses) exitWith {};

// get all hitpoints and selections
(getAllHitPointsDamage _vehicle) params [["_hitPoints", []], ["_hitSelections", []]];

if (_hitSelections isEqualTo []) exitWith { ACE_LOGERROR_1("No hit selections (%1)", _type); };

// get hitpoints of wheels with their selections
([_vehicle] call FUNC(getWheelHitPointsWithSelections)) params ["_wheelHitPoints", "_wheelHitSelections"];

_hitPointsAddedNames = [];
_hitPointsAddedStrings = [];
_hitPointsAddedAmount = [];
_processedHitpoints = [];

{
    _selection = _x;
    _hitpoint = _hitPoints select _forEachIndex;

    if (_selection in _wheelHitSelections) then {
         // Wheels should always be unique
        if (_hitpoint in _processedHitpoints) exitWith {TRACE_3("Duplicate Wheel",_hitpoint,_forEachIndex,_selection);};

        _icon = "A3\ui_f\data\igui\cfg\actions\repair_ca.paa";

        // An action to remove the wheel is required
        _name = format ["Remove_%1_%2", _forEachIndex, _hitpoint];
        _text = localize LSTRING(RemoveWheel);
        TRACE_4("Adding Wheel Actions",_name,_forEachIndex,_selection,_text);
        _condition = {[_this select 1, _this select 0, _this select 2 select 0, "RemoveWheel"] call DFUNC(canRepair)};
        _statement = {[_this select 1, _this select 0, _this select 2 select 0, "RemoveWheel"] call DFUNC(repair)};
        _action = [_name, _text, _icon, _statement, _condition, {}, [_hitpoint], _selection, 2] call EFUNC(interact_menu,createAction);
        [_type, 0, [], _action] call EFUNC(interact_menu,addActionToClass);

        // An action to replace the wheel is required
        _name = format ["Replace_%1_%2", _forEachIndex, _selection];
        _text = localize LSTRING(ReplaceWheel);
        _condition = {[_this select 1, _this select 0, _this select 2 select 0, "ReplaceWheel"] call DFUNC(canRepair)};
        _statement = {[_this select 1, _this select 0, _this select 2 select 0, "ReplaceWheel"] call DFUNC(repair)};
        _action = [_name, _text, _icon, _statement, _condition, {}, [_hitpoint], _selection, 2] call EFUNC(interact_menu,createAction);
        [_type, 0, [], _action] call EFUNC(interact_menu,addActionToClass);
    } else {
        // Empty selections don't exist
        // Empty hitpoints don't contain enough information
        if (_selection isEqualTo "") exitWith {};
        if (_hitpoint isEqualTo "") exitWith {};

        // Associated hitpoints can be grouped via config to produce a single repair action
        _groupsConfig = configFile >> "CfgVehicles" >> _type >> QGVAR(hitpointGroups);
        if (isArray _groupsConfig) then {
            _childHitPoint = false;
            {
                {
                    if (_hitpoint == _x) exitWith {
                        _childHitPoint = true;
                    };
                } forEach (_x select 1);
            } forEach (getArray _groupsConfig);
        };
        // If the current selection is associated with a child hitpoint, then skip
        if (_childHitPoint) exitWith { TRACE_3("childHitpoint",_hitpoint,_forEachIndex,_selection); };

        // Find the action position
        _position = _vehicle selectionPosition [_selection,"HitPoints"];
        // Custom position can be defined via config for associated hitpoint
        _positionsConfig = configFile >> "CfgVehicles" >> _type >> QGVAR(hitpointPositions);
        if (isArray _positionsConfig) then {
            {
                _x params ["_hit", "_pos"];
                if (_hitpoint == _hit) exitWith {
                    if (typeName _pos == "ARRAY") exitWith {
                        _position = _pos; // Position in model space
                    };
                    if (typeName _pos == "STRING") exitWith {
                        _position = _vehicle selectionPosition [_pos,"HitPoints"]; // Selection name
                    };
                    ACE_LOGERROR_3("Invalid custom position %1 of hitpoint %2 in vehicle %3.",_position,_hitpoint,_type);
                };
            } forEach (getArray _positionsConfig);
        };

        // Prepair the repair action
        _name = format ["Repair_%1_%2", _forEachIndex, _selection];
        _icon = "A3\ui_f\data\igui\cfg\actions\repair_ca.paa";

        // Find localized string and track those added for numerization
        ([_hitpoint, "%1", _hitpoint, [_hitPointsAddedNames, _hitPointsAddedStrings, _hitPointsAddedAmount]] call FUNC(getHitPointString)) params ["_text", "_trackArray"];
        _hitPointsAddedNames = _trackArray select 0;
        _hitPointsAddedStrings = _trackArray select 1;
        _hitPointsAddedAmount = _trackArray select 2;

        if (_hitpoint in TRACK_HITPOINTS) then {
            // Tracks should always be unique
            if (_hitpoint in _processedHitpoints) exitWith {TRACE_3("Duplicate Track",_hitpoint,_forEachIndex,_selection);};
            if (_hitpoint == "HitLTrack") then {
                _position = [-1.75, 0, -1.75];
            } else {
                _position = [1.75, 0, -1.75];
            };
            TRACE_5("Adding RepairTrack",_name,_forEachIndex,_selection,_text,_position);
            _condition = {[_this select 1, _this select 0, _this select 2 select 0, "RepairTrack"] call DFUNC(canRepair)};
            _statement = {[_this select 1, _this select 0, _this select 2 select 0, "RepairTrack"] call DFUNC(repair)};
            _action = [_name, _text, _icon, _statement, _condition, {}, [_hitpoint], _position, 4] call EFUNC(interact_menu,createAction);
            [_type, 0, [], _action] call EFUNC(interact_menu,addActionToClass);
        } else {
            TRACE_5("Adding MiscRepair",_name,_forEachIndex,_selection,_text,_position);
            _condition = {[_this select 1, _this select 0, _this select 2 select 0, "MiscRepair"] call DFUNC(canRepair)};
            _statement = {[_this select 1, _this select 0, _this select 2 select 0, "MiscRepair"] call DFUNC(repair)};
            _action = [_name, _text, _icon, _statement, _condition, {}, [_forEachIndex], _position, 5] call EFUNC(interact_menu,createAction);
            // Put inside main actions if no other position was found above
            if (_position isEqualTo [0,0,0]) then {
                [_type, 0, ["ACE_MainActions", QGVAR(Repair)], _action] call EFUNC(interact_menu,addActionToClass);
            } else {
                [_type, 0, [], _action] call EFUNC(interact_menu,addActionToClass);
            };
        };

        _processedHitPoints pushBack _hitPoint;
    };
} forEach _hitSelections;

_condition = {[_this select 1, _this select 0, "", "fullRepair"] call DFUNC(canRepair)};
_statement = {[_this select 1, _this select 0, "", "fullRepair"] call DFUNC(repair)};
_action = [QGVAR(fullRepair), localize LSTRING(fullRepair), "A3\ui_f\data\igui\cfg\actions\repair_ca.paa", _statement, _condition, {}, [], "", 4] call EFUNC(interact_menu,createAction);
[_type, 0, ["ACE_MainActions", QGVAR(Repair)], _action] call EFUNC(interact_menu,addActionToClass);

// set class as initialized
_initializedClasses pushBack _type;

SETMVAR(GVAR(initializedClasses),_initializedClasses);
