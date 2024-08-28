class CfgWeapons {
    // Man-Portable launchers, rear-facing overpressure

    class launch_O_Titan_F;

    class rhs_weap_fim92: launch_O_Titan_F {
        EGVAR(overpressure,range) = 6;
        EGVAR(overpressure,angle) = 40;
        EGVAR(overpressure,damage) = 0.6;
        EGVAR(overpressure,offset) = 1.45;
    };

    class Launcher_Base_F;

    class rhs_weap_smaw: Launcher_Base_F {
        EGVAR(overpressure,angle) = 45;
        EGVAR(overpressure,offset) = 1.3;
    };

    class rhs_weap_maaws: Launcher_Base_F {
        EGVAR(overpressure,range) = 15;
        EGVAR(overpressure,angle) = 70;
        EGVAR(overpressure,damage) = 0.75;
        EGVAR(overpressure,offset) = 0.95;
    };

    class rhs_weap_M136: Launcher_Base_F {
        EGVAR(overpressure,range) = 10;
        EGVAR(overpressure,angle) = 50;
        EGVAR(overpressure,offset) = 0.9;
    };
};
