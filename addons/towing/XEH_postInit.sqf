#include "script_component.hpp"
["MouseButtonDown", LINKFUNC(onMouseButtonDown)] call CBA_fnc_addDisplayHandler;
["MouseButtonUp", LINKFUNC(onMouseButtonUp)] call CBA_fnc_addDisplayHandler;
GVAR(mouseLeft) = false;
GVAR(mouseRight) = false;

[QGVAR(lockVehicle), {
    params ["_vehicle", "_lock"];
    if (_lock) then {
        _vehicle lock 2;
    } else {
        _vehicle lock 0;
    };
}] call CBA_fnc_addEventHandler;

