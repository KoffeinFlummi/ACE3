
class CfgVehicles {
    class All {
        class Turrets;
    };

    class AllVehicles: All {
        class NewTurret {
            class Turrets;
        };
        class CargoTurret;
    };

    class Air: AllVehicles {
        class AnimationSources;
    };

    class Helicopter: Air {
        class Turrets {
            class MainTurret;
        };
    };

    class Plane: Air {};

    class ParachuteBase: Helicopter {
        class Turrets;
    };

    class UAV: Plane {};

    class Helicopter_Base_F: Helicopter {
        class Turrets: Turrets {
            class CopilotTurret;
        };
    };

    class Helicopter_Base_H: Helicopter_Base_F {
        class Turrets: Turrets {
            class CopilotTurret;
        };
        //class UserActions;
    };

    class Heli_Light_01_base_F: Helicopter_Base_H {
        lockDetectionSystem = 0;
        incomingMissileDetectionSystem = 16;
        driverCanEject = 1;
        //class MFD {};
        class Turrets: Turrets {
            class CopilotTurret: CopilotTurret {
                canEject = 1;
                showHMD = 1;
            };
        };
    };

    class B_Heli_Light_01_F: Heli_Light_01_base_F {
        /*class Turrets: Turrets {
            class CopilotTurret: CopilotTurret {};

            class CargoTurret_01: CargoTurret {};
            class CargoTurret_02: CargoTurret_01 {};
            class CargoTurret_03: CargoTurret_02 {};
            class CargoTurret_04: CargoTurret_01 {};
        };*/
    };

    class Heli_Light_01_armed_base_F: Heli_Light_01_base_F {
        lockDetectionSystem = 0;
        incomingMissileDetectionSystem = 16;
        driverCanEject = 1;
        //class MFD {};
        class Turrets: Turrets {
            class CopilotTurret: CopilotTurret {
                canEject = 1;
            };
        };
    };

    class B_Heli_Light_01_armed_F: Heli_Light_01_armed_base_F {};

    class Heli_Light_02_base_F: Helicopter_Base_H {
        driverCanEject = 1;
        lockDetectionSystem = 12;
        incomingMissileDetectionSystem = 16;
        magazines[] = {"2000Rnd_762x51_Belt_T_Green", "12Rnd_PG_missiles", "168Rnd_CMFlare_Chaff_Magazine"};
        class Turrets: Turrets {
            class CopilotTurret: CopilotTurret {
                canEject = 1;
                showHMD = 1;
            };
        };
    };

    class Plane_Base_F: Plane {
        class Turrets {
            class CopilotTurret;
        };
    };

    class Heli_Attack_01_base_F: Helicopter_Base_F {
        lockDetectionSystem = 12;
        incomingMissileDetectionSystem = 16;
        driverCanEject = 1;
        //class MFD {};
        class AnimationSources: AnimationSources {
            class HitGlass1 {
                source = "Hit";
                hitpoint = "HitGlass1";
                raw = 1;
            };
            class HitGlass2: HitGlass1 {
                hitpoint = "HitGlass2";
            };
            class HitGlass3: HitGlass1 {
                hitpoint = "HitGlass3";
            };
            class HitGlass4: HitGlass1 {
                hitpoint = "HitGlass4";
            };
            class Gatling {
                source = "revolving";
                weapon = "ACE_gatling_20mm_Comanche";
            };
            class Hide {
                source = "user";
                animPeriod = 0;
                initPhase = 0;
            };
            class Muzzle_flash {
                source = "ammorandom";
                weapon = "ACE_gatling_20mm_Comanche";
            };
        };
        class Turrets: Turrets {
            class MainTurret: MainTurret {
                canEject = 1;
                showHMD = 1;
                weapons[] = {"ACE_gatling_20mm_Comanche","missiles_DAGR","missiles_ASRAAM"};
                magazines[] = {"ACE_500Rnd_20mm_shells_Comanche","4Rnd_AAA_missiles","24Rnd_PG_missiles"};
            };
        };
    };

    class B_Heli_Attack_01_F: Heli_Attack_01_base_F {};

    class Heli_Attack_02_base_F: Helicopter_Base_F {
        lockDetectionSystem = 12;
        incomingMissileDetectionSystem = 16;
        driverCanEject = 1;
        class Turrets: Turrets {
            class MainTurret: MainTurret {
                canEject = 1;
            };
        };
    };

