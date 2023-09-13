#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

GVAR(captivityEnabled) = false;

GVAR(restraints) = call (uiNamespace getVariable QGVAR(restraints));
GVAR(lockedRestraints) = call (uiNamespace getVariable QGVAR(lockedRestraints));

#include "initSettings.sqf"

ADDON = true;
