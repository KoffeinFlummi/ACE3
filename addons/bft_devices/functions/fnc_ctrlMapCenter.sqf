#include "script_component.hpp"
/*
 * Author: Gundy
 *
 * Description:
 *   Determine map center position of given map control
 *
 * Arguments:
 *   0: Map control to return map center coordinates for <OBJECT>
 *
 * Return Value:
 *   2D world coordinates of map control center <ARRAY>
 *
 * Example:
 *   [_ctrlScreen] call ace_bft_devices_fnc_ctrlMapCenter;
 *
 * Public: No
 */


params ["_ctrlScreen"];

private _ctrlPos = ctrlPosition _ctrlScreen;
private _ctrlPosCenter = [(_ctrlPos select 0) + ((_ctrlPos select 2) / 2),(_ctrlPos select 1) + ((_ctrlPos select 3) / 2)];

_ctrlScreen ctrlMapScreenToWorld _ctrlPosCenter
