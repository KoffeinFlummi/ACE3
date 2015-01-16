
class Mode_SemiAuto;
class Mode_FullAuto;
class SlotInfo;

class CfgWeapons {

    /* MX */

    class Rifle;
    class Rifle_Base_F: Rifle {
        class WeaponSlotsInfo;
    };

    class arifle_MX_Base_F: Rifle_Base_F {
        magazines[] += {
            "ACE_30Rnd_65x39_caseless_mag_Tracer_Dim",
            "ACE_30Rnd_65x39_caseless_mag_SD",
            "ACE_30Rnd_65x39_caseless_mag_AP",
            "100Rnd_65x39_caseless_mag",
            "100Rnd_65x39_caseless_mag_Tracer"
        };

        class Single: Mode_SemiAuto {
            dispersion = 0.000800; // radians. Equal to 2.75 MOA.
            // Based on widely cited 2 MOA figure for new 5.56 ACR.
        };

        class FullAuto: Mode_FullAuto {
            dispersion = 0.00147; // radians. Equal to 5.1 MOA.
        };

        class WeaponSlotsInfo: WeaponSlotsInfo {
            class MuzzleSlot: SlotInfo {
                compatibleItems[] += {"ACE_muzzle_mzls_H"};
            };
        };
    };

    class arifle_MX_SW_F: arifle_MX_Base_F {
        magazines[] += {
            "30Rnd_65x39_caseless_mag",
            "30Rnd_65x39_caseless_mag_Tracer"
        };

        class Single: Mode_SemiAuto {
            dispersion = 0.000800; // radians. Equal to 2.75 MOA.
            // Based on widely cited 2 MOA figure for new 5.56 ACR.
        };

        class manual: FullAuto {
            dispersion = 0.00147; // radians. Equal to 5.1 MOA.
        };

        class WeaponSlotsInfo: WeaponSlotsInfo {
            class MuzzleSlot: MuzzleSlot {
                // Shit is broken again
                //compatibleItems[] += {"ACE_muzzle_mzls_H"};
                compatibleItems[] = {"muzzle_snds_H","muzzle_snds_H_SW","ACE_muzzle_mzls_H"};
            };
        };
    };

    class arifle_MXM_F: arifle_MX_Base_F {
        magazines[] += {
            "30Rnd_65x39_caseless_mag",
            "30Rnd_65x39_caseless_mag_Tracer"
        };

        class Single: Single {
            dispersion = 0.00029; // radians. Equal to 1 MOA.
            // 6.5mm is easily capable of this in a half-tuned rifle.
        };

        class FullAuto: FullAuto {
            dispersion = 0.000800; // radians. Equal to 2.75 MOA.
        };
    };


    /* Katiba */

    class arifle_katiba_Base_F: Rifle_Base_F {
        magazines[] += {
            "ACE_30Rnd_65x39_caseless_green_mag_Tracer_Dim",
            "ACE_30Rnd_65x39_caseless_green_mag_SD",
            "ACE_30Rnd_65x39_caseless_green_mag_AP"
        };

        class Single: Mode_SemiAuto {
            dispersion = 0.000800; // radians. Equal to 2.75 MOA.
            // Based on widely cited 2 MOA figure for new 5.56 ACR?
            // Use your imagination for fictional weapons!
        };

        class FullAuto: Mode_FullAuto {
            dispersion = 0.00147; // radians. Equal to 5.1 MOA.
        };

        class WeaponSlotsInfo: WeaponSlotsInfo {
            class MuzzleSlot: SlotInfo {
                compatibleItems[] += {"ACE_muzzle_mzls_H"};
            };
        };
    };


    /* Other */

    class Rifle_Long_Base_F: Rifle_Base_F {
        class WeaponSlotsInfo;
    };

    class EBR_base_F: Rifle_Long_Base_F {
        class WeaponSlotsInfo: WeaponSlotsInfo {
            class MuzzleSlot: SlotInfo {
                compatibleItems[] += {"ACE_muzzle_mzls_B"};
            };
        };
    };

    class DMR_01_base_F: Rifle_Long_Base_F {
        class WeaponSlotsInfo: WeaponSlotsInfo {
            class MuzzleSlot: SlotInfo {
                compatibleItems[] += {"ACE_muzzle_mzls_B"};
            };
        };
    };

