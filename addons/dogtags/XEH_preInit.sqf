#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

GVAR(disabledFactions) = createHashMap;

GVAR(dogtagsData) = createHashMap;

if (isServer) then {
    GVAR(idCounter) = 0;
};

ADDON = true;
