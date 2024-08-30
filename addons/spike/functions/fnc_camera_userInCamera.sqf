#include "..\script_component.hpp"
/*
 * Author: Dani (TCVM)
 * Switches away from the currently controlled camera
 *
 * Arguments:
 * 0: Guidance Arg Array <ARRAY>
 * 1: PFID <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [[], 0] call ace_missileguidance_fnc_guidancePFH;
 *
 * Public: No
 */
params [["_cameraNamespace", objNull]];

if (isNil QGVAR(activeCamera)) exitWith { false };

(!isNull GVAR(activeCamera)) && { isNull _cameraNamespace || (_cameraNamespace isEqualTo GVAR(activeCamera)) };
