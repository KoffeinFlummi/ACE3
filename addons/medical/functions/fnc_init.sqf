/*
 * Author: KoffeinFlummi, commy2
 * Initializes unit variables.
 *
 * Arguments:
 * 0: The Unit <OBJECT>
 *
 * ReturnValue:
 * nil
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_unit"];

if (damage _unit > 0) then {
    _unit setDamage 0;
};

_unit setVariable [QGVAR(pain), 0, true];
_unit setVariable [QGVAR(bloodVolume), DEFAULT_BLOOD_VOLUME, true];
_unit setVariable [QGVAR(isUnconscious), false, true];
_unit setVariable [QGVAR(partialHealCounter), 0, true];

// tourniquets
_unit setVariable [QGVAR(tourniquets), [0,0,0,0,0,0], true];
_unit setVariable [QGVAR(occludedMedications), nil, true]; //Delayed Medications (from tourniquets)

// wounds and injuries
_unit setVariable [QGVAR(openWounds), [], true];
_unit setVariable [QGVAR(bandagedWounds), [], true];
_unit setVariable [QGVAR(stitchedWounds), [], true];

// vitals
_unit setVariable [QGVAR(heartRate), 80];
_unit setVariable [QGVAR(heartRateAdjustments), []];
_unit setVariable [QGVAR(bloodPressure), [80, 120]];
_unit setVariable [QGVAR(peripheralResistance), 100];

// triage card and logs
// TODO move to treatment
//_unit setVariable [QGVAR(triageLevel), 0, true];
//_unit setVariable [QGVAR(triageCard), [], true];

// IVs
_unit setVariable [QGVAR(ivBags), nil, true];

// damage storage
_unit setVariable [QGVAR(bodyPartStatus), [0,0,0,0,0,0], true];

// generic medical admin
_unit setVariable [QGVAR(inCardiacArrest), false, true];
_unit setVariable [QGVAR(hasLostBlood), 0, true];
_unit setVariable [QGVAR(isBleeding), false, true];
_unit setVariable [QGVAR(hasPain), false, true];
_unit setVariable [QGVAR(amountOfReviveLives), GVAR(amountOfReviveLives), true];
_unit setVariable [QGVAR(painSuppress), 0, true];

private ["_allUsedMedication", "_logs"];

// medication
_allUsedMedication = _unit getVariable [QGVAR(allUsedMedication), []];
{
   _unit setVariable [_x select 0, nil];
} forEach _allUsedMedication;
_unit setVariable [QGVAR(allUsedMedication), [], true];

// TODO move to treatment
_logs = _unit getVariable [QGVAR(allLogs), []];
{
    _unit setVariable [_x, nil];
} forEach _logs;
_unit setVariable [QGVAR(allLogs), [], true];

[{
    params ["_unit"];
    [QGVAR(initialized), [_unit]] call CBA_fnc_localEvent;
}, [_unit], 0.5, 0.1] call CBA_fnc_waitAndExecute;
