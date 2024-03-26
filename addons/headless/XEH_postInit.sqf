#include "script_component.hpp"

if (!isMultiplayer) exitWith {};

["ace_settingsInitialized", {
    // Register and remove HCs if not client that is not server and distribution or end mission enabled
    if ((!hasInterface || isServer) && {XGVAR(enabled) || XGVAR(endMission) != 0}) then {
        if (isServer) then {
            // Request rebalance on any unit spawn (only if distribution enabled)
            if (XGVAR(enabled)) then {
                ["AllVehicles", "initPost", FUNC(handleSpawn), nil, nil, true] call CBA_fnc_addClassEventHandler;
            };
            // Add disconnect EH
            addMissionEventHandler ["HandleDisconnect", {call FUNC(handleDisconnect)}];

            // If CBA's loadout validation is enabled, warn users
            if (XGVAR(transferLoadout) > 0 && {(missionNamespace getVariable ["CBA_network_loadoutValidation", 0]) isEqualTo 2}) then {
                WARNING("CBA_network_loadoutValidation is enabled - acex_headless_transferLoadout should therefore be disabled");
                [QEGVAR(common,displayTextStructured), ["CBA_network_loadoutValidation is enabled - acex_headless_transferLoadout should therefore be disabled", 3]] call CBA_fnc_globalEvent;
            };

            ["CBA_SettingChanged", {
                params ["_setting", "_value"];

                if (_setting != "CBA_network_loadoutValidation") exitWith {};

                if (XGVAR(transferLoadout) > 0 && {_value isEqualTo 2}) then {
                    WARNING("CBA_network_loadoutValidation is enabled - acex_headless_transferLoadout should therefore be disabled");
                    [QEGVAR(common,displayTextStructured), ["CBA_network_loadoutValidation is enabled - acex_headless_transferLoadout should therefore be disabled", 3]] call CBA_fnc_globalEvent;
                };
            }] call CBA_fnc_addEventHandler;
        } else {
            // Register HC (this part happens on HC only)
            [QXGVAR(headlessClientJoined), [player]] call CBA_fnc_globalEvent; // Global event for API purposes
        };

        // Transfer loadouts (naked unit work-around)
        if (XGVAR(transferLoadout) > 0) then {
            ["CAManBase", "Local", {
                params ["_unit", "_local"];

                // Check if naked unit bug happened
                if (_local && {uniform _unit == ""}) then {
                    scopeName QGVAR(applyLoadout);
                    INFO_1("Unit [%1] became local with broken loadout - attempting to fix",_unit);
                    if (XGVAR(transferLoadout) == 1) then {
                        // Transferred loadout, if unavailable reset to config default (still better than naked)
                        private _loadout = _unit getVariable [QGVAR(loadout), []];
                        if (_loadout isNotEqualTo []) then {
                            [_unit, _loadout] call CBA_fnc_setLoadout;
                            breakOut QGVAR(applyLoadout);
                        };
                    };
                    // Config default loadout
                    _unit setUnitLoadout (typeOf _unit);
                };
            }] call CBA_fnc_addClassEventHandler;
        };
    };
}] call CBA_fnc_addEventHandler;
