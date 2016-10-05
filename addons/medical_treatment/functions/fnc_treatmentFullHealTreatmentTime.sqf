/*
 * Author: Ruthberg
 * Calculates the personal aid kit treatment time based on amount of damage to heal
 *
 * Arguments:
 * unit <OBJECT>
 *
 * Return Value:
 * treatment time <NUMBER>
 *
 * Example:
 * [_target] call ace_medical_treatment_fnc_treatmentFullHealTreatmentTime
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_unit"];

private _totalDamage = 0;

{
    _totalDamage = _totalDamage + _x;
} forEach (_unit getVariable [QEGVAR(medical,bodyPartStatus), []]);

10 max (_totalDamage * 10) min 120
