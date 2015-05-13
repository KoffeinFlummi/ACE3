// by commy2
#include "script_component.hpp"

private ["_magazine"];

PARAMS_2(_unit,_weapon);
_magazine = _this select 5;

if (_weapon != "Throw") exitWith {};

private "_count";
_count = {_x == _magazine} count magazines _unit;

[_magazine, _count] call FUNC(displayGrenadeTypeAndNumber);

if (_count == 0) then {
    if (GVAR(CurrentGrenadeMuzzleIsFrag)) then {GVAR(CurrentGrenadeMuzzleFrag) = ""} else {GVAR(CurrentGrenadeMuzzleOther) = ""};
};
