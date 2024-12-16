#include "..\script_component.hpp"
/*
 * Author: LinkIsGrim
 * Stat condition to only show stats if all exist.
 *
 * Arguments:
 * 0: Stats <ARRAY>
 * 1: Item config path <CONFIG>
 *
 * Return Value:
 * Stat Text <STRING>
 *
 * Public: Yes
*/

params ["_stats", "_config"];
TRACE_2("statCondition_existsAll",_stats,_config);

(_stats findIf {isNull (_config >> _x)}) == -1
