#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        units[] = {};
        weapons[] = {};
        requiredVersion = 0.60;
        requiredAddons[] = {ace_common};
        version = QUOTE(VERSION);
        versionStr = QUOTE(VERSION);
        versionAr[] = {VERSION_AR};
        author[] = {"KoffeinFlummi", "TaoSensai", "commy2"};
        authorUrl = "https://github.com/Taosenai/tmr";
    };
};

#include "CfgEventHandlers.hpp"

// DOC: http://forums.bistudio.com/showthread.php?94464-explaining-the-cfgRecoils-array
class CfgRecoils {
    #define KICKBACK 0.07
    #define KICKBACKPRONE 0.05

    #define MUZZLECLIMB 0.01
    #define MUZZLERECOVERY -0.004

    // BASE RECOILS
    pistolBase[]                 = {0,0.8*KICKBACK,0.9*MUZZLECLIMB, 0.12,0,0, 0.15,0,0.9*MUZZLERECOVERY, 0.3,0,0};
    subMachineGunBase[]          = {0,0.5*KICKBACK,0.5*MUZZLECLIMB, 0.12,0,0, 0.15,0,0.5*MUZZLERECOVERY, 0.3,0,0};
    assaultRifleBase[]           = {0,1*KICKBACK,1*MUZZLECLIMB, 0.12,0,0, 0.15,0,1*MUZZLERECOVERY, 0.3,0,0};
    machinegunBase[]             = {0,1*KICKBACK,1*MUZZLECLIMB, 0.12,0,0, 0.15,0,1*MUZZLERECOVERY, 0.3,0,0};
    launcherBase[]               = {0,0,0};

    // PISTOLS
    recoil_pistol_light[]        = {0,0.8*KICKBACK,0.9*MUZZLECLIMB, 0.12,0,0, 0.15,0,0.9*MUZZLERECOVERY, 0.3,0,0};
    recoil_pistol_heavy[]        = {0,1.1*KICKBACK,1.4*MUZZLECLIMB, 0.12,0,0, 0.15,0,1.4*MUZZLERECOVERY, 0.3,0,0};
    recoil_prone_pistol_light[]  = {0,0.8*KICKBACKPRONE,0.9*MUZZLECLIMB, 0.12,0,0, 0.15,0,0.9*MUZZLERECOVERY, 0.3,0,0};
    recoil_prone_pistol_heavy[]  = {0,1.1*KICKBACKPRONE,1.4*MUZZLECLIMB, 0.12,0,0, 0.15,0,1.4*MUZZLERECOVERY, 0.3,0,0};

    // SUBMACHINE GUNS
    recoil_single_smg_01[]       = {0,0.5*KICKBACK,0.5*MUZZLECLIMB, 0.12,0,0, 0.15,0,0.5*MUZZLERECOVERY, 0.3,0,0};
    recoil_burst_smg_01[]        = {0,0.5*KICKBACK,0.5*MUZZLECLIMB, 0.12,0,0, 0.15,0,0.5*MUZZLERECOVERY, 0.3,0,0};
    recoil_auto_smg_01[]         = {0,0.5*KICKBACK,0.5*MUZZLECLIMB, 0.12,0,0, 0.15,0,0.5*MUZZLERECOVERY, 0.3,0,0};
    recoil_single_prone_smg_01[] = {0,0.5*KICKBACKPRONE,0.5*MUZZLECLIMB, 0.12,0,0, 0.15,0,0.5*MUZZLERECOVERY, 0.3,0,0};
    recoil_burst_prone_smg_01[]  = {0,0.5*KICKBACKPRONE,0.5*MUZZLECLIMB, 0.12,0,0, 0.15,0,0.5*MUZZLERECOVERY, 0.3,0,0};
    recoil_auto_prone_smg_01[]   = {0,0.5*KICKBACKPRONE,0.5*MUZZLECLIMB, 0.12,0,0, 0.15,0,0.5*MUZZLERECOVERY, 0.3,0,0};

