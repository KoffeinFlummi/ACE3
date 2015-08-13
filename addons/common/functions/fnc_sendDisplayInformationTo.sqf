/*
 * Author: Glowbal
 *
 * Sends a display information hint to a receiver
 *
 * Arguments:
 * 0: receiver <OBJECT>
 * 1: title (STRING)
 * 2: content (ARRAY)
 * 3: type <NUMBER>(Optional)
 *
 * Return Value:
 * None
 *
 * Public: Yes
 */
#include "script_component.hpp"

private ["_reciever","_title","_content","_type", "_parameters", "_localizationArray"];

params[["_reciever",ObjNull,[ObjNull]],["_title","",[""]],["_content","",[""]],["_type",0,[0]],["_parameters",[],[[]]]];

if (isPlayer _reciever) then {
    if (!local _reciever) then {
        [_this, QFUNC(sendDisplayInformationTo), _reciever, false] call EFUNC(common,execRemoteFnc);
    } else {
        if (isLocalized _title) then {
            _title = localize _title;
        };
        _localizationArray = [_title];
        {
            _localizationArray pushback _x;
            true
        } count _parameters;
        _title = format _localizationArray;

        {
            if (isLocalized _x) then {
                _localizationArray = [localize _x];
                {
                    _localizationArray pushback _x;
                    true
                } count _parameters;

                _content set [_forEachIndex, format _localizationArray];
            };

        } forEach _content;

        [_title,_content,_type] call EFUNC(common,displayInformation);
    };
};
