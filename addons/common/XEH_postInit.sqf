// ACE - Common
#include "script_component.hpp"

// Load settings from profile
if (hasInterface) then {
    call FUNC(loadSettingsFromProfile);
};

// Listens for global "SettingChanged" events, to update the force status locally
["SettingChanged", {

    PARAMS_2(_name,_value);
    if !(count _this > 2) exitWith {};

    _force = _this select 2;
    if (_force) then {
        _settingData = [_name] call FUNC(getSettingData);
        if (count _settingData == 0) exitWith {};
        _settingData set [6,_force];
    };
}] call FUNC(addEventhandler);

// hack to get PFH to work in briefing
[QGVAR(onBriefingPFH), "onEachFrame", {
    if (time > 0) exitWith {
        [QGVAR(onBriefingPFH), "onEachFrame"] call BIS_fnc_removeStackedEventHandler;
    };

    call cba_common_fnc_onFrame;
}] call BIS_fnc_addStackedEventHandler;
/////

QGVAR(remoteFnc) addPublicVariableEventHandler {
    (_this select 1) call FUNC(execRemoteFnc);
};

[missionNamespace] call FUNC(executePersistent);

// check previous version number from profile
_currentVersion = getText (configFile >> "CfgPatches" >> QUOTE(ADDON) >> "version");
_previousVersion = profileNamespace getVariable ["ACE_VersionNumberString", ""];

if (_currentVersion != _previousVersion) then {
    // do something

    profileNamespace setVariable ["ACE_VersionNumberString", _currentVersion];
};

0 spawn COMPILE_FILE(scripts\Version\checkVersionNumber);

"ACEg" addPublicVariableEventHandler { _this call FUNC(_handleNetEvent); };
"ACEc" addPublicVariableEventHandler { _this call FUNC(_handleNetEvent); };

// everything that only player controlled machines need, goes below this
if (!hasInterface) exitWith {};

call COMPILE_FILE(scripts\assignedItemFix);

call COMPILE_FILE(scripts\initCanInteractFunction);
call COMPILE_FILE(scripts\initScrollWheel);

0 spawn {
    while {true} do {
        waitUntil {!isNull (findDisplay 46)}; sleep 0.1;
        findDisplay 46 displayAddEventHandler ["MouseZChanged", QUOTE( _this call GVAR(onScrollWheel) )];
        [false] call FUNC(disableUserInput);
        waitUntil {isNull (findDisplay 46)};
    };
};
enableCamShake true;

// Set the name for the current player
["playerChanged", {
    EXPLODE_2_PVT(_this,_newPlayer,_oldPlayer);

    if (alive _newPlayer) then {
        [_newPlayer] call FUNC(setName)
    };
    if (alive _oldPlayer) then {
        [_oldPlayer] call FUNC(setName)
    };

}] call FUNC(addEventhandler);

GVAR(OldPlayerInventory) = objNull;
if !(isNull ACE_player) then {
    GVAR(OldPlayerInventory) = [ACE_player] call FUNC(getAllGear);
};
GVAR(OldPlayerVisionMode) = currentVisionMode ACE_player;
GVAR(OldZeusDisplayIsOpen) = !(isNull findDisplay 312);
GVAR(OldCameraView) = cameraView;
GVAR(OldPlayerVehicle) = vehicle ACE_player;
GVAR(OldPlayerTurret) = [ACE_player] call FUNC(getTurretIndex);

// PFH to raise varios events
[{

    // "playerInventoryChanged" event
    _newPlayerInventory = objNull;
    if !(isNull ACE_player) then {
        _newPlayerInventory = [ACE_player] call FUNC(getAllGear);

        if !(_newPlayerInventory isEqualTo GVAR(OldPlayerInventory)) then {
        // Raise ACE event locally
        ["playerInventoryChanged", [ACE_player, _newPlayerInventory]] call FUNC(localEvent);
    };
    GVAR(OldPlayerInventory) = _newPlayerInventory;

    // "playerVisionModeChanged" event
    _newPlayerVisionMode = currentVisionMode ACE_player;
    if !(_newPlayerVisionMode isEqualTo GVAR(OldPlayerVisionMode)) then {
        // Raise ACE event locally
        GVAR(OldPlayerVisionMode) = _newPlayerVisionMode;
        ["playerVisionModeChanged", [ACE_player, _newPlayerVisionMode]] call FUNC(localEvent);
    };

    // "inventoryDisplayChanged" event
    _newInventoryDisplayIsOpen = !(isNull findDisplay 602);
    if !(_newInventoryDisplayIsOpen isEqualTo GVAR(OldInventoryDisplayIsOpen)) then {
        // Raise ACE event locally
        GVAR(OldInventoryDisplayIsOpen) = _newInventoryDisplayIsOpen;
        ["inventoryDisplayChanged", [ACE_player, _newInventoryDisplayIsOpen]] call FUNC(localEvent);
    };

    // "zeusDisplayChanged" event
    _newZeusDisplayIsOpen = !(isNull findDisplay 312);
    if !(_newZeusDisplayIsOpen isEqualTo GVAR(OldZeusDisplayIsOpen)) then {
        // Raise ACE event locally
        GVAR(OldZeusDisplayIsOpen) = _newZeusDisplayIsOpen;
        ["zeusDisplayChanged", [ACE_player, _newZeusDisplayIsOpen]] call FUNC(localEvent);
    };

    // "cameraViewChanged" event
    _newCameraView = cameraView;
    if !(_newCameraView isEqualTo GVAR(OldCameraView)) then {
        // Raise ACE event locally
        GVAR(OldCameraView) = _newCameraView;
        ["cameraViewChanged", [ACE_player, _newCameraView]] call FUNC(localEvent);
    };

    // "playerVehicleChanged" event
    _newPlayerVehicle = vehicle ACE_player;
    if !(_newPlayerVehicle isEqualTo GVAR(OldPlayerVehicle)) then {
        // Raise ACE event locally
        GVAR(OldPlayerVehicle) = _newPlayerVehicle;
        ["playerVehicleChanged", [ACE_player, _newPlayerVehicle]] call FUNC(localEvent);
    };

    // "playerTurretChanged" event
    [ACE_player] call FUNC(getTurretIndex);
    if !(_newPlayerTurret isEqualTo GVAR(OldPlayerTurret)) then {
        // Raise ACE event locally
        GVAR(OldPlayerTurret) = _newPlayerTurret;
        ["playerTurretChanged", [ACE_player, _newPlayerTurret]] call FUNC(localEvent);
    };

}, 0, []] call cba_fnc_addPerFrameHandler;

[QGVAR(StateArrested),false,true,QUOTE(ADDON)] call FUNC(defineVariable);
[QGVAR(carriedBy),objNull,false,QUOTE(ADDON)] call FUNC(defineVariable);
[QGVAR(carriedObj),objNull,false,QUOTE(ADDON)] call FUNC(defineVariable);

["VehicleSetFuel", {
PARAMS_2(_vehicle,_fuelLevel);
_vehicle setFuel _fuelLevel;
}] call FUNC(addEventhandler);
