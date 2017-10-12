/*
 * Author: ACE-Team
 * Not currently used
 *
 * Arguments:
 * 0: TARGET <OBJECT>
 * 1: ARGS <ARRAY>
 *
 * Return Value:
 * Boolean <BOOLEAN>
 *
 * Example:
 * [bob, kevin] call ACE_missileguidance_fnc_handleHandoff
 *
 * Public: No
 */

#include "script_component.hpp"
params ["_target", "_args"];

if (isNil "_target" || {isNull _target} || {!local _target} ) exitWith { false };

[FUNC(guidancePFH), 0, _args] call CBA_fnc_addPerFrameHandler;
