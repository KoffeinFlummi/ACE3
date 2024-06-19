// by commy2
#include "script_component.hpp"

if (!hasInterface) exitWith {};

GVAR(holdKeyHandler) = -1;
GVAR(isShowGameTime) = false;
GVAR(isKeyDownAzimuth) = false;
GVAR(isKeyDownDistance) = false;
GVAR(isKeyDownDistance2) = false;
GVAR(keyDownTimeAzimuth) = -1;
GVAR(keyDownTimeDistance) = -1;
GVAR(keyDownTimeDistance2) = -1;
GVAR(useMil) = false;
GVAR(useFeet) = false;
GVAR(modeReticle) = 0;
GVAR(illuminate) = false;

#include "initKeybinds.inc.sqf"
