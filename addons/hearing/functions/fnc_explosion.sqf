#include "..\script_component.hpp"
/*
 * Author: johnb43
 * Handles deafness due to explosions going off near the player.
 *
 * Arguments:
 * 0: Projectile <OBJECT>
 * 1: Explosion position ASL <ARRAY>
 * 2: Velocity <ARRAY> (unused)
 *
 * Return Value:
 * None
 *
 * Example:
 * [_projectile, [0, 0, 0], [0, 0, 0]] call ace_hearing_fnc_explosion
 *
 * Public: No
 */

#define STRENGTH_MULTIPLIER 300

// Ignore spectators, curators and alike
if ((getNumber (configOf ACE_player >> "isPlayableLogic")) == 1) exitWith {};

params ["_projectile", "_pos"];

// Don't allow for distances under 1
private _distance = ((eyePos ACE_player) vectorDistance _pos) max 1;

// Fast exit if explosion far away
if (_distance > 100) exitWith {
    TRACE_1("too far away",_distance);
};

private _ammoConfig = configOf _projectile;
private _audibleFire = getNumber (_ammoConfig >> "audibleFire");
private _explosive = getNumber (_ammoConfig >> "explosive");

private _vehAttenuation = [GVAR(playerVehAttenuation), 1] select (isNull objectParent ACE_player || {isTurnedOut ACE_player});

TRACE_5("",typeOf _projectile,_distance,_explosive,_audibleFire,_vehAttenuation);

// Handle grenades differently from shells and other
_distance = if (_projectile isKindOf "Grenade" || {_projectile isKindOf "GrenadeCore"}) then {
    _distance / 4
} else {
    _distance ^ linearConversion [1, 30, _distance, 1, 2.5, true]
};

private _strength = _vehAttenuation * _audibleFire / _distance * _explosive * STRENGTH_MULTIPLIER;

TRACE_2("adjusted distance",_distance,_strength);

// Call immediately, as it will get picked up later by the update thread anyway
_strength call FUNC(earRinging);
