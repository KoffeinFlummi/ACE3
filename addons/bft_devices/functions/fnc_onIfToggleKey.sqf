#include "script_component.hpp"
/*
 * Author: Gundy
 *
 * Description:
 *   Called whenever a interface toggle (open/close) key is pressed. Based on situation will open or close the interface for a BFT device
 *
 * Arguments:
 *   0: 0 = Primary, 1 = Secondary, 3 = Tertiary <INTEGER>
 *
 * Return Value:
 *   Handled <BOOL>
 *
 * Example:
 *   0 call ace_bft_devices_fnc_onIfToggleKey;
 *
 * Public: No
 */


params ["_type"];

private _handled = false;

// exit if we have already an interface starting up
if (GVAR(ifOpenStart)) exitWith {_handled};

private _previousInterface = "";

// if UAV gunner view is open, exit the view
if (GVAR(uavViewActive)) then {
    objNull remoteControl (gunner GVAR(actUav));
    vehicle ACE_player switchCamera 'internal';
    GVAR(uavViewActive) = false;
    true
};

// close interface and exit if there is an interface open of the same type
if (!I_CLOSED && {I_GET_TYPE == _type}) exitWith {
    [] call FUNC(ifClose);
    true
};

// close interface if there is one open
if !(I_CLOSED) then {
    _previousInterface = I_GET_NAME;
    [] call FUNC(ifClose);
    _handled = true;
};

// see if player is carrying any devices
private _playerDevices = [ACE_player] call EFUNC(bft,getOwnedDevices);

// get devices for the vehicle the player might be in
private _vehicleDevices = [vehicle ACE_player] call EFUNC(bft,getOwnedDevices);

// select a device --- the first one for now
private _playerDeviceId = ["", _playerDevices select 0] select !(_playerDevices isEqualTo []);
private _vehicleDeviceId = ["", _vehicleDevices select 0] select !(_vehicleDevices isEqualTo []);

// bail if we could not retrieve a device ID
if (_playerDeviceId == "" && _vehicleDeviceId == "") exitWith {_handled};

// get device data
private _playerDeviceData = [[], [_playerDeviceId] call EFUNC(bft,getDeviceData)] select (_playerDeviceId != "");
private _vehicleDeviceData = [[], [_vehicleDeviceId] call EFUNC(bft,getDeviceData)] select (_vehicleDeviceId != "");

// bail if we could not receive device data
if (_playerDeviceData isEqualTo [] && _vehicleDeviceData isEqualTo []) exitWith {_handled};

// get interface for device
private _playerDeviceInterface = if !(_playerDeviceData isEqualTo []) then {
    private _interfaces = [_playerDeviceId,ACE_player] call EFUNC(bft,getInterfaces);
    // select the first device -- for now
    if (count _interfaces > 0) then {_interfaces select 0} else {""};
} else {""};
private _vehicleDeviceInterface = if !(_vehicleDeviceData isEqualTo []) then {
    private _interfaces = [_vehicleDeviceId,ACE_player] call EFUNC(bft,getInterfaces);
    // select the first device -- for now
    if (count _interfaces > 0) then {_interfaces select 0} else {""};
} else {""};

// get uiNamespace variable names
private _playerDeviceDisplayName = if (_playerDeviceInterface != "") then {
    if (isText (configFile >> "ACE_BFT" >> "Interfaces" >> _playerDeviceInterface >> "displayName")) then {
        getText (configFile >> "ACE_BFT" >> "Interfaces" >> _playerDeviceInterface >> "displayName")
    } else {""};
} else {""};
private _playerDeviceDialogName = if (_playerDeviceInterface != "") then {
    if (isText (configFile >> "ACE_BFT" >> "Interfaces" >> _playerDeviceInterface >> "dialogName")) then {
        getText (configFile >> "ACE_BFT" >> "Interfaces" >> _playerDeviceInterface >> "dialogName")
    } else {""};
} else {""};
private _vehicleDeviceDisplayName = if (_vehicleDeviceInterface != "") then {
    if (isText (configFile >> "ACE_BFT" >> "Interfaces" >> _vehicleDeviceInterface >> "displayName")) then {
        getText (configFile >> "ACE_BFT" >> "Interfaces" >> _vehicleDeviceInterface >> "displayName")
    } else {""};
} else {""};
private _vehicleDeviceDialogName = if (_vehicleDeviceInterface != "") then {
    if (isText (configFile >> "ACE_BFT" >> "Interfaces" >> _vehicleDeviceInterface >> "dialogName")) then {
        getText (configFile >> "ACE_BFT" >> "Interfaces" >> _vehicleDeviceInterface >> "dialogName")
    } else {""};
} else {""};

// logic to determine which interface to open
private _selectedInterface = switch (_type) do {
    case 0: {
        // display first, vehicle device first
        if (_vehicleDeviceDisplayName != "") exitWith {[_vehicleDeviceInterface,_vehicleDeviceDisplayName,_vehicleDeviceId,false]};
        if (_playerDeviceDisplayName != "") exitWith {[_playerDeviceInterface,_playerDeviceDisplayName,_playerDeviceId,false]};
        if (_vehicleDeviceDialogName != "") exitWith {[_vehicleDeviceInterface,_vehicleDeviceDialogName,_vehicleDeviceId,true]};
        if (_playerDeviceDialogName != "") exitWith {[_playerDeviceInterface,_playerDeviceDialogName,_playerDeviceId,true]};
        ["","","",false]
    };
    case 1: {
        // dialog first, vehicle device first
        if (_vehicleDeviceDialogName != "") exitWith {[_vehicleDeviceInterface,_vehicleDeviceDialogName,_vehicleDeviceId,true]};
        if (_playerDeviceDialogName != "") exitWith {[_playerDeviceInterface,_playerDeviceDialogName,_playerDeviceId,true]};
        if (_vehicleDeviceDisplayName != "") exitWith {[_vehicleDeviceInterface,_vehicleDeviceDisplayName,_vehicleDeviceId,false]};
        if (_playerDeviceDisplayName != "") exitWith {[_playerDeviceInterface,_playerDeviceDisplayName,_playerDeviceId,false]};
        ["","","",false]
    };
    case 2: {
        // dialog first, player device first
        if (_playerDeviceDialogName != "") exitWith {[_playerDeviceInterface,_playerDeviceDialogName,_playerDeviceId,true]};
        if (_vehicleDeviceDialogName != "") exitWith {[_vehicleDeviceInterface,_vehicleDeviceDialogName,_vehicleDeviceId,true]};
        if (_playerDeviceDisplayName != "") exitWith {[_playerDeviceInterface,_playerDeviceDisplayName,_playerDeviceId,false]};
        if (_vehicleDeviceDisplayName != "") exitWith {[_vehicleDeviceInterface,_vehicleDeviceDisplayName,_vehicleDeviceId,false]};
        ["","","",false]
    };
    default {["","","",false]};
};

_selectedInterface params ["_interface", "_interfaceName", "_deviceID", "_isDialog"];

if (_interfaceName != "" && _interfaceName != _previousInterface) then {
    // queue the start up of the interface as we might still have one closing down
    [{
        if (I_CLOSED) then {
            params ["_args", "_idPFH"];
            [_idPFH] call CBA_fnc_removePerFrameHandler;
            (_args + [ACE_player, vehicle ACE_player]) call FUNC(ifOpen);
        };
    }, 0, [_deviceID,_interface,_type,_interfaceName,_isDialog]] call CBA_fnc_addPerFrameHandler;
};

true
