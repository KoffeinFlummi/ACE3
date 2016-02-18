#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"ace_common"};
        author[] = {"Nou"};
        VERSION_CONFIG;
    };
};

#include "CfgEventhandlers.hpp"
#include "Cfg3DEN.hpp"

#include "CfgAmmo.hpp"
