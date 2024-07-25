#include "..\script_component.hpp"
/*
 * Author: BaerMitUmlaut
 * Initializes the item context menu for the DBAL.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call ace_irlight_fnc_initItemContextMenu
 *
 * Public: No
 */

{
    _x params ["_variant", "_displayName"];

    [
        "ACE_DBAL_A3_Red", "POINTER", _displayName, [], "", {
            params ["", "", "_item", "", "_variant"];

            private _baseClass = getText (configFile >> "CfgWeapons" >> _item >> "baseWeapon");
            _item != _baseClass + _variant
        }, {
            params ["_unit", "", "_item", "_slot", "_variant"];

            if !(_slot in ["RIFLE_POINTER", "LAUNCHER_POINTER", "PISTOL_POINTER"]) exitWith {};

            private _baseClass = getText (configFile >> "CfgWeapons" >> _item >> "baseWeapon");

            [_unit, _item, _baseClass + _variant] call EFUNC(common,switchAttachmentMode);
        }, false, _variant
    ] call CBA_fnc_addItemContextMenuOption;
} forEach [
    ["", LSTRING(Mode_IRDual)],
    ["_IP", LSTRING(Mode_IRPointer)],
    ["_II", LSTRING(Mode_IRIlluminator)],
    ["_VP", LSTRING(Mode_VisiblePointer)]
];
