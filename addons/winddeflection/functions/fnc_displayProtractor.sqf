#include "script_component.hpp"

#define __dsp (uiNamespace getVariable "RscProtractor")
#define __ctrl1 (__dsp displayCtrl 132950)
#define __ctrl2 (__dsp displayCtrl 132951)

private ["_inclinationAngle", "_refPosition"];

if (GVAR(Protractor)) exitWith {
	GVAR(Protractor) = false;
	1 cutText ["", "PLAIN"];
	true
};
if (weaponLowered ACE_player) exitWith { true };
if (vehicle ACE_player != ACE_player) exitWith { true };
if (currentWeapon ACE_player != primaryWeapon ACE_player) exitWith { true };

[] spawn {
	2 cutText ["", "PLAIN"];
	GVAR(WindInfo) = false;
	0 cutText ["", "PLAIN"];
	GVAR(Protractor) = true;
	
	while {GVAR(Protractor) && !(weaponLowered ACE_player) && currentWeapon ACE_player == primaryWeapon ACE_player} do {
		_refPosition = [SafeZoneX + 0.001, SafeZoneY + 0.001, 0.2, 0.2 * 4/3];
		
		_inclinationAngle = asin((ACE_player weaponDirection currentWeapon ACE_player) select 2);
		_inclinationAngle = -58 max _inclinationAngle min 58;
		
		1 cutRsc ["RscProtractor", "PLAIN", 1, false];
		
		__ctrl1 ctrlSetScale 0.75;
		__ctrl1 ctrlCommit 0;
		__ctrl1 ctrlSetText QUOTE(PATHTOF(rsc\protractor.paa));
		__ctrl1 ctrlSetTextColor [1, 1, 1, 1];
		
		__ctrl2 ctrlSetScale 0.75;
		__ctrl2 ctrlSetPosition [(_refPosition select 0), (_refPosition select 1) - 0.0012 * _inclinationAngle, (_refPosition select 2), (_refPosition select 3)];
		__ctrl2 ctrlCommit 0;
		__ctrl2 ctrlSetText QUOTE(PATHTOF(rsc\protractor_marker.paa));
		__ctrl2 ctrlSetTextColor [1, 1, 1, 1];
		
		sleep 0.1;
	};

	GVAR(Protractor) = false;
	1 cutText ["", "PLAIN"];
};

true