    recoil_single_smg_02[]       = {0,0.5*KICKBACK,0.5*MUZZLECLIMB, 0.12,0,0, 0.15,0,0.5*MUZZLERECOVERY, 0.3,0,0};
    recoil_burst_smg_02[]        = {0,0.5*KICKBACK,0.5*MUZZLECLIMB, 0.12,0,0, 0.15,0,0.5*MUZZLERECOVERY, 0.3,0,0};
    recoil_auto_smg_02[]         = {0,0.5*KICKBACK,0.5*MUZZLECLIMB, 0.12,0,0, 0.15,0,0.5*MUZZLERECOVERY, 0.3,0,0};
    recoil_single_prone_smg_02[] = {0,0.5*KICKBACKPRONE,0.5*MUZZLECLIMB, 0.12,0,0, 0.15,0,0.5*MUZZLERECOVERY, 0.3,0,0};
    recoil_burst_prone_smg_02[]  = {0,0.5*KICKBACKPRONE,0.5*MUZZLECLIMB, 0.12,0,0, 0.15,0,0.5*MUZZLERECOVERY, 0.3,0,0};
    recoil_auto_prone_smg_02[]   = {0,0.5*KICKBACKPRONE,0.5*MUZZLECLIMB, 0.12,0,0, 0.15,0,0.5*MUZZLERECOVERY, 0.3,0,0};

    recoil_single_pdw[]          = {0,0.5*KICKBACK,0.5*MUZZLECLIMB, 0.12,0,0, 0.15,0,0.5*MUZZLERECOVERY, 0.3,0,0};
    recoil_burst_pdw[]           = {0,0.5*KICKBACK,0.5*MUZZLECLIMB, 0.12,0,0, 0.15,0,0.5*MUZZLERECOVERY, 0.3,0,0};
    recoil_auto_pdw[]            = {0,0.5*KICKBACK,0.5*MUZZLECLIMB, 0.12,0,0, 0.15,0,0.5*MUZZLERECOVERY, 0.3,0,0};
    recoil_single_prone_pdw[]    = {0,0.5*KICKBACKPRONE,0.5*MUZZLECLIMB, 0.12,0,0, 0.15,0,0.5*MUZZLERECOVERY, 0.3,0,0};
    recoil_burst_prone_pdw[]     = {0,0.5*KICKBACKPRONE,0.5*MUZZLECLIMB, 0.12,0,0, 0.15,0,0.5*MUZZLERECOVERY, 0.3,0,0};
    recoil_auto_prone_pdw[]      = {0,0.5*KICKBACKPRONE,0.5*MUZZLECLIMB, 0.12,0,0, 0.15,0,0.5*MUZZLERECOVERY, 0.3,0,0};

    // ASSAULT RIFLES
    recoil_single_mx[]           = {0,1*KICKBACK,1*MUZZLECLIMB, 0.12,0,0, 0.15,0,1*MUZZLERECOVERY, 0.3,0,0};
    recoil_auto_mx[]             = {0,1*KICKBACK,1*MUZZLECLIMB, 0.12,0,0, 0.15,0,1*MUZZLERECOVERY, 0.3,0,0};
    recoil_single_prone_mx[]     = {0,1*KICKBACKPRONE,1*MUZZLECLIMB, 0.12,0,0, 0.15,0,1*MUZZLERECOVERY, 0.3,0,0};
    recoil_auto_prone_mx[]       = {0,1*KICKBACKPRONE,1*MUZZLECLIMB, 0.12,0,0, 0.15,0,1*MUZZLERECOVERY, 0.3,0,0};

    recoil_single_ktb[]          = {0,1*KICKBACK,1*MUZZLECLIMB, 0.12,0,0, 0.15,0,1*MUZZLERECOVERY, 0.3,0,0};
    recoil_auto_ktb[]            = {0,1*KICKBACK,1*MUZZLECLIMB, 0.12,0,0, 0.15,0,1*MUZZLERECOVERY, 0.3,0,0};
    recoil_single_prone_ktb[]    = {0,1*KICKBACKPRONE,1*MUZZLECLIMB, 0.12,0,0, 0.15,0,1*MUZZLERECOVERY, 0.3,0,0};
    recoil_auto_prone_ktb[]      = {0,1*KICKBACKPRONE,1*MUZZLECLIMB, 0.12,0,0, 0.15,0,1*MUZZLERECOVERY, 0.3,0,0};

