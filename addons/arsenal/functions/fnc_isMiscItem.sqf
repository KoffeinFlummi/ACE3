#define DEBUG_MODE_FULL
#include "..\script_component.hpp"
/*
 * Author: DartRuffian, LinkIsGrim
 * Determines if a class is a miscellaneous item or not.
 *
 * Arguments:
 * 0: Item or magazine <STRING>
 * 1: Item config, for running in preStart (CBA fnc isn't available) <CONFIG> (default: nil)
 *
 * Return Value:
 * True if class is a misc item, otherwise false <BOOL>
 *
 * Example:
 * "ACE_CableTie" call ace_arsenal_fnc_isMiscItem
 *
 * Public: No
*/

params ["_item", "_config"];
TRACE_2("",_item,_config);

(uiNamespace getVariable QGVAR(isMiscItemCache)) getOrDefaultCall [_item, {
    _item isKindOf ["CBA_MiscItem", configFile >> "CfgWeapons"] || {
        if (isNil "_config") then {
            _config = _item call CBA_fnc_getItemConfig;
        };
        getNumber (_config >> "ACE_asItem") == 1 || {getNumber (_config >> "ACE_isUnique") == 1}
    }
}, true]
