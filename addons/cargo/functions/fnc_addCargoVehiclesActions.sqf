/*
 * Author: Dystopian
 * Create actions for nearest vehicles with cargo.
 *
 * Arguments:
 * 0: Target <OBJECT>
 * 1: Player <OBJECT>
 *
 * Return Value:
 * Children actions <ARRAY>
 *
 * Example:
 * [cursorObject, player] call ace_cargo_fnc_addCargoVehiclesActions
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_target", "_player"];

private _statement = {
    params ["_target", "_player", "_vehicle"];
    [_player, _target, _vehicle] call FUNC(startLoadIn);
};

private _vehicles = (nearestObjects [_player, GVAR(cargoHolderTypes), MAX_LOAD_DISTANCE]) select {
    private _hasCargoConfig = 1 == getNumber (configFile >> "CfgVehicles" >> typeOf _x >> QGVAR(hasCargo));
    private _hasCargoPublic = _x getVariable [QGVAR(hasCargo), false];
    (_hasCargoConfig || {_hasCargoPublic}) && {_x != _target}
};

[_vehicles, _statement, _target] call EFUNC(interact_menu,createVehiclesActions)
