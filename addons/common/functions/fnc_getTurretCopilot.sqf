/*
 * Author: commy2
 * Get the turret index of a vehicles copilot.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 *
 * Return Value:
 * Vehicle Copilot Turret indecies <ARRAY>
 *
 * Public: No
 */
#include "script_component.hpp"

private ["_turrets", "_turret", "_config"];

params ["_vehicle"];

_turrets = allTurrets [_vehicle, true];

_turret = [];
{
    _config = configFile >> "CfgVehicles" >> typeOf _vehicle;

    _config = [_config, _x] call FUNC(getTurretConfigPath);

    if (getNumber (_config >> "isCopilot") == 1 && {getNumber (_config >> "primaryGunner") != 1} && {getNumber (_config >> "primaryObserver") != 1}) exitWith {
        _turret = _x;
    };
    true
} count _turrets;

_turret
