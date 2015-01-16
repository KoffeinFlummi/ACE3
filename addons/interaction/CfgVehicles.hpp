#define MACRO_ADDITEM(ITEM,COUNT) class _xx_##ITEM { \
  name = #ITEM; \
  count = COUNT; \
};

class CfgVehicles {

  class Module_F;
  class ACE_ModuleInteraction: Module_F {
    author = "$STR_ACE_Common_ACETeam";
    category = "ACE";
    displayName = "Interaction System";
    function = "ACE_Interaction_fnc_moduleInteraction";
    scope = 2;
    isGlobal = 1;
    icon = PATHTOF(UI\IconInteraction_ca.paa);
    class Arguments {
      class EnableTeamManagement {
        displayName = "Enable Team Management";
        description = "Should players be allowed to use the Team Management Menu? Default: Yes";
        typeName = "BOOL";
        class values {
          class Yes { default = 1; name = "Yes"; value = 1;};
          class No { name = "No"; value = 0; };
        };
      };
    };
  };

  class Man;
  class CAManBase: Man {
    class ACE_Actions {
      class ACE_TeamManagement {
        displayName = "$STR_ACE_Interaction_TeamManagement";
        distance = 4;
        condition = QUOTE(alive _target && {!isPlayer _target} && {_target in units group _player} && {GVAR(EnableTeamManagement)});
        statement = "";
        showDisabled = 0;
        priority = 3.2;
        icon = PATHTOF(UI\team\team_management_ca.paa);
        subMenu[] = {"ACE_TeamManagement", 0};
        hotkey = "M";
        enableInside = 1;

        class ACE_JoinTeamRed {
          displayName = "$STR_ACE_Interaction_JoinTeamRed";
          distance = 4;
          condition = QUOTE(alive _target && {!isPlayer _target} && {_target in units group _player});
          statement = QUOTE([ARR_2(_target,'RED')] call DFUNC(joinTeam));
          showDisabled = 1;
          icon = PATHTOF(UI\team\team_red_ca.paa);
          priority = 2.4;
          hotkey = "R";
          enableInside = 1;
        };
        class ACE_JoinTeamGreen {
          displayName = "$STR_ACE_Interaction_JoinTeamGreen";
          distance = 4;
          condition = QUOTE(alive _target && {!isPlayer _target} && {_target in units group _player});
          statement = QUOTE([ARR_2(_target,'GREEN')] call DFUNC(joinTeam));
          showDisabled = 1;
          icon = PATHTOF(UI\team\team_green_ca.paa);
          priority = 2.3;
          hotkey = "G";
          enableInside = 1;
        };
        class ACE_JoinTeamBlue {
          displayName = "$STR_ACE_Interaction_JoinTeamBlue";
          distance = 4;
          condition = QUOTE(alive _target && {!isPlayer _target} && {_target in units group _player});
          statement = QUOTE([ARR_2(_target,'BLUE')] call DFUNC(joinTeam));
          showDisabled = 1;
          icon = PATHTOF(UI\team\team_blue_ca.paa);
          priority = 2.2;
          hotkey = "B";
          enableInside = 1;
        };
        class ACE_JoinTeamYellow {
          displayName = "$STR_ACE_Interaction_JoinTeamYellow";
          distance = 4;
          condition = QUOTE(alive _target && {!isPlayer _target} && {_target in units group _player});
          statement = QUOTE([ARR_2(_target,'YELLOW')] call DFUNC(joinTeam));
          showDisabled = 1;
          icon = PATHTOF(UI\team\team_yellow_ca.paa);
          priority = 2.1;
          hotkey = "Y";
          enableInside = 1;
        };

        class ACE_LeaveTeam {
          displayName = "$STR_ACE_Interaction_LeaveTeam";
          distance = 4;
          condition = QUOTE(alive _target && {!isPlayer _target} && {_target in units group _player} && {assignedTeam _player != 'MAIN'});
          statement = QUOTE([ARR_2(_target,'MAIN')] call DFUNC(joinTeam));
          showDisabled = 1;
          icon = PATHTOF(UI\team\team_white_ca.paa);
          priority = 2.5;
          hotkey = "N";
          enableInside = 1;
        };
      };

