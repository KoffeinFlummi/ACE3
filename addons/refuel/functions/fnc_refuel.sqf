#include "script_component.hpp"
/*
 * Author: GitHawk
 * Refuels the vehicle.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Vehicle <OBJECT>
 * 2: Nozzle <OBJECT>
 * 3: Connection Point <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [bob, kevin, nozzle, [2, 1, 5]] call ace_refuel_fnc_refuel
 *
 * Public: No
 */

params [["_unit", objNull, [objNull]], ["_sink", objNull, [objNull]], ["_nozzle", objNull, [objNull]], ["_connectToPoint", [0,0,0], [[]], 3]];

private _config = configOf _sink;
private _rate = if (isNumber(_config >> QGVAR(flowRate))) then {
    getNumber (_config >> QGVAR(flowRate)) * GVAR(rate)
} else {
    // Jerry cans for example have no flow rate defined, default to 1
    GVAR(rate)
};

[{
    params ["_args", "_pfID"];
    _args params [["_source", objNull, [objNull]], ["_sink", objNull, [objNull]], ["_unit", objNull, [objNull]], ["_nozzle", objNull, [objNull]], ["_rate", 1, [0]], ["_startFuel", 0, [0]], ["_connectFromPoint", [0,0,0], [[]], 3], ["_connectToPoint", [0,0,0], [[]], 3]];

    if !(_nozzle getVariable [QGVAR(isConnected), false]) exitWith {
        [_pfID] call CBA_fnc_removePerFrameHandler;
    };

    // Quit if target or fuel tank got destroyed
    if (!alive _source || {!alive _sink}) exitWith {
        [objNull, _nozzle] call FUNC(disconnect);
        [_pfID] call CBA_fnc_removePerFrameHandler;
    };

    // Quit if hose distance was exceeded
    private _hoseLength = _source getVariable [QGVAR(hoseLength), GVAR(hoseLength)];
    private _tooFar = ((_sink modelToWorld _connectToPoint) distance (_source modelToWorld _connectFromPoint)) > (_hoseLength - 2);
    if (_tooFar && {!(_nozzle getVariable [QGVAR(jerryCan), false])}) exitWith {
        [LSTRING(Hint_TooFar), 2, _unit] call EFUNC(common,displayTextStructured);
        [objNull, _nozzle] call FUNC(disconnect);
        [_pfID] call CBA_fnc_removePerFrameHandler;
    };

    // Main fueling process
    private _finished = false;
    private _fueling = _nozzle getVariable [QGVAR(isRefueling), false];
    if (_fueling) then {
        // Calculate rate using mission time to take time acceleration and pause into account
        private _addedFuel = _rate * (CBA_missionTime - (_nozzle getVariable [QGVAR(lastTickMissionTime), CBA_missionTime]));
        _nozzle setVariable [QGVAR(lastTickMissionTime), CBA_missionTime];

        // Figure out exactly how much fuel to transfer while being sure not to take too much from source
        private _fuelInSource = [_source] call FUNC(getFuel);
        if (_fuelInSource != REFUEL_INFINITE_FUEL) then {
            if (_addedFuel > _fuelInSource) then {
                _addedFuel = _fuelInSource;
                _fuelInSource = 0;
                _finished = true;
                [LSTRING(Hint_SourceEmpty), 2, _unit] call EFUNC(common,displayTextStructured);
            } else {
                _fuelInSource = _fuelInSource - _addedFuel;
            };
        };
        
        private _maxFuel = _nozzle getVariable [QGVAR(maxFuel), 0];
        private _refuelContainer = _nozzle getVariable [QGVAR(refuelContainer), false];
        
        // Add fuel to target while being sure not to put too much into sink
        private _fuelInSink = (if (_refuelContainer) then {
            [_sink] call FUNC(getFuel)
        } else {
            (_nozzle getVariable [QGVAR(tempFuel), _startFuel]) * _maxFuel
        }) + _addedFuel;
        
        if (_fuelInSink >= _maxFuel) then {
            // Put any extra fuel back
            _fuelInSource = _fuelInSource + (_fuelInSink - _maxFuel);
            _addedFuel = _maxFuel - _fuelInSink;
            // We're done
            _fuelInSink = _maxFuel;
            _finished = true;
            [LSTRING(Hint_Completed), 2, _unit] call EFUNC(common,displayTextStructured);
        };
        
        if (_refuelContainer) then {
            [_sink, _fuelInSink] call FUNC(setFuel);
        } else {
            [QEGVAR(common,setFuel), [_sink, _fuelInSink / _maxFuel], _sink] call CBA_fnc_targetEvent;
            _nozzle setVariable [QGVAR(tempFuel), _fuelInSink];
        };
        
        // Increment fuel counter
        _source setVariable [QGVAR(fuelCounter), (_source getVariable [QGVAR(fuelCounter), 0]) + _addedFuel, true];

        [QGVAR(tick), [_source, _sink, _addedFuel, _refuelContainer]] call CBA_fnc_localEvent;

        [_source, _fuelInSource] call FUNC(setFuel);
    } else {
        _nozzle setVariable [QGVAR(tempFuel), fuel _sink];
    };

    // Reset variables when done
    if (_finished) exitWith {
        [QGVAR(stopped), [_source, _sink]] call CBA_fnc_localEvent;
        _nozzle setVariable [QGVAR(lastTickMissionTime), nil];
        _nozzle setVariable [QGVAR(isRefueling), false, true];
    };
}, 1, [
    _nozzle getVariable QGVAR(source),
    _sink,
    _unit,
    _nozzle,
    _rate,
    fuel _sink,
    _nozzle getVariable [QGVAR(attachPos), [0,0,0]],
    _connectToPoint
]] call CBA_fnc_addPerFrameHandler;

["cba_xeh_deleted","ace_interact_menu_atcache_repair_19_palivo","bis_addvirtualweaponcargo_cargo","bis_fnc_initvehicle_mass","ace_interact_menu_atcache_ace_mainactions","cba_xeh_incomingmissile","cba_xeh_getin","cba_xeh_local","cba_xeh_isprocessed","cba_xeh_init","cba_xeh_initpost","cba_xeh_fired","ace_cargo_space","ace_interact_menu_atcache_replace_8_hitrf2wheel","cba_xeh_respawn","cba_xeh_engine","ace_refuel_currentfuelcargo","ace_refuel_nozzle","ace_cargo_loaded","ace_interact_menu_atcache_repair_1_motor","ace_interact_menu_atcache_remove_8_hitrf2wheel","cba_xeh_killed","ace_vehicles_enginestate","cba_xeh_getout","cba_xeh_isinitialized","ace_interact_menu_atcache_repair_0_palivo","ace_interact_menu_atcache_repair_2_karoserie","bis_fnc_arsenal_action"]