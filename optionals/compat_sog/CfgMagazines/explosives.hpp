class vn_magazine;

// Claymore (Remote)
class vn_mine_m18_mag: vn_magazine {
    useAction = 0;

    displayNameShort = ""; // Every explosive inherits this and it breaks naming in the placing menu

    EGVAR(explosives,Placeable) = 1;
    EGVAR(explosives,SetupObject) = QEXPLOSIVES_PLACE(m18);

    class ACE_Triggers {
        SupportedTriggers[] = {"Command", "MK16_Transmitter"};
        class Command {
            digDistance = -0.05;
            fuseTime = 0.5;
        };
        class MK16_Transmitter: Command {};
    };
};
// Claymore (Proximity)
class vn_mine_m18_range_mag: vn_mine_m18_mag {
    class ACE_Triggers {
        SupportedTriggers[] = {"PressurePlate"};
        class PressurePlate {
            digDistance = -0.05;
        };
    };
};

// Claymore x3 (Remote)
class vn_mine_m18_x3_mag: vn_mine_m18_mag {
    EGVAR(explosives,SetupObject) = QEXPLOSIVES_PLACE(m18_x3);

    class ACE_Triggers {
        SupportedTriggers[] = {"Command", "MK16_Transmitter"};
        class Command {
            digDistance = 0.02;
            fuseTime = 0.5;
        };
        class MK16_Transmitter: Command {};
    };
};
// Claymore x3 (Proximity)
class vn_mine_m18_x3_range_mag: vn_mine_m18_x3_mag {
    class ACE_Triggers {
        SupportedTriggers[] = {"PressurePlate"};
        class PressurePlate {
            digDistance = 0.02;
        };
    };
};

// Toe-Popper
class vn_mine_m14_mag: vn_mine_m18_mag {
    EGVAR(explosives,SetupObject) = QEXPLOSIVES_PLACE(m14);

    class ACE_Triggers {
        SupportedTriggers[] = {"PressurePlate"};
        class PressurePlate {
            digDistance = 0.001;
        };
    };
};

// Bounding Mine
class vn_mine_m16_mag: vn_mine_m18_mag {
    EGVAR(explosives,SetupObject) = QEXPLOSIVES_PLACE(m16);

    class ACE_Triggers {
        SupportedTriggers[] = {"PressurePlate"};
        class PressurePlate {
            digDistance = 0.02;
        };
    };
};

// Bounding Mine (Trip Wire 2m)
class vn_mine_tripwire_m16_02_mag: vn_mine_m16_mag {
    EGVAR(explosives,SetupObject) = QEXPLOSIVES_PLACE(m16_tripwire_2m);

    class ACE_Triggers {
        SupportedTriggers[] = {"Tripwire"};
        class Tripwire {
            digDistance = 0.02;
        };
    };
};
// Bounding Mine (Trip Wire 4m)
class vn_mine_tripwire_m16_04_mag: vn_mine_tripwire_m16_02_mag {
    EGVAR(explosives,SetupObject) = QEXPLOSIVES_PLACE(m16_tripwire_4m);

    class ACE_Triggers {
        SupportedTriggers[] = {"Tripwire"};
        class Tripwire {
            digDistance = 0.02;
        };
    };
};

// F1 (Trip Wire 2m)
class vn_mine_tripwire_f1_02_mag: vn_mine_tripwire_m16_02_mag {
    EGVAR(explosives,SetupObject) = QEXPLOSIVES_PLACE(f1_tripwire_2m);
};
// F1 (Trip Wire 4m)
class vn_mine_tripwire_f1_04_mag: vn_mine_tripwire_f1_02_mag {
    EGVAR(explosives,SetupObject) = QEXPLOSIVES_PLACE(f1_tripwire_4m);
};

// Arty Shell (Trip Wire 4m)
class vn_mine_tripwire_arty_mag: vn_mine_tripwire_m16_02_mag {
    EGVAR(explosives,SetupObject) = QEXPLOSIVES_PLACE(arty_tripwire_4m);
};

// Satchel Charge
class vn_mine_satchel_remote_02_mag: vn_mine_m18_mag {
    useAction = 0;
    EGVAR(explosives,SetupObject) = QEXPLOSIVES_PLACE(satchel_remote_02);

    class ACE_Triggers {
        SupportedTriggers[] = {"Timer", "Command", "MK16_Transmitter", "DeadmanSwitch"};
        class Timer {
            fuseTime = 0.5;
        };
        class Command {
            fuseTime = 0.5;
        };
        class MK16_Transmitter: Command {};
        class DeadmanSwitch: Command {};
    };
};

// TM57 Anti-Tank Mine
class vn_mine_tm57_mag: vn_mine_m18_mag {
    EGVAR(explosives,SetupObject) = QEXPLOSIVES_PLACE(tm57);

    class ACE_Triggers {
        SupportedTriggers[] = {"PressurePlate"};
        class PressurePlate {};
    };
};

// M15 Anti-Tank Mine
class vn_mine_m15_mag: vn_mine_tm57_mag {
    EGVAR(explosives,SetupObject) = QEXPLOSIVES_PLACE(m15);

    class ACE_Triggers {
        SupportedTriggers[] = {"PressurePlate"};
        class PressurePlate {
            digDistance = 0.03;
        };
    };
};

// M112 Breaching charge
class vn_mine_m112_remote_mag: vn_mine_m18_mag {
    EGVAR(explosives,SetupObject) = QEXPLOSIVES_PLACE(m112);

