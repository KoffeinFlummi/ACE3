/*
 * Author: Glowbal
 * Updates the vitals. Is expected to be called every second.
 *
 * Arguments:
 * 0: The Unit <OBJECT>
 *
 * ReturnValue:
 * <NIL>
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_unit"];

private _lastTimeUpdated = _unit getVariable [QGVAR(lastTimeUpdated), CBA_missionTime];
private _deltaT = CBA_missionTime - _lastTimeUpdated;
_unit setVariable [QGVAR(lastTimeUpdated), CBA_missionTime];

TRACE_2("ACE_DEBUG",_unit,_deltaT);

if (_deltaT == 0) exitWith {};

private _lastTimeValuesSynced = _unit getVariable [QGVAR(lastMomentValuesSynced), 0];
private _syncValues = (CBA_missionTime - _lastTimeValuesSynced >= 10 + floor(random(10))) && GVAR(keepLocalSettingsSynced);

if (_syncValues) then {
    _unit setVariable [QGVAR(lastMomentValuesSynced), CBA_missionTime];
};

private _bloodVolume = (_unit getVariable [QGVAR(bloodVolume), DEFAULT_BLOOD_VOLUME]) + _deltaT * ([_unit, _syncValues] call FUNC(getBloodVolumeChange));
_bloodVolume = 0 max _bloodVolume min DEFAULT_BLOOD_VOLUME;

_unit setVariable  [QGVAR(bloodVolume), _bloodVolume, _syncValues];

TRACE_3("ACE_DEBUG",_bloodVolume,_syncValues,_unit);
// Set variables for synchronizing information across the net
if (_bloodVolume < BLOOD_VOLUME_HAS_LOST_SOME) then {
    if (_bloodVolume < BLOOD_VOLUME_HAS_LOST_MUCH) then {
        if (_unit getVariable [QGVAR(hasLostBlood), 0] != 2) then {
            _unit setVariable [QGVAR(hasLostBlood), 2, true];
        };
    } else {
        if (_unit getVariable [QGVAR(hasLostBlood), 0] != 1) then {
            _unit setVariable [QGVAR(hasLostBlood), 1, true];
        };
    };
} else {
    if (_unit getVariable [QGVAR(hasLostBlood), 0] != 0) then {
        _unit setVariable [QGVAR(hasLostBlood), 0, true];
    };
};

private _bloodLoss = _unit call FUNC(getBloodLoss);
TRACE_3("ACE_DEBUG",_bloodLoss,_unit getVariable QGVAR(isBleeding),_unit);
if (_bloodLoss > 0) then {
    _unit setVariable [QGVAR(bloodloss), _bloodLoss, _syncValues];

    [QGVAR(TakenInjury), _unit] call CBA_fnc_localEvent;

    if !(_unit getVariable [QGVAR(isBleeding), false]) then {
        _unit setVariable [QGVAR(isBleeding), true, true];
    };
} else {
    if (_unit getVariable [QGVAR(isBleeding), false]) then {
        _unit setVariable [QGVAR(isBleeding), false, true];
    };
};

private _painStatus = _unit getVariable [QGVAR(pain), 0];
TRACE_4("ACE_DEBUG",_painStatus,_unit getVariable QGVAR(hasPain),_unit getVariable QGVAR(painSuppress),_unit);
if (_painStatus > (_unit getVariable [QGVAR(painSuppress), 0])) then {
    if !(_unit getVariable [QGVAR(hasPain), false]) then {
        _unit setVariable [QGVAR(hasPain), true, true];
    };
} else {
    if (_unit getVariable [QGVAR(hasPain), false]) then {
        _unit setVariable [QGVAR(hasPain), false, true];
    };
};

if (_bloodVolume < BLOOD_VOLUME_DEAD) exitWith {
    [_unit, "bloodloss"] call FUNC(setDead);
};

if ([_unit] call EFUNC(common,isAwake)) then {
    if (_bloodVolume < BLOOD_VOLUME_UNCONSCIOUS && {random 1 < BLOOD_LOSS_KNOCK_OUT_CHANCE}) exitWith {
        [_unit, true, BLOOD_LOSS_KNOCK_OUT_DURATION] call FUNC(setUnconscious);
    };
};

if (GVAR(level) >= 2) then {
    TRACE_6("ACE_DEBUG_ADVANCED_VITALS",_painStatus,_bloodVolume,_unit getVariable QGVAR(hasPain),_unit getVariable QGVAR(morphine),_syncValues,_unit);

    // Handle pain due tourniquets, that have been applied more than 120 s ago
    private _oldTourniquets = (_unit getVariable [QGVAR(tourniquets), []]) select {_x > 0 && {CBA_missionTime - _x > 120}};
    // Increase pain at a rate of 0.001 units/s per old tourniquet
    _painStatus = _painStatus + (count _oldTourniquets) * 0.001 * _deltaT;

    // Set the vitals
    private _heartRate = (_unit getVariable [QGVAR(heartRate), 80]) + _deltaT * ([_unit] call FUNC(getHeartRateChange));
    _unit setVariable  [QGVAR(heartRate), 0 max _heartRate, _syncValues];

    private _bloodPressure = [_unit] call FUNC(getBloodPressure);
    _unit setVariable  [QGVAR(bloodPressure), _bloodPressure, _syncValues];

    _painReduce = [0.001, 0.002] select (_painStatus > 5);

    // @todo: replace this and the rest of the setVariable with EFUNC(common,setApproximateVariablePublic)
    _unit setVariable [QGVAR(pain), 0 max (_painStatus - _deltaT * _painReduce), _syncValues];

    TRACE_8("ACE_DEBUG_ADVANCED_VITALS",_painStatus,_painReduce,_heartRate,_bloodVolume,_bloodPressure,_deltaT,_syncValues,_unit);

    // Check vitals for medical status
    // TODO check for in revive state instead of variable
    _bloodPressure params ["_bloodPressureL", "_bloodPressureH"];

    if (!(_unit getVariable [QGVAR(inCardiacArrest),false])) then {
        if (_heartRate < 10 || _bloodPressureH < 30 || _bloodVolume < BLOOD_VOLUME_CARDIAC_ARREST) then {
            [_unit, true, 10+ random(20)] call FUNC(setUnconscious); // safety check to ensure unconsciousness for units if they are not dead already.
        };

        if ((_bloodPressureH > 260) || {_bloodPressureL < 40 && ({_heartRate > 190})} || {(_bloodPressureH > 145 && {_heartRate > 150})}) then {

            if (random(1) > 0.7) then {
                [_unit] call FUNC(setCardiacArrest);
            };
        };
        if (_heartRate > 200 || (_heartRate < 20)) then {
            [_unit] call FUNC(setCardiacArrest);
        };
    };
};