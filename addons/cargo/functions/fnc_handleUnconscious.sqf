#include "script_component.hpp"
/*
 * Author: Smith
 * Handle unconsciousness.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [bob] call ace_cargo_fnc_handleUnconscious
 *
 * Public: No
*/

params ["_unit"];

if (!local _unit) exitWith {};

if (_unit getVariable [QGVAR(isDeploying), false]) then {
    [_unit] call FUNC(deployCancel);
};
