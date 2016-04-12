/*
 * Author: Glowbal, Ruthberg
 * Module for adjusting the wind deflection settings
 *
 * Arguments:
 * 0: The module logic <LOGIC>
 * 1: units <ARRAY>
 * 2: activated <BOOL>
 *
 * Return Value:
 * None <NIL>
 *
 * Example:
 * [module, [], true] call ace_weather_fnc_initModuleSettings
 *
 * Public: No
 */

#include "script_component.hpp"

params ["_logic", "_units", "_activated"];

if !(_activated) exitWith {};

// Control server side weather propagation
[_logic, QGVAR(enableServerController), "enableServerController"] call CFUNC(readSettingFromModule);

// Overrides the default weather (editor, mission settings) with ACE weather (map based)
[_logic, QGVAR(useACEWeather), "useACEWeather"] call CFUNC(readSettingFromModule);

// Control client side weather effects
[_logic, QGVAR(syncRain), "syncRain"] call CFUNC(readSettingFromModule);
[_logic, QGVAR(syncWind), "syncWind"] call CFUNC(readSettingFromModule); // Wind, Gusts, Waves
[_logic, QGVAR(syncMisc), "syncMisc"] call CFUNC(readSettingFromModule); // Lightnings, Rainbow, Fog

// Server weather update interval
[_logic, QGVAR(serverUpdateInterval), "serverUpdateInterval"] call CFUNC(readSettingFromModule);

GVAR(serverUpdateInterval) = 1 max GVAR(serverUpdateInterval) min 600;
