/*
 * Author: commy2
 *
 * Sets a public variable, but wait a certain amount of time to transfer the value over the network. Changing the value by calling this function again resets the windup timer.
 *
 * Argument:
 * 0: Object the variable should be assigned to (Object)
 * 1: Name of the variable (String)
 * 2: Value of the variable (Any)
 * 3: Windup time (Number, optional. Default: 1)
 *
 * Return value:
 * Nothing.
 */
#include "script_component.hpp"

private ["_object", "_varName", "_value", "_sync"];

_object = _this select 0;
_varName = _this select 1;
_value = _this select 2;
_sync = _this select 3;

if (isNil "_sync") then {
    _sync = 1;
};

// set value locally
_object setVariable [_varName, _value];

// "duh"
if (!isMultiplayer) exitWith {};

// generate stacked eventhandler id
private "_idName";
_idName = format ["ACE_setVariablePublic_%1", _varName];

// when to push the value
private "_syncTime";
_syncTime = diag_tickTime + _sync;

// add eventhandler. should the value change, then overwrite the previous eventhandler
[_idName, "onEachFrame", {
    // wait to sync the variable
    if (diag_tickTime > _this select 3) then {
        // set value public
        (_this select 0) setVariable [_this select 1, _this select 2, true];

        // remove eventhandler
        [_this select 4, "onEachFrame"] call BIS_fnc_removeStackedEventHandler
    };
}, [_object, _varName, _value, _syncTime, _idName]] call BIS_fnc_addStackedEventHandler;
nil
