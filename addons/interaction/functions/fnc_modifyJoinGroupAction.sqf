/*
 * Author: PabstMirror
 * Modifies the ACE_JoinGroup action to show group name.
 *
 * Arguments:
 * 0: Target <OBJECT>
 * 1: Player <OBJECT>
 * 2: Args <Any>
 * 3: Action Data <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorObject, player, [], []] call ace_repair_fnc_modifyInteraction;
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_target", "_player", "", "_actionData"];

private _actionText = format ["%1: %2", localize LSTRING(JoinGroup), groupID group _target];
TRACE_3("",_target,group _target,_actionText);
_actionData set [1, _actionText];
