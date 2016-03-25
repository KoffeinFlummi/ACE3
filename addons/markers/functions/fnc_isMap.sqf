/*
 * Author: SzwedzikPL
 * Checks if item is a map
 *
 * Arguments:
 * 0: Item class <STRING>
 *
 * Return Value:
 * is a map <BOOL>
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_item"];

_item == "ItemMap" || _item call FUNC(isUniqueMap)
