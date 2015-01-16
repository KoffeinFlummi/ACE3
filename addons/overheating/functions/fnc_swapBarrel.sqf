/*
 * Author: Commy2
 *
 * Make a unit start swapping it's barrel
 *
 * Argument:
 * 0: unit
 * 1: weapon
 *
 * Return value:
 * None
 */
#include "\z\ace\addons\overheating\script_component.hpp"

EXPLODE_2_PVT(_this,_player,_weapon);

if (stance _player != "PRONE") then {
  [_player, "amovpknlmstpsraswrfldnon", 1] call EFUNC(common,doAnimation);
};
_player playActionNow "GestureDismountMuzzle";
_player playAction "GestureMountMuzzle";
playSound "ACE_BarrelSwap";

[10, [_player, _weapon], QFUNC(swapBarrelCallback), localize "STR_ACE_Overheating_SwappingBarrel"] call EFUNC(common,progressBar);
