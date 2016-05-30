#include "script_component.hpp"

class CfgPatches {
  class ADDON {
    units[] = {};
    weapons[] = {};
    requiredVersion = REQUIRED_VERSION;
    requiredAddons[] = {"ace_interaction"};
    author[] = {"PabstMirror"};
    authorUrl = "https://github.com/acemod/ACE3";
    VERSION_CONFIG;
  };
};

#include "CfgEventHandlers.hpp"

#include "CfgMagazines.hpp"
#include "CfgVehicles.hpp"
#include "CfgWeapons.hpp"

//#include "CBA_Settings.hpp"
