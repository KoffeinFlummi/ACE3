
class CfgMagazines {
    class HandGrenade;
    class ACE_HandFlare_Base: HandGrenade {
        scope = 1;
        value = 2;
        nameSoundWeapon = "smokeshell";
        nameSound = "smokeshell";
        mass = 4;
        initSpeed = 22;
    };

    class ACE_HandFlare_White: ACE_HandFlare_Base {
        author = ECSTRING(common,ACETeam);
        scope = 2;
        displayname = CSTRING(M127A1_White_Name);
        descriptionShort = CSTRING(M127A1_White_Description);
        displayNameShort = CSTRING(M127A1_White_NameShort);
        model = "\A3\weapons_f\ammo\flare_white";
        picture = "\A3\Weapons_F\Data\UI\gear_flare_white_ca.paa";
        ammo = "ACE_G_Handflare_White";
    };

    class ACE_HandFlare_Red: ACE_HandFlare_Base {
        author = ECSTRING(common,ACETeam);
        scope = 2;
        displayname = CSTRING(M127A1_Red_Name);
        descriptionShort = CSTRING(M127A1_Red_Description);
        displayNameShort = CSTRING(M127A1_Red_NameShort);
        model = "\A3\weapons_f\ammo\flare_red";
        picture = "\A3\Weapons_F\Data\UI\gear_flare_red_ca.paa";
        ammo = "ACE_G_Handflare_Red";
    };

    class ACE_HandFlare_Green: ACE_HandFlare_Base {
        author = ECSTRING(common,ACETeam);
        scope = 2;
        displayname = CSTRING(M127A1_Green_Name);
        descriptionShort = CSTRING(M127A1_Green_Description);
        displayNameShort = CSTRING(M127A1_Green_NameShort);
        model = "\A3\weapons_f\ammo\flare_green";
        picture = "\A3\Weapons_F\Data\UI\gear_flare_green_ca.paa";
        ammo = "ACE_G_Handflare_Green";
    };

    class ACE_HandFlare_Yellow: ACE_HandFlare_Base {
        author = ECSTRING(common,ACETeam);
        scope = 2;
        displayname = CSTRING(M127A1_Yellow_Name);
        descriptionShort = CSTRING(M127A1_Yellow_Description);
        displayNameShort = CSTRING(M127A1_Yellow_NameShort);
        model = "\A3\weapons_f\ammo\flare_yellow";
        picture = "\A3\Weapons_F\Data\UI\gear_flare_yellow_ca.paa";
        ammo = "ACE_G_Handflare_Yellow";
    };

    class ACE_M84: HandGrenade {
        author = ECSTRING(common,ACETeam);
        displayname = CSTRING(M84_Name);
        descriptionShort = CSTRING(M84_Description);
        displayNameShort = CSTRING(M84_NameShort);
        model = QPATHTOF(models\ACE_m84.p3d);
        picture = QPATHTOF(UI\ACE_m84_x_ca.paa);
        ammo = "ACE_G_M84";
        mass = 4;
    };

    class ACE_CTS9: HandGrenade {
        author = ECSTRING(common,ACETeam);
        displayname = CSTRING(CTS9_Name);
        descriptionShort = CSTRING(M84_Description);
        displayNameShort = CSTRING(CTS9_NameShort);
        model = QPATHTOF(models\ACE_CTS_9bang.p3d);
        picture = QPATHTOF(UI\ace_cts9_x_ca.paa);
        ammo = "ACE_G_CTS9";
        mass = 4;
    };

    class SmokeShell;
    class ACE_M14: SmokeShell {
        author = ECSTRING(common,ACETeam);
        displayname = CSTRING(Incendiary_Name);
        descriptionShort = CSTRING(Incendiary_Description);
        displayNameShort = CSTRING(Incendiary_NameShort);
        model = QPATHTOF(models\ace_anm14th3.p3d);
        picture = QPATHTOF(UI\ace_anm14th3_x_ca.paa);
        ammo = "ACE_G_M14";
        mass = 4;
    };

