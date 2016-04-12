#include "script_component.hpp"

if (!hasInterface) exitWith {};

GVAR(ladder) = objNull;
GVAR(cancelTime) = 0;
GVAR(currentStep) = 3;
GVAR(currentAngle) = 0;

/*["interactMenuOpened", {
    if ((ACE_time > GVAR(cancelTime)) && !isNull GVAR(ladder)) then {
        GVAR(ladder) call FUNC(cancelTLdeploy);
    };
}] call CFUNC(addEventHandler);*/

// Cancel adjustment if interact menu opens
["interactMenuOpened", {[ACE_player] call FUNC(handleInteractMenuOpened)}] call CFUNC(addEventHandler);

// Cancel adjusting on player change.
["playerChanged", {_this call FUNC(handlePlayerChanged)}] call CFUNC(addEventhandler);
["playerVehicleChanged", {[ACE_player, objNull] call FUNC(handlePlayerChanged)}] call CFUNC(addEventhandler);

// handle falling unconscious
["medical_onUnconscious", {_this call FUNC(handleUnconscious)}] call CFUNC(addEventhandler);

// @todo captivity?
