#include "..\script_component.hpp"
/*
 * Author: Smith
 * Cancels object to unload deployment.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Key <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [ACE_player] call ace_cargo_fnc_deployCancel
 *
 * Public: No
 */

params ["_unit", "_key"];

if (_key != 1 || {GVAR(deployPFH) == -1}) exitWith {};

// enable running again
[_unit, "forceWalk", QUOTE(ADDON), false] call EFUNC(common,statusEffect_set);
[_unit, "blockThrow", QUOTE(ADDON), false] call EFUNC(common,statusEffect_set);

// delete placement dummy
deleteVehicle GVAR(itemPreviewObject);

// remove deployment pfh
[GVAR(deployPFH)] call CBA_fnc_removePerFrameHandler;
GVAR(deployPFH) = -1;

// remove mouse button actions
call EFUNC(interaction,hideMouseHint);

[_unit, "DefaultAction", _unit getVariable [QGVAR(Deploy), -1]] call EFUNC(common,removeActionEventHandler);
[_unit, "zoomtemp",      _unit getVariable [QGVAR(Cancel), -1]] call EFUNC(common,removeActionEventHandler);

_unit setVariable [QGVAR(isDeploying), false, true];
