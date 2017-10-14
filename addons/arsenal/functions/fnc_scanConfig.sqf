#include "script_component.hpp"

private _cargo = [
    [[], [], []], // Weapons 0, primary, handgun, secondary
    [[], [], [], []], // WeaponAccessories 1, optic,side,muzzle,bipod
    [ ], // Magazines 2
    [ ], // Headgear 3
    [ ], // Uniform 4
    [ ], // Vest 5
    [ ], // Backpacks 6
    [ ], // Goggles 7
    [ ], // NVGs 8
    [ ], // Binoculars 9
    [ ], // Map 10
    [ ], // Compass 11
    [ ], // Radio slot 12
    [ ], // Watch slot  13
    [ ], // Comms slot 14
    [ ], // WeaponThrow 15
    [ ], // WeaponPut 16
    [ ] // InventoryItems 17
];

private _configCfgWeapons = configFile >> "CfgWeapons"; //Save this lookup in variable for perf improvement

{
    private _configItemInfo = _x >> "ItemInfo";
    private _simulationType = getText (_x >> "simulation");
    private _className = configName _x;

    switch true do {
        /* Weapon acc */
        case (
                isClass (_configItemInfo) &&
                {(getNumber (_configItemInfo >> "type")) in [101, 201, 301, 302]} &&
                {!(configName _x isKindOf ["CBA_MiscItem", (_configCfgWeapons)])}
            ): {

            switch (getNumber (_configItemInfo >> "type")) do {
                case 201: {
                    (_cargo select 1) select 0 pushBackUnique _className;
                };
                case 301: {
                    (_cargo select 1) select 1 pushBackUnique _className;
                };
                case 101: {
                    (_cargo select 1) select 2 pushBackUnique _className;
                };
                case 302: {
                    (_cargo select 1) select 3 pushBackUnique _className;
                };
            };

        };
        /* Headgear */
        case (isClass (_configItemInfo) && {getNumber (_configItemInfo >> "type") == 605}): {
            (_cargo select 3) pushBackUnique _className;
        };
        /* Uniform */\
        case (isClass (_configItemInfo) && {getNumber (_configItemInfo >> "type") == 801}): {
            (_cargo select 4) pushBackUnique _className;
        };
        /* Vest */
        case (isClass (_configItemInfo) && {getNumber (_configItemInfo >> "type") == 701}): {
            (_cargo select 5) pushBackUnique _className;
        };
        /* NVgs */
        case (_simulationType == "NVGoggles"): {
            (_cargo select 8) pushBackUnique _className;
        };
        /* Binos */
        case (_simulationType == "Binocular" ||
        ((_simulationType == 'Weapon') && {(getNumber (_x >> 'type') == 4096)})): {
            (_cargo select 9) pushBackUnique _className;
        };
        /* Map */
        case (_simulationType == "ItemMap"): {
            (_cargo select 10) pushBackUnique _className;
        };
        /* Compass */
        case (_simulationType == "ItemCompass"): {
            (_cargo select 11) pushBackUnique _className;
        };
        /* Radio */
        case (_simulationType == "ItemRadio"): {
            (_cargo select 12) pushBackUnique _className;
        };
        /* Watch */
        case (_simulationType == "ItemWatch"): {
            (_cargo select 13) pushBackUnique _className;
        };
        /* GPS */
        case (_simulationType == "ItemGPS"): {
            (_cargo select 14) pushBackUnique _className;
        };
        /* UAV terminals */
        case (isClass (_x >> "ItemInfo") && {getNumber (_x >> "ItemInfo" >> "type") == 621}): {
            (_cargo select 14) pushBackUnique _className;
        };
        /* Weapon, at the bottom to avoid adding binos */
        case (isClass (_x >> "WeaponSlotsInfo") &&
            {getNumber (_x >> 'type') != 4096}): {
            switch (getNumber (_x >> "type")) do {
                case 1: {
                    (_cargo select 0) select 0 pushBackUnique (_className call bis_fnc_baseWeapon);
                };
                case 2: {
                    (_cargo select 0) select 1 pushBackUnique (_className call bis_fnc_baseWeapon);
                };
                case 4: {
                    (_cargo select 0) select 2 pushBackUnique (_className call bis_fnc_baseWeapon);
                };
            };
        };
        /* Misc items */
        case (
                isClass (_configItemInfo) &&
                ((getNumber (_configItemInfo >> "type")) in [101, 201, 301, 302] &&
                {(_className isKindOf ["CBA_MiscItem", (_configCfgWeapons)])}) ||
                {(getNumber (_configItemInfo >> "type")) in [401, 619, 620]}
            ): {
            (_cargo select 17) pushBackUnique _className;
        };
    };
} foreach configProperties [_configCfgWeapons, "isClass _x && {getNumber (_x >> 'scope') == 2}", true];

{
    private _className = configName _x;
    private _grenadeList = [];
    {
        _grenadeList append getArray (_configCfgWeapons >> "Throw" >> _x >> "magazines");
        false
    } count getArray (_configCfgWeapons >> "Throw" >> "muzzles");

    private _putList = [];
    {
        _putList append getArray (_configCfgWeapons >> "Put" >> _x >> "magazines");
        false
    } count getArray (_configCfgWeapons >> "Put" >> "muzzles");


    switch true do {
        // Rifle, handgun, secondary weapons mags
        case (
                (getNumber (_x >> "type") in [256,512,1536,16]) &&
                {!(_className in _grenadeList)} &&
                {!(_className in _putList)}
            ): {
            (_cargo select 2) pushBackUnique _className;
        };
        // Grenades
        case (_className in _grenadeList): {
            (_cargo select 15) pushBackUnique _className;
        };
        // Put
        case (_className in _putList): {
            (_cargo select 16) pushBackUnique _className;
        };
    };
} foreach configProperties [(configFile >> "CfgMagazines"), "isClass _x && {getNumber (_x >> 'scope') == 2}", true];

{
    if (getText (_x >> "vehicleClass") == "Backpacks") then {
        (_cargo select 6) pushBackUnique (configName _x);
    };
} foreach configProperties [(configFile >> "CfgVehicles"), "isClass _x && {getNumber (_x >> 'scope') == 2}", true];

{
    (_cargo select 7) pushBackUnique (configName _x);
} foreach configProperties [(configFile >> "CfgGlasses"), "isClass _x && {getNumber (_x >> 'scope') == 2}", true];

uiNamespace setVariable [QGVAR(configItems), _cargo];
