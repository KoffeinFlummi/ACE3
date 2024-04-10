#include "script_component.hpp"
/*
 * Author: KoffeinFlummi, esteldunedain, Ruthberg
 *
 * Watches for scope changes.
 * Defines key bindings
 *
 */

if (!hasInterface) exitWith {};

GVAR(Optics) = ["", "", ""];
GVAR(Guns) = ["", "", ""];
GVAR(canAdjustElevation) = [false, false, false];
GVAR(canAdjustWindage) = [false, false, false];
GVAR(scopeAdjust) = [[[0,0],0,[0,0],0], [[0,0],0,[0,0],0], [[0,0],0,[0,0],0]];

["CBA_settingsInitialized", {

    if (!GVAR(enabled)) exitWith {};

    if (GVAR(deduceBarometricPressureFromTerrainAltitude)) then {
        GVAR(zeroReferenceBarometricPressure) = 1013.25 * (1 - (0.0065 * EGVAR(common,mapAltitude)) / 288.15) ^ 5.255754495;
    };

    // Check inventory when it changes
    ["loadout", LINKFUNC(inventoryCheck), true] call CBA_fnc_addPlayerEventHandler;

    // Instantly hide knobs when scoping in
    ["cameraView", {
        params ["_player", "_newCameraView"];

        if (_newCameraView == "GUNNER") then {
            private _layer = [QGVAR(Zeroing)] call BIS_fnc_rscLayer;
            _layer cutText ["", "PLAIN", 0];

            if (!isNil QGVAR(fadePFH)) then {
                [GVAR(fadePFH)] call CBA_fnc_removePerFrameHandler;
                GVAR(fadePFH) = nil;
            };
        };
    }] call CBA_fnc_addPlayerEventHandler;

    // Add keybinds
    #include "initKeybinds.inc.sqf"

    // Register fire event handler
    ["ace_firedPlayer", LINKFUNC(firedEH)] call CBA_fnc_addEventHandler;
    ["ace_firedPlayerNonLocal", LINKFUNC(firedEH)] call CBA_fnc_addEventHandler;

}] call CBA_fnc_addEventHandler;
