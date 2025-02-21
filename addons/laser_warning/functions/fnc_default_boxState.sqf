#include "..\script_component.hpp"
/*
 * Author: tcvm
 * Returns default values for the box state
 *
 * Arguments:
 * 0: Powered by default <BOOL>
 *
 * Return Value:
 * Box State Array <ARRAY>
 *
 * Example:
 * call ace_laser_warning_fnc_default_boxState;
 *
 * Public: No
 */
params [["_powered", false]];
[
    _powered,   // Power
    []          // Laser log
]