
class MainTurret;
class CfgVehicles {
    class LandVehicle;
    
    class StaticWeapon : LandVehicle {
        class Turrets {
            class MainTurret;
        };
    };
    
    class StaticMGWeapon: StaticWeapon{
		class Turrets : Turrets  {
			class MainTurret : MainTurret {
                class ViewOptics;
            };
		};
	};
    
    class ACE_M47_Dragon_Static_Base : StaticMGWeapon {
		features = "Balls";
        scope = 0;
		displayName = "ACE M47 Dragon";
		class Armory {
			description = "Balls";
		};
		model = QUOTE(PATHTOF(models\ace_m47_static.p3d));
		picture = "\A3\Static_F_Gamma\data\UI\gear_StaticTurret_AT_CA.paa";
		UiPicture = "\A3\Static_F_Gamma\data\UI\gear_StaticTurret_AT_CA.paa";
		icon = "\A3\Static_F_Gamma\data\UI\map_StaticTurret_AT_CA.paa";
		threat[] = {0.3,1.0,0.3};
		cost = 150000;
		class Damage {
			tex[] = {};
			mat[] = {"a3\static_f_gamma\data\staticturret_01.rvmat","a3\static_f_gamma\data\staticturret_01_damage.rvmat","a3\static_f_gamma\data\staticturret_01_destruct.rvmat","a3\static_f_gamma\data\staticturret_02.rvmat","a3\static_f_gamma\data\staticturret_02_damage.rvmat","a3\static_f_gamma\data\staticturret_02_destruct.rvmat","a3\weapons_f_beta\launchers\titan\data\titan_launcher.rvmat","a3\weapons_f_beta\launchers\titan\data\titan_launcher_damage.rvmat","a3\weapons_f_beta\launchers\titan\data\titan_launcher_destruct.rvmat","a3\weapons_f_beta\launchers\titan\data\titan_mtube.rvmat","a3\weapons_f_beta\launchers\titan\data\titan_mtube_damage.rvmat","a3\weapons_f_beta\launchers\titan\data\titan_mtube_destruct.rvmat"};
		};
		class Turrets: Turrets
		{
			class MainTurret: MainTurret
			{
				optics = 1;
				turretInfoType = "RscWeaponEmpty";
				gunnerOpticsModel = PATHTOF(models\optics_m47.p3d);
				minElev = -20;
				weapons[] = {"ACE_M47_Dragon_Static"};
				magazines[] = {};
                
                gunnerAction = "gunner_static_low01";
				gunnergetInAction = "";
				gunnergetOutAction = "";
                
                discreteDistance[] = {};
				discreteDistanceInitIndex = 0;
                
                class OpticsIn 
                {
                    class Wide: ViewOptics
                    {
                        initFov = 0.015;
                        minFov = 0.015;
                        maxFov = 0.015;
                        gunnerOpticsModel = PATHTOF(models\optics_m47.p3d);
                        gunnerOutOpticsModel = "\A3\weapons_f\reticle\optics_empty";
                        gunnerOpticsEffect[] = {"TankGunnerOptics1","OpticsBlur2","OpticsCHAbera2"};
                    };
                };
                
				displayName = "Balls in your face";
                
				class ViewOptics: ViewOptics
				{
					initAngleX = 0;
					minAngleX = -30;
					maxAngleX = 30;
					initAngleY = 5;
					minAngleY = -100;
					maxAngleY = 100;
					initFov = 0.015;
					minFov = 0.015;
					maxFov = 0.015;
					visionMode[] = {"Normal"};
					thermalMode[] = {0};
				};
				gunnerRightHandAnimName = "OtocHlaven_shake";
				gunnerLeftHandAnimName = "OtocHlaven_shake";
				gunBeg = "spice rakety";
				gunEnd = "konec rakety";
				memoryPointGunnerOptics = "look";
			};
		};
		class AnimationSources {
			class rest_rotate {
				source="user";
				animPeriod=0.00001;
				initPhase=-0.35;
				maxValue="3.60";
				minValue="-3.60";
			};
			class optic_hide {
				source="user";
				animPeriod=0.0001;
				initPhase=1;
				maxValue="1";
				minValue="0";
			};
			class missile_hide {
				source="user";
				animPeriod=0.0001;
				initPhase=0;
				maxValue="1";
				minValue="0";
			};
		};
		soundGetOut[] = {"A3\sounds_f\dummysound",0.001,1,5};
		soundGetIn[] = {"A3\sounds_f\dummysound",0.00031622776,1,5};
		armorStructural = 10.0;
		class assembleInfo
		{
			primary = 0;
			base = "";
			assembleTo = "";
			dissasembleTo[] = {};
			displayName = "";
		};
		hiddenSelections[] = {"camo_launcher","camo_tube"};
	};

    class ACE_M47_Dragon_Static : ACE_M47_Dragon_Static_Base {
        author = "ACE Team";
		_generalMacro = "O_static_AT_F";
		scope = 2;
		displayname = "ACE_M47_Dragon_Static";
		side = 1;
		faction = "BLU_F";
		crew = "B_soldier_f";
		hiddenSelectionsTextures[] = {"\a3\weapons_f_beta\launchers\titan\data\launcher_co.paa","\a3\weapons_f_beta\launchers\titan\data\tubem_co.paa"};
		class assembleInfo: assembleInfo
		{
			dissasembleTo[] = {"B_AT_01_weapon_F","B_HMG_01_support_F"};
		};
    };
};