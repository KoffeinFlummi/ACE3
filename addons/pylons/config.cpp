#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"ace_interact_menu", "ace_zeus"};
        author = ECSTRING(common,ACETeam);
        authors[] = {"654wak654"};
        url = ECSTRING(main,URL);
        VERSION_CONFIG;
    };
};

#include "ACE_Settings.cpp"
#include "CfgEventHandlers.hpp"
#include "menu.hpp"
