/*
 * Author: Jonpas
 * Checks if a throwable can be prepared.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Pick Up <BOOL> (default: false)
 *
 * Return Value:
 * Can Prepare <BOOL>
 *
 * Example:
 * [unit] call ace_advanced_throwing_fnc_canPrepare
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_unit", ["_pickUp", false]];

// Don't delay when picking up
if (_pickUp) then {
    _unit setVariable [QGVAR(lastThrownTime), -1];
};

GVAR(enabled) &&

#ifdef ALLOW_QUICK_THROW
{true} &&
#else
{_unit getVariable [QGVAR(lastThrownTime), CBA_missionTime - 3] < CBA_missionTime - 2} && // Prevent throwing in quick succession
#endif

{!(call EFUNC(common,isFeatureCameraActive))} &&
{!EGVAR(common,isReloading)} &&
{[_unit, objNull, ["isNotInside", "isNotSitting"/*, "isNotOnLadder"*/]] call EFUNC(common,canInteractWith)} && // Ladder needs positioning fixes on throw
{_unit call CBA_fnc_canUseWeapon} // Disable in non-FFV seats due to surface detection issues
