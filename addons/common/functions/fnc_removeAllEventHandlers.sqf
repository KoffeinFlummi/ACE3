/*
 * Author: Nou
 *
 * Remove all events of a certain event type.
 *
 * Argument:
 * 0: Event name (string)
 *
 * Return value:
 * None
 *
 * Public: No
 */
#include "script_component.hpp"
private ["_eventNames", "_eventFunctions", "_eventIndex"];

params ["_eventName"];
GVAR(events) params ["_eventNames", "_events"];
_eventFunctions = [];
_eventIndex = _eventNames find _eventName;
if (_eventIndex != -1) then {
    _events set [_eventIndex, []];
};
