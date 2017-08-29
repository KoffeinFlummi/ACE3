/*
 * Author: 654wak654
 * Removes a cargo item from the vehicle.
 *
 * Arguments:
 * 0: Item <STRING> or <OBJECT>
 * 1: Vehicle <OBJECT>
 * 2: Amount <NUMBER> (default: 1)
 *
 * Return Value:
 * None
 *
 * Example:
 * ["item", vehicle] call ace_cargo_fnc_removeCargoItem
 *
 * Public: Yes
 */
#include "script_component.hpp"

params ["_item", "_vehicle", ["_amount", 1]];
TRACE_3("params",_item,_vehicle,_amount);

private _loaded = _vehicle getVariable [QGVAR(loaded), []];

private _itemsRemoved = 0;
private _addedSpace = 0;

{
    if (_itemsRemoved == _amount) exitWith {};

    if (_x isEqualTo _item || {_x isEqualType objNull && {typeOf _x == _item}}) then {
        INC(_itemsRemoved);
        ADD(_addedSpace,[_x] call FUNC(getSizeItem));

        if (_x isEqualType objNull) then {
            deleteVehicle _x;
        };
        _loaded set [_forEachIndex, nil];
    };
} forEach _loaded;

FILTER(_loaded,_x != nil);
_vehicle setVariable [QGVAR(loaded), _loaded, true];

private _space = [_vehicle] call FUNC(getCargoSpaceLeft);
_vehicle setVariable [QGVAR(space), _space + _addedSpace, true];

// Invoke listenable event
["ace_cargoRemoved", [_item, _vehicle, _amount]] call CBA_fnc_globalEvent;
