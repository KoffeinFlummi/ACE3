/*
 * Author: Garth 'L-H' de Wet
 * Turns 0-1 damage of explosion Event into a rating system of 0-3
 *
 * Arguments:
 * 0: The amount of damage <NUMBER>
 *
 * Return Value:
 * The rating [0-3] <NUMBER>
 *
 * Example:
 * 0.05 call ace_goggles_fnc_getExplosionIndex;
 *
 * Public: No
 */
private ["_effectIndex"];
if (_this <= 0.04) exitWith {0};
if (_this <= 0.06)) exitWith {1};
if (_this <= 0.09) exitWith {2};
3
