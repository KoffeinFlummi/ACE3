#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {
            "ACE_HandFlare_White",
            "ACE_HandFlare_Red",
            "ACE_HandFlare_Green",
            "ACE_HandFlare_Yellow",
            "ACE_M84",
            "ACE_M14",
            "ACE_CTS9",
            "ACE_SatchelCharge_Remote_Mag_Throwable",
            "ACE_DemoCharge_Remote_Mag_Throwable"
        };
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"ace_common","ace_explosives"};
        author = ECSTRING(common,ACETeam);
        authors[] = {"commy2","KoffeinFlummi"};
        url = ECSTRING(main,URL);
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgAmmo.hpp"
#include "CfgWeapons.hpp"
#include "CfgMagazines.hpp"
#include "CfgMagazineWells.hpp"
#include "CfgVehicles.hpp"

#include "Effects.hpp"
