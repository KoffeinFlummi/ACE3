/*
 * Author: PabstMirror (ideas from Nou's mapGridToPos and BIS_fnc_gridToPos)
 * Finds real x/y offset and map step for a 10 digit grid
 * Save time by preparing data one time at startup
 *
 * Argument:
 * None
 *
 * Return values:
 * None
 *
 * Example:
 * [] call ace_map_fnc_getMapGridData
 *
 * Public: No
 */
#include "script_component.hpp"

private["_cfgGrid", "_formatX", "_formatY", "_heightOffset", "_offsetX", "_offsetY", "_originGrid", "_realOffsetY", "_startGrid", "_stepX", "_stepY", "_zoom", "_zoomMax", "_letterGrid"];

GVAR(mapGridData) = [];

//--- Extract grid values from world config (Borrowed from BIS_fnc_gridToPos)
_cfgGrid = configFile >> "CfgWorlds" >> worldName >> "Grid";
_offsetX = getNumber (_cfgGrid >> "offsetX");
_offsetY = getNumber (_cfgGrid >> "offsetY");
_zoomMax = 1e99;
_formatX = "";
_formatY = "";
_stepX = 1e10;
_stepY = 1e10;
{
    _zoom = getnumber (_x >> "zoomMax");
    if (_zoom < _zoomMax) then {
        _zoomMax = _zoom;
        _formatX = getText (_x >> "formatX");
        _formatY = getText (_x >> "formatY");
        _stepX = getNumber (_x >> "stepX");
        _stepY = getNumber (_x >> "stepY");
    };
} foreach configProperties [_cfgGrid, "isClass _x", false];

_letterGrid = false;
if (((toLower _formatX) find "a") != -1) then {_letterGrid = true};
if (((toLower _formatY) find "a") != -1) then {_letterGrid = true};
if (_letterGrid) exitWith {
    diag_log text format ["[ACE] Map Grid Warning (%1) - Map uses letter grids [%2,%3]", worldName, _formatX, _formatY];
};

//Start at [0, 500] and move north until we get a change in grid
_heightOffset = 500;
_startGrid = mapGridPosition [0, _heightOffset];
_originGrid = _startGrid;
while {_startGrid == _originGrid} do {
    _heightOffset = _heightOffset + 1;
    _originGrid = mapGridPosition [0, _heightOffset];
};

//Calculate the real y offset
_realOffsetY = parseNumber (_originGrid select [(count _formatX), (count _formatY)]) * _stepY + _heightOffset - 1;

//Calculate MGRS 10digit step - they should both be 1 meter:
_stepXat5 = _stepX * 10 ^ ((count _formatX) - 5);
_stepYat5 = -1 * _stepY * 10 ^ ((count _formatY) - 5);

if (_stepYat5 < 0) then {
    diag_log text format ["[ACE] Map Grid Warning (%1) - Northing is reversed", worldName];
};
if (_stepXat5 != 1) then {
    diag_log text format ["[ACE] Map Grid Warning (%1) - MGRS 10 digit grid does not equal 1 meter: (%2) for x", worldName, _stepXat5];
};
if ((_stepYat5 != 1) && {_stepYat5 != -1}) then {
    diag_log text format ["[ACE] Map Grid Warning (%1) - MGRS 10 digit grid does not equal 1 meter: (%2) for y", worldName, _stepXat5];
};

GVAR(mapGridData) = [_offsetX, _realOffsetY, _stepXat5, _stepYat5];
