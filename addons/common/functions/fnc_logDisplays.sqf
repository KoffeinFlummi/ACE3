// by commy2
#include "script_component.hpp"

private ["_array", "_index"];

_array = [];

for "_index" from 0 to 10000 do {
  if (str (findDisplay _index) != "No Display") then {
    diag_log text str findDisplay _index;
    _array pushBack _index;
  };
};

_array;
