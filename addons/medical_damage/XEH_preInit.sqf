#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

call FUNC(parseConfigForInjuries);

addMissionEventHandler ["Loaded",{
    INFO("Mission Loaded - Reloading medical configs for extension");
    // Reload configs into extension (handle full game restart)
    call FUNC(parseConfigForInjuries);
}];

// decide which woundsHandler to use by whether the extension is present or not  
if ("ace_medical" callExtension "version" != "") then {
    DFUNC(woundsHandlerActive) = LINKFUNC(woundsHandler);
} else {
    DFUNC(woundsHandlerActive) = LINKFUNC(woundsHandlerSQF);
};

[QEGVAR(medical_engine,woundReceived), {
    params ["_unit", "_woundedHitPoint", "_receivedDamage", "", "_ammo"];

    private _typeOfDamage = _ammo call FUNC(getTypeOfDamage);
    [_unit, _woundedHitPoint, _receivedDamage, _typeOfDamage] call FUNC(woundsHandlerActive);

    // Disable for now:
    // [_unit, EGVAR(medical,STATE_MACHINE)] call EFUNC(medical,addStateHandler);
}] call CBA_fnc_addEventHandler;

ADDON = true;