    recoil_single_mk20[]         = {0,0.8*KICKBACK,0.8*MUZZLECLIMB, 0.12,0,0, 0.15,0,0.8*MUZZLERECOVERY, 0.3,0,0};
    recoil_auto_mk20[]           = {0,0.8*KICKBACK,0.8*MUZZLECLIMB, 0.12,0,0, 0.15,0,0.8*MUZZLERECOVERY, 0.3,0,0};
    recoil_single_prone_mk20[]   = {0,0.8*KICKBACKPRONE,0.8*MUZZLECLIMB, 0.12,0,0, 0.15,0,0.8*MUZZLERECOVERY, 0.3,0,0};
    recoil_auto_prone_mk20[]     = {0,0.8*KICKBACKPRONE,0.8*MUZZLECLIMB, 0.12,0,0, 0.15,0,0.8*MUZZLERECOVERY, 0.3,0,0};

    recoil_single_trg[]          = {0,0.8*KICKBACK,0.8*MUZZLECLIMB, 0.12,0,0, 0.15,0,0.8*MUZZLERECOVERY, 0.3,0,0};
    recoil_auto_trg[]            = {0,0.8*KICKBACK,0.8*MUZZLECLIMB, 0.12,0,0, 0.15,0,0.8*MUZZLERECOVERY, 0.3,0,0};
    recoil_single_prone_trg[]    = {0,0.8*KICKBACKPRONE,0.8*MUZZLECLIMB, 0.12,0,0, 0.15,0,0.8*MUZZLERECOVERY, 0.3,0,0};
    recoil_auto_prone_trg[]      = {0,0.8*KICKBACKPRONE,0.8*MUZZLECLIMB, 0.12,0,0, 0.15,0,0.8*MUZZLERECOVERY, 0.3,0,0};

    recoil_single_sdar[]         = {0,0.8*KICKBACK,0.8*MUZZLECLIMB, 0.12,0,0, 0.15,0,0.8*MUZZLERECOVERY, 0.3,0,0};
    recoil_auto_sdar[]           = {0,0.8*KICKBACK,0.8*MUZZLECLIMB, 0.12,0,0, 0.15,0,0.8*MUZZLERECOVERY, 0.3,0,0};
    recoil_single_prone_sdar[]   = {0,0.8*KICKBACKPRONE,0.8*MUZZLECLIMB, 0.12,0,0, 0.15,0,0.8*MUZZLERECOVERY, 0.3,0,0};
    recoil_auto_prone_sdar[]     = {0,0.8*KICKBACKPRONE,0.8*MUZZLECLIMB, 0.12,0,0, 0.15,0,0.8*MUZZLERECOVERY, 0.3,0,0};

    // MACHINE GUNS
    recoil_single_mk200[]        = {0,1*KICKBACK,1*MUZZLECLIMB, 0.12,0,0, 0.15,0,1*MUZZLERECOVERY, 0.3,0,0};
    recoil_auto_mk200[]          = {0,1*KICKBACK,1*MUZZLECLIMB, 0.12,0,0, 0.15,0,1*MUZZLERECOVERY, 0.3,0,0};
    recoil_single_prone_mk200[]  = {0,1*KICKBACKPRONE,1*MUZZLECLIMB, 0.12,0,0, 0.15,0,1*MUZZLERECOVERY, 0.3,0,0};
    recoil_auto_prone_mk200[]    = {0,1*KICKBACKPRONE,1*MUZZLECLIMB, 0.12,0,0, 0.15,0,1*MUZZLERECOVERY, 0.3,0,0};

    recoil_single_zafir[]        = {0,1.5*KICKBACK,1.5*MUZZLECLIMB, 0.12,0,0, 0.15,0,1.5*MUZZLERECOVERY, 0.3,0,0};
    recoil_auto_zafir[]          = {0,1.5*KICKBACK,1.5*MUZZLECLIMB, 0.12,0,0, 0.15,0,1.5*MUZZLERECOVERY, 0.3,0,0};
    recoil_single_prone_zafir[]  = {0,1.5*KICKBACKPRONE,1.5*MUZZLECLIMB, 0.12,0,0, 0.15,0,1.5*MUZZLERECOVERY, 0.3,0,0};
    recoil_auto_prone_zafir[]    = {0,1.5*KICKBACKPRONE,1.5*MUZZLECLIMB, 0.12,0,0, 0.15,0,1.5*MUZZLERECOVERY, 0.3,0,0};

