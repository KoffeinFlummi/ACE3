#include "..\script_component.hpp"
#include "\a3\ui_f\hpp\defineResincl.inc"
/*
 * Author: commy2, johnb43, based on BIS_fnc_errorMsg and BIS_fnc_guiMessage by Karel Moricky (BI)
 * Opens a textbox with an error message, used for PBO checking.
 * CBA isn't guaranteed to be loaded, so use vanilla functionality only!
 *
 * Arguments:
 * 0: Header <STRING>
 * 1: Text <STRING, TEXT>
 * 2: Unique name of the error message function sent by the server <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * ["[ACE] ERROR", "Test"] call ace_common_fnc_checkErrorMessage
 *
 * Public: No
 */

disableSerialization;

// Force stop any loading screens
endLoadingScreen;

// No message without player possible
if (!hasInterface) exitWith {};

private _mainDisplay = call BIS_fnc_displayMission;

// Wait for display
if (isNull _mainDisplay) exitWith {
    _this spawn {
        params ["", "", "_fncNameCheckErrorMessage"];

        waitUntil {
            uiSleep 0.25;

            !isNull (call BIS_fnc_displayMission)
        };

        _this call (missionNamespace getVariable [_fncNameCheckErrorMessage, ""]);
    };
};

params ["_textHeader", "_textMessage"];

// Use curator display if present
private _curatorDisplay = findDisplay 312;

if (!isNull _curatorDisplay) then {
    _mainDisplay = _curatorDisplay;
};

if (_textMessage isEqualType "") then {
    _textMessage = parseText _textMessage;
};

private _display = _mainDisplay createDisplay "RscDisplayCommonMessagePause";

if (isNull _display) exitWith {};

private _ctrlRscMessageBox =          _display displayCtrl 2351;
private _ctrlBcgCommonTop =           _display displayCtrl 235100;
private _ctrlBcgCommon =              _display displayCtrl 235101;
private _ctrlText =                   _display displayCtrl 235102;
private _ctrlBackgroundButtonOK =     _display displayCtrl 235103;
private _ctrlBackgroundButtonMiddle = _display displayCtrl 235104;
private _ctrlBackgroundButtonCancel = _display displayCtrl 235105;
private _ctrlButtonOK =               _display displayCtrl 235106;
private _ctrlButtonCancel =           _display displayCtrl 235107;

_ctrlBcgCommonTop ctrlSetText _textHeader;

private _ctrlButtonOKPos = ctrlPosition _ctrlButtonOK;
private _ctrlBcgCommonPos = ctrlPosition _ctrlBcgCommon;
private _bottomSpaceY = (_ctrlButtonOKPos select 1) - ((_ctrlBcgCommonPos select 1) + (_ctrlBcgCommonPos select 3));

private _ctrlTextPos = ctrlPosition _ctrlText;
private _marginX = (_ctrlTextPos select 0) - (_ctrlBcgCommonPos select 0);
private _marginY = (_ctrlTextPos select 1) - (_ctrlBcgCommonPos select 1);

_ctrlText ctrlSetStructuredText _textMessage;
private _ctrlTextPosH = ctrlTextHeight _ctrlText;

_ctrlBcgCommon ctrlSetPosition [
    _ctrlBcgCommonPos select 0,
    _ctrlBcgCommonPos select 1,
    _ctrlBcgCommonPos select 2,
    _ctrlTextPosH + _marginY * 2
];
_ctrlBcgCommon ctrlCommit 0;

_ctrlText ctrlSetPosition [
    (_ctrlBcgCommonPos select 0) + _marginX,
    (_ctrlBcgCommonPos select 1) + _marginY,
    (_ctrlBcgCommonPos select 2) - _marginX * 2,
    _ctrlTextPosH
];
_ctrlText ctrlCommit 0;

private _bottomPosY = (_ctrlBcgCommonPos select 1) + _ctrlTextPosH + (_marginY * 2) + _bottomSpaceY;

{
    private _xPos = ctrlPosition _x;

    _xPos set [1, _bottomPosY];
    _x ctrlSetPosition _xPos;
    _x ctrlCommit 0;
} forEach [
    _ctrlBackgroundButtonOK,
    _ctrlBackgroundButtonMiddle,
    _ctrlBackgroundButtonCancel,
    _ctrlButtonOK,
    _ctrlButtonCancel
];

private _ctrlRscMessageBoxPos = ctrlPosition _ctrlRscMessageBox;
private _ctrlRscMessageBoxPosH = _bottomPosY + (_ctrlButtonOKPos select 3);

_ctrlRscMessageBox ctrlSetPosition [
    0.5 - (_ctrlBcgCommonPos select 2) / 2,
    0.5 - _ctrlRscMessageBoxPosH / 2,
    (_ctrlBcgCommonPos select 2) + 0.5,
    _ctrlRscMessageBoxPosH
];

_ctrlRscMessageBox ctrlEnable true;
_ctrlRscMessageBox ctrlCommit 0;

// Enable ok button
_ctrlButtonOK ctrlEnable true;
_ctrlButtonOK ctrlSetFade 0;
_ctrlButtonOK ctrlSetText localize "STR_DISP_OK";
_ctrlButtonOK ctrlCommit 0;

ctrlSetFocus _ctrlButtonOK;

// Disable cancel button
_ctrlButtonCancel ctrlEnable false;
_ctrlButtonCancel ctrlSetFade 0;
_ctrlButtonCancel ctrlSetText "";
_ctrlButtonCancel ctrlCommit 0;

_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", {(ctrlParent (_this select 0)) closeDisplay IDC_OK; true}];
_ctrlButtonCancel ctrlAddEventHandler ["ButtonClick", {(ctrlParent (_this select 0)) closeDisplay IDC_CANCEL; true}];

// Intercept all keystrokes except the esacpe key
_display displayAddEventHandler ["KeyDown", {_this select 1 == 1}];

// If BIS_fnc_guiMessage is called while the display is opened, the "Unload" display EH will be lost and won't fire
[_display] spawn {
    disableSerialization;

    params ["_display"];

    // Wait until the display has been closed
    waitUntil {
        uiSleep 0.25;

        !isNull _display;
    };

    // Just to be safe
    endLoadingScreen;

    // Close curator and mission displays
    findDisplay 312 closeDisplay 0;
    findDisplay 46 closeDisplay 0;
};

nil
