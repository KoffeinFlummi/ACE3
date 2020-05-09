class CfgWeapons {
    class NVGoggles;
    class rhsusf_ANPVS_14: NVGoggles { // Monocular
        modelOptics = "";
        EGVAR(nightvision,border) = QPATHTOEF(nightvision,data\nvg_mask_4096.paa);
        EGVAR(nightvision,bluRadius) = 0.13;
    };
    class rhsusf_ANPVS_15: rhsusf_ANPVS_14 { // Binocular (same as base)
        modelOptics = "";
        EGVAR(nightvision,border) = QPATHTOEF(nightvision,data\nvg_mask_binos_4096.paa);
        EGVAR(nightvision,bluRadius) = 0.15;
    };

    class Pistol_Base_F;
    class Rifle_Base_F;
    class srifle_EBR_F;
    class launch_O_Titan_F;
    class GM6_base_F;
    class rhs_weap_M107_Base_F: GM6_base_F {
        ACE_barrelTwist = 381.0;
        ACE_barrelLength = 736.6;
        ACE_RailHeightAboveBore = 4.18639;
    };
    class rhs_weap_XM2010_Base_F: Rifle_Base_F {
        ACE_barrelTwist = 254.0;
        ACE_barrelLength = 609.6;
        ACE_Overheating_dispersion = 0.75;
        ACE_RailHeightAboveBore = 3.1028;
    };
    class rhs_weap_m24sws: rhs_weap_XM2010_Base_F {
        ACE_barrelTwist = 285.75;
        ACE_barrelLength = 609.6;
        ACE_RailHeightAboveBore = 2.41891;
    };
    class rhs_weap_m40a5: rhs_weap_XM2010_Base_F {
        ACE_barrelTwist = 304.8; // 1:12"
        ACE_barrelLength = 635.0; // 25"
        ACE_RailHeightAboveBore = 2.46368;
    };
    class arifle_MX_Base_F;
    class rhs_weap_m4_Base: arifle_MX_Base_F {
        ACE_RailHeightAboveBore = 2.56518;
        ACE_barrelTwist = 177.8;
        ACE_barrelLength = 368.3;
    };
    class rhs_weap_m4a1;
    class rhs_weap_hk416d10: rhs_weap_m4a1 {
        ACE_RailHeightAboveBore = 3.56139;
        ACE_barrelTwist = 177.8;
        ACE_barrelLength = 254;
    };
    class rhs_weap_hk416d145: rhs_weap_hk416d10 {
        ACE_barrelTwist = 177.8;
        ACE_barrelLength = 368.3;
    };
    class rhs_weap_m27iar: rhs_weap_m4a1 {
        ACE_RailHeightAboveBore = 3.56139;
        ACE_barrelTwist = 177.8;
        ACE_barrelLength = 419.1;
    };
    class rhs_weap_m4a1_blockII;
    class rhs_weap_mk18: rhs_weap_m4a1_blockII {
        ACE_RailHeightAboveBore = 2.6068;
        ACE_barrelTwist = 177.8;
        ACE_barrelLength = 261.62;
    };
    class rhs_weap_m16a4: rhs_weap_m4_Base {
        ACE_RailHeightAboveBore = 2.59324;
        ACE_barrelTwist = 177.8;
        ACE_barrelLength = 508.0;
    };
    class rhs_weap_saw_base: Rifle_Base_F { // Base class for all Minimi
        ACE_Overheating_allowSwapBarrel = 1;
    };
    class rhs_weap_lmg_minimi_railed;
    class rhs_weap_m249_pip_S: rhs_weap_lmg_minimi_railed {
        ACE_RailHeightAboveBore = 3;
        ACE_barrelLength = 348;
        ACE_barrelTwist = 177.8;
    };
    class rhs_weap_m249_pip_L: rhs_weap_lmg_minimi_railed {
        ACE_RailHeightAboveBore = 3;
        ACE_barrelLength = 464.8;
        ACE_barrelTwist = 177.8;
    };
    class rhs_weap_m249: rhs_weap_lmg_minimi_railed {
        ACE_barrelLength = 464.8;
        ACE_barrelTwist = 177.8;
    };
    class rhs_weap_m249_pip: rhs_weap_lmg_minimi_railed {
        ACE_RailHeightAboveBore = 3;
        ACE_barrelLength = 464.8;
        ACE_barrelTwist = 177.8;
    };
    class rhs_weap_M249_base;
    class rhs_weap_m240_base: rhs_weap_M249_base {
        ACE_RailHeightAboveBore = 2.68925;
        ACE_barrelTwist = 304.8;
        ACE_barrelLength = 629.92;
        ACE_Overheating_allowSwapBarrel = 1;
    };
    class rhs_weap_m14_base: srifle_EBR_F {
        ACE_barrelTwist = 304.8;
        ACE_barrelLength = 558.8;
        ACE_Overheating_dispersion = 0.75;
        ACE_RailHeightAboveBore = 1.98812;
    };
    class rhs_weap_m14_socom_base: rhs_weap_m14_base {
      ACE_barrelTwist = 304.8;
      ACE_barrelLength = 413; //16.25 in (413 mm)
      ACE_Overheating_dispersion = 0.75;
      ACE_RailHeightAboveBore = 1.98812;
    };
    class rhs_weap_m14ebrri;
    class rhs_weap_sr25: rhs_weap_m14ebrri {
        ACE_barrelTwist = 285.75;
        ACE_barrelLength = 609.6;
        ACE_RailHeightAboveBore = 1.98812;
    };
    class rhs_weap_sr25_ec: rhs_weap_sr25 {
        ACE_barrelTwist = 285.75;
        ACE_barrelLength = 508.0;
        ACE_RailHeightAboveBore = 1.98812;
    };
    class rhs_weap_SCAR_H_Base;
    class rhs_weap_SCAR_H_CQC_Base : rhs_weap_SCAR_H_Base {
        ACE_barrelTwist =  304.8; // 1:12"
        ACE_barrelLength = 330.0;
        ACE_RailHeightAboveBore = 3;
    };
    class rhs_weap_SCAR_H_LB_Base : rhs_weap_SCAR_H_CQC_Base {
        ACE_barrelTwist =  304.8; // 1:12"
        ACE_barrelLength = 508.0;
        ACE_RailHeightAboveBore = 3;
    };
    class rhs_weap_SCAR_H_STD_Base : rhs_weap_SCAR_H_LB_Base {
        ACE_barrelTwist =  304.8; // 1:12"
        ACE_barrelLength = 406.0;
        ACE_RailHeightAboveBore = 3;
    };
    class rhs_weap_M590_5RD: Rifle_Base_F {
        ACE_barrelTwist = 0.0;
        ACE_twistDirection = 0;
        ACE_barrelLength = 469.9;
    };
    class rhs_weap_M590_8RD: rhs_weap_M590_5RD {
        ACE_barrelTwist = 0.0;
        ACE_twistDirection = 0;
        ACE_barrelLength = 508.0;
    };
    class SMG_02_base_F;
    class rhsusf_weap_MP7A1_base_f: SMG_02_base_F {
        ACE_barrelLength = 180;
        ACE_barrelTwist = 160;
        ACE_IronSightBaseAngle = -0.286479; // 5 mRad POA = POI at the default discreteDistance 100 m, SMG_02_base_F default value 0.434847
        ACE_RailBaseAngle = 0; // SMG_02_base_F default value 0.0217724
        ACE_RailHeightAboveBore = 5;
    };
    // RHS pistols
    class hgun_ACPC2_F;
    class rhsusf_weap_m1911a1: hgun_ACPC2_F {
        ACE_barrelTwist = 406.4;
        ACE_barrelLength = 127.0;
    };
    class hgun_P07_F;
    class rhsusf_weap_glock17g4: hgun_P07_F {
        ACE_barrelTwist = 248.92;
        ACE_barrelLength = 114.046;
    };
    class rhsusf_weap_m9: rhsusf_weap_glock17g4 {
        ACE_barrelTwist = 248.92;
        ACE_barrelLength = 124.46;
    };
    // RHS sniper scopes
    class ItemCore;
    class InventoryOpticsItem_Base_F;
    class rhsusf_acc_sniper_base: ItemCore {
        ACE_ScopeAdjust_Vertical[] = {-4, 30};
        ACE_ScopeAdjust_Horizontal[] = {-6, 6};
        ACE_ScopeAdjust_VerticalIncrement = 0.1;
        ACE_ScopeAdjust_HorizontalIncrement = 0.1;
        class ItemInfo: InventoryOpticsItem_Base_F {
            class OpticsModes {
                class pso1_scope {
                    discreteDistance[] = {100};
                    discreteDistanceInitIndex = 0;
                };
            };
        };
    };
    // ACOG is a sniper scope for some reason, but we don't want scope adjust
    class rhsusf_acc_ACOG: rhsusf_acc_sniper_base {
        ACE_ScopeAdjust_Vertical[] = { 0, 0 };
        ACE_ScopeAdjust_Horizontal[] = { 0, 0 };
        ACE_ScopeAdjust_VerticalIncrement = 0;
        ACE_ScopeAdjust_HorizontalIncrement = 0;
    };
    class rhsusf_acc_LEUPOLDMK4: rhsusf_acc_sniper_base {
        ACE_ScopeHeightAboveRail = 2.62567;
    };
    class rhsusf_acc_LEUPOLDMK4_2: rhsusf_acc_sniper_base {
        ACE_ScopeHeightAboveRail = 3.86377;
        class ItemInfo: InventoryOpticsItem_Base_F {
            class OpticsModes {
                class pso1_scope {
                    discreteDistance[] = {100};
                    discreteDistanceInitIndex = 0;
                };
            };
        };
    };
    class rhsusf_acc_premier: rhsusf_acc_LEUPOLDMK4_2 {
        ACE_ScopeHeightAboveRail = 5.26066;
        class ItemInfo: InventoryOpticsItem_Base_F {
            class OpticsModes {
                class pso1_scope {
                    discreteDistance[] = {100};
                    discreteDistanceInitIndex = 0;
                };
            };
        };
    };
    class rhsusf_acc_premier_low: rhsusf_acc_premier {
        ACE_ScopeHeightAboveRail = 3.90899;
    };
    class rhsusf_acc_premier_anpvs27: rhsusf_acc_premier {
        ACE_ScopeHeightAboveRail = 5.25066;
        class ItemInfo: InventoryOpticsItem_Base_F {
            class OpticsModes {
                class pso1_nvg {
                    discreteDistance[] = {100};
                    discreteDistanceInitIndex = 0;
                };
            };
        };
    };
    class rhsusf_acc_M8541: rhsusf_acc_premier { // http://www.schmidtundbender.de/en/products/police-and-military-forces/3-12x50-pm-iilpmtc.html
        ACE_ScopeHeightAboveRail = 4.2235;
        ACE_ScopeAdjust_Vertical[] = {0, 22};
        ACE_ScopeAdjust_Horizontal[] = {-6, 6};
        ACE_ScopeAdjust_VerticalIncrement = 0.1;
        ACE_ScopeAdjust_HorizontalIncrement = 0.1;
        class ItemInfo: InventoryOpticsItem_Base_F {
            class OpticsModes {
                class Snip {
                    discreteDistance[] = {100};
                    discreteDistanceInitIndex = 0;
                };
            };
        };
    };
    class rhsusf_acc_M8541_low: rhsusf_acc_M8541 {
        ACE_ScopeHeightAboveRail = 2.9789;
    };
    // RHS lauchers
    class rhs_weap_fgm148: launch_O_Titan_F {
        ace_javelin_enabled = 1;
        weaponInfoType = "ACE_RscOptics_javelin";
        modelOptics = "\z\ace\addons\javelin\data\reticle_titan.p3d";
        canLock = 0;
        lockingTargetSound[] = {"",0,1};
        lockedTargetSound[] = {"",0,1};
        class Single;
        class Cruise: Single {
            EGVAR(missileGuidance,attackProfile) = "JAV_DIR";
        };
        class TopDown: Single {
            EGVAR(missileGuidance,attackProfile) = "JAV_TOP";
        };
    };

    class Launcher;
    class Launcher_Base_F: Launcher {
        class WeaponSlotsInfo;
    };
    class rhs_weap_smaw: Launcher_Base_F {
        ace_reloadlaunchers_enabled = 1;
        ace_overpressure_angle = 45;
    };
    class rhs_weap_maaws: Launcher_Base_F {
        ace_reloadlaunchers_enabled = 1;
        ace_overpressure_range = 15;
        ace_overpressure_angle = 70;
        ace_overpressure_damage = 0.75;
    };

    #define HEARING_PROTECTION_OPEN EGVAR(hearing,protection) = 0; EGVAR(hearing,lowerVolume) = 0;
    #define HEARING_PROTECTION_VICCREW EGVAR(hearing,protection) = 0.85; EGVAR(hearing,lowerVolume) = 0.6;
    #define HEARING_PROTECTION_EARMUFF EGVAR(hearing,protection) = 0.75; EGVAR(hearing,lowerVolume) = 0.5;
    #define HEARING_PROTECTION_PELTOR EGVAR(hearing,protection) = 0.75; EGVAR(hearing,lowerVolume) = 0;
    // Fast Helmets
    class rhsusf_opscore_01;
    class rhsusf_opscore_ut_pelt_nsw: rhsusf_opscore_01 {
        HEARING_PROTECTION_PELTOR
    };
    class rhsusf_opscore_aor1_pelt: rhsusf_opscore_01 {
        HEARING_PROTECTION_PELTOR
    };
    class rhsusf_opscore_aor1_pelt_nsw: rhsusf_opscore_01 {
        HEARING_PROTECTION_PELTOR
    };
    class rhsusf_opscore_bk_pelt: rhsusf_opscore_01 {
        HEARING_PROTECTION_PELTOR
    };
    class rhsusf_opscore_fg_pelt: rhsusf_opscore_01 {
        HEARING_PROTECTION_PELTOR
    };
    class rhsusf_opscore_fg_pelt_nsw: rhsusf_opscore_01 {
        HEARING_PROTECTION_PELTOR
    };
    class rhsusf_opscore_fg_pelt_cam: rhsusf_opscore_01 {
        HEARING_PROTECTION_PELTOR
    };
    class rhsusf_opscore_paint_pelt: rhsusf_opscore_01 {
        HEARING_PROTECTION_PELTOR
    };
    class rhsusf_opscore_paint_pelt_nsw: rhsusf_opscore_01 {
        HEARING_PROTECTION_PELTOR
    };
    class rhsusf_opscore_paint_pelt_nsw_cam: rhsusf_opscore_01 {
        HEARING_PROTECTION_PELTOR
    };
    class rhsusf_opscore_aor2_pelt: rhsusf_opscore_01 {
        HEARING_PROTECTION_PELTOR
    };
    class rhsusf_opscore_aor2_pelt_nsw: rhsusf_opscore_01 {
        HEARING_PROTECTION_PELTOR
    };
    class rhsusf_opscore_ut_pelt: rhsusf_opscore_01 {
        HEARING_PROTECTION_PELTOR
    };
    class rhsusf_opscore_ut_pelt_cam: rhsusf_opscore_01 {
        HEARING_PROTECTION_PELTOR
    };
    class rhsusf_opscore_ut_pelt_nsw_cam: rhsusf_opscore_01 {
        HEARING_PROTECTION_PELTOR
    };
    class rhsusf_opscore_mc_pelt: rhsusf_opscore_01 {
        HEARING_PROTECTION_PELTOR
    };
    class rhsusf_opscore_mc_pelt_nsw: rhsusf_opscore_01 {
        HEARING_PROTECTION_PELTOR
    };
    class rhsusf_opscore_cover;
    class rhsusf_opscore_mc_cover_pelt_nsw: rhsusf_opscore_cover {
        HEARING_PROTECTION_PELTOR
    };
    class rhsusf_opscore_mc_cover_pelt: rhsusf_opscore_cover {
        HEARING_PROTECTION_PELTOR
    };
    class rhsusf_opscore_mc_cover_pelt_cam: rhsusf_opscore_cover {
        HEARING_PROTECTION_PELTOR
    };
    class rhsusf_opscore_rg_cover_pelt: rhsusf_opscore_cover {
        HEARING_PROTECTION_PELTOR
    };
    class rhsusf_opscore_coy_cover_pelt: rhsusf_opscore_cover {
        HEARING_PROTECTION_PELTOR
    };
    class rhsusf_opscore_mar_01;
    class rhsusf_opscore_mar_ut_pelt: rhsusf_opscore_mar_01 {
        HEARING_PROTECTION_PELTOR
    };
    class rhsusf_opscore_mar_fg_pelt: rhsusf_opscore_mar_01 {
        HEARING_PROTECTION_PELTOR
    };

    // ACH Helmets
    class rhsusf_ach_helmet_ocp;
    class rhsusf_ach_bare_des_headset: rhsusf_ach_helmet_ocp {
        HEARING_PROTECTION_PELTOR
    };
    class rhsusf_ach_bare_des_headset_ess: rhsusf_ach_helmet_ocp {
        HEARING_PROTECTION_PELTOR
    };
    class rhsusf_ach_bare_headset: rhsusf_ach_helmet_ocp {
        HEARING_PROTECTION_PELTOR
    };
    class rhsusf_ach_bare_headset_ess: rhsusf_ach_helmet_ocp {
        HEARING_PROTECTION_PELTOR
    };
    class rhsusf_ach_bare_semi_headset: rhsusf_ach_helmet_ocp {
        HEARING_PROTECTION_PELTOR
    };
    class rhsusf_ach_bare_semi_headset_ess: rhsusf_ach_helmet_ocp {
        HEARING_PROTECTION_PELTOR
    };
    class rhsusf_ach_bare_tan_headset: rhsusf_ach_helmet_ocp {
        HEARING_PROTECTION_PELTOR
    };
    class rhsusf_ach_bare_tan_headset_ess: rhsusf_ach_helmet_ocp {
        HEARING_PROTECTION_PELTOR
    };
    class rhsusf_ach_bare_wood_headset: rhsusf_ach_helmet_ocp {
        HEARING_PROTECTION_PELTOR
    };
    class rhsusf_ach_bare_wood_headset_ess: rhsusf_ach_helmet_ocp {
        HEARING_PROTECTION_PELTOR
    };
    class rhsusf_ach_helmet_headset_ocp: rhsusf_ach_helmet_ocp {
        HEARING_PROTECTION_PELTOR
    };
    class rhsusf_ach_helmet_headset_ess_ocp: rhsusf_ach_helmet_ocp {
        HEARING_PROTECTION_PELTOR
    };

    // ACVC Helmets
    class rhsusf_cvc_helmet: rhsusf_opscore_01 {
        HEARING_PROTECTION_VICCREW
    };

    // MICH Helmets
    class rhsusf_mich_bare;
    class rhsusf_mich_bare_alt: rhsusf_mich_bare {
        HEARING_PROTECTION_PELTOR
    };
    class rhsusf_mich_bare_norotos;
    class rhsusf_mich_bare_norotos_alt: rhsusf_mich_bare_norotos {
        HEARING_PROTECTION_PELTOR
    };
    class rhsusf_mich_bare_norotos_arc;
    class rhsusf_mich_bare_norotos_arc_alt: rhsusf_mich_bare_norotos_arc {
        HEARING_PROTECTION_PELTOR
    };
    class rhsusf_mich_bare_semi;
    class rhsusf_mich_bare_alt_semi: rhsusf_mich_bare_semi {
        HEARING_PROTECTION_PELTOR
    };
    class rhsusf_mich_bare_norotos_semi;
    class rhsusf_mich_bare_norotos_alt_semi: rhsusf_mich_bare_norotos_semi {
        HEARING_PROTECTION_PELTOR
    };
    class rhsusf_mich_bare_norotos_arc_semi: rhsusf_mich_bare_norotos_alt_semi {
        HEARING_PROTECTION_OPEN
    };
    class rhsusf_mich_bare_norotos_arc_alt_semi: rhsusf_mich_bare_norotos_arc_semi {
        HEARING_PROTECTION_PELTOR
    };
    class rhsusf_mich_bare_tan;
    class rhsusf_mich_bare_alt_tan: rhsusf_mich_bare_tan {
        HEARING_PROTECTION_PELTOR
    };
    class rhsusf_mich_bare_norotos_tan;
    class rhsusf_mich_bare_norotos_alt_tan: rhsusf_mich_bare_norotos_tan {
        HEARING_PROTECTION_PELTOR
    };
    class rhsusf_mich_bare_norotos_arc_tan;
    class rhsusf_mich_bare_norotos_arc_alt_tan: rhsusf_mich_bare_norotos_arc_tan {
        HEARING_PROTECTION_PELTOR
    };

    class rhsusf_hgu56p: rhsusf_opscore_01 {
        HEARING_PROTECTION_VICCREW
    };
    class rhsusf_hgu56p_visor: rhsusf_hgu56p {
        ACE_Protection = 1;
    };
    class rhsusf_hgu56p_black;
    class rhsusf_hgu56p_visor_black: rhsusf_hgu56p_black {
        ACE_Protection = 1;
    };
    class rhsusf_hgu56p_green;
    class rhsusf_hgu56p_visor_green: rhsusf_hgu56p_green {
        ACE_Protection = 1;
    };
    class rhsusf_hgu56p_visor_mask: rhsusf_hgu56p {
        ACE_Protection = 1;
    };
    class rhsusf_hgu56p_visor_mask_black: rhsusf_hgu56p_black {
        ACE_Protection = 1;
    };
    class rhsusf_hgu56p_visor_mask_Empire_black: rhsusf_hgu56p_black {
        ACE_Protection = 1;
    };
    class rhsusf_hgu56p_visor_mask_green: rhsusf_hgu56p_green {
        ACE_Protection = 1;
    };
    class rhsusf_hgu56p_mask_smiley;
    class rhsusf_hgu56p_visor_mask_smiley: rhsusf_hgu56p_mask_smiley {
        ACE_Protection = 1;
    };
    class rhsusf_hgu56p_pink;
    class rhsusf_hgu56p_visor_mask_pink: rhsusf_hgu56p_pink {
        ACE_Protection = 1;
    };
    class rhsusf_hgu56p_visor_pink: rhsusf_hgu56p_pink {
        ACE_Protection = 1;
    };
    class rhsusf_hgu56p_saf;
    class rhsusf_hgu56p_visor_saf: rhsusf_hgu56p_saf {
        ACE_Protection = 1;
    };
    class rhsusf_hgu56p_usa;
    class rhsusf_hgu56p_visor_usa: rhsusf_hgu56p_usa {
        ACE_Protection = 1;
    };
    class rhsusf_hgu56p_white;
    class rhsusf_hgu56p_visor_white: rhsusf_hgu56p_white {
        ACE_Protection = 1;
    };
    class rhsusf_hgu56p_visor_mask_black_skull;
    class rhsusf_hgu56p_mask_black_skull: rhsusf_hgu56p_visor_mask_black_skull {
        ACE_Protection = 0;
    };
    class rhsusf_ihadss: rhsusf_opscore_01 {
        HEARING_PROTECTION_VICCREW
    };

    class H_HelmetB;
    class RHS_jetpilot_usaf: H_HelmetB {
        ACE_Protection = 1;
        HEARING_PROTECTION_VICCREW
    };

    CREATE_CSW_PROXY(rhs_mortar_81mm);
    CREATE_CSW_PROXY(RHS_M2);
    CREATE_CSW_PROXY(RHS_MK19);
    CREATE_CSW_PROXY(Rhs_weap_TOW_Launcher_static);

    class GVAR(m252_carry): Launcher_Base_F {
        class ACE_CSW {
            type = "weapon";
            deployTime = 20;
            pickupTime = 25;
            class assembleTo {
                EGVAR(csw,mortarBaseplate) = "RHS_M252_WD";
            };
        };
        class WeaponSlotsInfo: WeaponSlotsInfo {
            // One WeaponSlot with a positive value for iconScale forces game to use icon overlay method.
            // Required, because the inventory icon has no accessory variants.
            class MuzzleSlot {
                iconScale = 0.1;
            };
            mass = 620; // M252 Mortar Weight
        };
        displayName = ECSTRING(CSW,m252_tube);
        author = ECSTRING(common,ACETeam);
        scope = 2;
        model = QPATHTOEF(apl,ACE_CSW_Bag.p3d);
        modes[] = {};
        picture = "\rhsusf\addons\rhsusf_heavyweapons\data\ico\RHS_M252_D_ca.paa";
    };

    class GVAR(m2_carry): Launcher_Base_F {
        class ACE_CSW {
            type = "weapon";
            deployTime = 4;
            pickupTime = 4;
            class assembleTo {
                EGVAR(csw,m3Tripod) = "RHS_M2StaticMG_WD";
                EGVAR(csw,m3TripodLow) = "RHS_M2StaticMG_MiniTripod_WD";
            };
        };
        class WeaponSlotsInfo: WeaponSlotsInfo {
            class MuzzleSlot {
                iconScale = 0.1;
            };
            mass = 840;
        };
        displayName = ECSTRING(CSW,m2_gun);
        author = ECSTRING(common,ACETeam);
        scope = 2;
        model = QPATHTOEF(apl,ACE_CSW_Bag.p3d);
        modes[] = {};
        picture = "\rhsusf\addons\rhsusf_heavyweapons\data\ico\RHS_M2StaticMG_D_ca.paa";
    };

    class GVAR(mk19_carry): Launcher_Base_F {
        class ACE_CSW {
            type = "weapon";
            deployTime = 4;
            pickupTime = 4;
            class assembleTo {
                EGVAR(csw,m3TripodLow) = "RHS_MK19_TriPod_WD";
            };
        };
        class WeaponSlotsInfo: WeaponSlotsInfo {
            class MuzzleSlot {
                iconScale = 0.1;
            };
            mass = 770;
        };
        displayName = ECSTRING(CSW,mk19_gun);
        author = ECSTRING(common,ACETeam);
        scope = 2;
        model = QPATHTOEF(apl,ACE_CSW_Bag.p3d);
        modes[] = {};
        picture = "\rhsusf\addons\rhsusf_heavyweapons\data\ico\RHS_MK19_TriPod_D_ca.paa";
    };

    class GVAR(tow_carry): Launcher_Base_F {
        class ACE_CSW {
            type = "weapon";
            deployTime = 4;
            pickupTime = 4;
            class assembleTo {
                EGVAR(csw,m220Tripod) = "RHS_TOW_TriPod_WD";
            };
        };
        class WeaponSlotsInfo: WeaponSlotsInfo {
            class MuzzleSlot {
                iconScale = 0.1;
            };
            mass = 500;
        };
        displayName = ECSTRING(CSW,tow_tube);
        author = ECSTRING(common,ACETeam);
        scope = 2;
        model = QPATHTOEF(apl,ACE_CSW_Bag.p3d);
        modes[] = {};
        picture = "\rhsusf\addons\rhsusf_heavyweapons\data\Ico\RHS_TOW_TriPod_D_ca.paa";
    };
};
