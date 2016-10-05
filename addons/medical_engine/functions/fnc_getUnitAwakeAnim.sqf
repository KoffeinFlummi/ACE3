/*
 * Author: commy2
 * Report awake animation of unit inside vehicle.
 *
 * Arguments:
 * 0: The unit <OBJECT>
 *
 * ReturnValue:
 * The animtaion <STRING>
 *
 * Example:
 * player call ace_medical_engine_fnc_getUnitAwakeAnim
 *
 * Public: no
 */
#include "script_component.hpp"

params ["_unit"];

private _vehicle = vehicle _unit;

// --- on foot
if (_vehicle isEqualTo _unit) exitWith {""};

// --- driver
private _config = configFile >> "CfgVehicles" >> typeOf _vehicle;

if (_unit == driver _vehicle) exitWith {
    getText (configFile >> "CfgMovesBasic" >> "ManActions" >> getText (_config >> "driverAction")) // return
};

// --- turret
private _turret = _unit call CBA_fnc_turretPath;

if !(_turret isEqualTo []) exitWith {
    private _turretConfig = [_vehicle, _turret] call CBA_fnc_getTurret;

    getText (configFile >> "CfgMovesBasic" >> "ManActions" >> getText (_turretConfig >> "gunnerAction")) // return
};

// --- cargo
private _cargoIndex = _vehicle getCargoIndex _unit;

if (_cargoIndex != -1) exitWith {
    getText (configFile >> "CfgMovesBasic" >> "ManActions" >> getArray (_config >> "cargoAction") select _cargoIndex) // return
};

// --- default
""