    // PRECISION RIFLES
    recoil_single_dmr[]          = {0,1.5*KICKBACK,1.5*MUZZLECLIMB, 0.12,0,0, 0.15,0,1.5*MUZZLERECOVERY, 0.3,0,0};
    recoil_auto_dmr[]            = {0,1.5*KICKBACK,1.5*MUZZLECLIMB, 0.12,0,0, 0.15,0,1.5*MUZZLERECOVERY, 0.3,0,0};
    recoil_single_prone_dmr[]    = {0,1.5*KICKBACKPRONE,1.5*MUZZLECLIMB, 0.12,0,0, 0.15,0,1.5*MUZZLERECOVERY, 0.3,0,0};
    recoil_auto_prone_dmr[]      = {0,1.5*KICKBACKPRONE,1.5*MUZZLECLIMB, 0.12,0,0, 0.15,0,1.5*MUZZLERECOVERY, 0.3,0,0};

    recoil_single_ebr[]          = {0,1.5*KICKBACK,1.5*MUZZLECLIMB, 0.12,0,0, 0.15,0,1.5*MUZZLERECOVERY, 0.3,0,0};
    recoil_auto_ebr[]            = {0,1.5*KICKBACK,1.5*MUZZLECLIMB, 0.12,0,0, 0.15,0,1.5*MUZZLERECOVERY, 0.3,0,0};
    recoil_single_prone_ebr[]    = {0,1.5*KICKBACKPRONE,1.5*MUZZLECLIMB, 0.12,0,0, 0.15,0,1.5*MUZZLERECOVERY, 0.3,0,0};
    recoil_auto_prone_ebr[]      = {0,1.5*KICKBACKPRONE,1.5*MUZZLECLIMB, 0.12,0,0, 0.15,0,1.5*MUZZLERECOVERY, 0.3,0,0};

    recoil_single_gm6[]          = {0,2.5*KICKBACK,2.5*MUZZLECLIMB, 0.12,0,0, 0.15,0,2.5*MUZZLERECOVERY, 0.3,0,0};
    recoil_single_prone_gm6[]    = {0,2.5*KICKBACKPRONE,2.5*MUZZLECLIMB, 0.12,0,0, 0.15,0,2.5*MUZZLERECOVERY, 0.3,0,0};

    // LAUNCHERS
    recoil_single_law[]          = {0,0,0};
    recoil_single_nlaw[]         = {0,0,0};
    recoil_single_titan[]        = {0,0,0};
};

class CfgCameraShake {
    // Seems to be ignored by Arma
    defaultCaliberCoefWeaponFire = 0;
};

// Completely disable BI's camshake on fire.
class CfgMovesBasic {
    class Default {
        camShakeFire = 0;
    };
};
class CfgMovesMaleSdr : CfgMovesBasic {
    class States {
        class AmovPercMstpSlowWrflDnon;
        class AmovPknlMstpSlowWrflDnon : AmovPercMstpSlowWrflDnon {
            camShakeFire = 0;
        };
        class AmovPercMstpSrasWrflDnon;
        class AmovPpneMstpSrasWrflDnon : AmovPercMstpSrasWrflDnon {
            camShakeFire = 0;
        };
        class AmovPknlMstpSrasWlnrDnon : Default {
            camShakeFire = 0;
        };
        class AmovPknlMrunSlowWrflDf;
        class AmovPknlMtacSlowWrflDf : AmovPknlMrunSlowWrflDf {
            camShakeFire = 0;
        };
        class AmovPknlMrunSlowWrflDfl;
        class AmovPknlMtacSlowWrflDfl : AmovPknlMrunSlowWrflDfl {
            camShakeFire = 0;
        };
        class AmovPknlMrunSlowWrflDl;
        class AmovPknlMtacSlowWrflDl : AmovPknlMrunSlowWrflDl {
            camShakeFire = 0;
        };
        class AmovPknlMrunSlowWrflDbl;
        class AmovPknlMtacSlowWrflDbl : AmovPknlMrunSlowWrflDbl {
            camShakeFire = 0;
        };
        class AmovPknlMrunSlowWrflDb;
        class AmovPknlMtacSlowWrflDb : AmovPknlMrunSlowWrflDb {
            camShakeFire = 0;
        };
        class AmovPknlMrunSlowWrflDbr;
        class AmovPknlMtacSlowWrflDbr : AmovPknlMrunSlowWrflDbr {
            camShakeFire = 0;
        };
        class AmovPknlMrunSlowWrflDr;
        class AmovPknlMtacSlowWrflDr : AmovPknlMrunSlowWrflDr {
            camShakeFire = 0;
        };
        class AmovPknlMrunSlowWrflDfr;
        class AmovPknlMtacSlowWrflDfr : AmovPknlMrunSlowWrflDfr {
            camShakeFire = 0;
        };
        class AmovPknlMstpSrasWrflDnon;
        class AmovPknlMwlkSrasWrflDf : AmovPknlMstpSrasWrflDnon {
            camShakeFire = 0;
        };
        class AmovPknlMrunSrasWrflDf;
        class AmovPknlMtacSrasWrflDf : AmovPknlMrunSrasWrflDf {
            camShakeFire = 0;
        };
        class AmovPknlMwlkSrasWpstDf;
        class AmovPknlMtacSrasWpstDf : AmovPknlMwlkSrasWpstDf {
            camShakeFire = 0;
        };
    };
};