    class Heli_Transport_01_base_F: Helicopter_Base_H {
        lockDetectionSystem = 12;
        incomingMissileDetectionSystem = 16;
        driverCanEject = 1;
        class Turrets: Turrets {
            class CopilotTurret: CopilotTurret {
                canEject = 1;
                showHMD = 1;
            };
            class MainTurret: MainTurret {
                magazines[] = {"2000Rnd_762x51_Belt_T_Red"};
                canEject = 1;
            };
            class RightDoorGun: MainTurret {
                magazines[] = {"2000Rnd_762x51_Belt_T_Red"};
                canEject = 1;
            };
        };
        /*class UserActions {
            class DoorL1_Open {
                available = 1;
                condition = "((this doorPhase 'door_L') == 0) AND Alive(this) AND driver this != player AND gunner this != player";
            };
            class DoorR1_Open: DoorL1_Open {
                condition = "((this doorPhase 'door_R') == 0) AND Alive(this) AND driver this != player AND gunner this != player";
            };
            class DoorL1_Close: DoorL1_Open {
                condition = "((this doorPhase 'door_L') > 0) AND Alive(this) AND driver this != player AND gunner this != player";
            };
            class DoorR1_Close: DoorL1_Close {
                condition = "((this doorPhase 'door_R') > 0) AND Alive(this) AND driver this != player AND gunner this != player";
            };
        };*/
    };

    class Heli_Transport_02_base_F: Helicopter_Base_H {
        lockDetectionSystem = 12;
        incomingMissileDetectionSystem = 16;
        driverCanEject = 1;
        //class MFD {};
        class Turrets: Turrets {
            class CopilotTurret: CopilotTurret {
                canEject = 1;
                showHMD = 1;
            };

            class CargoTurret_01: CargoTurret {};
            class CargoTurret_02: CargoTurret_01 {};
        };
        /*class UserActions: UserActions {
            class DoorL1_Open {
                available = 1;
                condition = "this animationPhase ""door_back_L"" < 0.5 AND Alive(this)";
            };
            class DoorR1_Open: DoorL1_Open {
                condition = "this animationPhase ""door_back_R"" < 0.5 AND Alive(this)";
            };
            class DoorL1_Close: DoorL1_Open {
                condition = "this animationPhase ""door_back_L"" > 0.5 AND Alive(this)";
            };
            class DoorR1_Close: DoorL1_Close {
                condition = "this animationPhase ""door_back_R"" > 0.5 AND Alive(this)";
            };
            class CargoRamp_Open: DoorL1_Open {
                userActionID = 52;
                displayName = "$STR_ACE_Aircraft_OpenCargoRamp";
                textToolTip = "$STR_ACE_Aircraft_OpenCargoRamp";
                position = "action_cargoramp";
                radius = 3.0;
                condition = "this animationPhase ""cargoramp_open"" < 0.5 AND Alive(this)";
                statement = "this animateDoor ['cargoramp_open', 1]";
            };
            class CargoRamp_Close: DoorL1_Close {
                userActionID = 55;
                displayName = "$STR_ACE_Aircraft_CloseCargoRamp";
                textToolTip = "$STR_ACE_Aircraft_CloseCargoRamp";
                position = "action_cargoramp";
                radius = 3.0;
                condition = "this animationPhase ""cargoramp_open"" > 0.5 AND Alive(this)";
                statement = "this animateDoor ['cargoramp_open', 0]";
            };
        };*/
    };

    class I_Heli_Transport_02_F: Heli_Transport_02_base_F {};

    class I_Heli_light_03_base_F: Helicopter_Base_F {
        lockDetectionSystem = 0;
        incomingMissileDetectionSystem = 16;
        driverCanEject = 1;
        //class MFD {};
        weapons[] = {"M134_minigun","missiles_DAR","CMFlareLauncher"};
        magazines[] = {"5000Rnd_762x51_Yellow_Belt","24Rnd_missiles","168Rnd_CMFlare_Chaff_Magazine"};
        class Turrets: Turrets {
            class MainTurret: MainTurret {
                canEject = 1;
                showHMD = 1;
                gunBeg = "commanderview";
                gunEnd = "laserstart";
                memoryPointGun = "laserstart";
                stabilizedInAxes = 3;
                weapons[] = {"Laserdesignator_mounted"};
                soundServo[] = {"",0.01,1,30};
                magazines[] = {"Laserbatteries"};
                inGunnerMayFire = 1;
            };
        };
    };

