/*
 * Author: commy2, Phyma
 * Get door animations. @todo rewrite for better custom building support could look in animationsources instead of animate
 *
 * Arguments:
 * 0: House <OBJECT>
 * 1: Door <STRING>
 *
 * Return Value:
 * Animation and Locked variable <ARRAY>
 * 0: Animation <STRING>
 * 1: Locked variable <STRING>
 *
 * Example:
 * array = [target, "door"] call ace_interaction_fnc_getDoorAnimations
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_house", "_door"];

private ["_index", "_animations", "_lockedVariable"];

private _animate = animationNames _house;
private _animations = [];
private _lockedVariable = [];

{
    _animName = _x;
    if ([toLower _door, _animName] call BIS_fnc_inString) then {
        if (["disabled", _animName] call BIS_fnc_inString || ["locked", _animName] call BIS_fnc_inString) then {
            _LockedVariable pushBack _animName;
        } else {
            _animations pushBack _animName;
        };
    };
} forEach _animate;

[_animations, _lockedVariable]
