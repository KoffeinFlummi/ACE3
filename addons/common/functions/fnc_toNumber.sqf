/*
 * Author(s): Garth de Wet (LH)
 *
 * Takes a string/number and returns the number.
 *
 * Arguments:
 * 0: TYPE - Value to attempt to convert to number or if number simply return number.
 *
 * Returns:
 * NUMBER
 *
 * Example:
 * number = ["102"] call FUNC(toNumber);
 *
 * Public: No
*/
#include "script_component.hpp"

params ["_value"];

if (typeName _value == "SCALAR") exitWith {
    _value
};

(parseNumber _value)
