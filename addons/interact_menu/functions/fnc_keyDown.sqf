/*
 * Author: NouberNou
 * Handle interaction key down
 *
 * Argument:
 * None
 *
 * Return value:
 * true <BOOL>
 *
 * Public: No
 */
#include "script_component.hpp"

if(!GVAR(keyDown)) then {
    while {dialog} do {closeDialog 0};

    // Only interact with others if on foot
    if (vehicle ACE_player != ACE_player) exitWith {};

    GVAR(keyDown) = true;
    GVAR(keyDownTime) = diag_tickTime;

    ["interactMenuOpened", [0]] call EFUNC(common,localEvent);
};
true
