#include "script_component.hpp"

#if __has_include("\vn\weapons_f_vietnam\config.bin")
#else
    #define PATCH_SKIP "SOG-Vietnam"
#endif

#if __has_include("\z\ace\addons\csw\script_component.hpp")
#else
    #ifdef PATCH_SKIP
    #else
        #define PATCH_SKIP "ACE Trenches"
    #endif
#endif

#if __has_include("\x\grad_trenches\addons\main\script_component.hpp")
#else
    #ifdef PATCH_SKIP
    #else
        #define PATCH_SKIP "Grad Trenches"
    #endif
#endif

#ifdef PATCH_SKIP
ACE_PATCH_NOT_LOADED(ADDON,PATCH_SKIP)
#else

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {
            "loadorder_f_vietnam", "ace_compat_sog_trenches", "grad_trenches_main"
        };
        skipWhenMissingDependencies = 1;
        author = ECSTRING(common,ACETeam);
        authors[] = {"BaerMitUmlaut", "veteran29"};
        url = ECSTRING(main,URL);
        VERSION_CONFIG;
    };
};

#include "CfgVehicles.hpp"

#endif