// Ammo
class CfgAmmo {
    class MissileCore;
    class MissileBase: MissileCore {
        GVAR(shakeMultiplier) = 2;
    };

    class BombCore;
    class LaserBombCore: BombCore {
        GVAR(shakeMultiplier) = 2;
    };
    class Bo_Mk82: BombCore {
        GVAR(shakeMultiplier) = 2;
    };

    class RocketCore;
    class ArtilleryRocketCore: RocketCore {
        GVAR(shakeMultiplier) = 1.4;
    };
    class RocketBase: RocketCore {
        GVAR(shakeMultiplier) = 1.4;
    };

    class BulletCore;
    class BulletBase: BulletCore {
        GVAR(shakeMultiplier) = 1;
    };

    class ShotgunCore;
    class ShotgunBase: ShotgunCore {
        GVAR(shakeMultiplier) = 1.1;
    };

    class ShellCore;
    class ShellBase: ShellCore {
        GVAR(shakeMultiplier) = 3;
    };

    class SubmunitionCore;
    class SubmunitionBase: SubmunitionCore {
        GVAR(shakeMultiplier) = 3;
    };

    class ShotDeployCore;
    class ShotDeployBase: ShotDeployCore {
        GVAR(shakeMultiplier) = 3;
    };
};

// Weapons
// 1. Set the recoil profiles for all fire modes.
// 2. Set the shake multiplier. This determines the camshake for the weapon.
//     Ex: GVAR(shakeMultiplier) = 1; (disabled currently)

class CfgWeapons {
    class CannonCore;
    class autocannon_Base_F: CannonCore {
        GVAR(shakeMultiplier) = 0;
    };
    class autocannon_35mm: CannonCore {
        GVAR(shakeMultiplier) = 0;
    };
    class cannon_120mm: CannonCore {
        GVAR(shakeMultiplier) = 0;
    };
    class mortar_155mm_AMOS: CannonCore {
        GVAR(shakeMultiplier) = 0;
    };
    class mortar_82mm: CannonCore {
        GVAR(shakeMultiplier) = 0;
    };

    // No camshake for gatlings
    class gatling_20mm: CannonCore {
        GVAR(shakeMultiplier) = 0;
    };
    class gatling_25mm: CannonCore {
        GVAR(shakeMultiplier) = 0;
    };
    class gatling_30mm: CannonCore {
        GVAR(shakeMultiplier) = 0;
    };

    class MGunCore;
    class MGun: MGunCore {
        GVAR(shakeMultiplier) = 0;
    };
    // No camshake for smoke launchers
    class SmokeLauncher: MGun {
        GVAR(shakeMultiplier) = 0;
    };

    // No camshake for coax machine guns
    class LMG_RCWS;
    class LMG_M200: LMG_RCWS {
        GVAR(shakeMultiplier) = 0;
    };
    class LMG_coax: LMG_RCWS {
        GVAR(shakeMultiplier) = 0;
    };
    class LMG_Minigun: LMG_RCWS {
        GVAR(shakeMultiplier) = 0;
    };
};

// Vehicles
class CfgVehicles {
    class LandVehicle;
    class Tank: LandVehicle {
        GVAR(enableCamshake) = 1;
    };
    class Car: LandVehicle {
        GVAR(enableCamshake) = 1;
    };
    class StaticWeapon: LandVehicle {
        GVAR(enableCamshake) = 1;
    };

    class Allvehicles;
    class Air: Allvehicles {
        GVAR(enableCamshake) = 1;
    };
};
