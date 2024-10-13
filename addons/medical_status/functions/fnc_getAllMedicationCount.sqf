#include "..\script_component.hpp"
/*
 * Author: PabstMirror, modified by Cplhardcore
 * Gets effective count of all medications in a unit's system
 * (each medication dose is scaled from 0..1 based on time till max effect and max time in system)
 *
 * Arguments:
 * 0: The patient <OBJECT>
 * 1: Get raw count (true) or effect ratio (false) <BOOL> (default: true)
 *
 * Return Value:
 * Dose Count <NUMBER>
 * Medication effectiveness (float) <NUMBER>
 *
 * Example:
 * [player] call ace_medical_status_fnc_getAllMedicationCount
 *
 * Public: Yes
 */

params ["_target", ["_getCount", true]];

private _medicationClasses = (_target getVariable [VAR_MEDICATIONS, []]) apply {_x select 0};
_medicationClasses = _medicationClasses arrayIntersect _medicationClasses;
_medicationClasses apply {[_target, _x, _getCount] call FUNC(getMedicationCount)} // return