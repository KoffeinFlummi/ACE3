#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

#include "initSettings.sqf"

GVAR(canUseArtilleryComputer) = false;

if (hasInterface) then {
    ["CAManBase", "Init", {
        params ["_unit"];
        private _id = _unit addAction ["", {
            params ["_target", "_caller", "_actionId", "_arguments"];
            _caller action ["ArtilleryComputer", objectParent _caller];
        }, nil, 0.1, false, true, "", QGVAR(canUseArtilleryComputer)];

        _unit setUserActionText [_id, localize "STR_artillery_computer"];
    }] call CBA_fnc_addClassEventHandler;
};

ADDON = true;
