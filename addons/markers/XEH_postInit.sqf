// by commy2
#include "script_component.hpp"

// recieve remote marker data
[QGVAR(setMarkerNetwork), {_this call DFUNC(setMarkerNetwork)}] call CBA_fnc_addEventHandler;

// recieve marker data for JIP
[QGVAR(setMarkerJIP), {_this call DFUNC(setMarkerJIP)}] call CBA_fnc_addEventHandler;

// request marker data for JIP
if (isMultiplayer && {!isServer} && {hasInterface}) then {
    GVAR(localLogic) = (createGroup sideLogic) createUnit ["Logic", [0,0,0], [], 0, "NONE"];
    [QGVAR(sendMarkersJIP), [GVAR(localLogic)]] call CBA_fnc_serverEvent;
};

GVAR(mapDisplaysWithDrawEHs) = [];
GVAR(currentMarkerPosition) = [];
GVAR(currentMarkerAngle) = 0;
GVAR(currentMarkerColorConfigName) = "";
GVAR(currentMarkerConfigName) = "";

// set marker pos local on every computer (prevent markers visible for everyone)
[QGVAR(applyMarkerPosLocal), {
    params["_marker", "_pos"];
    _marker setMarkerPosLocal _pos;
}] call CBA_fnc_addEventHandler;

["ace_settingsInitialized", {
    if (GVAR(movableMarkersEnabled)) then {
        addMissionEventHandler ["Map", {
            params ["_isOpen"];

            if (_isOpen) then {
                (findDisplay 12 displayCtrl 51) ctrlAddEventHandler ["MouseButtonDown", FUNC(onMouseButtonDownMap)];
                (findDisplay 12 displayCtrl 51) ctrlAddEventHandler ["MouseButtonUp", FUNC(onMouseButtonUpMap)];
            } else {
                ACE_player setVariable [QGVAR(moveInProgress), false];
            };
        }];
    };
}] call CBA_fnc_addEventHandler;