    class I_Heli_light_03_F: I_Heli_light_03_base_F {
        class Turrets: Turrets {
            class MainTurret: MainTurret {};

            class CargoTurret_01: CargoTurret {};
            class CargoTurret_02: CargoTurret_01 {};
        };
    };

    class I_Heli_light_03_unarmed_base_F: I_Heli_light_03_base_F {
        //class MFD {};
    };
    class I_Heli_light_03_unarmed_F: I_Heli_light_03_unarmed_base_F {};

    class Plane_CAS_01_base_F: Plane_Base_F {
        lockDetectionSystem = 12;
        incomingMissileDetectionSystem = 16;
        //class MFD {};
        class Turrets;
        #include <flightmodel_thunderbolt.hpp>
    };

    class Plane_CAS_02_base_F: Plane_Base_F {
        lockDetectionSystem = 12;
        incomingMissileDetectionSystem = 16;
        class Turrets;
        #include <flightmodel_yak.hpp>
    };

    class Plane_Fighter_03_base_F: Plane_Base_F {
        lockDetectionSystem = 12;
        incomingMissileDetectionSystem = 16;
        class Turrets;
        #include <flightmodel_alca.hpp>
    };

    class UAV_01_base_F: Helicopter_Base_F {
        /*class Turrets: Turrets {
            class MainTurret: MainTurret {};
        };*/
    };

    class UAV_02_base_F: UAV {
        class Turrets {
            class MainTurret;
        };
        weapons[] = {};
        magazines[] = {};
    };

    class UAV_02_CAS_base_F: UAV_02_base_F {
        /*class Turrets: Turrets {
            class MainTurret: MainTurret {};
        };*/
        weapons[] = {};
        magazines[] = {};
    };

    class B_Heli_Transport_03_base_F: Helicopter_Base_H {
        lockDetectionSystem = 12;
        incomingMissileDetectionSystem = 16;
        driverCanEject = 1;
        class Turrets: Turrets {
            class CopilotTurret: CopilotTurret {
                canEject = 1;
            };
            //class MainTurret: MainTurret {};
            class RightDoorGun: MainTurret {};

            class CargoTurret_01: CargoTurret {};
            class CargoTurret_02: CargoTurret_01 {};
        };
    };

    class B_Heli_Transport_03_unarmed_base_F: B_Heli_Transport_03_base_F {
        class Turrets: Turrets {
            class CopilotTurret: CopilotTurret {
                canEject = 1;
            };
            //class MainTurret: MainTurret {};
            //class RightDoorGun: MainTurret {};

            //class CargoTurret_01: CargoTurret {};
            //class CargoTurret_02: CargoTurret_01 {};
        };
    };

    class Heli_Transport_04_base_F: Helicopter_Base_H {
        lockDetectionSystem = 12;
        incomingMissileDetectionSystem = 16;
        driverCanEject = 1;
        class Turrets: Turrets {
            class CopilotTurret: CopilotTurret {
                canEject = 1;
            };
            class LoadmasterTurret: MainTurret {
                canEject = 1;
            };
        };
    };

    class O_Heli_Transport_04_bench_F: Heli_Transport_04_base_F {
        class Turrets: Turrets {
            class CopilotTurret: CopilotTurret {
                canEject = 1;
            };
            class LoadmasterTurret: LoadmasterTurret {
                canEject = 1;
            };

            class CargoTurret_01: CargoTurret {};
            class CargoTurret_02: CargoTurret_01 {};
            class CargoTurret_03: CargoTurret_01 {};
            class CargoTurret_04: CargoTurret_01 {};
            class CargoTurret_05: CargoTurret_01 {};
            class CargoTurret_06: CargoTurret_05 {};
            class CargoTurret_07: CargoTurret_05 {};
            class CargoTurret_08: CargoTurret_05 {};
        };
    };

    class O_Heli_Transport_04_covered_F: Heli_Transport_04_base_F {
        class Turrets: Turrets {
            class CopilotTurret: CopilotTurret {
                canEject = 1;
            };
            class LoadmasterTurret: LoadmasterTurret {
                canEject = 1;
            };

            class CargoTurret_01: CargoTurret {};
            class CargoTurret_02: CargoTurret_01 {};
        };
    };
};
