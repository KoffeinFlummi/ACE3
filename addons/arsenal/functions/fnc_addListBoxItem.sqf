#include "script_component.hpp"
/*
 * Author: Dedmen, johnb43
 * Add a listbox row.
 *
 * Arguments:
 * 0: Config category, must be "CfgWeapons", "CfgVehicles", "CfgMagazines", "CfgVoice" <STRING>
 * 1: Classname <STRING>
 * 2: Panel control <CONTROL>
 * 3: Name of the picture entry in that Cfg class <STRING> (default: "picture")
 *
 * Return Value:
 * None
 *
 * Example:
 * ["CfgWeapons", "launch_NLAW_F", _ctrl, "icon"] call ace_arsenal_fnc_addListBoxItem
 *
 * Public: Yes
 */

params ["_configCategory", "_className", "_ctrlPanel", ["_pictureEntryName", "picture", [""]]];

// Sanitise key, as it's public; If not in cache, find info and cache it for later use
private _cachedItemInfo = GVAR(addListBoxItemCache) getOrDefaultCall [toLower (_configCategory + _className), {
    // Get classname (config case), display name, picture and DLC
    private _configPath = configFile >> _configCategory >> _className;
    private _dlcName = _configPath call EFUNC(common,getAddon);

    // If _pictureEntryName is empty, then this item has no picture (e.g. faces)
    [configName _configPath, getText (_configPath >> "displayName"), if (_pictureEntryName == "") then {""} else {getText (_configPath >> _pictureEntryName)}, if (_dlcName != "") then {(modParams [_dlcName, ["logo"]]) param [0, ""]} else {""}]
}, true];

_cachedItemInfo params ["_className", "_displayName", "_itemPicture", "_modPicture"];

private _lbAdd = _ctrlPanel lbAdd _displayName;
_ctrlPanel lbSetData [_lbAdd, _className];
_ctrlPanel lbSetPicture [_lbAdd, _itemPicture];
_ctrlPanel lbSetPictureRight [_lbAdd, ["", _modPicture] select GVAR(enableModIcons)];
_ctrlPanel lbSetTooltip [_lbAdd, format ["%1\n%2", _displayName, _className]];
