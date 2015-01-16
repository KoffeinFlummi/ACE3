class CfgVehicles
{
	class Logic;
	class Module_F: Logic {
		class ArgumentsBaseUnits {
		};
	};
	class ACE_moduleCombatMedicalSystem: Module_F	{
		scope = 2;
		displayName = "Combat Medical System [ACE]";
		icon = QUOTE(PATHTOF(data\ACE_medical_module.paa));
		category = "ACE_medical";
		function = QUOTE(FUNC(initalizeModuleCMS));
		functionPriority = 1;
		isGlobal = 1;
		isTriggerActivated = 0;
		author = "Glowbal";
		class Arguments	{
			class advancedLevel {
				displayName = "Advanced Level";
				description = "How advanced can the medical system be?";
				typeName = "NUMBER";
				class values {
					class basic {
						name = "Basic. Only bleeding and pain.";
						value = 0;
						default = 1;
					};
					class normal {
						name = "Normal. Bleeding, Pain, Blood pressure and heart rate";
						value = 1;
					};
					class full  {
						name = "Full. Everything enabled.";
						value = 2;
					};
				};
			};
			class openingOfWounds {
				displayName = "Advanced Wounds";
				description = "When set to true, bandaged wounds could on occasion re-open, resulting in new open wounds that need to be bandaged.";
				typeName = "BOOL";
				defaultValue = 1;
			};
			class mediACEtting {
				displayName = "Advanced Medic roles";
				description = "Medics only are able to view the detailed information";
				typeName = "BOOL";
				defaultValue = 1;
			};
			class difficultySetting {
				displayName = "Survival Difficulty";
				description = "Select the aggressiveness of the medical simulation";
				typeName = "NUMBER";
				class values {
					class recruit {
						name = "Recruit";
						value = 0.5;
					};
					class regular {
						name = "Regular";
						value = 1;
						default = 1;
					};
					class veteran {
						name = "Veteran";
						value = 1.2;
					};
					class expert  {
						name = "Expert";
						value = 1.5;
					};
				};
			};
			class enableFor {
				displayName = "Enabled for";
				description = "Select what units CMS will be enabled for";
				typeName = "NUMBER";
				class  values {
					class playableUnits {
						name = "Players only";
						value = 0;
						default = 1;
					};
					class playableUnitsAndAI {
						name = "Players and AI";
						value = 1;
					};
				};
			};
			class enableAirway {
				displayName = "Enable Airway";
				description = "Should CMS Airway system be enabled?";
				typeName = "NUMBER";
				class values {
					class enable {
						name = "Yes";
						value = 1;
					};
					class disable {
						name = "No";
						value = 0;
						default = 1;
					};
				};
			};
			class vehCrashes {
				displayName = "Vehicle Crashes";
				description = "Enable injuries on vehicle crashes";
				typeName = "BOOL";
				defaultValue = 1;
			};

			class aidKitUponUsage {
				displayName = "Disposable Aid kit";
				description = "Is a personal aid kit disposable?";
				typeName = "BOOL";
				defaultValue = false;
			};
			class aidKitMedicsOnly {
				displayName = "Medics only";
				description = "Are aid kits restricted to medics only?";
				typeName = "BOOL";
				defaultValue = false;
			};
			class aidKitRestrictions {
				displayName = "Aid kit";
				description = "When can an Aid kit be used?";
				typeName = "NUMBER";
				class  values {
					class medFacility {
						name = "Medical Facility";
						value = 0;
						default = 1;
					};
					class medFAcilityNoBleeding {
						name = "Medical Facility & No bleeding";
						value = 1;
					};
					class Everywhere {
						name = "Everywhere";
						value = 2;
					};
					class EverywhereNoBleeding {
						name = "Everywhere & No Bleeding";
						value = 3;
					};
				};
			};
			class bandageTime {
				displayName = "Bandage Time";
				description = "Time it takes for a bandage action to be completed";
				typeName = "NUMBER";
				defaultValue = 5;
			};
			class stitchingAllow {
				displayName = "Can Stitch";
				description = "What units can use stitching?";
				typeName = "NUMBER";
				defaultValue = 0;
				class values {
					class medicsOnly {
						name = "Medics Only";
						value = 0;
						default = 1;
					};
					class everyone {
						name = "Everyone";
						value = 1;
					};
					class noOne {
						name = "No units";
						value = -1;
					};
				};
			};

		};
		class ModuleDescription {
			description = "Provides a more realistic medical system for both players and AI."; // Short description, will be formatted as structured text
			sync[] = {};
		};
	};
	class ACE_moduleAssignMedicRoles_CMS: Module_F {
		scope = 2;
		displayName = "Set Medic Class [ACE]";
		icon = QUOTE(PATHTOF(data\ACE_medical_module.paa));
		category = "ACE_medical";
		function = QUOTE(FUNC(assignMedicRoles_CMS));
		functionPriority = 10;
		isGlobal = 2;
		isTriggerActivated = 0;
		isDisposable = 0;
		author = "Glowbal";
		class Arguments	{
			class EnableList {
				displayName = "List";
				description = "List of unit names that will be classified as medic, separated by commas.";
				defaultValue = "";
			};
			class class {
				displayName = "Is Medic";
				description = "Medics allow for more advanced treatment in case of Advanced Medic roles enabled";
				typeName = "BOOL";
				defaultValue = true;
			};
		};
		class ModuleDescription {
			description = "Assigns the ACE medic class to a unit"; // Short description, will be formatted as structured text
			sync[] = {};
		};
	};

	class ACE_moduleAssignMedicalVehicle_CMS: Module_F {
		scope = 2;
		displayName = "set Medical Vehicle [ACE]";
		icon = QUOTE(PATHTOF(data\ACE_medical_module.paa));
		category = "ACE_medical";
		function = QUOTE(FUNC(assignMedicalVehicle_CMS));
		functionPriority = 10;
		isGlobal = 2;
		isTriggerActivated = 0;
		isDisposable = 0;
		author = "Glowbal";
		class Arguments	{
			class EnableList {
				displayName = "List";
				description = "List of object names that will be classified as medical vehicle, separated by commas.";
				defaultValue = "";
			};
			class enabled {
				displayName = "Is Medical Vehicle";
				description = "Whatever or not the objects in the list will be a medical vehicle.";
				typeName = "BOOL";
				defaultValue = true;
			};
		};
		class ModuleDescription {
			description = "Assigns the ACE medical vehicle class to a vehicle.";
			sync[] = {};
		};
	};

	class ACE_moduleAssignMedicalFacility_CMS: Module_F {
		scope = 2;
		displayName = "Set Medical Facility [ACE]";
		icon = QUOTE(PATHTOF(data\ACE_medical_module.paa));
		category = "ACE_medical";
		function = QUOTE(FUNC(assignMedicalFacility_CMS));
		functionPriority = 10;
		isGlobal = 2;
		isTriggerActivated = 0;
		isDisposable = 0;
		author = "Glowbal";
		class Arguments	{
			class class {
				displayName = "Is Medical Facility";
				description = "Registers an object as a medical facility for CMS";
				typeName = "BOOL";
			};
		};
		class ModuleDescription {
			description = "Defines an object as a medical facility for CMS. This allows for more advanced treatments. Can be used on buildings and vehicles. ";
			sync[] = {};
		};
	};
	class ACE_moduleAssignMedicalEquipment_CMS: Module_F {
		scope = 2;
		displayName = "Assign Medical Equipment [ACE]";
		icon = QUOTE(PATHTOF(data\ACE_medical_module.paa));
		category = "ACE_medical";
		function = QUOTE(FUNC(assignMedicalEquipment_CMS));
		functionPriority = 1;
		isGlobal = 1;
		isTriggerActivated = 0;
		author = "Glowbal";
		class Arguments	{
			class equipment {
				displayName = "Assign Equipment";
				description = "Assign Medical equipment to all players";
				typeName = "NUMBER";
				defaultValue = 0;
				class values {
					class AllPlayers {
						name = "All Players";
						value = 0;
						default = 1;
					};
					class MedicsOnly {
						name = "Medics only";
						value = 1;
					};
				};
			};
		};
		class ModuleDescription {
			description = "Assigns medical equipment to units";
			sync[] = {};
		};
	};


	class MapBoard_altis_F;
	class ACE_bodyBag: MapBoard_altis_F {
		scope = 1;
		side = -1;
		model = QUOTE(PATHTOF(equipment\bodybag.p3d));
		icon = "";
		displayName = $STR_ACE_MAG_BODYBAG_DISPLAY;
	};


	class Item_Base_F;
	class ACE_bandage_basicItem: Item_Base_F {
		scope = 2;
		scopeCurator = 2;
		displayName = $STR_ACE_MAG_BANDAGE_BASIC_DISPLAY;
		author = "Glowbal";
		vehicleClass = "Items";
		class TransportItems
		{
			class ACE_bandage_basic
			{
				name = "ACE_bandage_basic";
				count = 1;
			};
		};
	};
	class ACE_packing_bandageItem: Item_Base_F {
		scope = 2;
		scopeCurator = 2;
		displayName = $STR_ACE_MAG_PACKING_BANDAGE_DISPLAY;
		author = "Glowbal";
		vehicleClass = "Items";
		class TransportItems
		{
			class ACE_packing_bandage
			{
				name = "ACE_packing_bandage";
				count = 1;
			};
		};
	};
	class ACE_bandageElasticItem: Item_Base_F {
		scope = 2;
		scopeCurator = 2;
		displayName = $STR_ACE_MAG_BANDAGE_ELASTIC_DISPLAY;
		author = "Glowbal";
		vehicleClass = "Items";
		class TransportItems
		{
			class ACE_bandageElastic
			{
				name = "ACE_bandageElastic";
				count = 1;
			};
		};
	};
	class ACE_tourniquetItem: Item_Base_F {
		scope = 2;
		scopeCurator = 2;
		displayName = $STR_ACE_MAG_TOURNIQUET_DISPLAY;
		author = "Glowbal";
		vehicleClass = "Items";
		class TransportItems
		{
			class ACE_tourniquet
			{
				name = "ACE_tourniquet";
				count = 1;
			};
		};
	};
	class ACE_splintItem: Item_Base_F {
		scope = 2;
		scopeCurator = 2;
		displayName = $STR_ACE_MAG_SPLINT_DISPLAY;
		author = "Glowbal";
		vehicleClass = "Items";
		class TransportItems
		{
			class ACE_splint
			{
				name = "ACE_splint";
				count = 1;
			};
		};
	};
	class ACE_morphineItem: Item_Base_F {
		scope = 2;
		scopeCurator = 2;
		displayName = $STR_ACE_MAG_MORPHINE_DISPLAY;
		author = "Glowbal";
		vehicleClass = "Items";
		class TransportItems
		{
			class ACE_morphine
			{
				name = "ACE_morphine";
				count = 1;
			};
		};
	};
	class ACE_atropineItem: Item_Base_F {
		scope = 2;
		scopeCurator = 2;
		displayName = $STR_ACE_MAG_ATROPINE_DISPLAY;
		author = "Glowbal";
		vehicleClass = "Items";
		class TransportItems
		{
			class ACE_atropine
			{
				name = "ACE_atropine";
				count = 1;
			};
		};
	};
	class ACE_epinephrineItem: Item_Base_F {
		scope = 2;
		scopeCurator = 2;
		displayName = $STR_ACE_MAG_EPINEPHRINE_DISPLAY;
		author = "Glowbal";
		vehicleClass = "Items";
		class TransportItems
		{
			class ACE_epinephrine
			{
				name = "ACE_epinephrine";
				count = 1;
			};
		};
	};
	class ACE_plasma_ivItem: Item_Base_F {
		scope = 2;
		scopeCurator = 2;
		displayName = $STR_ACE_MAG_PLASMA_IV;
		author = "Glowbal";
		vehicleClass = "Items";
		class TransportItems
		{
			class ACE_plasma_iv
			{
				name = "ACE_plasma_iv";
				count = 1;
			};
		};
	};
	class ACE_plasma_iv_500Item: Item_Base_F {
		scope = 2;
		scopeCurator = 2;
		displayName = $STR_ACE_MAG_PLASMA_IV_500;
		author = "Glowbal";
		vehicleClass = "Items";
		class TransportItems
		{
			class ACE_plasma_iv_500
			{
				name = "ACE_plasma_iv_500";
				count = 1;
			};
		};
	};
	class ACE_plasma_iv_250Item: Item_Base_F {
		scope = 2;
		scopeCurator = 2;
		displayName = $STR_ACE_MAG_PLASMA_IV_250;
		author = "Glowbal";
		vehicleClass = "Items";
		class TransportItems
		{
			class ACE_plasma_iv_250
			{
				name = "ACE_plasma_iv_250";
				count = 1;
			};
		};
	};
	class ACE_blood_ivItem: Item_Base_F {
		scope = 2;
		scopeCurator = 2;
		displayName = $STR_ACE_MAG_BLOOD_IV;
		author = "Glowbal";
		vehicleClass = "Items";
		class TransportItems
		{
			class ACE_blood_iv
			{
				name = "ACE_blood_iv";
				count = 1;
			};
		};
	};
	class ACE_blood_iv_500Item: Item_Base_F {
		scope = 2;
		scopeCurator = 2;
		displayName = $STR_ACE_MAG_BLOOD_IV_500;
		author = "Glowbal";
		vehicleClass = "Items";
		class TransportItems
		{
			class ACE_blood_iv_500
			{
				name = "ACE_blood_iv_500";
				count = 1;
			};
		};
	};
	class ACE_blood_iv_250Item: Item_Base_F {
		scope = 2;
		scopeCurator = 2;
		displayName = $STR_ACE_MAG_BLOOD_IV_250;
		author = "Glowbal";
		vehicleClass = "Items";
		class TransportItems
		{
			class ACE_blood_iv_250
			{
				name = "ACE_blood_iv_250";
				count = 1;
			};
		};
	};
	class ACE_saline_ivItem: Item_Base_F {
		scope = 2;
		scopeCurator = 2;
		displayName = $STR_ACE_MAG_SALINE_IV;
		author = "Glowbal";
		vehicleClass = "Items";
		class TransportItems
		{
			class ACE_saline_iv
			{
				name = "ACE_saline_iv";
				count = 1;
			};
		};
	};
	class ACE_saline_iv_500Item: Item_Base_F {
		scope = 2;
		scopeCurator = 2;
		displayName = $STR_ACE_MAG_SALINE_IV_500;
		author = "Glowbal";
		vehicleClass = "Items";
		class TransportItems
		{
			class ACE_saline_iv_500
			{
				name = "ACE_saline_iv_500";
				count = 1;
			};
		};
	};
	class ACE_saline_iv_250Item: Item_Base_F {
		scope = 2;
		scopeCurator = 2;
		displayName = $STR_ACE_MAG_SALINE_IV_250;
		author = "Glowbal";
		vehicleClass = "Items";
		class TransportItems
		{
			class ACE_saline_iv_250
			{
				name = "ACE_saline_iv_250";
				count = 1;
			};
		};
	};
	class ACE_quikclotItem: Item_Base_F {
		scope = 2;
		scopeCurator = 2;
		displayName = $STR_ACE_MAG_QUIKCLOT_DISPLAY;
		author = "Glowbal";
		vehicleClass = "Items";
		class TransportItems
		{
			class ACE_quikclot
			{
				name = "ACE_quikclot";
				count = 1;
			};
		};
	};
	class ACE_nasopharyngeal_tubeItem: Item_Base_F {
		scope = 2;
		scopeCurator = 2;
		displayName = $STR_ACE_MAG_NPA_DISPLAY;
		author = "Glowbal";
		vehicleClass = "Items";
		class TransportItems
		{
			class ACE_nasopharyngeal_tube
			{
				name = "ACE_nasopharyngeal_tube";
				count = 1;
			};
		};
	};
	class ACE_opaItem: Item_Base_F {
		scope = 2;
		scopeCurator = 2;
		displayName = $STR_ACE_MAG_OPA_DISPLAY;
		author = "Glowbal";
		vehicleClass = "Items";
		class TransportItems
		{
			class ACE_opa
			{
				name = "ACE_opa";
				count = 1;
			};
		};
	};
	class ACE_liquidSkinItem: Item_Base_F {
		scope = 2;
		scopeCurator = 2;
		displayName = $STR_ACE_MAG_LIQUID_SKIN_DISPLAY;
		author = "Glowbal";
		vehicleClass = "Items";
		class TransportItems
		{
			class ACE_liquidSkin
			{
				name = "ACE_liquidSkin";
				count = 1;
			};
		};
	};
	class ACE_chestsealItem: Item_Base_F {
		scope = 2;
		scopeCurator = 2;
		displayName = $STR_ACE_MAG_CHEST_SEAL_DISPLAY;
		author = "Glowbal";
		vehicleClass = "Items";
		class TransportItems
		{
			class ACE_chestseal
			{
				name = "ACE_chestseal";
				count = 1;
			};
		};
	};
	class ACE_personal_aid_kitItem: Item_Base_F {
		scope = 2;
		scopeCurator = 2;
		displayName = $STR_ACE_MAG_AID_KIT_DISPLAY;
		author = "Glowbal";
		vehicleClass = "Items";
		class TransportItems
		{
			class ACE_personal_aid_kit
			{
				name = "ACE_personal_aid_kit";
				count = 1;
			};
		};
	};
	class ACE_bodyBagItem: Item_Base_F {
		scope = 2;
		scopeCurator = 2;
		displayName = $STR_ACE_MAG_BODYBAG_DISPLAY;
		author = "Glowbal";
		vehicleClass = "Items";
		class TransportItems
		{
			class ACE_itemBodyBag
			{
				name = "ACE_itemBodyBag";
				count = 1;
			};
		};
	};


	class NATO_Box_Base;
	class ACE_medical_supply_crate_cms : NATO_Box_Base {
		scope = 2;
		accuracy = 1000;
		displayName = "Medical Supply Crate [ACE]";
		model = "\A3\weapons_F\AmmoBoxes\AmmoBox_F";
		author = "Glowbal";
		class TransportItems {
			class ACE_bandage_basic {
				name = "ACE_bandage_basic";
				count = 25;
			};
			class ACE_packing_bandage {
				name = "ACE_packing_bandage";
				count = 25;
			};
			class ACE_tourniquet {
				name = "ACE_tourniquet";
				count = 25;
			};
			class ACE_splint {
				name = "ACE_splint";
				count = 25;
			};
			class ACE_plasma_iv {
				name = "ACE_plasma_iv";
				count = 25;
			};
			class ACE_plasma_iv_500 {
				name = "ACE_plasma_iv_500";
				count = 25;
			};
			class ACE_plasma_iv_250 {
				name = "ACE_plasma_iv_250";
				count = 25;
			};
			class ACE_blood_iv {
				name = "ACE_blood_iv";
				count = 25;
			};
			class ACE_blood_iv_500 {
				name = "ACE_blood_iv_500";
				count = 25;
			};
			class ACE_blood_iv_250 {
				name = "ACE_blood_iv_250";
				count = 25;
			};
			class ACE_saline_iv {
				name = "ACE_saline_iv";
				count = 25;
			};
			class ACE_saline_iv_500 {
				name = "ACE_saline_iv_500";
				count = 25;
			};
			class ACE_saline_iv_250 {
				name = "ACE_saline_iv_250";
				count = 25;
			};
			class ACE_morphine {
				name = "ACE_morphine";
				count = 25;
			};
			class ACE_epinephrine {
				name = "ACE_epinephrine";
				count = 25;
			};
			class ACE_atropine {
				name = "ACE_atropine";
				count = 25;
			};
			class ACE_quikclot {
				name = "ACE_quikclot";
				count = 25;
			};
			class ACE_nasopharyngeal_tube {
				name = "ACE_nasopharyngeal_tube";
				count = 25;
			};
			class ACE_bandageElastic {
				name = "ACE_bandageElastic";
				count = 25;
			};
			class ACE_liquidSkin {
				name = "ACE_liquidSkin";
				count = 25;
			};
			class ACE_chestseal {
				name = "ACE_chestseal";
				count = 25;
			};
			class ACE_personal_aid_kit {
				name = "ACE_personal_aid_kit";
				count = 25;
			};
			class ACE_surgical_kit {
				name = "ACE_surgical_kit";
				count = 25;
			};
			class ACE_itemBodyBag {
				name = "ACE_itemBodyBag";
				count = 5;
			};
		};
	};
};
