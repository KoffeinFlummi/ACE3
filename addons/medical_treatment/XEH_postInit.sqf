
#include "script_component.hpp"

[QEGVAR(medical,initialized), FUNC(checkItems)] call CBA_fnc_addEventHandler;

if (isServer) then {
    [QGVAR(createLitterServer), FUNC(litterHandleCreate)] call CBA_fnc_addEventHandler;
};

// treatment events
[QGVAR(treatmentBandageLocal), FUNC(treatmentBandageLocal)] call CBA_fnc_addEventHandler;
[QGVAR(treatmentMorphineLocal), FUNC(treatmentMorphineLocal)] call CBA_fnc_addEventHandler;
//[QGVAR(treatmentEpipenLocal), FUNC(treatmentEpipenLocal)] call CBA_fnc_addEventHandler;
[QGVAR(treatmentBloodbagLocal), FUNC(treatmentBloodbagLocal)] call CBA_fnc_addEventHandler;
