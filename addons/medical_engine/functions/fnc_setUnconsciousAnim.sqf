/*
 * Author: commy2
 * Force local unit into ragdoll / unconsciousness animation.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Is unconscious (optional, default: true) <BOOLEAN>
 *
 * Return Value:
 * None
 *
 * Example:
 * player call ace_medical_engine_fnc_setUnconsciousAnim
 *
 * Public: No
 */
#include "script_component.hpp"

params [["_unit", objNull, [objNull]], ["_isUnconscious", true, [false]]];

if (!local _unit) exitWith {
    ERROR("Unit not local or null");
};

_unit setUnconscious _isUnconscious;

if (_isUnconscious) then {
    // eject from static weapon
    if (vehicle _unit isKindOf "StaticWeapon") then {
        [_unit] call EFUNC(common,unloadPerson);
    };

    // set animation inside vehicles
    if (vehicle _unit != _unit) then {
        private _unconAnim = _unit call EFUNC(common,getDeathAnim);
        [_unit, _unconAnim] call EFUNC(common,doAnimation);
    };

    private _id = _unit addEventHandler ["AnimChanged", {
        params ["_unit", "_anim"];

        if (!local _unit || {lifeState _unit != "INCAPACITATED"}) exitWith {
            private _id = _unit getVariable QGVAR(unconAnimEHID);
            _unit removeEventHandler ["AnimChanged", _id];
        };

        private _unconAnim = "unconscious";

        _unit playMove _unconAnim; // this one is handled weird in doAnimation. @todo, clean up
        //[_unit, _unconAnim, 0, true] call EFUNC(common,doAnimation);
    }];

    _unit setVariable [QGVAR(unconAnimEHID), _id];
} else {
    // reset animation inside vehicles
    if (vehicle _unit != _unit) then {
        private _awakeAnim = _unit call FUNC(getUnitAwakeAnim);
        [_unit, _awakeAnim, 2] call EFUNC(common,doAnimation);
    } else {
        // and on foot
        [_unit, "AmovPpneMstpSnonWnonDnon"] call EFUNC(common,doAnimation);
    };
};
