#include "script_component.hpp"
/*
 * Author: Gundy
 *
 * Description:
 *   Calculate octant (i.e. "norht-west") from direction
 *
 * Arguments:
 *   0: Degree value to convert 0 to 360 <INTEGER>
 *
 * Return Value:
 *   Matching octant as either N, NE, E, SE, S, SW, W, NW <STRING>
 *
 * Example:
 *   [direction player] call ace_bft_devices_fnc_degreeToOctant;
 *
 * Public: No
 */


params ["_dir"];

private _octant = round (_dir / 45);

["N ","NE","E ","SE","S ","SW","W ","NW","N "] select _octant
