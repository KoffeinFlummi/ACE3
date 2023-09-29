#include "..\script_component.hpp"
/*
 * Author: Glowbal, drofseh
 * Places a dead body inside a grave.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject] call ace_medical_treatment_fnc_placeInGrave
 *
 * Public: No
 */

params ["_medic", "_patient"];
TRACE_1("placeInGrave",_patient);

if ((alive _patient) && {GVAR(allowGraveDigging) < 2}) exitWith {
    [LSTRING(bodybagWhileStillAlive)] call EFUNC(common,displayTextStructured);
};

private _graveClassname = missionNameSpace getVariable [QGVAR(graveClassname), "Land_ACE_Grave"];
// Land_Grave_dirt_F needed to be rotated 90 degrees to line up with the body, Land_ACE_Grave does not.
private _graveRotation = missionNameSpace getVariable [QGVAR(graveRotation), 0]; 

[_this, _graveClassname, [0,0,0], _graveRotation] call FUNC(placeInBodyBagOrGrave);

