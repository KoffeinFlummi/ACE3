#include "..\script_component.hpp"
/*
 * Author: PabstMirror
 * Set new waypoint of a drone
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Group <GROUP>
 * 2: Pos 2D <ARRAY>
 * 3: Type <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [v, group v, [2000,5000], "LOITER"] call ace_aircraft_fnc_droneSetWaypoint
 *
 * Public: No
 */

params ["_vehicle", "_group", "_pos", "_type", "_target"];
TRACE_4("droneSetWaypoint",_vehicle,_group,_pos,_type);

private _index = (currentWaypoint _group) min count waypoints _group;
private _waypoint = [_group, _index];
// Try to save attributes from existing waypoint
private _currentHeight = round ((waypointPosition _waypoint) select 2);
private _currentLoiterRadius = waypointLoiterRadius _waypoint;
private _currentLoiterType = waypointLoiterType _waypoint;

// Set pos to ATL
_pos set [
    2,
    [0, _currentHeight] select (_currentHeight >= 50)
];

// [_group] call CBA_fnc_clearWaypoints;
_waypoint = _group addWaypoint [_pos, 0];
if (_type == "FOLLOW" && {_target isKindOf "CAManBase" || (_target isKindOf "LandVehicle")}) then {
    if (_vehicle isKindOf "UGV_01_base_F") then { // Vanilla follow waypoint is broken for UGVs, requiring a workaround.
        _waypoint setWaypointType "HOLD";
        [{
            params ["_args", "_handle"];
            _args params ["_vehicle", "_group", "_waypoint", "_target"];

            if ( // Abort PFH if a new waypoint is created via UAV Terminal or ACE Interaction
                _waypoint select 1 != currentWaypoint _group || 
                {!alive _vehicle}
            ) exitWith {
                [_handle] call CBA_fnc_removePerFrameHandler;
            };

            _waypoint setWaypointPosition [(getPosASL _target), -1];
        }, 3, [_vehicle, _group, _waypoint, _target]] call CBA_fnc_addPerFrameHandler;
    } else {
        _waypoint setWaypointType _type;
        _waypoint waypointAttachVehicle _target;
    };
};

TRACE_3("",_currentHeight,_currentLoiterRadius,_currentLoiterType);
if (_currentHeight > 1) then { _vehicle flyInHeight _currentHeight; };
if (_currentLoiterRadius > 1) then { _waypoint setWaypointLoiterRadius _currentLoiterRadius; };
if (_currentLoiterType != "") then { _waypoint setWaypointLoiterType _currentLoiterType; };

_group setCurrentWaypoint _waypoint;
