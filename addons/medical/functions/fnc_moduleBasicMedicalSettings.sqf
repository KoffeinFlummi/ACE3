/*
 * Author: Glowbal
 * Module for adjusting the medical treatment settings
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

params ["_logic", "_units", "_activated"];

if !(_activated) exitWith {};

[_logic, QGVAR(medicSetting_basicEpi), "medicSetting_basicEpi"] call CFUNC(readSettingFromModule);
[_logic, QGVAR(useLocation_basicEpi), "useLocation_basicEpi"] call CFUNC(readSettingFromModule);
