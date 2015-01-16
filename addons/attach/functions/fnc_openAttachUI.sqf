#include "script_component.hpp"

/*
  Author: Garth de Wet (LH)

  Description:
    Opens the UI for attaching objects.

  Parameters:
    0: OBJECT - unit

  Returns:
    Nothing

  Example:
    [player] call ACE_Attach_fnc_openAttachUI;
*/
private ["_unit", "_actions", "_attachables", "_item"];
_unit = _this select 0;
_listed = [];
_attachables = magazines _unit;
_actions = [localize "STR_ACE_Attach_AttachDetach", localize "STR_ACE_Attach_Attach"] call EFUNC(interaction,prepareSelectMenu);
{
  if !(_x in _listed) then {
    _item = ConfigFile >> "CfgMagazines" >> _x;
    if (getNumber (_item >> "ACE_Attachable") == 1) then {
      _actions = [
        _actions,
        getText(_item >> "displayName"),
        getText(_item >> "picture"),
        _x
      ] call EFUNC(interaction,addSelectableItem);
    };
    _listed pushBack _x;
  };
} forEach _attachables;
_attachables = items _unit;
{
  if !(_x in _listed) then {
    _item = ConfigFile >> "CfgWeapons" >> _x;
    if (getNumber (_item >> "ACE_Attachable") == 1) then {
      _actions = [
        _actions,
        getText(_item >> "displayName"),
        getText(_item >> "picture"),
        _x
      ] call EFUNC(interaction,addSelectableItem);
    };
    _listed pushBack _x;
  };
} forEach _attachables;

[
  _actions,
  {
    [ACE_player, _this] call FUNC(attach);
    call EFUNC(interaction,hideMenu);
  },
  {
    call EFUNC(interaction,hideMenu);
    if !(profileNamespace getVariable [QEGVAR(interaction,AutoCloseMenu), false]) then {"Default" call EFUNC(interaction,openMenuSelf)};
  }
] call EFUNC(interaction,openSelectMenu);
