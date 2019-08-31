#include "script_component.hpp"

if (isServer) then {
    // Cancel dig on hard disconnection. Function is identical to killed
    addMissionEventHandler ["HandleDisconnect", {_this call FUNC(handleKilled)}];

    [QGVAR(addDigger), {_this call FUNC(handleDiggingServer)}] call CBA_fnc_addEventHandler;
    [QGVAR(handleDiggingServer), {_this call FUNC(addDiggerToGVAR)}] call CBA_fnc_addEventHandler;
};

if (!hasInterface) exitWith {};

GVAR(trench) = objNull;
GVAR(digPFH) = -1;
GVAR(digDirection) = 0;

// Cancel dig sandbag if interact menu opened
["ace_interactMenuOpened", {[ACE_player] call FUNC(handleInteractMenuOpened)}] call CBA_fnc_addEventHandler;

// Cancel dig on player change. This does work when returning to lobby, but not when hard disconnecting.
["unit", FUNC(handlePlayerChanged)] call CBA_fnc_addPlayerEventHandler;
["loadout", FUNC(handlePlayerInventoryChanged)] call CBA_fnc_addPlayerEventHandler;
["vehicle", {[ACE_player, objNull] call FUNC(handlePlayerChanged)}] call CBA_fnc_addPlayerEventHandler;

// handle waking up dragged unit and falling unconscious while dragging
["ace_unconscious", {_this call FUNC(handleUnconscious)}] call CBA_fnc_addEventHandler;

if (GVAR(enableAutomaticFilePath)) exitWith {[] call FUNC(automaticFilePath);};

//@todo Captivity?