      class ACE_TapShoulder {
        displayName = "$STR_ACE_Interaction_TapShoulder";
        distance = 4;
        condition = QUOTE([ARR_2(_player, _target)] call DFUNC(canTapShoulder));
        statement = QUOTE([ARR_2(_player, _target)] call DFUNC(tapShoulder));
        showDisabled = 1;
        priority = 2.8;
        hotkey = "Q";
        enableInside = 1;
      };
      class ACE_JoinGroup {
        displayName = "$STR_ACE_Interaction_JoinGroup";
        distance = 4;
        condition = QUOTE(side group _player == side group _target && {group _player != group _target});
        statement = QUOTE([_player] joinSilent group _target;);
        showDisabled = 0;
        priority = 2.6;
        icon = PATHTOF(UI\team\team_management_ca.paa);
        hotkey = "J";
        enableInside = 1;
      };

      class ACE_GetDown {
        displayName = "$STR_ACE_Interaction_GetDown";
        distance = 4;
        condition = QUOTE([_target] call DFUNC(canInteractWith));
        statement = QUOTE([_target] call DFUNC(getDown));
        showDisabled = 0;
        priority = 2.2;
      };
      class ACE_SendAway {
        displayName = "$STR_ACE_Interaction_SendAway";
        distance = 4;
        condition = QUOTE([_target] call DFUNC(canInteractWith));
        statement = QUOTE([_target] call DFUNC(sendAway));
        showDisabled = 0;
        priority = 2.0;
      };
      class ACE_Pardon {
        displayName = "$STR_ACE_Interaction_Pardon";
        distance = 4;
        condition = QUOTE(rating _target < -2000 && {alive _target} && {side group _player == side group _target});
        statement = QUOTE([ARR_3(_target,'{_this addRating -rating _this}',_target)] call DEFUNC(common,execRemoteFnc));
        showDisabled = 0;
        priority = 2.5;
        enableInside = 1;
      };
    };

    class ACE_SelfActions {
      class ACE_TeamManagement {
        displayName = "$STR_ACE_Interaction_TeamManagement";
        condition = QUOTE(GVAR(EnableTeamManagement));
        statement = "";
        showDisabled = 1;
        priority = 3.2;
        icon = PATHTOF(UI\team\team_management_ca.paa);
        subMenu[] = {"ACE_TeamManagement", 1};
        enableInside = 1;
        hotkey = "M";

        class ACE_JoinTeamRed {
          displayName = "$STR_ACE_Interaction_JoinTeamRed";
          condition = QUOTE(true);
          statement = QUOTE([ARR_2(_player,'RED')] call DFUNC(joinTeam));
          showDisabled = 1;
          priority = 2.4;
          icon = PATHTOF(UI\team\team_red_ca.paa);
          enableInside = 1;
          hotkey = "R";
        };
        class ACE_JoinTeamGreen {
          displayName = "$STR_ACE_Interaction_JoinTeamGreen";
          condition = QUOTE(true);
          statement = QUOTE([ARR_2(_player,'GREEN')] call DFUNC(joinTeam));
          showDisabled = 1;
          priority = 2.3;
          icon = PATHTOF(UI\team\team_green_ca.paa);
          enableInside = 1;
          hotkey = "G";
        };
        class ACE_JoinTeamBlue {
          displayName = "$STR_ACE_Interaction_JoinTeamBlue";
          condition = QUOTE(true);
          statement = QUOTE([ARR_2(_player,'BLUE')] call FUNC(joinTeam));
          showDisabled = 1;
          priority = 2.2;
          icon = PATHTOF(UI\team\team_blue_ca.paa);
          enableInside = 1;
          hotkey = "B";
        };
        class ACE_JoinTeamYellow {
          displayName = "$STR_ACE_Interaction_JoinTeamYellow";
          condition = QUOTE(true);
          statement = QUOTE([ARR_2(_player,'YELLOW')] call FUNC(joinTeam));
          showDisabled = 1;
          priority = 2.1;
          icon = PATHTOF(UI\team\team_yellow_ca.paa);
          enableInside = 1;
          hotkey = "Y";
        };

