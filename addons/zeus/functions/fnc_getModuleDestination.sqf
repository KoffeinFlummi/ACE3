/*
 * Author: PabstMirror
 * Allows zeus to click to indicate a 3d position.
 *
 * Arguments:
 * 0: The souce object <OBJECT>
 * 1: Code to run when position is ready <CODE>
 * - Code is passed [0: Successful <BOOL>, 1: Object <OBJECT>, 2: Position ASL <ARRAY>]
 * 2: Text <STRING><OPTIONAL>
 * 3: Icon image file <STRING><OPTIONAL>
 * 4: Icon color <ARRAY><OPTIONAL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, {systemChat format ["Done %1", _this]}] call ace_zeus_fnc_getModuleDestination
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_object", "_code", ["_text", ""], ["_icon", "\a3\ui_f\data\IGUI\Cfg\Cursors\select_target_ca.paa"], ["_color", [1,0,0,1]]];

if (missionNamespace getVariable [QGVAR(moduleDestination_running), false]) exitWith {
    [false, _object, [0,0,0]] call _code;
    ERROR("getModuleDestination already running");
};

GVAR(moduleDestination_running) = true;

// Add mouse button eh for the zeus display (triggered from 2d or 3d)
GVAR(moduleDestination_displayEHMouse) = [(findDisplay 312), "mouseButtonDown", {
    params ["", "_mouseButton"];
    if (_mouseButton != 0) exitWith {}; // Only watch for LMB
    _thisArgs params ["_object", "_code"];
    private _mousePosASL = if (ctrlShown ((findDisplay 312) displayCtrl 50)) then {
        private _pos2d = (((findDisplay 312) displayCtrl 50) ctrlMapScreenToWorld getMousePosition);
        _pos2d set [2, getTerrainHeightASL _pos2d];
        _pos2d
    } else {
        AGLToASL (screenToWorld getMousePosition);
    };
    TRACE_2("placed",_object,_mousePosASL);
    [true, _object, _mousePosASL] call _code;
    GVAR(moduleDestination_running) = false;
}, [_object, _code]] call CBA_fnc_addBISEventHandler;

// Add key eh for the zeus display (triggered from 2d or 3d)
GVAR(moduleDestination_displayEHKeyboard) = [(findDisplay 312), "KeyDown", {
    params ["", "_keyCode"];
    if (_keyCode != 1) exitWith {}; // Only watch for ESC
    _thisArgs params ["_object", "_code"];
    private _mousePosASL = if (ctrlShown ((findDisplay 312) displayCtrl 50)) then {
        private _pos2d = (((findDisplay 312) displayCtrl 50) ctrlMapScreenToWorld getMousePosition);
        _pos2d set [2, getTerrainHeightASL _pos2d];
        _pos2d
    } else {
        AGLToASL (screenToWorld getMousePosition);
    };
    TRACE_2("aborted",_object,_mousePosASL);
    [false, _object, _mousePosASL] call _code;
    GVAR(moduleDestination_running) = false;
    true;
}, [_object, _code]] call CBA_fnc_addBISEventHandler;

// Add draw eh for the zeus map - draws the 2d icon and line
GVAR(moduleDestination_mapDrawEH) = [((findDisplay 312) displayCtrl 50), "draw", {
    params ["_mapCtrl"];
    _thisArgs params ["_object", "_text", "_icon", "_color"];

    private _pos2d = (((findDisplay 312) displayCtrl 50) ctrlMapScreenToWorld getMousePosition);
    _mapCtrl drawIcon [_icon, _color, _pos2d, 24, 24, 45, _text, 1, 0.03, "TahomaB", "right"];
    _mapCtrl drawLine [getPos _object, _pos2d, _color];
}, [_object, _text, _icon, _color]] call CBA_fnc_addBISEventHandler;

[{
    (_this select 0) params ["_object", "_code", "_text", "_icon", "_color"];
    if ((isNull _object) || {isNull findDisplay 312} || {!isNull findDisplay 49}) then {
        TRACE_3("null-exit",isNull _object,isNull findDisplay 312,isNull findDisplay 49);
        GVAR(moduleDestination_running) = false;
        [false, _object, [0,0,0]] call _code;
    };
    if (GVAR(moduleDestination_running)) then {
        // Draw the 3d icon and line
        private _mousePosAGL = screenToWorld getMousePosition;
        drawIcon3D [_icon, _color, _mousePosAGL, 1.5, 1.5, 45, _text];
        drawLine3D [_mousePosAGL, ASLtoAGL (getPosASL _object), _color];;
    } else {
        TRACE_3("cleaning up",_this select 1, GVAR(moduleDestination_displayEH), GVAR(moduleDestination_mapDrawEH));
        (_this select 1) call CBA_fnc_removePerFrameHandler;
        (findDisplay 312) displayRemoveEventHandler ["mouseButtonDown", GVAR(moduleDestination_displayEHMouse)];
        (findDisplay 312) displayRemoveEventHandler ["KeyDown", GVAR(moduleDestination_displayEHKeyboard)];
        ((findDisplay 312) displayCtrl 50) ctrlRemoveEventHandler ["draw", GVAR(moduleDestination_mapDrawEH)];
        GVAR(moduleDestination_displayEHMouse) = nil;
        GVAR(moduleDestination_displayEHKeyboard) = nil;
        GVAR(moduleDestination_mapDrawEH) = nil;
    };
}, 0, [_object, _code, _text, _icon, _color]] call CBA_fnc_addPerFrameHandler;
