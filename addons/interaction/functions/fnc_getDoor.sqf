/*
 * Author: commy2, Phyma
 * Find door.
 *
 * Arguments:
 * 0: Distance <NUMBER>
 *
 * Return Value:
 * House objects and door <ARRAY>
 * 0: House <OBJECT>
 * 1: Door Name <STRING>
 *
 * Example:
 * [player, target] call ace_interaction_fnc_getDoor
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_distance"];

private ["_position0", "_position1", "_intersections", "_house", "_door"];

_position0 = positionCameraToWorld [0, 0, 0];
_position1 = positionCameraToWorld [0, 0, _distance];

_intersections = lineIntersectsSurfaces [AGLToASL _position0, AGLToASL _position1, cameraOn, objNull, true, 1, "GEOM"];

if (_intersections isEqualTo []) exitWith {[objNull, ""]};

_house = _intersections select 0 select 2;

// shithouse is bugged
if (typeOf _house == "") exitWith {[objNull, ""]};

_intersections = [_house, "GEOM"] intersect [_position0, _position1];

_door = _intersections select 0 select 0;

if (isNil "_door") exitWith {[_house, ""]};

//Check if door is glass because then we need to find the proper location of the door so we can use it
if (["glass", _door] call BIS_fnc_inString) then {
    _door = [_distance, _house, _door] call FUNC(getGlassDoor);   
};

if (isNil "_door") exitWith {systemChat "Wrong"; [_house, ""]};

[_house, _door]
