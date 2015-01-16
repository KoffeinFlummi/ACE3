/*
 * Author: commy2
 *
 * Get the turret index of a vehicles copilot.
 *
 * Argument:
 * 0: Vehicle type (String)
 *
 * Return value:
 * Turret index of the vehicles gunner. Empty array means no copilot position. (Array)
 */
#include "script_component.hpp"

private ["_vehicle", "_turrets", "_turret", "_config"];

_vehicle = _this select 0;

_turrets = [_vehicle] call FUNC(getTurrets);

_turret = [];
{
  _config = configFile >> "CfgVehicles" >> _vehicle;

  _config = [_config, _x] call FUNC(getTurretConfigPath);

  if (getNumber (_config >> "isCopilot") == 1 && {getNumber (_config >> "primaryGunner") != 1} && {getNumber (_config >> "primaryObserver") != 1}) exitWith {
    _turret = _x;
  };
} forEach _turrets;
_turret
