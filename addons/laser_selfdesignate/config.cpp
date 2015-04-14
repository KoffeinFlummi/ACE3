#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"ace_laser"};
        version = VERSION;
    };
};

#include "CfgEventhandlers.hpp"
#include "CfgWeapons.hpp"
#include "CfgVehicles.hpp"
