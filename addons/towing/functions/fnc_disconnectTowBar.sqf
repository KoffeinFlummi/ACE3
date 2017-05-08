/*
 * Author: Jonpas
 * Disconnects the tow bar.
 *
 * Arguments:
 * 0: Target <OBJECT>
 * 1: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call ace_towing_fnc_disconnectTowBar
 *
 * Public: no
 */
#include "script_component.hpp"

params [["_target", objNull, [objNull]], ["_unit", objNull, [objNull]]];

private _connectingVehicle = _unit getVariable QGVAR(towConnecting);
private _towingVehicle = _target getVariable QGVAR(isTowed);
private _towedVehicle = _target getVariable QGVAR(isTowing);

if (!isNil "_connectingVehicle") exitWith {
    _unit setVariable [QGVAR(towConnecting), nil];
    _connectingVehicle setVariable [QGVAR(isTowing), nil, true];
};

// Vehicle being towed
if (!isNil "_towingVehicle") exitWith {
    _target setVariable [QGVAR(towState), nil, true];
    _target setVariable [QGVAR(isTowed), nil, true];
    _towingVehicle setVariable [QGVAR(isTowing), nil, true];
};

// Vehicle towing
if (!isNil "_towedVehicle") exitWith {
    _towedVehicle setVariable [QGVAR(towState), nil, true];
    _target setVariable [QGVAR(isTowing), nil, true];
    _towedVehicle setVariable [QGVAR(isTowed), nil, true];
}