    class ACE_Triggers {
        SupportedTriggers[] = {"Timer", "Command", "MK16_Transmitter", "DeadmanSwitch"};
        class Timer {
            fuseTime = 0.5;
            digDistance = 1;
        };
        class Command {
            fuseTime = 0.5;
            digDistance = 1;
        };
        class MK16_Transmitter: Command {};
        class DeadmanSwitch: Command {};
    };
};

// Spiked ammo box
class vn_mine_ammobox_range_mag: vn_mine_m18_mag {
    EGVAR(explosives,SetupObject) = QEXPLOSIVES_PLACE(ammobox_range);

    class ACE_Triggers {
        SupportedTriggers[] = {"PressurePlate"};
        class PressurePlate {
            digDistance = 0.01;
        };
    };
};

// Punji large
class vn_mine_punji_01_mag: vn_mine_m18_mag {
    useAction = 0;
    EGVAR(explosives,SetupObject) = QEXPLOSIVES_PLACE(punji_01);

    class ACE_Triggers {
        SupportedTriggers[] = {"PressurePlate"};
        class PressurePlate {
            displayName = CSTRING(Action_DigIn);
        };
    };
};

// Punji small
class vn_mine_punji_02_mag: vn_mine_punji_01_mag {
    EGVAR(explosives,SetupObject) = QEXPLOSIVES_PLACE(punji_02);
};

// Punji whip
class vn_mine_punji_03_mag: vn_mine_punji_01_mag {
    EGVAR(explosives,SetupObject) = QEXPLOSIVES_PLACE(punji_03);
};

// Punji door-way
class vn_mine_punji_04_mag: vn_mine_m18_mag {
    useAction = 0;
    EGVAR(explosives,SetupObject) = QEXPLOSIVES_PLACE(punji_04);

    class ACE_Triggers {
        SupportedTriggers[] = {"PressurePlate"};
        class PressurePlate {
            displayName = CSTRING(Action_DigIn);
        };
    };
};

// Punji side whip
class vn_mine_punji_05_mag: vn_mine_punji_04_mag {
    EGVAR(explosives,SetupObject) = QEXPLOSIVES_PLACE(punji_05);
};

// Bike mine (Remote)
class vn_mine_bike_mag: vn_mine_m18_mag {
    EGVAR(explosives,SetupObject) = QEXPLOSIVES_PLACE(bike);

    class ACE_Triggers {
        SupportedTriggers[] = {QGVAR(Command), QGVAR(MK16_Transmitter)};
        class GVAR(Command) {
            digDistance = 0;
            fuseTime = 1;
        };
        class GVAR(MK16_Transmitter): GVAR(Command) {};
    };
};
// Bike mine (Proximity)
class vn_mine_bike_range_mag: vn_mine_bike_mag {
    class ACE_Triggers {
        SupportedTriggers[] = {"PressurePlate"};
        class PressurePlate {
            digDistance = 0;
        };
    };
};

// Cartridge mine
class vn_mine_cartridge_mag: vn_mine_m18_mag {
    EGVAR(explosives,SetupObject) = QEXPLOSIVES_PLACE(cartridge);
};

// Lighter mine
class vn_mine_lighter_mag: vn_mine_m18_mag {
    EGVAR(explosives,SetupObject) = QEXPLOSIVES_PLACE(lighter);
};

// Pot mine
class vn_mine_pot_mag: vn_mine_m18_mag {
    EGVAR(explosives,SetupObject) = QEXPLOSIVES_PLACE(pot);
};

// Jerrycan mine
class vn_mine_jerrycan_mag: vn_mine_m18_mag {
    EGVAR(explosives,SetupObject) = QEXPLOSIVES_PLACE(jerrycan);
};

// Mortar shell on a stick
class vn_mine_mortar_range_mag: vn_mine_m18_mag {
    EGVAR(explosives,SetupObject) = QEXPLOSIVES_PLACE(mortar_range);
};

// Limpet mine USA
class vn_mine_limpet_01_mag: vn_mine_m18_mag {
    EGVAR(explosives,SetupObject) = QEXPLOSIVES_PLACE(limpet_01);
};

// Limpet mine RUS
class vn_mine_limpet_02_mag: vn_mine_m18_mag {
    EGVAR(explosives,SetupObject) = QEXPLOSIVES_PLACE(limpet_02);
};

// Chicom NO8 mine
class vn_mine_chicom_no8_mag: vn_mine_m18_mag {
    EGVAR(explosives,SetupObject) = QEXPLOSIVES_PLACE(chicom_no8);
};

// DH10 mine
class vn_mine_dh10_mag: vn_mine_m18_mag {
    EGVAR(explosives,SetupObject) = QEXPLOSIVES_PLACE(dh10);
};

// Grenade board mine
class vn_mine_gboard_range_mag: vn_mine_m18_mag {
    EGVAR(explosives,SetupObject) = QEXPLOSIVES_PLACE(gboard);
};

// Satchel charge
class vn_mine_satchelcharge_02_mag: vn_mine_satchel_remote_02_mag {
    EGVAR(explosives,SetupObject) = QEXPLOSIVES_PLACE(satchelcharge_02);
};

// Bangalore mine
class vn_mine_bangalore_mag: vn_mine_m18_mag {
    EGVAR(explosives,SetupObject) = QEXPLOSIVES_PLACE(bangalore);
};
