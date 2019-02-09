#include "script_component.hpp"

#include "XEH_PREP.hpp"



//See XEH_postInit.sqf
private _initVehicleClasses = ["ThingX", "LandVehicle", "Air", "Ship_F"];

private _vehicleClasses_addClassEH = [];
private _objectClasses_addClassEH = [];
private _vehicleClasses_addAction = [];
private _itemClasses_addAction = [];

// find all remaining configured classes and init them
{
    private _class = configName _x;
    // init vehicle
    if (
        1 == getNumber (_x >> QGVAR(hasCargo))
        && {{if (_class isKindOf _x) exitWith {false}; true} forEach _initVehicleClasses}
    ) then {
        if (_class isKindOf "Static") then {
            if (2 == getNumber (_x >> "scope")) then {
                _vehicleClasses_addAction pushBackUnique _class;
            };
        } else {
            _vehicleClasses_addClassEH pushBackUnique _class;
            _initVehicleClasses pushBackUnique _class;
        };
    };
    // init object
    if (
        1 == getNumber (_x >> QGVAR(canLoad))
        && {{if (_class isKindOf _x) exitWith {false}; true} forEach _objectClasses_addClassEH}
    ) then {
        if (_class isKindOf "Static") then {
            if (2 == getNumber (_x >> "scope")) then {
                _itemClasses_addAction pushBackUnique _class;
            };
        } else {
            _objectClasses_addClassEH pushBackUnique _class;
        };
    };
} forEach ("true" configClasses (configFile >> "CfgVehicles"));


uiNamespace setVariable [QGVAR(vehicleClasses_classEH), compileFinal str _vehicleClasses_addClassEH];
uiNamespace setVariable [QGVAR(objectClasses_classEH), compileFinal str _objectClasses_addClassEH];
uiNamespace setVariable [QGVAR(initializedVehicleClasses), compileFinal str _vehicleClasses_addAction];
uiNamespace setVariable [QGVAR(initializedItemClasses), compileFinal str _itemClasses_addAction];