    class LMG_Mk200_F: Rifle_Long_Base_F {
        class manual: Mode_FullAuto {
            dispersion = 0.00175; // radians. Equal to 6 MOA.
        };

        class Single: manual {
            dispersion = 0.00175; // radians. Equal to 6 MOA.
        };

        class WeaponSlotsInfo: WeaponSlotsInfo {
            class MuzzleSlot: SlotInfo {
                compatibleItems[] += {"ACE_muzzle_mzls_H"};
            };
        };
    };

    class LMG_Zafir_F: Rifle_Long_Base_F {
        class FullAuto: Mode_FullAuto {
            dispersion = 0.00175; // radians. Equal to 6 MOA.
        };

        class Single: Mode_SemiAuto {
            dispersion = 0.00175; // radians. Equal to 6 MOA.
        };

        class WeaponSlotsInfo: WeaponSlotsInfo {
            class MuzzleSlot: SlotInfo {
                compatibleItems[] += {"ACE_muzzle_mzls_B"};
            };
        };
    };


    /* Assault Rifles */

    class Tavor_base_F: Rifle_Base_F {
        magazines[] += {
            "ACE_30Rnd_556x45_Stanag_Tracer_Dim",
            "ACE_30Rnd_556x45_Stanag_SD",
            "ACE_30Rnd_556x45_Stanag_AP"
        };

        class Single: Mode_SemiAuto {
            dispersion = 0.000727; // radians. Equal to 2.5 MOA, about the limit of mass-produced M855.
            //
        };

        class FullAuto: Mode_FullAuto {
            dispersion = 0.00147; // radians. Equal to 5.1 MOA.
        };

        class WeaponSlotsInfo: WeaponSlotsInfo {
            class MuzzleSlot: SlotInfo {
                compatibleItems[] += {"ACE_muzzle_mzls_L"};
            };
        };
    };

    class mk20_base_F: Rifle_Base_F {
        magazines[] += {
            "ACE_30Rnd_556x45_Stanag_Tracer_Dim",
            "ACE_30Rnd_556x45_Stanag_SD",
            "ACE_30Rnd_556x45_Stanag_AP"
        };

        class Single: Mode_SemiAuto {
            dispersion = 0.0008727; // radians. Equal to 3 MOA, about the limit of mass-produced M855 plus
            // some extra for these worn out Greek Army service rifles.
        };

        class FullAuto: Mode_FullAuto {
            dispersion = 0.00147; // radians. Equal to 5.1 MOA.
        };

        class WeaponSlotsInfo: WeaponSlotsInfo {
            class MuzzleSlot: SlotInfo {
                compatibleItems[] += {"ACE_muzzle_mzls_L"};
            };
        };
    };


    /* SMGs */

    class SDAR_base_F: Rifle_Base_F {
        magazines[] += {
            "ACE_30Rnd_556x45_Stanag_Tracer_Dim",
            "ACE_30Rnd_556x45_Stanag_SD",
            "ACE_30Rnd_556x45_Stanag_AP"
        };

        class Single: Mode_SemiAuto {
            dispersion = 0.0008727; // radians. Equal to 3 MOA, about the limit of mass-produced M855 plus
            // some extra because Kel-Tec.
        };

        class FullAuto: Mode_FullAuto {
            dispersion = 0.00147; // radians. Equal to 5.1 MOA.
        };
    };

    class pdw2000_base_F: Rifle_Base_F {
        class WeaponSlotsInfo: WeaponSlotsInfo {
            class MuzzleSlot: SlotInfo {
                compatibleItems[] += {"ACE_muzzle_mzls_smg_02"};
            };
        };
    };

    class SMG_01_Base: Rifle_Base_F {
        class WeaponSlotsInfo: WeaponSlotsInfo {
            class MuzzleSlot: SlotInfo {
                compatibleItems[] += {"ACE_muzzle_mzls_smg_01"};
            };
        };
    };

    class SMG_02_base_F: Rifle_Base_F {
        class WeaponSlotsInfo: WeaponSlotsInfo {
            class MuzzleSlot: SlotInfo {
                compatibleItems[] += {"ACE_muzzle_mzls_smg_02"};
            };
        };
    };


    /* Pistols */

