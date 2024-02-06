#include "..\script_component.hpp"
/*
 * Author: johnb43
 * Sets the laser code on a laser source.
 *
 * Argument:
 * 0: Laser source <OBJECT>
 * 1: Laser code <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, 1111] call ace_laser_fnc_setLaserCode;
 *
 * Public: Yes
 */

params ["_laserSource", "_laserCode"];

_laserSource setVariable [QGVAR(code), _laserCode, true];
