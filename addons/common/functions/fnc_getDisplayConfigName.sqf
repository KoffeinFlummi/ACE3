/*
 * Author: commy2
 * N/A
 *
 * Arguments:
 * None
 *
 * Return Value:
 * (CONFIG)
 *
 * Public: No
 */
#include "script_component.hpp"

private ["_configName", "_index", "_config"];

_configName = "";

for "_index" from 0 to (count configFile - 1) do {
    _config = configFile select _index;
    if (isClass _config && {isNumber (_config >> "idd")} && {getNumber (_config >> "idd") == _this}) exitWith {
        _configName = configName _config;
    };
};

_configName
