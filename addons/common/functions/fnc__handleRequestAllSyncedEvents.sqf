/*
 * Author: jaynus
 *
 * Handles a server-side request for synchronization ALL events on JIP to a client.
 *
 * Arguments:
 * 0: client (object)
 *
 * Return value:
 * Event is successed (BOOLEAN)
 *
 * Public : No
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"
params ["_client"];

{
    private["_eventEntry", "_eventLog"];
    _eventEntry = HASH_GET(GVAR(syncedEvents),_x);
    _eventLog = _eventEntry select 1;

    ["SEH_s", _client, [_x, _eventLog] ] call FUNC(targetEvent);
} count (GVAR(syncedEvents) select 0);

true // Return
