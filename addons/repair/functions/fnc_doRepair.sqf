#include "..\script_component.hpp"
/*
 * Author: commy2
 * Called by repair action / progress bar. Raise events to set the new hitpoint damage.
 *
 * Arguments:
 * 0: Unit that does the repairing <OBJECT>
 * 1: Vehicle to repair <OBJECT>
 * 2: Selected hitPointIndex <NUMBER>
 * 3: Repair action classname <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [unit, vehicle, 6, "MiscRepair"] call ace_repair_fnc_doRepair
 *
 * Public: No
 */

params ["_unit", "_vehicle", "_hitPointIndex", "_action"];
TRACE_4("params",_unit,_vehicle,_hitPointIndex,_action);

// override minimum damage if doing full repair
private _postRepairDamageMin = [_unit, _action isEqualTo "fullRepair"] call FUNC(getPostRepairDamage);

(getAllHitPointsDamage _vehicle) params ["_allHitPoints"];
private _hitPointClassname = _allHitPoints select _hitPointIndex;
([_vehicle] call FUNC(getSelectionsToIgnore)) params ["", "_dependsIndexMap"];
private _repairedHitPoints = [];

// get current hitpoint damage
private _hitPointCurDamage = _vehicle getHitIndex _hitPointIndex;

// repair a max of 0.5, don't use negative values for damage
private _hitPointNewDamage = (_hitPointCurDamage - 0.5) max _postRepairDamageMin;

if (_hitPointNewDamage < _hitPointCurDamage) then {
    private _parentIndex = _dependsIndexMap get _hitPointIndex;
    if (isNil "_parentIndex") then {
        // raise event to set the new hitpoint damage
        TRACE_3("repairing main point",_vehicle,_hitPointIndex,_hitPointNewDamage);
        [QGVAR(setVehicleHitPointDamage), [_vehicle, _hitPointIndex, _hitPointNewDamage], _vehicle] call CBA_fnc_targetEvent;
        _hitPointCurDamage = _hitPointNewDamage;
    } else {
        // Fix damagable depends hitpoints with ignored parent (current hitpoint gets normalized)
        private _parentHitPointCurDamage = _vehicle getHitIndex _parentIndex;
        private _parentHitPointNewDamage = _parentHitPointCurDamage;
        if (_parentHitPointCurDamage > _postRepairDamageMin) then {
            _parentHitPointNewDamage = (_parentHitPointCurDamage - 0.5) max _postRepairDamageMin;
        };
        _repairedHitPoints pushBack _parentIndex;
        TRACE_4("Repairing depends and parent",_vehicle,_hitPointIndex,_parentIndex,_parentHitPointNewDamage);
        [QGVAR(setVehicleHitPointDamage), [_vehicle, _parentIndex, _parentHitPointNewDamage], _vehicle] call CBA_fnc_targetEvent;
        _hitPointCurDamage = _parentHitPointNewDamage;
    };
};

// Get hitpoint groups if available
private _hitPointGroupConfig = configOf _vehicle >> QGVAR(hitpointGroups);
if (isArray _hitPointGroupConfig) then {
    // Retrieve hitpoint subgroup if current hitpoint is main hitpoint of a group
    {
        _x params ["_masterHitPoint", "_subHitArray"];
        // Exit using found hitpoint group if this hitpoint is leader of any
        if (_masterHitPoint == _hitPointClassname) exitWith {
            {
                private _subHitPoint = _x;
                private _subHitIndex = _allHitPoints findIf {_x == _subHitPoint}; //convert hitpoint classname to index
                if (_subHitIndex == -1) then {
                    ERROR_2("Invalid hitpoint %1 in hitPointGroups of %2",_subHitPoint,_vehicle);
                } else {
                    if (_subHitIndex in _repairedHitPoints) then {
                        TRACE_2("Skipping repair, sub hitpoint already fixed in depends",_subHitIndex,_vehicle);
                    } else {
                        private _subPointCurDamage = _vehicle getHitIndex _hitPointIndex;
                        private _subPointNewDamage = (_subPointCurDamage - 0.5) max _postRepairDamageMin;
                        if (_subPointNewDamage < _subPointCurDamage) then {
                            TRACE_3("repairing sub point",_vehicle,_subHitIndex,_subPointNewDamage);
                            _repairedHitPoints pushBack _subHitIndex;
                            [QGVAR(setVehicleHitPointDamage), [_vehicle, _subHitIndex, _subPointNewDamage], _vehicle] call CBA_fnc_targetEvent;
                        };
                    };
                };
            } forEach _subHitArray;
        };
    } forEach (getArray _hitPointGroupConfig);
};

// display text message if enabled
if (GVAR(DisplayTextOnRepair)) then {
    // Find localized string
    private _textLocalized = localize ([LSTRING(RepairedHitPointFully), LSTRING(RepairedHitPointPartially)] select (_hitPointCurDamage > 0));
    private _textDefault = localize ([LSTRING(RepairedFully), LSTRING(RepairedPartially)] select (_hitPointCurDamage > 0));
    ([_hitPointClassname, _textLocalized, _textDefault] call FUNC(getHitPointString)) params ["_text"];

    // Display text
    [_text] call EFUNC(common,displayTextStructured);
};