        class ACE_LeaveTeam {
          displayName = "$STR_ACE_Interaction_LeaveTeam";
          condition = QUOTE(assignedTeam _player != 'MAIN');
          statement = QUOTE([ARR_2(_player,'MAIN')] call FUNC(joinTeam));
          showDisabled = 1;
          priority = 2.5;
          icon = PATHTOF(UI\team\team_white_ca.paa);
          enableInside = 1;
          hotkey = "N";
        };

        class ACE_BecomeLeader {
          displayName = "$STR_ACE_Interaction_BecomeLeader";
          condition = QUOTE(count (units group _player) > 1 && {leader group _player != _player});
          statement = QUOTE(_newGroup = createGroup side group _player; (units group _player) joinSilent _newGroup; _newGroup selectLeader _player;);
          showDisabled = 1;
          priority = 1.0;
          icon = PATHTOF(UI\team\team_white_ca.paa);
          enableInside = 1;
          hotkey = "L";
        };
        class ACE_LeaveGroup {
          displayName = "$STR_ACE_Interaction_LeaveGroup";
          condition = QUOTE(count (units group _player) > 1);
          statement = QUOTE(_oldGroup = units group _player; _newGroup = createGroup side _player; [_player] joinSilent _newGroup; {_player reveal _x} forEach _oldGroup;);
          showDisabled = 1;
          priority = 1.2;
          icon = PATHTOF(UI\team\team_management_ca.paa);
          enableInside = 1;
          hotkey = "M";
        };
      };

      /* DANCE ANIMATION DOESN'T WORK :(
      class ACE_Dance {
        displayName = "$STR_ACE_Interaction_Dance";
        condition = "isClass (configFile >> 'CfgPatches' >> 'ACE_Movement') and !ACE_Dancing";
        statement = "ACE_Dancing = true; [-2, {_this switchMove 'TestDance';}, player] call CBA_fnc_globalExecute;";
        showDisabled = 0;
        priority = -1.2;
      };
      class ACE_StopDancing {
        displayName = "$STR_ACE_Interaction_StopDancing";
        condition = "ACE_Dancing";
        statement = "ACE_Dancing = false; [-2, {_this switchMove '';}, player] call CBA_fnc_globalExecute;";
        showDisabled = 0;
        priority = -1.2;
      };
      */

      class ACE_Gestures {
        displayName = "$STR_ACE_Interaction_Gestures";
        condition = "canStand _target";
        statement = "";
        showDisabled = 1;
        priority = 3.5;
        subMenu[] = {"ACE_Gestures", 1};
        icon = PATHTOF(UI\gestures_ca.paa);
        hotkey = "G";

