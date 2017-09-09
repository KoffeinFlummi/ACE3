/*
 * Author: BaerMitUmlaut
 * Checks if a unit is currently considered safe enough to treat itself.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Is unit safe enough <BOOL>
 *
 * Example:
 * call ACE_medical_ai_fnc_isSafe
 *
 * Public: No
 */
#include "script_component.hpp"

(getSuppression _this == 0) && {CBA_missionTime - (_this getVariable [QGVAR(lastFired), -30]) > 30}
