#include "script_component.hpp"
/*
 * Author: Glowbal
 * Check if unit has item. Note: case-sensitive.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Item Classname <STRING or ARRAY of STRING>
 * 2: Check all items in array (Optional, default: false) <BOOL>
 *
 * Return Value:
 * Unit has Item <BOOL>
 *
 * Example:
 * [bob, "item"] call ace_common_fnc_hasItem
 *
 * Public: Yes
 */

params [["_unit", objNull, [objNull]], ["_item", "", ["", [""]]], ["_checkAll", false, [false]]];

//private _unitItems = _unit call FUNC(uniqueItems);

if (_item isEqualType "") exitWith {
    _item in GVAR(uniqueItemsCache)
};

if (_checkAll) exitWith {
    _item findIf {!(_x in _unitItems)} == -1
};

_item findIf {_x in _unitItems} != -1
