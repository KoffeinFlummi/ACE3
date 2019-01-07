#include "script_component.hpp"
/*
 * Author: Garth 'L-H' de Wet, Ruthberg, edited by commy2 for better MP and eventual AI support and esteldunedain
 * Confirms trench dig
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [ACE_player] call ace_trenches_fnc_placeConfirm
 *
 * Public: No
 */

params ["_unit"];

// enable running again
[_unit, "forceWalk", "ACE_Trenches", false] call EFUNC(common,statusEffect_set);
[_unit, "blockThrow", "ACE_Trenches", false] call EFUNC(common,statusEffect_set);

// remove dig pfh
[GVAR(digPFH)] call CBA_fnc_removePerFrameHandler;
GVAR(digPFH) = -1;

// remove mouse button actions
call EFUNC(interaction,hideMouseHint);

[_unit, "DefaultAction", _unit getVariable [QGVAR(Dig), -1]] call EFUNC(common,removeActionEventHandler);

_unit setVariable [QGVAR(isPlacing), false, true];

// Delete placement dummy and create real trench
params ["_unit"];
if (isNull GVAR(trench)) exitWith {};

private _trenchClass = typeOf GVAR(trench);
private _vecDirAndUp = [vectorDir GVAR(trench), vectorUp GVAR(trench)];
private _pos = getPosWorld GVAR(trench);
diag_log format ["ACE_TRENCHES Old Pos: %1", _pos];
deleteVehicle GVAR(trench);

diag_log format ["ACE_TRENCHES New Pos: %1", _pos];
private _trench = createVehicle [_trenchClass, _pos, [], 0, "CAN_COLLIDE"];
_trench setObjectTextureGlobal [0,[_trench] call FUNC(getSurfaceTexturePath)];
_trench setPosWorld _pos;

private _boundingBox = boundingBoxReal _trench;
_boundingBox params ["_lbfc", "_rtbc"];                                         //_lbfc(Left Bottom Front Corner) _rtbc (Right Top Back Corner)
_lbfc params ["", "", "_lbfcZ"];
_rtbc params ["", "", "_rtbcZ"];

private _boundingBoxOffset =  missionNamespace getVariable [getText (configFile >> "CfgVehicles" >> _trenchClass >> QGVAR(boundingBoxOffset)),0];
private _posDiff = abs _lbfcZ + abs _rtbcZ - _boundingBoxOffset;
private _newPos = _trench modelToWorldWorld [0,0, -_posDiff];
diag_log format ["ACE_TRENCHES Underearth Pos: %1", _pos];
_trench setPosWorld _newPos;

_trench setVariable [QGVAR(diggingSteps), _posDiff/1000,true];
_trench setVectorDirAndUp _vecDirAndUp;

_trench setVariable [QGVAR(placeData), [_newPos, _vecDirAndUp], true];
_trench setVariable [QGVAR(progress), 0, true];

[_trench, _unit, false] call FUNC(continueDiggingTrench);
