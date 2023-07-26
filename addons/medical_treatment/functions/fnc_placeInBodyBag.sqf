#include "script_component.hpp"
/*
 * Author: Glowbal, drofseh
 * Places a dead body inside a body bag.
 *
 * Arguments:
 * 0: Medic <OBJECT>
 * 1: Patient <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, cursorObject] call ace_medical_treatment_fnc_placeInBodyBag
 *
 * Public: No
 */

private _alive = alive _patient;

if (_alive && {!GVAR(allowBodyBagUnconscious)}) exitWith {
    [_medic, "ACE_bodyBag"] call EFUNC(common,addToInventory); // re-add slighly used bodybag?
    [LSTRING(bodybagWhileStillAlive)] call EFUNC(common,displayTextStructured);
};

[_this,"ACE_bodyBagObject"] call ace_medical_treatment_fnc_placeInBodyBagOrGrave;
