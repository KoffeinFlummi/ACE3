
class CfgVehicles {
  /*class Man;
  class CAManBase: Man {
    // @todo
    class UserActions {
      class ACE_Fire {
        displayName = "";
        priority = -99;
        available = 1;
        radius = 2.5;
        radiusView = 0;
        position = "";
        showWindow = 0;
        showIn3D = 0;
        onlyForPlayer = 1;
        shortcut = "DefaultAction";
        condition = QUOTE(call GVAR(UserActionFireCondition));
        statement = QUOTE(call GVAR(UserActionFire));
        userActionID = 100;
      };
    };
  };*/

  // += needs a non inherited entry in that class, otherwise it simply overwrites
  //#include <DefaultItems.hpp>

  class Module_F;
  class ACE_ModuleCheckPBOs: Module_F {
    author = "$STR_ACE_Common_ACETeam";
    category = "ACE";
    displayName = "$STR_ACE_Common_CheckPBO_DisplayName";
	description = "$STR_ACE_Common_CheckPBO_Description";
    function = QFUNC(moduleCheckPBOs);
    scope = 2;
    isGlobal = 1;
    icon = QUOTE(PATHTOF(UI\Icon_Module_CheckPBO_ca.paa));
    class Arguments {
      class Action {
        displayName = "$STR_ACE_Common_CheckPBO_Action_DisplayName"; //Action
        description = "$STR_ACE_Common_CheckPBO_Action_Description"; //What to do with people who do not have the right PBOs?
        class values {
          class WarnOnce {
            default = 1;
            name = "$STR_ACE_Common_CheckPBO_Action_WarnOnce"; //Warn once
            value = 0;
          };
          class Warn {
            name = "$STR_ACE_Common_CheckPBO_Action_WarnPerm"; //Warn (permanent)
            value = 1;
          };
          class Kick {
            name = "$STR_ACE_Common_CheckPBO_Action_Kick"; //Kick
            value = 2;
          };
        };
      };
      class CheckAll {
        displayName = "$STR_ACE_Common_CheckPBO_CheckAll_DisplayName"; //Check all addons
        description = "$STR_ACE_Common_CheckPBO_CheckAll_Description"; //Check all addons instead of only those of ACE?
        typeName = "BOOL";
        class values {
          class WarnOnce {
            default = 1;
            name = "$STR_ACE_Common_CheckPBO_CheckAll_No"; //No
            value = 0;
          };
          class Warn {
            name = "$STR_ACE_Common_CheckPBO_CheckAll_Yes"; //Yes
            value = 1;
          };
        };
      };
      class Whitelist {
        displayName = "$STR_ACE_Common_CheckPBO_Whitelist_DisplayName"; //Whitelist
        description = "$STR_ACE_Common_CheckPBO_Whitelist_Description"; //What addons are allowed regardless?
        typeName = "STRING";
        class values {
            default = "[]";
        };
      };
    };
  };

  class ACE_ModuleLSDVehicles: Module_F {
    author = "$STR_ACE_Common_ACETeam";
    category = "ACE";
    displayName = "$STR_ACE_Common_LSDVehicles_DisplayName"; //LSD Vehicles
	description = "$STR_ACE_Common_LSDVehicles_Description";
    function = "ACE_Common_fnc_moduleLSDVehicles";
    scope = 2;
    icon = QUOTE(PATHTOF(UI\Icon_Module_LSD_ca.paa));
    isGlobal = 1;
    class Arguments {
    };
  };

  class Box_NATO_Support_F;
  class ACE_Box_Misc: Box_NATO_Support_F {
    author = "$STR_ACE_Common_ACETeam";
    displayName = "$STR_ACE_Common_MiscItems";
    transportMaxWeapons = 9001;
    transportMaxMagazines = 9001;
    transportMaxItems = 9001;
    maximumload = 9001;

    class TransportWeapons {};
    class TransportMagazines {};
    class TransportItems {};
    class TransportBackpacks {};
  };

    class Item_Base_F;
    class ACE_bananaItem: Item_Base_F {
        scope = 2;
        scopeCurator = 2;
        displayName = "$STR_ACE_Common_bananaDisplayName";
        author = "$STR_ACE_Common_ACETeam";
        vehicleClass = "Items";
        class TransportItems
        {
            class ACE_banana
            {
                name = "ACE_banana";
                count = 1;
            };
        };
    };
};
