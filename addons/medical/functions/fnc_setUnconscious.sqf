/*
 * Author: Glowbal
 * Sets a unit in the unconscious state.
 *
 * Arguments:
 * 0: The unit that will be put in an unconscious state <OBJECT>
 * 1: Set unconsciouns <BOOL> <OPTIONAL>
 * 2: Minimum unconscious time <NUMBER> <OPTIONAL>
 *
 * ReturnValue:
 * nil
 *
 * Public: yes
 */

#include "script_component.hpp"

#define DEFAULT_DELAY   (round(random(10)+5))

private ["_unit", "_set", "_animState", "_originalPos", "_captiveSwitch", "_startingTime","_minWaitingTime"];
_unit = _this select 0;
_set = if (count _this > 1) then {_this select 1} else {true};
_minWaitingTime = if (count _this > 2) then {_this select 2} else {DEFAULT_DELAY};

if !(_set) exitwith {
    _unit setvariable ["ACE_isUnconscious", false,true];
};

if !(!(isNull _unit) && {(_unit isKindOf "CaManBase") && ([_unit] call EFUNC(common,isAwake))}) exitwith{};

if (!local _unit) exitwith {
    [[_unit], QUOTE(DFUNC(setUnconscious)), _unit, false] call EFUNC(common,execRemoteFnc); /* TODO Replace by event system */
};

_unit setvariable ["ACE_isUnconscious", true, true];
_unit setUnconscious true;

if (_unit == ACE_player) then {
    if (visibleMap) then {openMap false};
    closeDialog 0;
};

// If a unit has the launcher out, it will sometimes start selecting the primairy weapon while unconscious,
// therefor we force it to select the primairy weapon before going unconscious
if ((vehicle _unit) isKindOf "StaticWeapon") then {
    moveOut _unit;
    unassignVehicle _unit;
    //_unit action ["eject", vehicle _unit];
};
if (animationState _unit in ["ladderriflestatic","laddercivilstatic"]) then {
    _unit action ["ladderOff", (nearestBuilding _unit)];
};
if (vehicle _unit == _unit) then {
    if (primaryWeapon _unit == "") then {
        _unit addWeapon "ACE_fakeWeapon";
    };
    _unit selectWeapon (primaryWeapon _unit);
    _unit switchMove "";
    _unit playmoveNow "";
};

// We are storing the current animation, so we can use it later on when waking the unit up inside a vehicle
_animState = animationState _unit;
_originalPos = unitPos _unit;

_unit setUnitPos "DOWN";
[_unit, true] call EFUNC(common,disableAI);

// So the AI does not get stuck, we are moving the unit to a temp group on its own.
[_unit, true, "ACE_isUnconscious", side group _unit] call EFUNC(common,switchToGroupSide);

[_unit, QGVAR(unconscious), true] call EFUNC(common,setCaptivityStatus);
[_unit, [_unit] call EFUNC(common,getDeathAnim), 1, true] call EFUNC(common,doAnimation);

_startingTime = time;

[{
    private ["_unit", "_vehicleOfUnit","_minWaitingTime", "_oldAnimation", "_captiveSwitch", "_hasMovedOut"];
    _args = _this select 0;
    _unit = _args select 0;
    _oldAnimation = _args select 1;
    _originalPos = _args select 2;
    _startingTime = _args select 3;
    _minWaitingTime = _args select 4;
    _hasMovedOut = _args select 5;

    if (!alive _unit) exitwith {
        [(_this select 1)] call cba_fnc_removePerFrameHandler;
    };

    // In case the unit is no longer in an unconscious state, we are going to check if we can already reset the animation
    if !(_unit getvariable ["ACE_isUnconscious",false]) exitwith {

        // TODO, handle this with carry instead, so we can remove the PFH here.
        // Wait until the unit isn't being carried anymore, so we won't end up with wierd animations
        if !(([_unit] call FUNC(isBeingCarried)) || ([_unit] call FUNC(isBeingDragged))) then {
            if (vehicle _unit == _unit) then {
                if (animationState _unit == "AinjPpneMstpSnonWrflDnon") then {
                    [_unit,"AinjPpneMstpSnonWrflDnon_rolltofront", 2] call EFUNC(common,doAnimation);
                    [_unit,"amovppnemstpsnonwnondnon", 1] call EFUNC(common,doAnimation);
                } else {
                    [_unit,"amovppnemstpsnonwnondnon", 2] call EFUNC(common,doAnimation);
                };
            } else {
                // Switch to the units original animation, assuming
                // TODO: what if the unit switched vehicle?
                [_unit, _oldAnimation, 2] call EFUNC(common,doAnimation);
            };
            // EXIT PFH
            [(_this select 1)] call cba_fnc_removePerFrameHandler;
        };
        if (!_hasMovedOut) then {
            // Reset the unit back to the previous captive state.
            [_unit, QGVAR(unconscious), false] call EFUNC(common,setCaptivityStatus);

            // Swhich the unit back to its original group
            [_unit, false, "ACE_isUnconscious", side group _unit] call EFUNC(common,switchToGroupSide);

            [_unit, false] call EFUNC(common,disableAI);
            _unit setUnitPos _originalPos; // This is not position but stance (DOWN, MIDDLE, UP)

            _unit setUnconscious false;
            ["medical_onUnconscious", [_unit, false]] call EFUNC(common,globalEvent);
            // ensure this statement runs only once
            _args set [5, true];
        };
    };

    // Ensure we are waiting at least a minimum period before checking if we can wake up the unit again, allows for temp knock outs
    if ((time - _startingTime) >= _minWaitingTime) exitwith {

        if (!([_unit] call FUNC(getUnconsciousCondition))) then {
            _unit setvariable ["ACE_isUnconscious", false, true];
        };
    };
}, 0.1, [_unit,_animState, _originalPos, _startingTime, _minWaitingTime, false] ] call CBA_fnc_addPerFrameHandler;

["medical_onUnconscious", [_unit, true]] call EFUNC(common,globalEvent);