    class Pistol;
    class Pistol_Base_F: Pistol {
        class WeaponSlotsInfo;
    };

    class hgun_P07_F: Pistol_Base_F {
        class WeaponSlotsInfo: WeaponSlotsInfo {
            class MuzzleSlot: SlotInfo {
                linkProxy = "\A3\data_f\proxies\weapon_slots\MUZZLE";
                compatibleItems[] += {"ACE_muzzle_mzls_smg_02"};
            };
        };
    };

    class hgun_Rook40_F: Pistol_Base_F {
        class WeaponSlotsInfo: WeaponSlotsInfo {
            class MuzzleSlot: SlotInfo {
                linkProxy = "\A3\data_f\proxies\weapon_slots\MUZZLE";
                compatibleItems[] += {"ACE_muzzle_mzls_smg_02"};
            };
        };
    };

    class hgun_ACPC2_F: Pistol_Base_F {
        class WeaponSlotsInfo: WeaponSlotsInfo {
            class MuzzleSlot: SlotInfo {
                compatibleItems[] += {"ACE_muzzle_mzls_smg_01"};
            };
        };
    };

    class hgun_Pistol_heavy_01_F: Pistol_Base_F {
        class WeaponSlotsInfo: WeaponSlotsInfo {
            class MuzzleSlot: SlotInfo {
                compatibleItems[] += {"ACE_muzzle_mzls_smg_01"};
            };
        };
    };

    /*class hgun_Pistol_heavy_02_F: Pistol_Base_F {
        class WeaponSlotsInfo: WeaponSlotsInfo {
            class MuzzleSlot {
                linkProxy = "\A3\data_f\proxies\weapon_slots\MUZZLE";
                compatibleItems[] += {"ACE_muzzle_mzls_smg_01"};
            };
        };
    };*/


    /* Silencers */

    class ItemCore;
    class InventoryMuzzleItem_Base_F;

    class muzzle_snds_H: ItemCore {
        class ItemInfo: InventoryMuzzleItem_Base_F {
            class MagazineCoef {
                initSpeed = 1.0;
            };

            class AmmoCoef {
                hit = 0.9;
                visibleFire = 0.5;
                audibleFire = 0.1;
                visibleFireTime = 0.5;
                audibleFireTime = 0.5;
                cost = 1.0;
                typicalSpeed = 1.0;
                airFriction = 1.0;
            };

            class MuzzleCoef {
                dispersionCoef = "0.8f";
                artilleryDispersionCoef = "1.0f";
                fireLightCoef = "0.5f";
                recoilCoef = "1.0f";
                recoilProneCoef = "1.0f";
                minRangeCoef = "1.0f";
                minRangeProbabCoef = "1.0f";
                midRangeCoef = "1.0f";
                midRangeProbabCoef = "1.0f";
                maxRangeCoef = "1.0f";
                maxRangeProbabCoef = "1.0f";
            };
        };
    };

    class muzzle_snds_L: muzzle_snds_H {
        class ItemInfo: ItemInfo {
            class MagazineCoef {
                initSpeed = 1.0;
            };

            class AmmoCoef {
                hit = 0.9;
                visibleFire = 0.5;
                audibleFire = 0.1;
                visibleFireTime = 0.5;
                audibleFireTime = 0.5;
                cost = 1.0;
                typicalSpeed = 1.0;
                airFriction = 1.0;
            };

            class MuzzleCoef {
                dispersionCoef = "0.8f";
                artilleryDispersionCoef = "1.0f";
                fireLightCoef = "0.5f";
                recoilCoef = "1.0f";
                recoilProneCoef = "1.0f";
                minRangeCoef = "1.0f";
                minRangeProbabCoef = "1.0f";
                midRangeCoef = "1.0f";
                midRangeProbabCoef = "1.0f";
                maxRangeCoef = "1.0f";
                maxRangeProbabCoef = "1.0f";
            };
        };
    };

    class muzzle_snds_M: muzzle_snds_H {
        class ItemInfo: ItemInfo {
            class MagazineCoef {
                initSpeed = 1.0;
            };

            class AmmoCoef {
                hit = 0.9;
                visibleFire = 0.5;
                audibleFire = 0.1;
                visibleFireTime = 0.5;
                audibleFireTime = 0.5;
                cost = 1.0;
                typicalSpeed = 1.0;
                airFriction = 1.0;
            };

