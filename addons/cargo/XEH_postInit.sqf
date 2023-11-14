#include "script_component.hpp"

["ace_addCargo", {_this call FUNC(addCargoItem)}] call CBA_fnc_addEventHandler;
[QGVAR(paradropItem), {
    params ["_item", "_vehicle", ["_showHint", true]];

    private _unloaded = [_item, _vehicle, _showHint] call FUNC(paradropItem);

    if (_unloaded && {GVAR(openAfterUnload) in [2, 3]}) then {
        GVAR(interactionVehicle) = _vehicle;
        GVAR(interactionParadrop) = true;
        createDialog QGVAR(menu);
    };
}] call CBA_fnc_addEventHandler;

["ace_loadCargo", {
    params ["_item", "_vehicle"];
    TRACE_2("LoadCargo EH",_item,_vehicle);

    private _loaded = [_item, _vehicle] call FUNC(loadItem);

    // Show hint as feedback
    private _hint = [LSTRING(LoadingFailed), LSTRING(LoadedItem)] select _loaded;
    private _itemName = [_item, true] call FUNC(getNameItem);
    private _vehicleName = getText (configOf _vehicle >> "displayName");

    [[_hint, _itemName, _vehicleName], 3.0] call EFUNC(common,displayTextStructured);

    if (_loaded) then {
        // Invoke listenable event
        ["ace_cargoLoaded", [_item, _vehicle]] call CBA_fnc_globalEvent;
    };
}] call CBA_fnc_addEventHandler;

["ace_unloadCargo", {
    params ["_item", "_vehicle", ["_unloader", objNull], ["_place", []]];
    TRACE_4("UnloadCargo EH",_item,_vehicle,_unloader,_place);

    private _unloaded = [_item, _vehicle, _unloader, _place] call FUNC(unloadItem); //returns true if sucessful

    // Show hint as feedback
    private _hint = [LSTRING(UnloadingFailed), LSTRING(UnloadedItem)] select _unloaded;
    private _itemName = [_item, true] call FUNC(getNameItem);
    private _vehicleName = getText (configOf _vehicle >> "displayName");

    [[_hint, _itemName, _vehicleName], 3.0] call EFUNC(common,displayTextStructured);

    if (_unloaded && {GVAR(openAfterUnload) in [1, 3]}) then {
        GVAR(interactionVehicle) = _vehicle;
        GVAR(interactionParadrop) = false;
        createDialog QGVAR(menu);
    };
}] call CBA_fnc_addEventHandler;

// Direction must be set before setting position according to wiki
[QGVAR(setDirAndUnload), {
    params ["_item", "_emptyPosAGL", "_direction"];

    _item setDir _direction;

    [QGVAR(serverUnload), [_item, _emptyPosAGL]] call CBA_fnc_serverEvent;
}] call CBA_fnc_addEventHandler;

// hideObjectGlobal must be executed before setPos to ensure light objects are rendered correctly
// Do both on server to ensure they are executed in the correct order
[QGVAR(serverUnload), {
    params ["_item", "_emptyPosAGL"];

    _item hideObjectGlobal false;
    _item setPosASL (AGLtoASL _emptyPosAGL);

    // Let objects remain invulernable for a short while after placement
    [EFUNC(common,statusEffect_set), [_item, "blockDamage", "ACE_cargo", false], 2] call CBA_fnc_waitAndExecute;
}] call CBA_fnc_addEventHandler;

// Private events to handle adding actions globally via public functions
[QGVAR(initObject), DFUNC(initObject)] call CBA_fnc_addEventHandler;
[QGVAR(initVehicle), DFUNC(initVehicle)] call CBA_fnc_addEventHandler;


GVAR(vehicleAction) = [
    QGVAR(openMenu), localize LSTRING(openMenu), "",
    {
        //IGNORE_PRIVATE_WARNING ["_target", "_player"];
        GVAR(interactionVehicle) = _target;
        GVAR(interactionParadrop) = false;
        createDialog QGVAR(menu);
    },
    {
        //IGNORE_PRIVATE_WARNING ["_target", "_player"];
        GVAR(enable) &&
        {(_target getVariable [QGVAR(hasCargo), getNumber (configOf _target >> QGVAR(hasCargo)) == 1])} &&
        {locked _target < 2} &&
        {([_player, _target] call EFUNC(interaction,getInteractionDistance)) < MAX_LOAD_DISTANCE} &&
        {alive _target} &&
        {[_player, _target, ["isNotSwimming"]] call EFUNC(common,canInteractWith)} &&
        {[_player, _target] call EFUNC(interaction,canInteractWithVehicleCrew)}
    }
] call EFUNC(interact_menu,createAction);

