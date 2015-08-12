/*
 * Author: Garth 'L-H' de Wet, Ruthberg
 * Cancels sandbag deployment
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call ace_sandbag_fnc_deployCancel
 *
 * Public: No
 */
#include "script_component.hpp"

if (isNull GVAR(placer)) exitWith {};

[GVAR(deployPFH)] call cba_fnc_removePerFrameHandler;

if (!isNull (GVAR(sandBag))) then {
    deleteVehicle GVAR(sandBag);
};

[GVAR(placer), "ACE_Sandbag", false] call EFUNC(Common,setForceWalkStatus);

call EFUNC(interaction,hideMouseHint);
[GVAR(placer), "DefaultAction", GVAR(placer) getVariable [QGVAR(Deploy),  -1]] call EFUNC(Common,removeActionEventHandler);
[GVAR(placer), "zoomtemp",      GVAR(placer) getVariable [QGVAR(Cancel), -1]] call EFUNC(Common,removeActionEventHandler);

GVAR(placer) addItem "ACE_Sandbag_empty";

GVAR(sandBag) = objNull;
GVAR(placer) = objNull;
