/*
 * Author: Dslyecxi, Jonpas
 * Prepares throwable or selects the next.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [unit] call ace_advancedthrowing_fnc_prepare
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_unit"];
TRACE_1("params",_unit);

// Select next throwable if one already in hand
if (_unit getVariable [QGVAR(inHand), false]) exitWith {
    TRACE_1("inHand",_unit);
    if (!(_unit getVariable [QGVAR(primed), false])) then {
        TRACE_1("not primed",_unit);
        [_unit] call EFUNC(weaponselect,selectNextGrenade);
    };
};

// Try selecting next throwable if none currently selected
if ((isNull (_unit getVariable [QGVAR(activeThrowable), objNull])) && {(currentThrowable _unit) isEqualTo []} && {!([_unit] call EFUNC(weaponselect,selectNextGrenade))}) exitWith {
    TRACE_1("no throwables",_unit);
};


_unit setVariable [QGVAR(inHand), true];

// Add controls hint
call FUNC(updateControlsHint);

// Add throw action to suppress weapon firing (not possible to suppress mouseButtonDown event)
_unit setVariable [QGVAR(throwAction), [_unit, "DefaultAction", {true}, {true}] call EFUNC(common,addActionEventHandler)];

// Draw throwable and throw arc if enabled
GVAR(draw3DHandle) = addMissionEventHandler ["Draw3D", {
    call FUNC(drawThrowable);
    if (GVAR(showThrowArc)) then {
        call FUNC(drawArc);
    };
}];
