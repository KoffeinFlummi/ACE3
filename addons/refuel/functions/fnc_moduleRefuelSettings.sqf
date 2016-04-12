/*
 * Author: GitHawk
 * Module for adjusting the refuel settings.
 *
 * Arguments:
 * 0: The module logic <LOGIC>
 * 1: units <ARRAY>
 * 2: activated <BOOL>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

#include "script_component.hpp"

params ["_logic", "", ["_activated", false, [false]]];

if !(_activated) exitWith {};

[_logic, QGVAR(rate), "rate"] call CFUNC(readSettingFromModule);

diag_log text format ["[ACE]: Refuel Module Initialized with flow rate: %1", GVAR(rate)];
