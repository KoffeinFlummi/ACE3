#include "script_component.hpp"
/*
 * Author: Brett Mayson
 * Places a flag in front of the player
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: Flag <STRING>
 *
 * Return Value:
 * Flag <OBJECT>
 *
 * Example:
 * [player, "ace_marker_flags_white"] call ace_marker_flags_placeFlag;
 *
 * Public: No
 */

params [["_unit", objNull, [objNull]], ["_flag", QGVAR(white), [""]]];

_unit removeItem _flag;
private _pos = _unit modelToWorld [0,1,0];
private _flag = _flag createVehicle _pos;
_flag setPos _pos;
[_unit, 'PutDown'] call ace_common_fnc_doGesture;
