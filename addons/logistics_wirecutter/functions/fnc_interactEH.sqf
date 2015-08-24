/*
 * Author: PabstMirror
 * When interact_menu starts rendering (from "interact_keyDown" event)
 *
 * Arguments:
 * Interact Menu Type (0 - world, 1 - self) <NUMBER>
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * [0] call ace_logistics_wirecutter_fnc_interactEH
 *
 * Public: Yes
 */
#include "script_component.hpp"

params ["_interactionType"];

//Ignore self-interaction menu
if (_interactionType != 0) exitWith {};

//for performance only do stuff it they have a wirecutter item
//(if they somehow get one durring keydown they'll just have to reopen)
if (!("ACE_wirecutter" in (items ace_player))) exitWith {};

[{
    private ["_attachedFence", "_helper", "_action"];
    params ["_args", "_pfID"];
    _args params ["_setPosition", "_addedHelpers", "_fencesHelped"];

    if (!EGVAR(interact_menu,keyDown)) then {
        {deleteVehicle _x; nil} count _addedHelpers;
        [_pfID] call CBA_fnc_removePerFrameHandler;
    } else {
        // Prevent Rare Error when ending mission with interact key down:
        if (isNull ace_player) exitWith {};

        //If player moved >5 meters from last pos, then rescan
        if (((getPosASL ace_player) distance _setPosition) > 5) then {

            {
                if (!(_x in _fencesHelped)) then {
                    if ([_x] call FUNC(isFence)) then {
                        _fencesHelped pushBack _x;
                        _helper = "ACE_LogicDummy" createVehicleLocal (getpos _x);
                        _action = [
                            QGVAR(helperCutFence),
                            (localize LSTRING(CutFence)),
                            QUOTE(PATHTOF(ui\wirecutter_ca.paa)),
                            {
                                params ["", "_player", "_attachedFence"];
                                [_player, _attachedFence] call FUNC(cutDownFence);
                            },
                            {
                                params ["", "_player", "_attachedFence"];
                                if (!([_player, _attachedFence, []] call EFUNC(common,canInteractWith))) exitWith {false};
                                ((!isNull _attachedFence) && {(damage _attachedFence) < 1} && {("ACE_wirecutter" in (items _player))})
                            },
                            {},
                            _x,
                            [0,0,0],
                            5
                        ] call EFUNC(interact_menu,createAction);
                        [_helper, 0, [],_action] call EFUNC(interact_menu,addActionToObject);
                        _helper setPosASL ((getPosASL _x) vectorAdd [0,0,1.25]);
                        _addedHelpers pushBack _helper;
                    };
                };
                nil
            } count nearestObjects [ace_player, [], 15];

            _args set [0, (getPosASL ace_player)];
        };
    };
}, 0.1, [((getPosASL ace_player) vectorAdd [-100,0,0]), [], []]] call CBA_fnc_addPerFrameHandler;
