/*
  Name: ACE_Respawn_fnc_moveRallypoint
  
  Author(s):
    commy2
  
  Description:
    Moves a rallypoint to the player's location
  
  Parameters:
    0: OBJECT - unit
    1: OBJECT - side
  
  Returns:
    VOID
*/

#include "script_component.hpp"

_this spawn {
    _unit = _this select 0;
    _side = _this select 1;

    // rallypoint names are defined in CfgVehicles.hpp

    _rallypoint = [
        objNull,
        missionNamespace getVariable ["ACE_Rallypoint_West", objNull],
        missionNamespace getVariable ["ACE_RallypointExit_East", objNull],
        missionNamespace getVariable ["ACE_RallypointExit_Independent", objNull]
    ] select ([west, east, independent] find _side) + 1;

    if (isNull _rallypoint) exitWith {};

    _position = getPosATL _unit;
    _position = _position findEmptyPosition [0, 2, typeOf _rallypoint];
    if (count _position == 0) then {_position = getPosATL _unit};

    _position set [2, 0];

    [localize "STR_ACE_Respawn_Deploy"] call EFUNC(common,displayTextStructured);

    sleep 5;
    _rallypoint setPosATL _position;
    _unit reveal _rallypoint;

    /*
    _marker = format ["AGM_RallyPoint_%1", _side];
    _marker setMarkerPos _position;
    _marker setMarkerTextLocal format ["%1:%2", [date select 3, 2, 0] call CBA_fnc_FORMATNumber, [date select 4, 2, 0] call CBA_fnc_FORMATNumber];
    */

    [localize "STR_ACE_Respawn_Deploy"] call EFUNC(common,displayTextStructured);
};
