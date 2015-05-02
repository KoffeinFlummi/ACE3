/*
 * Author: esteldunedain
 * Create one action per passenger
 *
 * Argument:
 * 0: Vehicle <OBJECT>
 * 1: Player <OBJECT>
 * 3: Parameters <ARRAY>
 *
 * Return value:
 * Children actions <ARRAY>
 *
 * Public: No
 */
#include "script_component.hpp"

EXPLODE_3_PVT(_this,_vehicle,_player,_parameters);

private ["_actions"];
_actions = [];

{
    private ["_unit"];
    _unit = _x;
    if (_unit != _player) then {
        _actions pushBack
            [
                [
                    str(_unit),
                    [_unit, true] call EFUNC(common,getName),
                    "",
                    {},
                    {true},
                    {_this call FUNC(addPassengerActions);},
                    [_unit]
                ] call EFUNC(interact_menu,createAction),
                [],
                _unit
            ];
    };
} forEach crew _vehicle;

_actions