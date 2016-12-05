/*
 * Author: PabstMirror
 * Interface to allow external modules to affect the pain level
 *
 * Arguments:
 * 0: The patient <OBJECT>
 * 1: Desired pain level (0 .. 1) <NUMBER>
 *
 * Return Value:
 * nothing
 *
 * Example:
 * [guy, 0.5] call ace_medical_fnc_adjustPainLevel
 *
 * Public: Yes
 */
#include "script_component.hpp"

params ["_unit", "_desiredPainLevel"];

if (!local _unit) exitWith { ERROR("unit is not local"); };

TRACE_2("ACE_DEBUG: adjustPainLevel Called",_unit,_desiredPainLevel);

private _pain = _unit getVariable [QGVAR(pain), 0];

_pain = 0 max (_pain max _desiredPainLevel) min 1;

_unit setVariable [QGVAR(pain), _pain];
