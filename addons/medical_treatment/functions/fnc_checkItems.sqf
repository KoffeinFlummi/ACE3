/*
 * Author: KoffeinFlummi, commy2
 * Replaces vanilla items with ACE ones.
 *
 * Arguments:
 * 0: The unit <OBJECT>
 *
 * ReturnValue:
 * None
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_unit"];

private _countFirstAidKit = {_x == "FirstAidKit"} count items _unit;
_unit removeItems "FirstAidKit";

private _countMedikit = {_x == "Medikit"} count items _unit;
_unit removeItems "Medikit";

if (EGVAR(medical,level) >= 2) then {
    // --- advanced
    for "_i" from 1 to _countFirstAidKit do {
        _unit addItem "ACE_fieldDressing";
        _unit addItem "ACE_packingBandage";
        _unit addItem "ACE_morphine";
        _unit addItem "ACE_tourniquet";
    };

    for "_i" from 1 to _countMedikit do {
        _unit addItemToBackpack "ACE_fieldDressing";
        _unit addItemToBackpack "ACE_packingBandage";
        _unit addItemToBackpack "ACE_packingBandage";
        _unit addItemToBackpack "ACE_epinephrine";
        _unit addItemToBackpack "ACE_morphine";
        _unit addItemToBackpack "ACE_salineIV_250";
        _unit addItemToBackpack "ACE_tourniquet";
    };
} else {
    // --- basic
    for "_i" from 1 to _countFirstAidKit do {
        _unit addItem "ACE_fieldDressing";
        _unit addItem "ACE_fieldDressing";
        _unit addItem "ACE_morphine";
    };

    for "_i" from 1 to _countMedikit do {
        _unit addItemToBackpack "ACE_epinephrine";
        _unit addItemToBackpack "ACE_epinephrine";
        _unit addItemToBackpack "ACE_epinephrine";
        _unit addItemToBackpack "ACE_epinephrine";
        _unit addItemToBackpack "ACE_bloodIV";
        _unit addItemToBackpack "ACE_bloodIV";
    };
};
