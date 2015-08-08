/*
 * Author: commy2
 *
 * Sets a public object namespace variable that gets reset with the same value after respawn, so JIP clients keep the value.
 *
 * Arguments:
 * 0: Object <OBJECT>
 * 1: Variable name <STRING>
 * 2: Any value <ANY>
 *
 * Return Value:
 * None
 *
 * Public: No
 */
#include "script_component.hpp"

private ["_respawnVariables"];

params ["_unit", "_varName", "_value"];

_respawnVariables = _unit getVariable ["ACE_respawnVariables", []];

if !(_varName in _respawnVariables) then {
  _respawnVariables pushBack _varName;
  _unit setVariable ["ACE_respawnVariables", _respawnVariables, true];
};

_unit setVariable [_varName, _value, true];