            class MuzzleCoef {
                dispersionCoef = "0.8f";
                artilleryDispersionCoef = "1.0f";
                fireLightCoef = "0.5f";
                recoilCoef = "1.0f";
                recoilProneCoef = "1.0f";
                minRangeCoef = "1.0f";
                minRangeProbabCoef = "1.0f";
                midRangeCoef = "1.0f";
                midRangeProbabCoef = "1.0f";
                maxRangeCoef = "1.0f";
                maxRangeProbabCoef = "1.0f";
            };
        };
    };

    class muzzle_snds_B: muzzle_snds_H {
        class ItemInfo: ItemInfo {
            class MagazineCoef {
                initSpeed = 1.0;
            };

            class AmmoCoef {
                hit = 0.9;
                visibleFire = 0.5;
                audibleFire = 0.1;
                visibleFireTime = 0.5;
                audibleFireTime = 0.5;
                cost = 1.0;
                typicalSpeed = 1.0;
                airFriction = 1.0;
            };

            class MuzzleCoef {
                dispersionCoef = "0.8f";
                artilleryDispersionCoef = "1.0f";
                fireLightCoef = "0.5f";
                recoilCoef = "1.0f";
                recoilProneCoef = "1.0f";
                minRangeCoef = "1.0f";
                minRangeProbabCoef = "1.0f";
                midRangeCoef = "1.0f";
                midRangeProbabCoef = "1.0f";
                maxRangeCoef = "1.0f";
                maxRangeProbabCoef = "1.0f";
            };
        };
    };

    class muzzle_snds_H_MG: muzzle_snds_H {
        class ItemInfo: ItemInfo {
            class MagazineCoef {
                initSpeed = 1.0;
            };

            class AmmoCoef {
                hit = 0.9;
                visibleFire = 0.5;
                audibleFire = 0.1;
                visibleFireTime = 0.5;
                audibleFireTime = 0.5;
                cost = 1.0;
                typicalSpeed = 1.0;
                airFriction = 1.0;
            };

            class MuzzleCoef {
                dispersionCoef = "0.8f";
                artilleryDispersionCoef = "1.0f";
                fireLightCoef = "0.5f";
                recoilCoef = "1.0f";
                recoilProneCoef = "1.0f";
                minRangeCoef = "1.0f";
                minRangeProbabCoef = "1.0f";
                midRangeCoef = "1.0f";
                midRangeProbabCoef = "1.0f";
                maxRangeCoef = "1.0f";
                maxRangeProbabCoef = "1.0f";
            };
        };
    };

    class muzzle_snds_H_SW: muzzle_snds_H_MG {
        class ItemInfo: ItemInfo {
            class MagazineCoef {
                initSpeed = 1.0;
            };

            class AmmoCoef {
                hit = 0.9;
                visibleFire = 0.5;
                audibleFire = 0.1;
                visibleFireTime = 0.5;
                audibleFireTime = 0.5;
                cost = 1.0;
                typicalSpeed = 1.0;
                airFriction = 1.0;
            };

            class MuzzleCoef {
                dispersionCoef = "0.8f";
                artilleryDispersionCoef = "1.0f";
                fireLightCoef = "0.5f";
                recoilCoef = "1.0f";
                recoilProneCoef = "1.0f";
                minRangeCoef = "1.0f";
                minRangeProbabCoef = "1.0f";
                midRangeCoef = "1.0f";
                midRangeProbabCoef = "1.0f";
                maxRangeCoef = "1.0f";
                maxRangeProbabCoef = "1.0f";
            };
        };
    };

    class muzzle_snds_acp: muzzle_snds_H {
        class ItemInfo: ItemInfo {
            class MagazineCoef {
                initSpeed = 1.0;
            };

            class AmmoCoef {
                hit = 0.9;
                visibleFire = 0.5;
                audibleFire = 0.1;
                visibleFireTime = 0.5;
                audibleFireTime = 0.5;
                cost = 1.0;
                typicalSpeed = 1.0;
                airFriction = 1.0;
            };

