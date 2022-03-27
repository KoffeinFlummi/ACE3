#if __has_include("\z\ace\addons\nomedical\script_component.hpp")

#else

#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {"ACE_fieldDressingItem","ACE_packingBandageItem","ACE_elasticBandageItem","ACE_tourniquetItem","ACE_splintItem","ACE_morphineItem","ACE_adenosineItem","ACE_epinephrineItem","ACE_plasmaIVItem","ACE_bloodIVItem","ACE_salineIVItem","ACE_quikClotItem","ACE_personalAidKitItem","ACE_surgicalKitItem","ACE_bodyBagItem","ACE_medicalSupplyCrate","ACE_medicalSupplyCrate_advanced"};
        weapons[] = {"ACE_fieldDressing","ACE_packingBandage","ACE_elasticBandage","ACE_tourniquet","ACE_splint","ACE_morphine","ACE_adenosine","ACE_epinephrine","ACE_plasmaIV","ACE_plasmaIV_500","ACE_plasmaIV_250","ACE_bloodIV","ACE_bloodIV_500","ACE_bloodIV_250","ACE_salineIV","ACE_salineIV_500","ACE_salineIV_250","ACE_quikclot","ACE_personalAidKit","ACE_surgicalKit","ACE_bodyBag"};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"ace_medical_status", "ace_medical_damage", "ace_apl"};
        author = ECSTRING(common,ACETeam);
        authors[] = {"Glowbal", "KoffeinFlummi", "Arcanum"};
        url = ECSTRING(main,URL);
        VERSION_CONFIG;
    };
};

#include "ACE_Medical_Treatment.hpp"
#include "ACE_Medical_Treatment_Actions.hpp"
#include "ACE_Medical_Facilities.hpp"
#include "CfgEventHandlers.hpp"
#include "CfgReplacementItems.hpp"
#include "CfgVehicles.hpp"
#include "CfgWeapons.hpp"
#include "Cfg3DEN.hpp"

#endif
