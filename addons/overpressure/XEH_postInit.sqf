#include "script_component.hpp"

["CBA_settingsInitialized", {
    TRACE_2("settingsInit eh",GVAR(backblastDistanceCoefficient),GVAR(overpressureDistanceCoefficient));

    ["ace_overpressure", LINKFUNC(overpressureDamage)] call CBA_fnc_addEventHandler;

    // Register fire event handlers
    if (GVAR(backblastDistanceCoefficient) > 0) then {
        ["ace_firedPlayer", LINKFUNC(firedEHBB)] call CBA_fnc_addEventHandler;
    };
    if (GVAR(overpressureDistanceCoefficient) > 0) then {
        ["ace_firedPlayerVehicle", {
            if (getNumber (configFile >> "CfgWeapons" >> _weapon >> QGVAR(backblast)) == 1) then {
                _this call FUNC(firedEHBB);
            } else {
                _this call FUNC(firedEHOP);
            };
        }] call CBA_fnc_addEventHandler;
    };

    GVAR(cacheHash) = createHashMap;
}] call CBA_fnc_addEventHandler;