            class MuzzleCoef {
                dispersionCoef = "0.8f";
                artilleryDispersionCoef = "1.0f";
                fireLightCoef = "0.5f";
                recoilCoef = "1.0f";
                recoilProneCoef = "1.0f";
                minRangeCoef = "1.0f";
                minRangeProbabCoef = "1.0f";
                midRangeCoef = "1.0f";
                midRangeProbabCoef = "1.0f";
                maxRangeCoef = "1.0f";
                maxRangeProbabCoef = "1.0f";
            };
        };
    };


    /* Flash suppressors */

    class ACE_muzzle_mzls_H: ItemCore {
        author = "$STR_ACE_Common_ACETeam";
        _generalMacro = "ACE_muzzle_mzls_H";
        htMin = 1;
        htMax = 600;
        afMax = 0;
        mfMax = 0;
        mFact = 1;
        tBody = 100;
        scope = 2;
        displayName = "$STR_ACE_muzzle_mzls_H";
        picture = "\A3\weapons_F\Data\UI\gear_acca_mzls_h_ca.paa";
        model = "\A3\weapons_f\acc\acca_mzls_H_F";

        class ItemInfo: InventoryMuzzleItem_Base_F {
            mass = 8;
            soundTypeIndex = 0;
            muzzleEnd = "zaslehPoint";
            alternativeFire = "Zasleh2";

            class MagazineCoef {
                initSpeed = 1.0;
            };

            class AmmoCoef {
                hit = 1.0;
                visibleFire = 0.5;
                audibleFire = 1.0;
                visibleFireTime = 0.5;
                audibleFireTime = 1.0;
                cost = 1.0;
                typicalSpeed = 1.0;
                airFriction = 1.0;
            };

            class MuzzleCoef {
                dispersionCoef = "0.9f";
                artilleryDispersionCoef = "1.0f";
                fireLightCoef = "0.5f";
                recoilCoef = "1.0f";
                recoilProneCoef = "1.0f";
                minRangeCoef = "1.0f";
                minRangeProbabCoef = "1.0f";
                midRangeCoef = "1.0f";
                midRangeProbabCoef = "1.0f";
                maxRangeCoef = "1.0f";
                maxRangeProbabCoef = "1.0f";
            };
        };

        inertia = 0.2;
    };

    class ACE_muzzle_mzls_B: ACE_muzzle_mzls_H {
        author = "$STR_ACE_Common_ACETeam";
        _generalMacro = "ACE_muzzle_mzls_B";
        displayName = "$STR_ACE_muzzle_mzls_B";
        picture = "\A3\weapons_F\Data\UI\gear_acca_mzls_h_ca.paa";
        model = "\A3\weapons_f\acc\acca_mzls_H_F";

        class ItemInfo: ItemInfo {
            mass = 6;
            soundTypeIndex = 0;
            muzzleEnd = "zaslehPoint";
            alternativeFire = "Zasleh2";

            class MagazineCoef {
                initSpeed = 1.0;
            };

            class AmmoCoef {
                hit = 1.0;
                visibleFire = 0.5;
                audibleFire = 1.0;
                visibleFireTime = 0.5;
                audibleFireTime = 1.0;
                cost = 1.0;
                typicalSpeed = 1.0;
                airFriction = 1.0;
            };

            class MuzzleCoef {
                dispersionCoef = "0.9f";
                artilleryDispersionCoef = "1.0f";
                fireLightCoef = "0.5f";
                recoilCoef = "1.0f";
                recoilProneCoef = "1.0f";
                minRangeCoef = "1.0f";
                minRangeProbabCoef = "1.0f";
                midRangeCoef = "1.0f";
                midRangeProbabCoef = "1.0f";
                maxRangeCoef = "1.0f";
                maxRangeProbabCoef = "1.0f";
            };
        };

        inertia = 0.2;
    };

    class ACE_muzzle_mzls_L: ACE_muzzle_mzls_H {
        author = "$STR_ACE_Common_ACETeam";
        _generalMacro = "ACE_muzzle_mzls_L";
        displayName = "$STR_ACE_muzzle_mzls_L";
        picture = "\A3\weapons_F\Data\UI\gear_acca_mzls_l_ca.paa";
        model = "\A3\weapons_f\acc\acca_mzls_l_F";

        class ItemInfo: ItemInfo {
            mass = 6;
            soundTypeIndex = 0;
            muzzleEnd = "zaslehPoint";
            alternativeFire = "Zasleh2";

