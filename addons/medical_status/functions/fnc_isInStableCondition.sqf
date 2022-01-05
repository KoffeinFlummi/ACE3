#include "script_component.hpp"
/*
 * Author: Glowbal, anden3, dgibso29
 * Check if a unit is in a stable condition, needed for PersonalAidKit treatment
 *
 * Arguments:
 * 0: The patient <OBJECT>
 *
 * Return Value:
 * Is in stable condition <BOOL>
 *
 * Example:
 * [player] call ace_medical_status_fnc_isInStableCondition
 *
 * Public: No
 */

params ["_unit"];

if (!alive _unit
    || {IS_UNCONSCIOUS(_unit)}
    || {IS_BLEEDING(_unit)}
    || {GET_HEART_RATE(_unit) < EGVAR(medical_treatment,minHeartRatePAK)}
) exitWith {false};

private _requiredBloodVolume = DEFAULT_BLOOD_VOLUME * (EGVAR(medical_treatment,minBloodPAK) / 100);
if (GET_BLOOD_VOLUME(_unit) < _requiredBloodVolume) exitWith {false};

if (EGVAR(medical_treatment,allowPainPAK) == 0 && { IS_IN_PAIN(_unit) }) exitWith {false};
if (EGVAR(medical_treatment,allowFracturesPAK) == 0 && { GET_FRACTURES(_unit) isNotEqualTo [] }) exitWith {false};

// Bangaded wounds required. This means there can be no open wounds.
if (EGVAR(medical_treatment,requiredWoundStatePAK) == 1 && { (GET_OPEN_WOUNDS(_unit) findIf {_x select 2 > 0} ) != -1 }) exitWith {false};

// Stitched wounds required. This means there can be no bandaged or open wounds.
if (EGVAR(medical_treatment,requiredWoundStatePAK) == 2 && { GET_BANDAGED_WOUNDS(_unit) isNotEqualTo [] } || { (GET_OPEN_WOUNDS(_unit) findIf {_x select 2 > 0} ) != -1 }) exitWith {false};

true
