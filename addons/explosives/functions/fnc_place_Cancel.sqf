/*
	Name: ACE_Explosives_fnc_Place_Cancel

	Author(s):
		Garth de Wet (LH)

	Description:
		Cancels placement of the explosive

	Parameters:
		Nothing

	Returns:
		Nothing

	Example:
		call ACE_Explosives_fnc_Place_Cancel;
*/
#include "script_component.hpp"
if (GVAR(pfeh_running)) then {
	[QGVAR(Placement),"OnEachFrame"] call CALLSTACK(BIS_fnc_removeStackedEventHandler);
	GVAR(pfeh_running) = false;
};
if (!isNull (GVAR(Setup))) then {
	deleteVehicle GVAR(Setup);
};
GVAR(Setup) = objNull;
if (isNil {GVAR(placer)}) then {
	GVAR(placer) = objNull;
};
// [GVAR(placer), "ACE_Explosives", false] call EFUNC(Common,setForceWalkStatus);
[GVAR(placer), "ACE_Explosives_Walk", "forceWalk", false, true, true] call EFUNC(common,setStatusEffect);
GVAR(placer) = objNull;
call EFUNC(interaction,hideMouseHint);
[ACE_player, "DefaultAction", ACE_player getVariable [QGVAR(Place),  -1]] call EFUNC(Common,removeActionEventHandler);
[ACE_player, "MenuBack",      ACE_player getVariable [QGVAR(Cancel), -1]] call EFUNC(Common,removeActionEventHandler);
