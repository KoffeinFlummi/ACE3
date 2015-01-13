/**
 * fn_bandageLocal_CMS.sqf
 * @Descr: N/A
 * @Author: Glowbal
 *
 * @Arguments: []
 * @Return:
 * @PublicAPI: false
 */

private ["_treatingPerson","_injuredPerson","_part","_selectionName","_openWounds","_woundsArray","_highest_amount","_highestSpot","_collectiveImpact", "_highestTotal","_totalNumber", "_selectedData"];
_injuredPerson = _this select 0;
_treatingPerson = _this select 1;
_selectionName = _this select 2;
_removeItem = _this select 3;
_selectedData = [_this, 4, "", [""]] call BIS_fnc_Param;

if (!local _injuredPerson) exitwith{["fnc_bandageLocal called on non local machine",3] call EFUNC(common,debug); };
[_injuredPerson] spawn cse_fnc_unitLoop_CMS;
if (_treatingPerson != _injuredPerson) then {
	[_injuredPerson,"STR_ACE_CMS_BANDAGING", "STR_ACE_CMS_IS_BANDAGING_YOU", 0, [[_treatingPerson] call EFUNC(common,getName)]] call EFUNC(common,sendDisplayMessageTo);
};
[_this] call EFUNC(common,debug);

[_injuredPerson,_removeItem] call FUNC(addToTriageList_CMS);
_collectiveImpact =	switch (_removeItem) do	{
		case "cse_packing_bandage":	{[1.0, 1.5, 1.2]};
		case "cse_bandageElastic": 	{[1.3, 0.9, 0.9]};
		case "cse_bandage_basic": 	{[1.5, 1.0, 0.6]};
		case "cse_stitching": 		{[2.0, 2.0, 2.0]};
		case "cse_quikclot": 		{[0.9, 0.3, 0.3]};
		default						{[0.9, 0.5, 0.5]};
	};
	_part =	[_selectionName] call FUNC(getBodyPartNumber_CMS);

	_openWounds = [_injuredPerson,QGVAR(openWounds)] call EFUNC(common,getDefinedVariable);
	_woundsArray = _openWounds select _part;

	_highestSpot = 0;
	_highest_amount = 0;
	{
		if (_x > _highest_amount) then {
			_highestSpot = _foreachIndex;
			_highest_amount = _x;
		};
	}foreach _woundsArray;

	if (_selectedData != "") then {
		[format["CUSTOM STUFF: %1", _selectedData]] call EFUNC(common,debug);
		_highestSpot = switch (_selectedData) do {
			case "open_wound_0": {0};
			case "open_wound_1": {1};
			case "open_wound_2": {2};
			default {_highestSpot};
		};
	};

	if (_highest_amount == 0 && CSE_BANDAGING_AID_CMS) then {
		_highestTotal = 0;
		{
			_totalNumber = 0;
			{
				_totalNumber = _totalNumber + _x;
			}foreach _x;
			if (_totalNumber > _highestTotal) then {
				_part = _foreachIndex;
				_highestTotal = _totalNumber;
			};
		}foreach _openWounds;
		_woundsArray = _openWounds select _part;
		_highestSpot = 0;
		_highest_amount = 0;
		{
			if (_x > _highest_amount) then {
				_highestSpot = _foreachIndex;
				_highest_amount = _x;
			};
		}foreach _woundsArray;
	};

	_impactOfBandage = (_collectiveImpact select _highestSpot);

	_wounds = _woundsArray select _highestSpot;
	_amountOfInpact = 0;
	if (_wounds >0) then {
		[_injuredPerson,"treatment",format["%2 has bandaged a wound on %1",[_part] call FUNC(fromNumberToBodyPart_CMS),[_treatingPerson] call EFUNC(common,getName)]] call FUNC(addActivityToLog_CMS);

		_amountOfInpact = _impactOfBandage;
		if (_impactOfBandage > _wounds) then {
			_amountOfInpact = _wounds;
		};
	};
	_wounds = (_wounds - _impactOfBandage);
	if (_wounds < 0) then {
		_wounds = 0;
	};
	_woundsArray set[_highestSpot, _wounds];
	_openWounds set [_part, _woundsArray];
	[_injuredPerson,QGVAR(openWounds),_openWounds] call EFUNC(common,setDefinedVariable);
	if (isnil "CSE_ADVANCED_WOUNDS_SETTING_CMS") then {
		CSE_ADVANCED_WOUNDS_SETTING_CMS = true;
	};
	if (_amountOfInpact > 0.0 && CSE_ADVANCED_WOUNDS_SETTING_CMS) then {
		_bandagedWounds = [_injuredPerson,QGVAR(bandagedWounds)] call EFUNC(common,getDefinedVariable);
		_bandagedPart = _bandagedWounds select _part;
		if (_highestSpot > 0) then {
			_bandagedWound = _bandagedPart select _highestSpot;
			_bandagedWound = _bandagedWound + _amountOfInpact;
			_bandagedPart set [_highestSpot,_bandagedWound];
			_bandagedWounds set[_part,_bandagedPart];
			[_injuredPerson,QGVAR(bandagedWounds),_bandagedWounds] call EFUNC(common,setDefinedVariable);
			[_injuredPerson, _amountOfInpact,_part,_highestSpot, _removeItem] spawn FUNC(bandageOpening_CMS);
		};
	};

	if (!([_injuredPerson] call FUNC(hasOpenWounds_CMS))) then {
		_injuredPerson setDamage 0;
	};

true