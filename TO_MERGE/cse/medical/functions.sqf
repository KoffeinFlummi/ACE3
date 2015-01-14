/*
functions.sqf
Usage: compileFinals the function SQF files into variables for use
Author: Glowbal

Arguments: none
Returns: none

Affects: n/a
Executes:
*/

FUNC(unitLoop_CMS) = {
	_unit = _this select 0;
	if !(local _unit) exitwith{};
	if !(_unit getvariable[QGVAR(addedToUnitLoop),false]) then{
		_unit setvariable [QGVAR(addedToUnitLoop),true];
	};

	if ([_unit] call FUNC(hasMedicalEnabled_CMS)) then {
		if (isnil QGVAR(injuredUnitCollection)) then {
			GVAR(injuredUnitCollection) = [];
		};
		if (_unit in GVAR(injuredUnitCollection)) exitwith {};
		GVAR(injuredUnitCollection) pushback _unit;
		[format["Added %1 to unitLoop",_unit]] call EFUNC(common,debug);
	};
};

FUNC(onBodySwitch_CMS) = {
	private ["_unit","_newUnit"];
	_unit = _this select 0;
	_newUnit = _this select 1;
	if (!dialog) exitwith{};
	if (GVAR(INTERACTION_TARGET) == _unit) then {
		GVAR(INTERACTION_TARGET) = _newUnit;
	};
};

FUNC(eh_killed_CMS) = {
	private["_unit"];
	_unit = _this select 0;
	if (!local _unit) exitwith {};
	[_unit, QGVAR(amountOfPain),0,true] call EFUNC(common,setDefinedVariable);
	[_unit, QGVAR(heartRate),0,true] call EFUNC(common,setDefinedVariable);
	[_unit, QGVAR(bloodPressure), [0,0],true] call EFUNC(common,setDefinedVariable);
	if (_unit getvariable[QGVAR(unconscious_non_captive_f),false]) then {
		_unit setCaptive false;
		_unit setvariable[QGVAR(unconscious_non_captive_f),nil];
	};
};

FUNC(eh_local_CMS) = {
	private["_unit"];
	_unit = _this select 0;
	_local = _this  select 1;
	[format["Locality changed for: %1",_this]] call EFUNC(common,debug);
	if (_local) then {
		if (_unit getvariable[QGVAR(addedToUnitLoop),false]) then {
			[_unit] call FUNC(unitLoop_CMS);
		};
	};
};
