// by PabstMirror, commy2
#include "script_component.hpp"

// Release object on disconnection. Function is identical to killed
if (isServer) then {
    // 'HandleDisconnect' EH triggers too late
    addMissionEventHandler ["PlayerDisconnected", {
        private _unit = (getUserInfo (_this select 5)) select 10;

        _unit call FUNC(handleKilled);
    }];

    // Handle surrending and handcuffing
    ["ace_captiveStatusChanged", {
        params ["_unit", "_state"];

        // If surrended or handcuffed, drop dragged/carried object
        if (_state) then {
            _unit call FUNC(handleKilled);
        };
    }] call CBA_fnc_addEventHandler;
};

if (!hasInterface) exitWith {};

if (isNil "ACE_maxWeightDrag") then {
    ACE_maxWeightDrag = 800;
};

if (isNil "ACE_maxWeightCarry") then {
    ACE_maxWeightCarry = 600;
};

if (isNil QGVAR(maxWeightCarryRun)) then {
    GVAR(maxWeightCarryRun) = 50;
};

["isNotDragging", {!((_this select 0) getVariable [QGVAR(isDragging), false])}] call EFUNC(common,addCanInteractWithCondition);
["isNotCarrying", {!((_this select 0) getVariable [QGVAR(isCarrying), false])}] call EFUNC(common,addCanInteractWithCondition);

// Release object on player change. This does work when returning to lobby, but not when hard disconnecting.
["unit", LINKFUNC(handlePlayerChanged)] call CBA_fnc_addPlayerEventHandler;
["vehicle", {[ACE_player, objNull] call FUNC(handlePlayerChanged)}] call CBA_fnc_addPlayerEventHandler;
["weapon", LINKFUNC(handlePlayerWeaponChanged)] call CBA_fnc_addPlayerEventHandler;

// Handle waking up dragged unit and falling unconscious while dragging
["ace_unconscious", LINKFUNC(handleUnconscious)] call CBA_fnc_addEventHandler;

// Display event handler
["MouseZChanged", {(_this select 1) call FUNC(handleScrollWheel)}] call CBA_fnc_addDisplayHandler;

[QGVAR(carryingContainerClosed), {
    params ["_container", "_owner"];
    TRACE_2("carryingContainerClosed EH",_container,_owner);
    if !(_owner getVariable [QGVAR(isCarrying), false]) exitWith { ERROR_1("not carrying - %1",_this) };

    private _weight = 0;
    if !(_container getVariable [QGVAR(ignoreWeightCarry), false]) then {
        _weight = [_container] call FUNC(getWeight);
    };

    // Drop the object if overweight
    if (_weight > ACE_maxWeightCarry) exitWith {
        [_owner, _container] call FUNC(dropObject_carry);
    };
    private _canRun = [_weight] call FUNC(canRun_carry);

    // Force walking based on weight
    [_owner, "forceWalk", QUOTE(ADDON), !_canRun] call EFUNC(common,statusEffect_set);
    [_owner, "blockSprint", QUOTE(ADDON), _canRun] call EFUNC(common,statusEffect_set);
}] call CBA_fnc_addEventHandler;

[QGVAR(draggingContainerClosed), {
    params ["_container", "_owner"];
    TRACE_2("draggingContainerClosed EH",_container,_owner);
    if !(_owner getVariable [QGVAR(isDragging), false]) exitWith { ERROR_1("not dragging - %1",_this) };

    private _weight = 0;
    if !(_container getVariable [QGVAR(ignoreWeightDrag), false]) then {
        _weight = [_container] call FUNC(getWeight);
    };

     // Drop the object if overweight
    if (_weight > ACE_maxWeightDrag) exitWith {
        [_owner, _container] call FUNC(dropObject);
    };
}] call CBA_fnc_addEventHandler;

#include "initKeybinds.sqf"
