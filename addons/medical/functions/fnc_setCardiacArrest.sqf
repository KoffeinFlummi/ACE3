/*
 * Author: Glowbal
 * Triggers a unit into the Cardiac Arrest state from CMS. Will put the unit in an unconscious state and run a countdown timer until unit dies.
 * Timer is a random value between 120 and 720 seconds.
 *
 * Arguments:
 * 0: The unit that will be put in cardiac arrest state <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [bob] call ace_medical_fnc_setCardiacArrest
 *
 * Public: yes
 */

#include "script_component.hpp"

params ["_unit"];

if (_unit getVariable [QGVAR(inCardiacArrest), false]) exitWith {};

_unit setVariable [QGVAR(inCardiacArrest), true, true];
_unit setVariable [QGVAR(heartRate), 0, true];

["ace_cardiacArrestEntered", [_unit]] call CBA_fnc_localEvent;

[_unit, true] call FUNC(setUnconsciousStatemachine);

