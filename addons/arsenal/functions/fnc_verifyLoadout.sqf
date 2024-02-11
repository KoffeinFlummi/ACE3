#include "..\script_component.hpp"
#include "..\defines.hpp"
/*
 * Author: Alganthe, johnb43
 * Verify the provided loadout: Check what items do not exist and what items aren't available in current arsenal.
 *
 * Arguments:
 * 0: Loadout <ARRAY> (CBA Extended Loadout or getUnitLoadout format)
 *
 * Return Value:
 * Verified loadout and missing / unavailable items list and count <ARRAY>
 *
 * Public: No
*/

params ["_loadout"];

private _extendedInfo = createHashMap;

// Check if the provided loadout is a CBA extended loadout
if (count _loadout == 2) then {
    _extendedInfo = +(_loadout select 1); // Copy the hashmap to prevent events from modifiyng the profileNamespace extendedInfo
    _loadout = _loadout select 0;
};

private _name = "";
private _itemArray = [];
private _nullItemsList = [];
private _unavailableItemsList = [];

// Search for all items and check their availability
private _fnc_filterLoadout = {
    _this apply {
        if (_x isEqualType "" && {_x != ""}) then {
            _name = _x call EFUNC(common,getConfigName);

            // If item doesn't exist in config, "" is returned
            if (_name == "") then {
                _nullItemsList pushBack _x;
            } else {
                // Check if item or its base weapon exist in the arsenal
                if !(_name in GVAR(virtualItemsFlat)) then {
                    _name = _name call FUNC(baseWeapon);
                    if !(_name in GVAR(virtualItemsFlat)) then {
                        _unavailableItemsList pushBack _name;
                        _name = "";
                    };
                };
            };

            _name
        } else {
            // Handle arrays
            if (_x isEqualType []) then {
                _itemArray = _x call _fnc_filterLoadout;
                // If "" is given as a container, an error is thrown, therefore, filter out all unavailable/null containers
                if (count _itemArray == 2 && {(_itemArray select 0) isEqualTo ""} && {(_itemArray select 1) isEqualType []}) then {
                    _itemArray = [];
                };
                _itemArray
            } else {
                // All other types and empty strings
                _x
            };
        };
    };
};

// Convert loadout to config case and replace null/unavailable items
// Loadout might come from a different modpack, which might have different config naming
_loadout = _loadout call _fnc_filterLoadout;

// Raise event for 3rd party: mostly for handling extended info
[QGVAR(loadoutVerified), [_loadout, _extendedInfo]] call CBA_fnc_localEvent;

[[_loadout, _extendedInfo], _nullItemsList arrayIntersect _nullItemsList, _unavailableItemsList arrayIntersect _unavailableItemsList]
