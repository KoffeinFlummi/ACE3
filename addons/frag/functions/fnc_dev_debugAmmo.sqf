#define DEBUG_MODE_FULL
#include "script_component.hpp"

params [["_debugNonFrag", false, [false]]];

diag_log text format ["Start [%1]", _this];

private _allMagsConfigs = configProperties [configFile >> "CfgMagazines", "isClass _x", true];
private _processedCfgAmmos = [];

{
    private _ammo = toLower getText (_x >> "ammo");
    if ((_ammo != "") && {!(_ammo in _processedCfgAmmos)}) then {
        _processedCfgAmmos pushBack _ammo;

        //Ignore mines/bombs
        if (_ammo isKindOf "TimeBombCore") exitWith {};

        _ammoConfig = configFile >> "CfgAmmo" >> _ammo;

        //Read configs and test if it would actually cause a frag, using same logic as FUNC(pfhRound)
        private _skip = getNumber (_ammoConfig >> QGVAR(skip));
        private _explosive = getNumber (_ammoConfig >> "explosive");
        private _indirectRange = getNumber (_ammoConfig >> "indirectHitRange");
        private _force = getNumber (_ammoConfig >> QGVAR(force));
        private _fragPower = getNumber(_ammoConfig >> "indirecthit")*(sqrt((getNumber (_ammoConfig >> "indirectHitRange"))));

        if (_force == 0) then {
            private _forceNonInherit = configProperties [configFile >> "CfgAmmo" >> _ammo, QUOTE(configName _x == QUOTE(QGVAR(forceOnce))), false];
            if (_forceNonInherit isEqualTo []) exitWith {};
            _force = getNumber (_forceNonInherit select 0);
        };

        private _shouldAdd = (_skip == 0) && {(_force == 1) || {_explosive > 0.5 && {_indirectRange >= 4.5} && {_fragPower >= 35}}};

        if (_shouldAdd) then {
            _warn = false;

            _fragTypes = getArray (_ammoConfig >> "ACE_frag_CLASSES");
            if(_fragTypes isEqualTo []) then {_warn = true;};
            _c = getNumber(_ammoConfig >> "ACE_frag_CHARGE");
            if(_c == 0) then {_warn = true;};
            _m = getNumber(_ammoConfig >> "ACE_frag_METAL");
            if(_m == 0) then {_warn = true;};
            _k = getNumber(_ammoConfig >> "ACE_frag_GURNEY_K");
            if(_k == 0) then {_warn = true;};
            _gC = getNumber(_ammoConfig >> "ACE_frag_GURNEY_C");
            if(_gC == 0) then { _warn = true;};

            if(_warn) then {
                diag_log text format ["Ammo [%1] from Mag [%2] MISSING frag configs:",_ammo,configName _x];
                diag_log text format [" - _c=%1,_m=%2,_k=%3,_gC=%4,_fragTypes=%5",_c,_m,_k,_gC,_fragTypes];
            };
        } else {
            if (_debugNonFrag && {isArray (_ammoConfig >> "ACE_frag_CLASSES")}) then {
                diag_log text format ["Ammo [%1] from Mag [%2] has frag configs but will NOT frag:",_ammo,configName _x];
                diag_log text format ["- skip=%1,explosive=%2,indirectHitRange=%3,force=%4,fragPower=%5",_skip,_explosive,_indirectRange,_force,_fragPower];
            };
        };
    };
} forEach _allMagsConfigs;

diag_log text format ["End [%1-%2]",count _allMagsConfigs, count _processedCfgAmmos];
