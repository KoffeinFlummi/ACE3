/**
 * fn_loadPersonLocal_f.sqf
 * @Descr: Load a person, local
 * @Author: Glowbal
 *
 * @Arguments: [unit OBJECT, vehicle OBJECT, caller OBJECT]
 * @Return: void
 * @PublicAPI: false
 */

#include "script_component.hpp"

private ["_unit","_vehicle","_caller","_handle","_loaded"];
_unit = [_this, 0, ObjNull,[ObjNull]] call BIS_fnc_Param;
_vehicle = [_this, 1, ObjNull,[ObjNull]] call BIS_fnc_Param;
_caller = [_this, 2, ObjNull,[ObjNull]] call BIS_fnc_Param;

if (!alive _unit) then {
	_unit = [_unit,_caller] call FUNC(makeCopyOfBody_F);
};

_unit moveInCargo _vehicle;
_loaded = _vehicle getvariable [QGVAR(loaded_persons_F),[]];
_loaded pushback _unit;
_vehicle setvariable [QGVAR(loaded_persons_F),_loaded,true];
if (!([_unit] call FUNC(isAwake))) then {
	_handle = [_unit,_vehicle] spawn {
		private ["_unit","_vehicle"];
		_unit = _this select 0;
		_vehicle = _this select 1;
		waituntil {vehicle _unit == _vehicle};
		sleep 0.5;
		[_unit,([_unit] call FUNC(getDeathAnim))] call FUNC(broadcastAnim);
	};
} else {
	if ([_unit] call FUNC(isArrested)) then {

	};
};