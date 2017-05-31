#include "script_component.hpp"
if (!hasInterface) exitWith {};

["ace_settingsInitialized", {
    if (!GVAR(enabled)) exitWith {};

    // - Post process effect ------------------------------------------------------
    GVAR(ppeBlackout) = ppEffectCreate ["ColorCorrections", 4220];
    GVAR(ppeBlackout) ppEffectEnable true;
    GVAR(ppeBlackout) ppEffectForceInNVG true;
    GVAR(ppeBlackout) ppEffectAdjust [1,1,0,[0,0,0,1],[0,0,0,0],[1,1,1,1],[10,10,0,0,0,0.1,0.5]];
    GVAR(ppeBlackout) ppEffectCommit 0.4;

    // - GVAR updating and initialization -----------------------------------------
    ["unit", FUNC(handlePlayerChanged), true] call CBA_fnc_addPlayerEventHandler;

    ["visibleMap", {
        params ["", "_visibleMap"]; // command visibleMap is updated one frame later
        private _staminaBarContainer = uiNamespace getVariable [QGVAR(staminaBarContainer), controlNull];
        _staminaBarContainer ctrlShow ((!_visibleMap) && {(vehicle ACE_player) == ACE_player});
    }, true] call CBA_fnc_addPlayerEventHandler;
    ["vehicle", {
        private _staminaBarContainer = uiNamespace getVariable [QGVAR(staminaBarContainer), controlNull];
        _staminaBarContainer ctrlShow ((!visibleMap) && {(vehicle ACE_player) == ACE_player});
    }, true] call CBA_fnc_addPlayerEventHandler;

    // - Duty factors -------------------------------------------------------------
    if (["ACE_Medical"] call EFUNC(common,isModLoaded)) then {
        [QEGVAR(medical,pain), { // 0->1.0, 0.5->1.05, 1->1.1
            linearConversion [0, 1, (_this getVariable [QEGVAR(medical,pain), 0]), 1, 1.1, true];
        }] call FUNC(addDutyFactor);
        [QEGVAR(medical,bloodVolume), { // 100->1.0, 90->1.1, 80->1.2
            linearConversion [100, 0, (_this getVariable [QEGVAR(medical,bloodVolume), 100]), 1, 2, true];
        }] call FUNC(addDutyFactor);
    };
    if (["ACE_Dragging"] call EFUNC(common,isModLoaded)) then {
        [QEGVAR(dragging,isCarrying), {
            [1, 3] select (_this getVariable [QEGVAR(dragging,isCarrying), false]);
        }] call FUNC(addDutyFactor);
    };

    /* SIMPLE WEATHER
    if (["ACE_Weather"] call EFUNC(common,isModLoaded)) then {
        [QEGVAR(weather,temperature), { // 35->1, 45->2
            linearConversion [35, 45, (missionNamespace getVariable [QEGVAR(weather,currentTemperature), 25]), 1, 2, true];
        }] call FUNC(addDutyFactor);
    };
    */

    [QGVAR(hotAndCold), {
        ACE_player getVariable [QGVAR(hotAndColdDuty), 1];
    }] call FUNC(addDutyFactor);

    DFUNC(updateHotAndCold) = {
        private _bodyTemp = [ACE_player getVariable [QGVAR(bodyTemperature),37]] call FUNC(calculateBodyTemperature);
        ACE_player setVariable [QGVAR(bodyTemperature),_bodyTemp];
        private _factors = [_bodyTemp] call FUNC(calculateBodyFactors); // [heatStress,sweat,shiver]
        private _heatStress = (_factors select 0);
        private _shiver = (_factors select 2);
        ACE_player setVariable [QGVAR(hotAndColdDuty), linearConversion [0, 2000, (_heatStress + _shiver), 1, 2, true]];

        [FUNC(updateHotAndCold), [], 1] call CBA_fnc_waitAndExecute;
    };
 
    [FUNC(updateHotAndCold), [], 1] call CBA_fnc_waitAndExecute;

    // - Add main loop at 1 second interval -------------------------------------------------------------
    [FUNC(mainLoop), [], 1] call CBA_fnc_waitAndExecute;
}] call CBA_fnc_addEventHandler;

["ace_settingChanged", {
    params ["_name", "_value"];

    if (_name == QGVAR(enableStaminaBar) && {!_value}) then {
        private _staminaBarContainer = uiNamespace getVariable [QGVAR(staminaBarContainer), controlNull];
        _staminaBarContainer ctrlSetFade 1;
        _staminaBarContainer ctrlCommit 0;
    };
}] call CBA_fnc_addEventHandler;
