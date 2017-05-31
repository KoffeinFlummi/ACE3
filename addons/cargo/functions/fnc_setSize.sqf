/*
 * Author: SilentSpike
 * Set the cargo size of any object. Has global effect.
 * Adds the load action menu if necessary.
 * Negative size makes unloadable.
 *
 * Arguments:
 * 0: Object <OBJECT>
 * 1: Cargo size <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorTarget, 3] call ace_cargo_fnc_setSize
 *
 * Public: Yes
 */
#include "script_component.hpp"

// Only run this after the settings are initialized
if !(EGVAR(common,settingsInitFinished)) exitWith {
    EGVAR(common,runAtSettingsInitialized) pushBack [FUNC(setSize), _this];
};

params [
    ["_object",objNull,[objNull]],
    ["_size",nil,[0]] // Default can't be a number since all are valid
];

// Nothing to do here
if (
    (isNil "_size") ||
    {isNull _object} ||
    {_size == _object getVariable [QGVAR(size), CARGO_SIZE(typeOf _object)]}
) exitWith {};

// Apply new size globally if specified
// Necessary to update value, even if unloadable, as API could be used again
_object setVariable [QGVAR(canLoad), _size >= 0, _global];
_object setVariable [QGVAR(size), _size, _global];

// If no size no need for load action
if (_size < 0) exitWith {};

// If an existing ID is present, load action has already been added globally
private _jipID = _object getVariable QGVAR(setSize_jipID);

// Actions should be added to all future JIP players too
if (isNil "_jipID") then {
    _jipID = [QGVAR(initObject), [_object]] call CBA_fnc_globalEventJIP;

    // Store the ID for any future calls to this function
    _object setVariable [QGVAR(setSize_jipID), _jipID, true];
};
