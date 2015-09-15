// by commy2
#include "script_component.hpp"

PARAMS_1(_target);

{
    if (isNil "_x") then {
        ACE_LOGERROR_1("No argument and function for remote function. ID: %1",_forEachIndex);
    } else {
        if (typeName _x == "ARRAY") then {
            [_x select 0, _target] call (_x select 1);
        };
    };
} forEach (_target getVariable ["ACE_PersistentFunctions", []]);
