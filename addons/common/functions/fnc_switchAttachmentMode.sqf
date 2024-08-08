#include "..\script_component.hpp"
/*
 * Author: PabstMirror
 * Switch attachment from one mode to another - based on CBA_accessory_fnc_switchAttachment
 * ToDo: Port this to CBA?
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Weapon (String or CBA-Weapon-Index (not ace's getWeaponIndex)) <STRING><NUMBER>
 * 2: From <STRING>
 * 3: To <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, 0, "ACE_DBAL_A3_Green_VP", "ACE_DBAL_A3_Green"] call ace_common_fnc_switchAttachmentMode
 *
 * Public: No
 */

params ["_unit", "_weapon", "_currItem", "_switchItem"];
TRACE_4("switchAttachmentMode",_unit,_weapon,_currItem,_switchItem);

if (_weapon isEqualTo "") exitWith {};

private _exit = false;
switch (_weapon) do {
    case 0;
    case (primaryWeapon _unit): {
        private _currWeaponType = 0;
        _unit removePrimaryWeaponItem _currItem;
        [{
            params ["_unit", "", "_switchItem"];
            _unit addPrimaryWeaponItem _switchItem;
            ["CBA_attachmentSwitched", _this] call CBA_fnc_localEvent;
        }, [_unit, _currItem, _switchItem, _currWeaponType]] call CBA_fnc_execNextFrame;
    };
    case 1;
    case (handgunWeapon _unit): {
        private _currWeaponType = 1;
        _unit removeHandgunItem _currItem;
        [{
            params ["_unit", "", "_switchItem"];
            _unit addHandgunItem _switchItem;
            ["CBA_attachmentSwitched", _this] call CBA_fnc_localEvent;
        }, [_unit, _currItem, _switchItem, _currWeaponType]] call CBA_fnc_execNextFrame;
    };
    case 2;
    case (secondaryWeapon _unit): {
        private _currWeaponType = 2;
        _unit removeSecondaryWeaponItem _currItem;
        [{
            params ["_unit", "", "_switchItem"];
            _unit addSecondaryWeaponItem _switchItem;
            ["CBA_attachmentSwitched", _this] call CBA_fnc_localEvent;
        }, [_unit, _currItem, _switchItem, _currWeaponType]] call CBA_fnc_execNextFrame;
    };
    default { 
        ERROR_1("bad weapon - %1",_this);
        _exit = true
    };
};
if (_exit) exitWith {};

private _configSwitchItem = configfile >> "CfgWeapons" >> _switchItem;
private _switchItemHintText = getText (_configSwitchItem >> "MRT_SwitchItemHintText");
private _switchItemHintImage = getText (_configSwitchItem >> "picture");
if (_unit == ACE_player) then {
    playSound "click";
    if (_switchItemHintText != "") then {
        [[_switchItemHintImage, 2.0], [_switchItemHintText], true] call CBA_fnc_notify;
    };
};
