/**
 * fn_canAccessMedicalEquipment_CMS.sqf
 * @Descr: Check if caller can access targets medical equipment, based upon accessLevel
 * @Author: Glowbal
 *
 * @Arguments: [target OBJECT, caller OBJECT]
 * @Return: BOOL
 * @PublicAPI: true
 */

private ["_target", "_caller", "_accessLevel", "_return"];
_target = _this select 0;
_caller = _this select 1;

_accessLevel = _target getvariable ["cse_allowSharedEquipmentAccess_CMS", -1];

_return = false;

if (_accessLevel >= 0) then {
	if (_accessLevel == 0) exitwith { _return = true; };
	if (_accessLevel == 1) exitwith { _return = (side _target == side _caller); };
	if (_accessLevel == 2) exitwith { _return = (group _target == group _caller); };
};

_return;