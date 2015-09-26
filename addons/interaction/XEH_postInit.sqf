// by commy2 and esteldunedain

#include "script_component.hpp"

ACE_Modifier = 0;

//SelectLeader Event Handler for BecomeLeader action:
[QGVAR(selectLeader), {
    PARAMS_2(_group,_leader);
    _group selectLeader _leader;
}] call EFUNC(common,addEventHandler);

//Pushing boats from FUNC(push)
[QGVAR(pushBoat), {
    params ["_boat", "_newVelocity"];
    _boat setVelocity _newVelocity;
}] call EFUNC(common,addEventHandler);


if (!hasInterface) exitWith {};

GVAR(isOpeningDoor) = false;

// restore global fire teams for JIP
private ["_team"];
{
    _team = _x getVariable [QGVAR(assignedFireTeam), ""];
    if (_team != "") then {_x assignTeam _team};
} forEach allUnits;


// Add keybinds
["ACE3 Common", QGVAR(openDoor), localize LSTRING(OpenDoor),
{
    // Conditions: canInteract
    if !([ACE_player, objNull, []] call EFUNC(common,canInteractWith)) exitWith {false};
    // Conditions: specific
    if (GVAR(isOpeningDoor) || {[MACRO_DOOR_REACH_DISTANCE] call FUNC(getDoor) select 1 == ''}) exitWith {false};

    // Statement
    call EFUNC(interaction,openDoor);
    true
},
{
    //Probably don't want any condidtions here, so variable never gets locked down
    // Statement
    GVAR(isOpeningDoor) = false;
    true
},
[57, [false, true, false]], false] call cba_fnc_addKeybind; //Key CTRL+Space


["ACE3 Common", QGVAR(tapShoulder), localize LSTRING(TapShoulder),
{
    // Conditions: canInteract
    if !([ACE_player, objNull, []] call EFUNC(common,canInteractWith)) exitWith {false};
    // Conditions: specific
    if !([ACE_player, cursorTarget] call FUNC(canTapShoulder)) exitWith {false};

    // Statement
    [ACE_player, cursorTarget, 0] call FUNC(tapShoulder);
    true
},
{false},
[20, [true, false, false]], false] call cba_fnc_addKeybind;

["isNotSwimming", {!underwater (_this select 0)}] call EFUNC(common,addCanInteractWithCondition);
["isNotOnLadder", {getNumber (configFile >> "CfgMovesMaleSdr" >> "States" >> animationState (_this select 0) >> "ACE_isLadder") != 1}] call EFUNC(common,addCanInteractWithCondition);