        /*class ACE_Gesture_Advance {
          displayName = "$STR_ACE_Interaction_Gestures_Attack";
          condition = "canStand _target";
          statement = "_target playActionNow 'gestureAttack';";
          showDisabled = 1;
          priority = 2.0;
        };*/
        class ACE_Gesture_Advance {
          displayName = "$STR_ACE_Interaction_Gestures_Advance";
          condition = QUOTE(canStand _target);
          statement = QUOTE(_target playActionNow 'gestureAdvance';);
          showDisabled = 1;
          priority = 1.9;
          hotkey = "1";
        };
        class ACE_Gesture_Go {
          displayName = "$STR_ACE_Interaction_Gestures_Go";
          condition = QUOTE(canStand _target);
          statement = QUOTE(_target playActionNow ([ARR_2('gestureGo','gestureGoB')] select floor random 2););
          showDisabled = 1;
          priority = 1.8;
          hotkey = "2";
        };
        class ACE_Gesture_Follow {
          displayName = "$STR_ACE_Interaction_Gestures_Follow";
          condition = QUOTE(canStand _target);
          statement = QUOTE(_target playActionNow 'gestureFollow';);
          showDisabled = 1;
          priority = 1.7;
          hotkey = "3";
        };
        /*class ACE_Gesture_Point {
          displayName = "$STR_ACE_Interaction_Gestures_Point";
          condition = QUOTE(canStand _target);
          statement = QUOTE(_target playActionNow 'gesturePoint';);
          showDisabled = 1;
          priority = 1.6;
        };*/
        class ACE_Gesture_Up {
          displayName = "$STR_ACE_Interaction_Gestures_Up";
          condition = QUOTE(canStand _target);
          statement = QUOTE(_target playActionNow 'gestureUp';);
          showDisabled = 1;
          priority = 1.5;
          hotkey = "4";
        };
        class ACE_Gesture_Cover {
          displayName = "$STR_ACE_Interaction_Gestures_Cover";
          condition = QUOTE(canStand _target);
          statement = QUOTE(_target playActionNow 'gestureCover';);
          showDisabled = 1;
          priority = 1.4;
          hotkey = "5";
        };
        class ACE_Gesture_CeaseFire {
          displayName = "$STR_ACE_Interaction_Gestures_Cease_Fire";
          condition = QUOTE(canStand _target);
          statement = QUOTE(_target playActionNow 'gestureCeaseFire';);
          showDisabled = 1;
          priority = 1.3;
          hotkey = "6";
        };
        class ACE_Gesture_Freeze {
          displayName = "$STR_ACE_Interaction_Gestures_Freeze";
          condition = QUOTE(canStand _target);
          statement = QUOTE(_target playActionNow 'gestureFreeze';);
          showDisabled = 1;
          priority = 1.2;
          hotkey = "7";
        };
        class ACE_Gesture_Yes {
          displayName = "$STR_ACE_Interaction_Gestures_Yes";
          condition = QUOTE(canStand _target);
          statement = QUOTE(_target playActionNow ([ARR_2('gestureYes','gestureNod')] select floor random 2););
          showDisabled = 1;
          priority = 1.1;
          hotkey = "8";
        };
        class ACE_Gesture_No {
          displayName = "$STR_ACE_Interaction_Gestures_No";
          condition = QUOTE(canStand _target);
          statement = QUOTE(_target playActionNow 'gestureNo';);
          showDisabled = 1;
          priority = 1.0;
          hotkey = "9";
        };
        class ACE_Gesture_Hi {
          displayName = "$STR_ACE_Interaction_Gestures_Hi";
          condition = QUOTE(canStand _target);
          statement = QUOTE(_target playActionNow ([ARR_3('gestureHi','gestureHiB','gestureHiC')] select floor random 3););
          showDisabled = 1;
          priority = 0.9;
          hotkey = "0";
        };
      };

      class ACE_Equipment {
        displayName = "$STR_ACE_Interaction_Equipment";
        condition = QUOTE(true);
        statement = "";
        showDisabled = 1;
        priority = 4.5;
        icon = "";  // @todo
        subMenu[] = {"ACE_Equipment", 1};
        enableInside = 1;
        hotkey = "E";

        class ACE_Dummy {
          displayName = "";
          condition = QUOTE(false);
          statement = "";
          showDisabled = 1;
          priority = -99;
          icon = PATHTOEF(common,UI\blank_CO.paa);
          enableInside = 1;
        };
      };
    };
  };

  class LandVehicle;
  class Car: LandVehicle {
    class ACE_Actions {};
    class ACE_SelfActions {};
  };
  class Tank: LandVehicle {
    class ACE_Actions {};
    class ACE_SelfActions {};
  };

  class Air;
  class Helicopter: Air {
    class ACE_Actions {};
    class ACE_SelfActions {};
  };
  class Plane: Air {
    class ACE_Actions {};
    class ACE_SelfActions {};
  };

  class Ship;
  class Ship_F: Ship {
    class ACE_Actions {
      class ACE_Push {
        displayName = "$STR_ACE_Interaction_Push";
        distance = 4;
        condition = QUOTE(getMass _target < 1000 && {alive _target});
        statement = QUOTE([ARR_2(_target, [ARR_3(2 * (vectorDir _player select 0), 2 * (vectorDir _player select 1), 0.5)])] call FUNC(push););
        showDisabled = 0;
        priority = -1;
      };
    };
    class ACE_SelfActions {};
  };

  class StaticWeapon: LandVehicle {
    class ACE_Actions {};
    class ACE_SelfActions {};
  };

  class StaticMortar;
  class Mortar_01_base_F: StaticMortar {
    class ACE_Actions {};
    class ACE_SelfActions {};
  };

};