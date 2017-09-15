/*
 * Author: GitHawk
 * Reads the fuel counter.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Fuel Source <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, fuelTruck] call ace_refuel_fnc_readFuelCounter
 *
 * Public: No
 */
#include "script_component.hpp"

params [["_unit", objNull, [objNull]], ["_source", objNull, [objNull]]];

private _currentFuel = [_source] call FUNC(getFuel);
if (_currentFuel == REFUEL_INFINITE_FUEL) then {
    private _fuelCounter = 0.01 * round (100 * (_source getVariable [QGVAR(fuelCounter), 0]));
    [[LSTRING(Hint_FuelCounter), _fuelCounter], 1.5, _unit] call EFUNC(common,displayTextStructured);
} else {
    private _fuelCounter = 0.01 * round (100 * ((_source getVariable [QGVAR(fuelCounter), _currentFuel]) - _currentFuel));
    [[LSTRING(Hint_FuelCounter), _fuelCounter], 1.5, _unit] call EFUNC(common,displayTextStructured);
};
