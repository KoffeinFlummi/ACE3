/*
 * Author: Glowbal
 * Grabs a variable. If variable has not been set, attempts to use default defined value
 *
 * Arguments:
 * 0: unit <OBJECT>
 * 1: Variable Name <STRING>
 *
 * Return Value:
 * Value of variable or default value, if the variable is undefined <ANY>
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_unit", "_variable"];

private "_value";

_value = _unit getVariable _variable;
if (isNil "_value") then {
    if (count _this > 2) then {
        _value = _this select 2;
    } else {
        private "_definedVariable";
        _definedVariable = ([_variable] call FUNC(getDefinedVariableInfo));
        if (count _definedVariable > 1) then {
            _value = _definedVariable select 1;
        };
    };
    if (isNil "_value") then {
        _value = 0;
    };
};
_value
