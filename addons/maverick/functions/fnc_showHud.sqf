/*
 * Author: xrufix (PabstMirror)
 * Shows the maverick hud when vehicle is equiped with the weapon.
 * Shows laser code, fire mode and seeker status.
 *
 * Arguments:
 * 0: Player <OBJECT>
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * [player] call ace_maverick_fnc_showHud
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_player"];
TRACE_1("showHud",_player);

private _enabled = false;
private _vehicle = vehicle _player;
private _turretPath = [-1];

if ((alive _player) && {_player != _vehicle}) then {
    if (_player != (driver _vehicle)) then {
        _turretPath = _player call CBA_fnc_turretPath
    };
    {
        if ((getNumber (configFile >> "CfgWeapons" >> _x >> QGVAR(enabled))) == 1) then {
            TRACE_1("enabled",_x);
            _enabled = true;
        };
    } forEach (_vehicle weaponsTurret _turretPath);
};

if ((!_enabled) && (GVAR(pfID) < 0)) exitWith {TRACE_2("Disabled - No Change",_enabled,GVAR(pfID));};

TRACE_2("Cleaning up old pfeh and display",_enabled,GVAR(pfID));
[GVAR(pfID)] call CBA_fnc_removePerFrameHandler;
if (!isNull (uiNamespace getVariable [QEGVAR(hellfire,display), displayNull])) then {
    ([QEGVAR(hellfire,modeDisplay)] call BIS_fnc_rscLayer) cutText ["", "PLAIN"];
};
GVAR(pfID) = -1;

if (!_enabled) exitWith {TRACE_2("Disabled - Now Off",_enabled,GVAR(pfID));};

TRACE_2("Enabled - Adding actions and PFEH",_enabled,GVAR(pfID));

private _adjustDown = false;
// Flares display will block ours, if present just move ours down a bit
{
    if ((getText (configFile >> "CfgWeapons" >> _x >> "simulation")) == "cmlauncher") exitWith {_adjustDown = true};
} forEach (_vehicle weaponsTurret _turretPath);

private _turretConfig = [_vehicle, _turretPath] call CBA_fnc_getTurret;
private _seekerSource = getText (_turretConfig >> "memoryPointGunnerOptics");
TRACE_3("",_adjustDown,_seekerSource,_vehicle selectionPosition _seekerSource);

GVAR(pfID) = [{
    params ["_args", "_pfID"];
    _args params ["_vehicle", "_turretPath", "_seekerSource", "_adjustDown"];

    // Restart display if null (not just at start, this will happen periodicly)
    if (isNull (uiNamespace getVariable [QEGVAR(hellfire,display), displayNull])) then {
        TRACE_1("creating display",_this);
        ([QEGVAR(hellfire,modeDisplay)] call BIS_fnc_rscLayer) cutRsc [QEGVAR(hellfire,modeDisplay), "PLAIN", 1, false];
        if (_adjustDown) then {
            private _ctrl = (uiNamespace getVariable [QEGVAR(hellfire,display), displayNull]) displayCtrl IDC_MODECONTROLGROUP;
            private _pos = ctrlPosition _ctrl;
            _pos set [1, (_pos select 1) + ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)];
            _ctrl ctrlSetPosition _pos;
            _ctrl ctrlCommit 0;
            TRACE_2("",_pos,_ctrl);
        };
    };

    private _currentWeapon = _vehicle currentWeaponTurret _turretPath;
    private _showLockMode = (getNumber (configFile >> "CfgWeapons" >> _currentWeapon >> QGVAR(enabled))) == 1;
    TRACE_2("",_currentWeapon,_showLockMode);

    private _ctrlGroup = (uiNamespace getVariable [QEGVAR(hellfire,display), displayNull]) displayCtrl 1000;

    if (!_showLockMode) exitWith {
        _ctrlGroup ctrlShow false;
    };
    TRACE_1("",_ctrlGroup);
    _ctrlGroup ctrlShow true;

    private _ctrlText = (uiNamespace getVariable [QEGVAR(hellfire,display), displayNull]) displayCtrl IDC_ATTACKMODE;
    private _ctrlCode = (uiNamespace getVariable [QEGVAR(hellfire,display), displayNull]) displayCtrl IDC_LASERCODE;
    private _ctrlIcon = (uiNamespace getVariable [QEGVAR(hellfire,display), displayNull]) displayCtrl IDC_LASERICON;
    TRACE_3("",_ctrlText,_ctrlCode,_ctrlIcon);

    // Do Laser Scan:
    private _laserSource = AGLtoASL (_vehicle modelToWorld (_vehicle selectionPosition _seekerSource));
    private _laserCode = _vehicle getVariable [QEGVAR(laser,code), ACE_DEFAULT_LASER_CODE];
    private _laserResult = [_laserSource, vectorDir _vehicle, 70, 5000, [ACE_DEFAULT_LASER_WAVELENGTH,ACE_DEFAULT_LASER_WAVELENGTH], _laserCode, _vehicle] call EFUNC(laser,seekerFindLaserSpot);
    TRACE_3("",_laserSource,_laserCode,_laserResult);
    private _foundTargetPos = _laserResult select 0;
    private _haveLock = !isNil "_foundTargetPos";
    TRACE_2("",_foundTargetPos,_haveLock);

    private _modeShort = "ERR";
    private _vehicleLockMode = _vehicle getVariable [QEGVAR(missileguidance,attackProfile), ""];
    TRACE_1("before switch",_vehicleLockMode);

    switch (_vehicleLockMode) do { // note: missileguidance is case sensitive
        // keep switch although unused in case of future use.
        default {
            _vehicleLockMode = "maverick";
            _modeShort = if (_haveLock) then {
                getText (configFile >> QEGVAR(missileguidance,AttackProfiles) >> _vehicleLockMode >> "nameLocked");
            } else {
                getText (configFile >> QEGVAR(missileguidance,AttackProfiles) >> _vehicleLockMode >> "name");
            };
        };
    };

    _ctrlIcon ctrlSetTextColor ([[0,0,0,0.25],[1,0,0,0.75]] select _haveLock);
    _ctrlText ctrlSetText _modeShort;
    _ctrlCode ctrlSetText format ["CODE: %1", _laserCode];

}, 0.1, [_vehicle, _turretPath, _seekerSource, _adjustDown]] call CBA_fnc_addPerFrameHandler;
