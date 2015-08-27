/*
* Author: Glowbal
* Action for checking the blood pressure of the patient
*
* Arguments:
* 0: The medic <OBJECT>
* 1: The patient <OBJECT>
*
* Return Value:
* None
*
* Public: No
*/

#include "script_component.hpp"
params ["_caller", "_target"];
[[_caller, _target], QUOTE(DFUNC(actionCheckBloodPressureLocal)), _target] call EFUNC(common,execRemoteFnc); /* TODO Replace by event system */
