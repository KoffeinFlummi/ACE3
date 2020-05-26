#include "script_component.hpp"
#include "..\defines.hpp"
/*
 * Author: Alganthe, Dedmen, SynixeBrett
 * Sort arsenal panel.
 *
 * Arguments:
 * 0: Panel's control to sort <CONTROL>
 * 1: Sorting mode <SCALAR>
 *
 * Return Value:
 * None
 *
 * Public: No
*/

params ["_control", "_mode"];

private _display = ctrlParent _control;

private _to_string = {
    switch true do {
        case (_this < 10): {
            format ["00000%1", _this]
        };
        case (_this < 100): {
            format ["0000%1", _this]
        };
        case (_this < 1000): {
            format ["000%1", _this]
        };
        case (_this < 10000): {
            format ["00%1", _this]
        };
        case (_this < 100000): {
            format ["0%1", _this]
        };
        default { _this };
    }
};

private _right = ctrlIDC _control == 17 && {GVAR(currentLeftPanel) in [IDC_buttonUniform ,IDC_buttonVest, IDC_buttonBackpack]};

if (ctrlIDC _control == 17) then {
    [
        if (_right) then {
            _display displayCtrl IDC_rightTabContentListnBox
        } else {
            _display displayCtrl IDC_rightTabContent
        },
        switch (GVAR(currentRightPanel)) do {
            case IDC_buttonCurrentMag;
            case IDC_buttonCurrentMag2;
            case IDC_buttonMag;
            case IDC_buttonMagALL: { "CfgMagazines" };
            default { "CfgWeapons" };
        },
        GVAR(sortListRightPanel) select (
            switch (GVAR(currentRightPanel)) do {
                case IDC_buttonOptic: { 0 };
                case IDC_buttonItemAcc: { 1 };
                case IDC_buttonMuzzle: { 2 };
                case IDC_buttonBipod: { 3 };
                case IDC_buttonCurrentMag;
                case IDC_buttonCurrentMag2;
                case IDC_buttonMag;
                case IDC_buttonMagALL: { 4 };
                case IDC_buttonThrow: { 5 };
                case IDC_buttonPut: { 6 };
                case IDC_buttonMisc: { 7 };
            }
        )
    ]
} else {
    [
        _display displayCtrl IDC_leftTabContent,
        switch (GVAR(currentLeftPanel)) do {
            case IDC_buttonBackpack: { "CfgVehicles" };
            case IDC_buttonGoggles: { "CfgGlasses" };
            default { "CfgWeapons" };
        },
        (GVAR(sortListLeftPanel) select ([
            IDC_buttonPrimaryWeapon,
            IDC_buttonHandgun,
            IDC_buttonSecondaryWeapon,
            IDC_buttonUniform,
            IDC_buttonVest,
            IDC_buttonBackpack,
            IDC_buttonHeadgear,
            IDC_buttonGoggles,
            IDC_buttonNVG,
            IDC_buttonBinoculars,
            IDC_buttonMap,
            IDC_buttonGPS,
            IDC_buttonRadio,
            IDC_buttonCompass,
            IDC_buttonWatch
        ] find GVAR(currentLeftPanel)))
    ]
} params ["_panel", "_cfgClass", "_sorts"];

private _curSel = if (_right) then {
    lnbCurSelRow _panel
} else {
    lbCurSel _panel
};
private _selected = if (_right) then {
    _panel lnbData [_curSel, 0];
} else {
    _panel lbData _curSel
};

private _statement = _sorts select _mode select 2;

private _for = if (_right) then {
    for '_i' from 0 to ((lnbSize _panel select 0) - 1)
} else {
    for '_i' from 1 to (lbSize _panel - 1)
};

_for do {
    private _item = if (_right) then {
        _panel lnbData [_i, 0]
    } else {
        _panel lbData _i
    };
    private _itemCfg = (configFile >> _cfgClass >> _item);
    private _value = _itemCfg call _statement;
    if (typeName _value isEqualTo "SCALAR") then {
        _value = _value call _to_string;
    };
    if (_value isEqualTo "") then {
        _value = "_";
    };
    // systemChat format ["%1 - %2 = %3", _item, _statement, _value];
    if (_right) then {
        _panel lnbSetText [[_i, 1], format ["%1%2", _value, _panel lnbText [_i, 1]]];
    } else {
        _panel lbSetText [_i, format ["%1%2", _value, _panel lbText _i]];
    };
};

if (_right) then {
    _panel lnbSort [1, false];

    _for do {
        private _data = _panel lnbData [_i, 0];
        if (_cursel >= 0) then {
            if (_data == _selected) then {_panel lnbSetCurSelRow _i};
        };
        _panel lnbSetText [[_i, 1], getText (configFile >> _cfgClass >> _data >> "displayName")];
    };
} else {
    lbSort [_panel, "ASC"];

    _for do {
        private _data = _panel lbData _i;
        if (_cursel >= 0) then {
            if (_data == _selected) then {_panel lbSetCurSel _i};
        };
        _panel lbSetText [_i, getText (configFile >> _cfgClass >> _data >> "displayName")];
    };
};
