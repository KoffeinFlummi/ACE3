/*
 * Author: Ruthberg
 * Toggles the coriolis and spin drift output on/off
 *
 * Arguments:
 * Nothing
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * call ace_atragmx_fnc_toggle_coriolis
 *
 * Public: No
 */
#include "script_component.hpp"

GVAR(showCoriolis) = !GVAR(showCoriolis);
true call FUNC(show_main_page);
