#include "script_component.hpp"
/*
 * Author: Glowbal
 * Local callback for finishing performing CPR on the patient.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject] call ace_medical_treatment_fnc_cprLocal
 *
 * Public: No
 */

params ["_medic", "_patient"];

[_patient, "activity", LSTRING(Activity_CPR), [[_medic, false, true] call EFUNC(common,getName)]] call FUNC(addToLog);

if (random 1 >= 0.6) then {
    [QEGVAR(medical,CPRSucceeded), _patient] call CBA_fnc_localEvent;
};
