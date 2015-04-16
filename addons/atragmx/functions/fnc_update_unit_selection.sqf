/*
 * Author: Ruthberg
 * Updates all input fields based on the currently selected unit
 *
 * Arguments:
 * Nothing
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * call ace_atragmx_fnc_update_unit_selection
 *
 * Public: No
 */
#include "script_component.hpp"

(__DSP displayCtrl 600) ctrlEnable true;
(__DSP displayCtrl 601) ctrlEnable true;
(__DSP displayCtrl 602) ctrlEnable true;

(__DSP displayCtrl 600 + GVAR(currentUnit)) ctrlEnable false;

[] call FUNC(update_gun);
[] call FUNC(update_atmosphere);
[] call FUNC(update_target);
[] call FUNC(update_result);
