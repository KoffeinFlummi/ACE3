/**
 * fn_cleanUpCopyOfBody_f.sqf
 * @Descr: Called from a custom eventhandler to ensure that any copies of bodies are cleaned up.
 * @Author: Glowbal
 *
 * @Arguments: [unit OBJECT]
 * @Return: BOOL
 * @PublicAPI: true
 */

#include "script_component.hpp"

private ["_unit", "_copy"];
_unit = _this select 0;

_copy = _unit getvariable QGVAR(copyOfBody_f);
if (isnil "_copy") exitwith {false};
[format["Cleaning up a copy of Body: %1 %2", _unit, _copy]] call FUNC(debug);
// lets clean it up
_unit setvariable [QGVAR(originalCopy_f), nil, true];
_unit setvariable [QGVAR(copyOfBody_f), nil, true];
if (!isNull _copy) then {
	deleteVehicle _copy;
};

true;