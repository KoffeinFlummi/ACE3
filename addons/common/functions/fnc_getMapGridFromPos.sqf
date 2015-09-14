/*
 * Author: VKing, PabstMirror
 * Gets a 10-digit map grid for the given world position
 *
 * Argument:
 * 0: Position (2D Position) <ARRAY>
 * 1: Return type; false for array of easting and northing, true for single string <Bool>
 *
 * Return values:
 * 0: Easting <String>
 * 1: Northing <String>
 *
 * Example:
 * [(getPos player)] call ace_common_fnc_getMapGridFromPos;
 *
 * Public: Yes
 */
// #define DEBUG_MODE_FULL
#include "script_component.hpp"

PARAMS_1(_pos);
DEFAULT_PARAM(1,_returnSingleString,false);

private["_count", "_easting", "_nativeGrid", "_northing"];

//Fallback, when map data is weird (letters)
if ((count GVAR(mapGridData)) == 0) exitWith {
    _nativeGrid = mapGridPosition _pos;
    if (_returnSingleString) then {
        _nativeGrid
    } else {
        _count = floor ((count _nativeGrid) / 2);
        [(_nativeGrid select [0, _count]), (_nativeGrid select [_count, _count])]
    };
};

EXPLODE_4_PVT(GVAR(mapGridData),_offsetX,_realOffsetY,_stepXat5,_stepYat5);
_easting = floor (((_pos select 0) - _offsetX) / _stepXat5);
_northing = floor (((_pos select 1) - _realOffsetY) / _stepYat5);

//Attempt to handle negative east/north (e.g.: moving west of map bounds)
if (_easting > 0) then {
    _easting = str _easting;
    while {count _easting < 5} do {_easting = "0" + _easting;};
} else {
    _easting = str abs _easting;
    while {count _easting < 4} do {_easting = "0" + _easting;};
    _easting = "-" + _easting;
};
if (_northing > 0) then {
    _northing = str _northing;
    while {count _northing < 5} do {_northing = "0" + _northing;};
} else {
    _northing = str abs _northing;
    while {count _northing < 4} do {_northing = "0" + _northing;};
    _northing = "-" + _northing;
};

if (_returnSingleString) then {
    _easting + _northing
} else {
    [_easting, _northing]
};