            class MagazineCoef {
                initSpeed = 1.0;
            };

            class AmmoCoef {
                hit = 1.0;
                visibleFire = 0.5;
                audibleFire = 1.0;
                visibleFireTime = 0.5;
                audibleFireTime = 1.0;
                cost = 1.0;
                typicalSpeed = 1.0;
                airFriction = 1.0;
            };

            class MuzzleCoef {
                dispersionCoef = "0.9f";
                artilleryDispersionCoef = "1.0f";
                fireLightCoef = "0.5f";
                recoilCoef = "1.0f";
                recoilProneCoef = "1.0f";
                minRangeCoef = "1.0f";
                minRangeProbabCoef = "1.0f";
                midRangeCoef = "1.0f";
                midRangeProbabCoef = "1.0f";
                maxRangeCoef = "1.0f";
                maxRangeProbabCoef = "1.0f";
            };
        };

        inertia = 0.1;
    };

    class ACE_muzzle_mzls_smg_01: ACE_muzzle_mzls_H {
        author = "$STR_ACE_Common_ACETeam";
        _generalMacro = "ACE_muzzle_mzls_smg_01";
        displayName = "$STR_ACE_muzzle_mzls_smg_01";
        picture = "\A3\weapons_F\Data\UI\gear_acca_mzls_l_ca.paa";
        model = "\A3\weapons_f\acc\acca_mzls_H_F"; //"\A3\weapons_f\acc\acca_mzls_smg_01_F";

        class ItemInfo: ItemInfo {
            mass = 6;
            soundTypeIndex = 0;
            muzzleEnd = "zaslehPoint";
            alternativeFire = "Zasleh2";

            class MagazineCoef {
                initSpeed = 1.0;
            };

            class AmmoCoef {
                hit = 1.0;
                visibleFire = 0.5;
                audibleFire = 1.0;
                visibleFireTime = 0.5;
                audibleFireTime = 1.0;
                cost = 1.0;
                typicalSpeed = 1.0;
                airFriction = 1.0;
            };

            class MuzzleCoef {
                dispersionCoef = "0.9f";
                artilleryDispersionCoef = "1.0f";
                fireLightCoef = "0.5f";
                recoilCoef = "1.0f";
                recoilProneCoef = "1.0f";
                minRangeCoef = "1.0f";
                minRangeProbabCoef = "1.0f";
                midRangeCoef = "1.0f";
                midRangeProbabCoef = "1.0f";
                maxRangeCoef = "1.0f";
                maxRangeProbabCoef = "1.0f";
            };
        };

        inertia = 0.1;
    };

    class ACE_muzzle_mzls_smg_02: ACE_muzzle_mzls_H {
        author = "$STR_ACE_Common_ACETeam";
        _generalMacro = "ACE_muzzle_mzls_smg_02";
        displayName = "$STR_ACE_muzzle_mzls_smg_02";
        picture = "\A3\weapons_F\Data\UI\gear_acca_mzls_l_ca.paa";
        model = "\A3\weapons_f\acc\acca_mzls_H_F"; //"\A3\weapons_f\acc\acca_mzls_smg_01_F";

        class ItemInfo: ItemInfo {
            mass = 6;
            soundTypeIndex = 0;
            muzzleEnd = "zaslehPoint";
            alternativeFire = "Zasleh2";

            class MagazineCoef {
                initSpeed = 1.0;
            };

            class AmmoCoef {
                hit = 1.0;
                visibleFire = 0.5;
                audibleFire = 1.0;
                visibleFireTime = 0.5;
                audibleFireTime = 1.0;
                cost = 1.0;
                typicalSpeed = 1.0;
                airFriction = 1.0;
            };

            class MuzzleCoef {
                dispersionCoef = "0.9f";
                artilleryDispersionCoef = "1.0f";
                fireLightCoef = "0.5f";
                recoilCoef = "1.0f";
                recoilProneCoef = "1.0f";
                minRangeCoef = "1.0f";
                minRangeProbabCoef = "1.0f";
                midRangeCoef = "1.0f";
                midRangeProbabCoef = "1.0f";
                maxRangeCoef = "1.0f";
                maxRangeProbabCoef = "1.0f";
            };
        };

        inertia = 0.1;
    };


    /* Vests */

    #include <FixVests.hpp>
};
