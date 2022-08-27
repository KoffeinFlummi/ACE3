#include "script_component.hpp"
/*
 * Author: Dystopian
 * Attaches child to parent vehicle.
 * Run globally.
 *
 * Arguments:
 * 0: Vehicle to tow from <OBJECT>
 * 1: Vehicle to tow <OBJECT>
 * 2: Rope End Position <ARRAY>
 * 3: Rope <OBJECT>
 * 4: Attached Helper Object <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [parent, cursorObject, [0,0,0], ropes parent select 0] call ace_towing_fnc_attachVehicles
 *
 * Public: No
 */
params ["_parent", "_child", "_relativeAttachPos", "_rope", "_helper"];
TRACE_5("attachVehicles",_parent,_child,_relativeAttachPos,_rope,_helper);

if (local _parent) then {
    _helper ropeDetach _rope;
    [_child, _relativeAttachPos] ropeAttachTo _rope;
    deleteVehicle _helper;
};

_child setTowParent _parent;
if (!isServer) exitWith {};

_child setVariable [QGVAR(parent), _parent, true];
GVAR(allChildren) pushBack _child;

{
    if (-1 == _x getVariable [QGVAR(DeletedEHID), -1]) then {
        _x setVariable [QGVAR(DeletedEHID), _x addEventHandler ["Deleted", {
            params ["_entity"];
            TRACE_1("Deleted EH",_entity);
            {
                [objNull, _hook, _entity] call FUNC(detachRope);
            } forEach ((_entity getVariable [QGVAR(childHooks), []]) + (_entity getVariable [QGVAR(parentHooks), []]));
        }]];
    };
} forEach [_parent, _child];

if (-1 == _parent getVariable [QGVAR(RopeBreakEHID), -1]) then {
    _parent setVariable [QGVAR(RopeBreakEHID), _parent addEventHandler ["RopeBreak", {
        params ["_parent", "_rope", "_child"];
        if (isNull _rope) exitWith {}; // happens
        private _hook = _rope getVariable [QGVAR(hook), objNull];
        private _hookChild = _hook getVariable [QGVAR(child), objNull];
        if (isNull _hook || {_child != _hookChild}) exitWith {}; // handle helper detach
        TRACE_4("RopeBreak EH",_parent,_rope,_child,_hook);
        [objNull, _hook] call FUNC(detachRope);
    }]];
};
