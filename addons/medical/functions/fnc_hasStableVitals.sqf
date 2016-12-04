/*
* Author: Ruthberg
* Check if a unit has stable vitals (required to become conscious)
*
* Arguments:
* 0: The patient <OBJECT>
*
* Return Value:
* Has stable vitals <BOOL>
*
* Public: No
*/

#include "script_component.hpp"

params ["_unit"];

if (_unit getVariable [QGVAR(bloodVolume), DEFAULT_BLOOD_VOLUME] < BLOOD_VOLUME_CLASS_2_HEMORRHAGE) exitWith { false };
if (_unit getVariable [QGVAR(inCardiacArrest), false]) exitWith { false };

private _cardiacOutput = [_unit] call FUNC(getCardiacOutput);
private _bloodLoss = _unit call FUNC(getBloodLoss);
if (_bloodLoss > (BLOOD_LOSS_KNOCK_OUT_THRESHOLD * _cardiacOutput) / 2) exitWith { false };

private _bloodPressure = [_unit] call FUNC(getBloodPressure);
_bloodPressure params ["_bloodPressureL", "_bloodPressureH"];
if (_bloodPressureL < 50 || {_bloodPressureH < 60}) exitWith { false };

private _heartRate = (_unit getVariable [QGVAR(heartRate), 80]);
if (_heartRate < 40) exitWith { false };

true
