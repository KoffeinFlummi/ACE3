/*
 * Author: Ruthberg
 * Cycles through the gun list
 *
 * Arguments:
 * step <NUMBER>
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * call ace_atragmx_cycle_scope_unit
 *
 * Public: No
 */
#include "script_component.hpp"

[(GVAR(currentGun) + (count GVAR(gunList)) + _this) % (count GVAR(gunList)), true] call FUNC(change_gun);
