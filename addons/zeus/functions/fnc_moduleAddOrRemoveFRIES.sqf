/*
 * Author: 654wak654
 * Add/Removes FRIES from a helicopter.
 *
 * Arguments:
 * 0: The module logic <OBJECT>
 * 1: Synchronized units <ARRAY>
 * 2: Activated <BOOL>
 *
 * Return Value:
 * None
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_logic", "_units", "_activated"];

if !(_activated && {local _logic}) exitWith {};

if !(["ace_fastroping"] call EFUNC(common,isModLoaded)) then {
    [LSTRING(RequiresAddon)] call EFUNC(common,displayTextStructured);
} else {
    (GETMVAR(BIS_fnc_curatorObjectPlaced_mouseOver,[""])) params ["_mouseOverType", "_mouseOverUnit"];

    if (_mouseOverType != "OBJECT") then {
        [LSTRING(NothingSelected)] call EFUNC(common,displayTextStructured);
    } else {
        if !(alive _mouseOverUnit) then {
            [LSTRING(OnlyAlive)] call EFUNC(common,displayTextStructured);
        } else {
            _config = configFile >> "CfgVehicles" >> typeOf _mouseOverUnit;
            _displayName = getText (_config >> "displayName");
            if !(isNumber (_config >> QEGVAR(fastroping,enabled))) then {
                [format [localize LSTRING(NotFastRopeCompatible), _displayName]] call EFUNC(common,displayTextStructured);
            } else {
                _fries = GETVAR(_mouseOverUnit,EGVAR(fastroping,FRIES),objNull);
                if (isNull _fries) then {
                    [QGVAR(equipFries), [_mouseOverUnit]] call CBA_fnc_serverEvent;
                } else {
                    if ([_mouseOverUnit] call EFUNC(fastroping,canCutRopes)) then {
                        [format [localize LSTRING(CantRemoveFRIES), _displayName]] call EFUNC(common,displayTextStructured);
                    } else {
                        [_mouseOverUnit] call EFUNC(fastroping,cutRopes);
                        deleteVehicle _fries;
                    };
                };
            };
        };
    };
};

deleteVehicle _logic;
