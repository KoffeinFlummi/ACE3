class CfgWeapons {

    class CSLA_LauncherBase;

    class CSLA_RPG7: CSLA_LauncherBase {
        EGVAR(reloadlaunchers,enabled) = 1;
    };

    class CSLA_RPG75: CSLA_LauncherBase {

    };

    class CSLA_Strela: CSLA_LauncherBase {
        EGVAR(overpressure,angle) = 30;
        EGVAR(overpressure,damage) = 0.5;
        EGVAR(overpressure,range) = 2;
    };

    class US85_launcherBase;
    class US85_MachinegunBase_5_56;
    class US85_MachinegunBase_7_62;
    class US85_weaponBase;

    class US85_M16_base: US85_weaponBase {

    };

    class US85_M249: US85_MachinegunBase_5_56 {
        EGVAR(overheating,allowSwapBarrel) = 1;
    };

    class US85_M60: US85_MachinegunBase_7_62 {
        EGVAR(overheating,allowSwapBarrel) = 1;
    };


    class US85_FIM92: US85_launcherBase {
        EGVAR(overpressure,angle) = 45;
        EGVAR(overpressure,damage) = 0.3;
        EGVAR(overpressure,range) = 15;
    };

    class US85_LAW72: US85_launcherBase {
        EGVAR(overpressure,angle) = 40;
        EGVAR(overpressure,damage) = 0.5;
        EGVAR(overpressure,range) = 15;
    };

    class US85_M136: US85_launcherBase {
        EGVAR(overpressure,angle) = 45;
        EGVAR(overpressure,damage) = 0.3;
        EGVAR(overpressure,range) = 10;
    };

    class US85_MAAWS: US85_launcherBase {
        EGVAR(reloadlaunchers,enabled) = 1;
        EGVAR(overpressure,angle) = 60;
        EGVAR(overpressure,damage) = 0.7;
        EGVAR(overpressure,priority) = 1;
        EGVAR(overpressure,range) = 10;
    }

    class US85_SMAW: US85_launcherBase {
        EGVAR(reloadlaunchers,enabled) = 1;
        EGVAR(overpressure,angle) = 45;
    };

};
