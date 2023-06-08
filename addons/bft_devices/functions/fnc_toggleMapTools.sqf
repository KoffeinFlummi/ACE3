#include "script_component.hpp"
/*
 * Author: Gundy
 *
 * Description:
 *   Toggle drawing of map tools
 *
 * Arguments:
 *   0: Interface ID <STRING>
 *
 * Return Value:
 *   Draw map tools <BOOL>
 *
 * Example:
 *   _drawMapTools = ["interfaceID"] call ace_bft_devices_fnc_toggleMapTools;
 *
 * Public: No
 */


params ["_interfaceID"];

private _newMapTools = !([_interfaceID, "mapTools"] call FUNC(getSettings));
[_interfaceID, [["mapTools", _newMapTools]]] call FUNC(setSettings);

_newMapTools