GVAR(objectActions) = [
    [QGVAR(renameObject), LELSTRING(common,rename), "", //TODO: add icon, maybe a pencil couldn't find it before.
        {
            //IGNORE_PRIVATE_WARNING ["_target", "_player"];
            GVAR(interactionVehicle) = _target;
            createDialog QGVAR(renameMenu);
        },
        {
            //IGNORE_PRIVATE_WARNING ["_target", "_player"];
            GVAR(enable) &&
            {GVAR(enableRename)} &&
            {(_target getVariable [QGVAR(canLoad), getNumber (configOf _target >> QGVAR(canLoad))]) in [true, 1]} &&
            {alive _target} &&
            {[_player, _target, ["isNotSwimming"]] call EFUNC(common,canInteractWith)} &&
            {[_player, _target] call EFUNC(interaction,canInteractWithVehicleCrew)} &&
            {(_target getVariable [QGVAR(noRename), getNumber (configOf _target >> QGVAR(noRename))]) in [false, 0]}
        }
    ] call EFUNC(interact_menu,createAction),
    [QGVAR(load), localize LSTRING(loadObject), "a3\ui_f\data\IGUI\Cfg\Actions\loadVehicle_ca.paa",
        {
            params ["_target", "_player"];
            [_player, _target] call FUNC(startLoadIn);
        },
        {
            //IGNORE_PRIVATE_WARNING ["_target", "_player"];
            GVAR(enable) &&
            {(_target getVariable [QGVAR(canLoad), getNumber (configOf _target >> QGVAR(canLoad))]) in [true, 1]} &&
            {locked _target < 2} &&
            {alive _target} &&
            {[_player, _target, ["isNotSwimming"]] call EFUNC(common,canInteractWith)} &&
            {[_player, _target] call EFUNC(interaction,canInteractWithVehicleCrew)} &&
            {((nearestObjects [_target, GVAR(cargoHolderTypes), (MAX_LOAD_DISTANCE + 10)]) findIf {
                private _hasCargoConfig = 1 == getNumber (configOf _x >> QGVAR(hasCargo));
                private _hasCargoPublic = _x getVariable [QGVAR(hasCargo), false];
                (_hasCargoConfig || {_hasCargoPublic}) && {_x != _target} && {alive _x} && {locked _x < 2} &&
                {([_target, _x] call EFUNC(interaction,getInteractionDistance)) < MAX_LOAD_DISTANCE}
            }) > -1}
        },
        LINKFUNC(addCargoVehiclesActions)
    ] call EFUNC(interact_menu,createAction)
];

// find all remaining configured classes and init them, see XEH_preStart.sqf
private _vehicleClassesAddAction = call (uiNamespace getVariable [QGVAR(initializedVehicleClasses), {[]}]);
{
    [_x, 0, ["ACE_MainActions"], GVAR(vehicleAction)] call EFUNC(interact_menu,addActionToClass);
} forEach _vehicleClassesAddAction;
GVAR(initializedVehicleClasses) append _vehicleClassesAddAction;

private _objectClassesAddAction = call (uiNamespace getVariable [QGVAR(initializedItemClasses), {[]}]);
{
    private _objectClass = _x;
    {
        [_objectClass, 0, ["ACE_MainActions"], _x] call EFUNC(interact_menu,addActionToClass);
    } forEach GVAR(objectActions);
} forEach _objectClassesAddAction;
GVAR(initializedItemClasses) append _objectClassesAddAction;

private _vehicleClassesAddClassEH = call (uiNamespace getVariable [QGVAR(vehicleClasses_classEH), {[]}]);
{
    [_x, "initPost", DFUNC(initVehicle), nil, nil, true] call CBA_fnc_addClassEventHandler;
} forEach _vehicleClassesAddClassEH;

private _objectClassesAddClassEH = call (uiNamespace getVariable [QGVAR(objectClasses_classEH), {[]}]);
{
    [_x, "initPost", DFUNC(initObject), nil, nil, true] call CBA_fnc_addClassEventHandler;
} forEach _objectClassesAddClassEH;

if (isServer) then {
    ["ace_placedInBodyBag", {
        params ["_target", "_bodyBag", "_isGrave"];
        if (_isGrave) exitWith {}; // assume graves aren't cargo
        _bodyBag setVariable [QGVAR(customName), [_target, false, true] call EFUNC(common,getName), true];
    }] call CBA_fnc_addEventHandler;
};

// Set variables, even on machines without interfaces, just to be safe
GVAR(selectedItem) = objNull;
GVAR(itemPreviewObject) = objNull;
GVAR(deployPFH) = -1;
GVAR(deployDistance) = -1;
GVAR(deployDirection) = 0;
GVAR(deployHeight) = 0;
GVAR(canDeploy) = false;

if (!hasInterface) exitWith {};

// Cancel object deployment if interact menu opened
["ace_interactMenuOpened", {ACE_player call FUNC(handleDeployInterrupt)}] call CBA_fnc_addEventHandler;

// Cancel deploy on player change. This does work when returning to lobby, but not when hard disconnecting
["unit", LINKFUNC(handleDeployInterrupt)] call CBA_fnc_addPlayerEventHandler;
["vehicle", {(_this select 0) call FUNC(handleDeployInterrupt)}] call CBA_fnc_addPlayerEventHandler;
["weapon", {(_this select 0) call FUNC(handleDeployInterrupt)}] call CBA_fnc_addPlayerEventHandler;

// When changing feature cameras, stop deployment
["featureCamera", {(_this select 0) call FUNC(handleDeployInterrupt)}] call CBA_fnc_addPlayerEventHandler;

// Handle falling unconscious while trying to deploy
["ace_unconscious", {(_this select 0) call FUNC(handleDeployInterrupt)}] call CBA_fnc_addEventHandler;

// Handle surrendering and handcuffing
["ace_captiveStatusChanged", {
    params ["_unit", "_state"];

    // If surrendered or handcuffed, stop deployment
    if (_state) then {
        _unit call FUNC(handleDeployInterrupt);
    };
}] call CBA_fnc_addEventHandler;