    class 3Rnd_UGL_FlareGreen_F;
    class 6Rnd_GreenSignal_F: 3Rnd_UGL_FlareGreen_F {
        author = ECSTRING(common,ACETeam);
        ammo = "F_40mm_Green";
        initSpeed = 120;
    };

    class 6Rnd_RedSignal_F: 6Rnd_GreenSignal_F {
        author = ECSTRING(common,ACETeam);
        ammo = "F_40mm_Red";
        initSpeed = 120;
    };

    class UGL_FlareWhite_F;
    class ACE_40mm_Flare_white: UGL_FlareWhite_F {
        author = ECSTRING(common,ACETeam);
        ammo = "ACE_40mm_Flare_white";
        displayName = CSTRING(40mm_flare_white);
        descriptionShort = CSTRING(parachute_flare_description);
    };

    class UGL_FlareRed_F;
    class ACE_40mm_Flare_red: UGL_FlareRed_F {
        author = ECSTRING(common,ACETeam);
        ammo = "ACE_40mm_Flare_red";
        displayName = CSTRING(40mm_flare_red);
        descriptionShort = CSTRING(parachute_flare_description);
    };

    class UGL_FlareGreen_F;
    class ACE_40mm_Flare_green: UGL_FlareGreen_F {
        author = ECSTRING(common,ACETeam);
        ammo = "ACE_40mm_Flare_green";
        displayName = CSTRING(40mm_flare_green);
        descriptionShort = CSTRING(parachute_flare_description);
    };

    class ACE_40mm_Flare_ir: UGL_FlareWhite_F {
        author = ECSTRING(common,ACETeam);
        ammo = "ACE_40mm_Flare_ir";
        displayName = CSTRING(40mm_flare_ir);
        descriptionShort = CSTRING(parachute_flare_ir_description);
    };

    class CA_Magazine;
    class ACE_SatchelCharge_Remote_Mag_Throwable: CA_Magazine {
        author = ECSTRING(common,ACETeam);
        scope = 1;
        picture = "\A3\Weapons_f\data\UI\gear_satchel_CA.paa";
        model = "\A3\Weapons_F\Explosives\satchel_i";
        descriptionShort = "Type: Charge<br />Rounds: 1<br />Used on: Things that need to die";
        class Library {
            libTextDesc = "An explosive satchel that is throwable. 7 second fixed fuse";
        };
        descriptionUse = "";
        type = "2*      256";
        allowedSlots[] = {901};
        value = 5;
        ammo = "ACE_SatchelCharge_Remote_Ammo_Thrown";
        mass = 80;
        count = 1;
        initSpeed = 10;
        maxLeadSpeed = 0;
        nameSoundWeapon = "satchelcharge";
        nameSound = "satchelcharge";
        weaponPoolAvailable = 0;
        useActionTitle = "";
        sound[] = {"A3\sounds_f\dummysound", 0.000316228, 1, 10};
        displayName = "Explosive Satchel (Throwable)";
        displayNameShort = "Satchel Charge";
        useAction = 0;
        EGVAR(explosives,placeable) = 0;
        class ACE_Triggers {
            SupportedTriggers[] = {};
        };
    };

    class ACE_DemoCharge_Remote_Mag_Throwable: ACE_SatchelCharge_Remote_Mag_Throwable {
        picture = "\A3\Weapons_F\Data\UI\gear_c4_charge_small_CA.paa";
        model = "\A3\Weapons_F\explosives\c4_charge_small_d";
        descriptionShort = "Type: Charge<br />Rounds: 1<br />Used on: Things that need to die";
        class Library {
            libTextDesc = "An explosive charge that is throwable. 7 second fixed fuse";
        };
        allowedSlots[] = {901, 701};
        ammo = "ACE_DemoCharge_Remote_Ammo_Thrown";
        mass = 20;
        initSpeed = 15;
        displayName = "Explosive Charge (Throwable)";
        displayNameShort = "Explosive Charge";
    };
};