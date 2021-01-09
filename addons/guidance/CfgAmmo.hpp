class CfgAmmo {
    class BulletBase;
    class Gatling_30mm_DEBUG: BulletBase {
        hit = 70; // default: 180
        indirectHit = 12; // default: 4
        indirectHitRange = 4; // default: 3
        caliber = 1.4; // default: 5
        deflecting = 3; // default: 5
        fuseDistance = 3; // default: 10
        tracerStartTime = 0.02; // default: 0.1
        timeToLive = 40; // default: 6
        class ADDON {
            enabled = 1;

            minDeflection = 0.0005;      // Minium flap deflection for guidance
            maxDeflection = 0.0025;       // Maximum flap deflection for guidance
            incDeflection = 0.0005;      // The incrmeent in which deflection adjusts.

            canVanillaLock = 0;          // Can this default vanilla lock? Only applicable to non-cadet mode

            // Guidance type for munitions
            defaultSeekerType = "SALH";
            seekerTypes[] = {"GPS", "SALH"};

            defaultSeekerLockMode = "LIN";
            seekerLockModes[] = {"LIN"};

            seekerAngle = 90;           // Angle in front of the missile which can be searched
            seekerAccuracy = 1;         // seeker accuracy multiplier

            seekerMinRange = 1;
            seekerMaxRange = 2500;      // Range from the missile which the seeker can visually search

            // Attack profile type selection
            defaultAttackProfile = "LIN";
            attackProfiles[] = {"LIN"};
        };
    };
    
    class Sh_82mm_AMOS;
    //PGMM
    class Sh_82mm_DEBUG: Sh_82mm_AMOS {
        class ADDON {
            enabled = 1;

            minDeflection = 0.0005;      // Minium flap deflection for guidance
            maxDeflection = 0.0025;       // Maximum flap deflection for guidance
            incDeflection = 0.0005;      // The incrmeent in which deflection adjusts.

            canVanillaLock = 0;          // Can this default vanilla lock? Only applicable to non-cadet mode

            // Guidance type for munitions
            defaultSeekerType = "SALH";
            seekerTypes[] = {"SALH"};

            defaultSeekerLockMode = "LIN";
            seekerLockModes[] = {"LIN"};

            seekerAngle = 90;           // Angle in front of the missile which can be searched
            seekerAccuracy = 1;         // seeker accuracy multiplier

            seekerMinRange = 1;
            seekerMaxRange = 2500;      // Range from the missile which the seeker can visually search

            // Attack profile type selection
            defaultAttackProfile = "IND";
            attackProfiles[] = {"IND"};
        };
    };

    class G_40mm_HE;
    //Raytheon 'Pike'
    class G_40mm_DEBUG: G_40mm_HE {
        timeToLive = 30;
        class ADDON {
            enabled = 1;

            minDeflection = 0.0005;      // Minium flap deflection for guidance
            maxDeflection = 0.0025;       // Maximum flap deflection for guidance
            incDeflection = 0.0005;      // The incrmeent in which deflection adjusts.

            canVanillaLock = 0;          // Can this default vanilla lock? Only applicable to non-cadet mode

            // Guidance type for munitions
            defaultSeekerType = "SALH";
            seekerTypes[] = {"SALH"};

            defaultSeekerLockMode = "LIN";
            seekerLockModes[] = {"LIN"};

            seekerAngle = 90;           // Angle in front of the missile which can be searched
            seekerAccuracy = 1;         // seeker accuracy multiplier

            seekerMinRange = 1;
            seekerMaxRange = 2500;      // Range from the missile which the seeker can visually search

            // Attack profile type selection
            defaultAttackProfile = "IND";
            attackProfiles[] = {"IND"};
        };
    };

    class RocketBase;
    class R_MRAAWS_HEAT_F: RocketBase {};
    class R_MRAAWS_HEAT55_F: R_MRAAWS_HEAT_F {
        class ADDON {
            enabled = 1;

            minDeflection = 0.0005;      // Minium flap deflection for guidance
            maxDeflection = 0.0025;       // Maximum flap deflection for guidance
            incDeflection = 0.0005;      // The incrmeent in which deflection adjusts.

            canVanillaLock = 0;          // Can this default vanilla lock? Only applicable to non-cadet mode

            // Guidance type for munitions
            defaultSeekerType = "PLOS";
            seekerTypes[] = {"PLOS"};

            defaultSeekerLockMode = "LIN";
            seekerLockModes[] = {"LIN"};

            seekerAngle = 90;           // Angle in front of the missile which can be searched
            seekerAccuracy = 1;         // seeker accuracy multiplier

            seekerMinRange = 1;
            seekerMaxRange = 2500;      // Range from the missile which the seeker can visually search

            // Attack profile type selection
            defaultAttackProfile = "DF";
            attackProfiles[] = {"DF"};
        };
    };

    //RGM-109 Tomahawk
    class ammo_Missile_Cruise_01;
    class ammo_Missile_Cruise_DEBUG: ammo_Missile_Cruise_01 {
        class ADDON {
            enabled = 1;
            
            seekers[] = {"GPS"};
            seekerDirection[] = {};
            fuzes[] = {};
            fuzeDirection[] = {};

            minDeflection = 0.0005;      // Minium flap deflection for guidance
            maxDeflection = 0.0025;       // Maximum flap deflection for guidance
            incDeflection = 0.0005;      // The incrmeent in which deflection adjusts.

            canVanillaLock = 0;          // Can this default vanilla lock? Only applicable to non-cadet mode

            // Guidance type for munitions
            defaultSeekerType = "GPS";
            seekerTypes[] = {"GPS"};

            defaultSeekerLockMode = "LIN";
            seekerLockModes[] = {"LIN"};

            seekerAngle = 90;           // Angle in front of the missile which can be searched
            seekerAccuracy = 1;         // seeker accuracy multiplier

            seekerMinRange = 1;
            seekerMaxRange = 2500;      // Range from the missile which the seeker can visually search

            // Attack profile type selection
            defaultAttackProfile = "SSBM";
            attackProfiles[] = {"SSBM"};
        };
    };

    class MissileBase;
    
    //AIM-9 Sidewinder
    class Missile_AA_04_F: MissileBase {
            class ADDON {
            enabled = 1;
            
            seekers[] = {"Sidewinder"};
            seekerDirection[] = {};
            fuzes[] = {};
            fuzeDirection[] = {};
            
            defaultSeekerType = "IR";
            seekerTypes[] = {"IR"};

            defaultSeekerLockMode = "LIN";
            seekerLockModes[] = {"LIN"};

            seekerAngle = 90;           // Angle in front of the missile which can be searched
            seekerAccuracy = 1;         // seeker accuracy multiplier

            seekerMinRange = 0;
            seekerMaxRange = 2500;      // Range from the missile which the seeker can visually search

            // Attack profile type selection
            defaultAttackProfile = "AGM";
            attackProfiles[] = {"AGM"};
        };
    };

    //AIM-9X Sidewinder
    class ammo_Missile_BIM9X: MissileBase {
            class ADDON {
            enabled = 1;
            
            seekers[] = {"SidewinderX"};
            seekerDirection[] = {};
            fuzes[] = {};
            fuzeDirection[] = {};
            
            defaultSeekerType = "IR";
            seekerTypes[] = {"IR"};

            defaultSeekerLockMode = "LIN";
            seekerLockModes[] = {"LIN"};

            seekerAngle = 90;           // Angle in front of the missile which can be searched
            seekerAccuracy = 1;         // seeker accuracy multiplier

            seekerMinRange = 0;
            seekerMaxRange = 2500;      // Range from the missile which the seeker can visually search

            // Attack profile type selection
            defaultAttackProfile = "AGM";
            attackProfiles[] = {"AGM"};
        };
    };
    
    //AIM-132 ASRAAM
    class M_Air_AA: MissileBase {
            class ADDON {
            enabled = 1;
            
            seekers[] = {"seekerAAIR"};
            seekerDirection[] = {};
            fuzes[] = {};
            fuzeDirection[] = {};
            
            defaultSeekerType = "IR";
            seekerTypes[] = {"IR"};

            defaultSeekerLockMode = "LIN";
            seekerLockModes[] = {"LIN"};

            seekerAngle = 90;           // Angle in front of the missile which can be searched
            seekerAccuracy = 1;         // seeker accuracy multiplier

            seekerMinRange = 0;
            seekerMaxRange = 2500;      // Range from the missile which the seeker can visually search

            // Attack profile type selection
            defaultAttackProfile = "AGM";
            attackProfiles[] = {"AGM"};
        };
    };
    
    //AIM-120D AMRAAM
    class ammo_Missile_AMRAAM_D: MissileBase {
            class ADDON {
            enabled = 1;
            
            seekers[] = {"seekerAAIR"};
            seekerDirection[] = {};
            fuzes[] = {};
            fuzeDirection[] = {};
            
            defaultSeekerType = "IR";
            seekerTypes[] = {"IR"};

            defaultSeekerLockMode = "LIN";
            seekerLockModes[] = {"LIN"};

            seekerAngle = 90;           // Angle in front of the missile which can be searched
            seekerAccuracy = 1;         // seeker accuracy multiplier

            seekerMinRange = 0;
            seekerMaxRange = 2500;      // Range from the missile which the seeker can visually search

            // Attack profile type selection
            defaultAttackProfile = "AGM";
            attackProfiles[] = {"AGM"};
        };
    };
    
    //Rafael Spike-MR 'Gil'
    class M_Titan_AT: MissileBase {
            class ADDON {
            enabled = 1;
            
            seekers[] = {"TitanAT"};
            seekerDirection[] = {};
            fuzes[] = {};
            fuzeDirection[] = {};
            
            defaultSeekerType = "MCLOS";
            seekerTypes[] = {"MCLOS"};

            defaultSeekerLockMode = "LIN";
            seekerLockModes[] = {"LIN"};

            seekerAngle = 90;           // Angle in front of the missile which can be searched
            seekerAccuracy = 1;         // seeker accuracy multiplier

            seekerMinRange = 0;
            seekerMaxRange = 2500;      // Range from the missile which the seeker can visually search

            // Attack profile type selection
            defaultAttackProfile = "AGM";
            attackProfiles[] = {"AGM"};
        };
    };
    
    //Rafael Mini-Spike
    class M_Titan_AP: M_Titan_AT {
        class ADDON {
            enabled = 1;
            
            seekers[] = {"TitanAT"};
            seekerDirection[] = {};
            fuzes[] = {};
            fuzeDirection[] = {};
            
            modes[] = {};
            flightProfile = "flightProfileDefault";

            degreesPerSecond = 15;

            
            defaultSeekerType = "MCLOS";
            seekerTypes[] = {"MCLOS"};

            defaultSeekerLockMode = "LIN";
            seekerLockModes[] = {"LIN"};

            seekerAngle = 90;           // Angle in front of the missile which can be searched
            seekerAccuracy = 1;         // seeker accuracy multiplier

            seekerMinRange = 0;
            seekerMaxRange = 2500;      // Range from the missile which the seeker can visually search

            // Attack profile type selection
            defaultAttackProfile = "AGM";
            attackProfiles[] = {"AGM"};
        };
    };
    
    // FIM-92 Stinger
    class M_Titan_AA: MissileBase {
        class ADDON {
            enabled = 1;
            
            seekers[] = {"AIMIR"};
            seekerDirection[] = {};
            fuzes[] = {};
            fuzeDirection[] = {};
            
            degreesPerSecond = 5;
            
          

            minDeflection = 0.0005;      // Minium flap deflection for guidance
            maxDeflection = 0.0025;       // Maximum flap deflection for guidance
            incDeflection = 0.0005;      // The incrmeent in which deflection adjusts.

            canVanillaLock = 0;          // Can this default vanilla lock? Only applicable to non-cadet mode

            // Guidance type for munitions
            defaultSeekerType = "IR";
            seekerTypes[] = {"IR"};

            defaultSeekerLockMode = "LIN";
            seekerLockModes[] = {"LIN"};

            seekerAngle = 90;           // Angle in front of the missile which can be searched
            seekerAccuracy = 1;         // seeker accuracy multiplier

            seekerMinRange = 0;
            seekerMaxRange = 2500;      // Range from the missile which the seeker can visually search

            // Attack profile type selection
            defaultAttackProfile = "AAM";
            attackProfiles[] = {"AAM"};
        };
    };

    //AGM-65 Maverick
    class Missile_AGM_02_F : MissileBase {
        class ADDON {
            enabled = 1;
            
            seekers[] = {"Maverick"};
            seekerDirection[] = {0, 1, 0};
            fuzes[] = {};
            fuzeDirection[] = {};

            degreesPerSecond = 15;

            minDeflection = 0.0005;      // Minium flap deflection for guidance
            maxDeflection = 0.0025;       // Maximum flap deflection for guidance
            incDeflection = 0.0005;      // The incrmeent in which deflection adjusts.

            canVanillaLock = 0;          // Can this default vanilla lock? Only applicable to non-cadet mode

            // Guidance type for munitions
            defaultSeekerType = "EO";
            seekerTypes[] = {"EO"};

            defaultSeekerLockMode = "LIN";
            seekerLockModes[] = {"LIN"};

            seekerAngle = 90;           // Angle in front of the missile which can be searched
            seekerAccuracy = 1;         // seeker accuracy multiplier

            seekerMinRange = 0;
            seekerMaxRange = 5000;      // Range from the missile which the seeker can visually search

            // Attack profile type selection
            defaultAttackProfile = "AGM";
            attackProfiles[] = {"AGM"};
        };
    };
    
    // AGM-88 HARM
    class ammo_Missile_AntiRadiationBase: MissileBase {
        class ADDON {
            enabled = 1;
            
            seekers[] = {"seekerARM"};
            seekerDirection[] = {0, 1, 0};
            fuzes[] = {};
            fuzeDirection[] = {};
            
            degreesPerSecond = 15;

            minDeflection = 0.0005;      // Minium flap deflection for guidance
            maxDeflection = 0.0025;       // Maximum flap deflection for guidance
            incDeflection = 0.0005;      // The incrmeent in which deflection adjusts.

            canVanillaLock = 0;          // Can this default vanilla lock? Only applicable to non-cadet mode

            // Guidance type for munitions
            defaultSeekerType = "PRH";
            seekerTypes[] = {"PRH"};

            defaultSeekerLockMode = "LIN";
            seekerLockModes[] = {"LIN"};

            seekerAngle = 90;           // Angle in front of the missile which can be searched
            seekerAccuracy = 1;         // seeker accuracy multiplier

            seekerMinRange = 0;
            seekerMaxRange = 5000;      // Range from the missile which the seeker can visually search

            // Attack profile type selection
            defaultAttackProfile = "AGM";
            attackProfiles[] = {"AGM"};
        };
    };

    class BombCore;
    class LaserBombCore: BombCore {};
    class ammo_Bomb_LaserGuidedBase: LaserBombCore {};
    
    // GBU-12 Paveway II
    class Bomb_04_F: ammo_Bomb_LaserGuidedBase {
        class ADDON {
            enabled = 1;
            
            seekers[] = {"LGB"};
            seekerDirection[] = {0, 1, 0};
            fuzes[] = {};
            fuzeDirection[] = {};
            
            degreesPerSecond = 5;
                
            // Guidance type for munitions
            defaultSeekerType = "SALH";
            seekerTypes[] = {"SALH"};

            defaultSeekerLockMode = "LIN";
            seekerLockModes[] = {"LIN"};

            seekerAngle = 90;           // Angle in front of the missile which can be searched
            seekerAccuracy = 1;         // seeker accuracy multiplier

            seekerMinRange = 0;
            seekerMaxRange = 5000;      // Range from the missile which the seeker can visually search

            // Attack profile type selection
            defaultAttackProfile = "GBU";
            attackProfiles[] = {"GBU"};
        };
    };

    // GBU-39 Small-Diameter Bomb    
    class ammo_Bomb_SmallDiameterBase: ammo_Bomb_LaserGuidedBase {};
    class ammo_Bomb_SDB: ammo_Bomb_SmallDiameterBase {
        class ADDON {
            enabled = 1;
            
            seekers[] = {"SDB"};
            seekerDirection[] = {0, 1, 0};
            fuzes[] = {};
            fuzeDirection[] = {};
            
            degreesPerSecond = 15;
                
            // Guidance type for munitions
            defaultSeekerType = "GPS";
            seekerTypes[] = {"GPS"};

            defaultSeekerLockMode = "LIN";
            seekerLockModes[] = {"LIN"};

            seekerAngle = 90;           // Angle in front of the missile which can be searched
            seekerAccuracy = 1;         // seeker accuracy multiplier

            seekerMinRange = 0;
            seekerMaxRange = 5000;      // Range from the missile which the seeker can visually search

            // Attack profile type selection
            defaultAttackProfile = "GBU";
            attackProfiles[] = {"GBU"};
        };     
    };
};

