#include "script_component.hpp"
/*
 * Author: Alganthe, SynixeBrett
 * Statement to sort weapons by their accuracy.
 *
 * Arguments:
 * 0: Item Config <CONFIG>
 *
 * Return Value:
 * Sorting Value <NUMBER>
 *
 * Public: No
*/

params ["_config"];

private _fireModes = getArray (_config >> "modes");
private _dispersion = [];

{
    if (getNumber (_config >> _x >> "showToPlayer") != 0) then {
        private _n = log getNumber (_config >> _x >> "dispersion");

        if (!finite _n) then {
            _n = 0;
        };

        _dispersion pushBackUnique _n;
    };
} foreach _fireModes;

_dispersion sort true;

round (_dispersion#0 * 100000)
