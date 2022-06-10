#include "script_component.hpp"
/*
 * Author: Timi007
 * Adds the child actions for placing and carring flags.
 *
 * Arguments:
 * 0: Player <OBJECT>
 *
 * Return Value:
 * Actions <ARRAY>
 *
 * Example:
 * [player] call ace_flags_fnc_addActions
 *
 * Public: No
 */

params ["_player"];

private _actions = [];

{
    (GVAR(flagItemCache) get _x) params ["_flagName", "_texture", "_actionIconPlace", "_actionIconCarry"];

    // Place flag
    _actions pushBack [
        [
            "place_" + _x,
            format [LLSTRING(place), _flagName],
            _actionIconPlace,
            {
                params ["_player", "", "_item"];
                [_player, _item] call FUNC(placeFlag);
            },
            {true},
            {},
            _x
        ] call EFUNC(interact_menu,createAction),
        [],
        _player
    ];

    // Carry flag
    _actions pushBack [
        [
            "carry_" + _x,
            format [LLSTRING(carry), _flagName],
            _actionIconCarry,
            {
                params ["_player", "", "_item"];
                [_player, _item] call FUNC(carryFlag);
            },
            {!([_this select 0] call FUNC(carriesFlag))}, // Should not carry flag already
            {},
            _x
        ] call EFUNC(interact_menu,createAction),
        [],
        _player
    ];
} forEach ([_player] call FUNC(getFlags));

_actions
