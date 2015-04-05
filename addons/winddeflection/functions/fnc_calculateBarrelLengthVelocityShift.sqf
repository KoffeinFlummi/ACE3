#include "script_component.hpp"

private ["_ammo", "_weapon", "_barrelLength", "_muzzleVelocityTable", "_barrelLengthTable", "_muzzleVelocity", "_lowerIndex", "_upperIndex", "_barrelLengthRatio", "_muzzleVelocityNew"];
_ammo           = _this select 0;
_weapon         = _this select 1;
_muzzleVelocity = _this select 2;

_barrelLength = getNumber(configFile >> "cfgWeapons" >> _weapon >> "ACE_barrelLength");

if (_barrelLength == 0) exitWith { 0 };

_muzzleVelocityTable = [];
_barrelLengthTable = [];

if (isArray(configFile >> "cfgAmmo" >> _ammo >> "ACE_muzzleVelocities")) then {
	_muzzleVelocityTable = getArray(configFile >> "cfgAmmo" >> _ammo >> "ACE_muzzleVelocities");
};
if (isArray(configFile >> "cfgAmmo" >> _ammo >> "ACE_barrelLengths")) then {
	_barrelLengthTable = getArray(configFile >> "cfgAmmo" >> _ammo >> "ACE_barrelLengths");
};

if (count _muzzleVelocityTable != count _barrelLengthTable) exitWith { 0 };
if (count _muzzleVelocityTable == 0 || count _barrelLengthTable == 0) exitWith { 0 };
if (count _muzzleVelocityTable == 1) exitWith { (_muzzleVelocityTable select 0) - _muzzleVelocity };

_lowerIndex = 0;
_upperIndex = (count _barrelLengthTable) - 1;

if (_barrelLength <= (_barrelLengthTable select _lowerIndex)) exitWith { (_muzzleVelocityTable select _lowerIndex) - _muzzleVelocity };
if (_barrelLength >= (_barrelLengthTable select _upperIndex)) exitWith { (_muzzleVelocityTable select _upperIndex) - _muzzleVelocity };

for "_i" from 0 to (count _barrelLengthTable) - 1 do {
	if (_barrelLength >= _barrelLengthTable select _i) then {
		_lowerIndex = _i;
	};
};
for "_i" from (count _barrelLengthTable) - 1 to 0 step -1 do {
	if (_barrelLength <= _barrelLengthTable select _i) then {
		_upperIndex = _i;
	};
};

_barrelLengthRatio = 0;
if ((_barrelLengthTable select _upperIndex) - (_barrelLengthTable select _lowerIndex) > 0) then {
	_barrelLengthRatio = ((_barrelLengthTable select _upperIndex) - _barrelLength) / ((_barrelLengthTable select _upperIndex) - (_barrelLengthTable select _lowerIndex));
};

_muzzleVelocityNew = (_muzzleVelocityTable select _lowerIndex) + ((_muzzleVelocityTable select _upperIndex) - (_muzzleVelocityTable select _lowerIndex)) * (1 - _barrelLengthRatio);

_muzzleVelocityNew - _muzzleVelocity
