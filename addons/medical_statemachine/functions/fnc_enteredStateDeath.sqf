#include "script_component.hpp"
/*
 * Author: SilentSpike
 * Handles a unit reaching the point of death (calls for a status update).
 *
 * Arguments:
 * 0: The Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call ace_medical_statemachine_fnc_enteredStateDeath
 *
 * Public: No
 */

params ["_unit"];
if (isNull _unit || {!isNil {_unit getVariable QEGVAR(medical,causeOfDeath)}}) exitWith {};

//IGNORE_PRIVATE_WARNING ["_thisOrigin", "_thisTransition"]; // vars provided by CBA_statemachine
TRACE_4("enteredStateDeath",_this,_thisOrigin,_thisTransition,CBA_missionTime);

private _causeOfDeath = format ["%1:%2", _thisOrigin, _thisTransition];
private _instigator = _unit getVariable [QEGVAR(medical,lastInstigator), objNull];

[_unit, _causeOfDeath, _instigator] call EFUNC(medical_status,setDead);
