/**
 * fn_sendRequest_f.sqf
 * @Descr: Send a request to an unit and execute code based upon results.
 * @Author: Glowbal
 *
 * @Arguments: [caller OBJECT, target OBJECT, requestID STRING, requestMessage STRING (Will be localized for other target object), callback CODE (Code called upon accept or decline.)]
 * @Return: void
 * @PublicAPI: true
 */

#include "script_component.hpp"

private ["_caller", "_target", "_requestMessage", "_requestID", "_callBack"];
_caller = _this select 0;
_target = _this select 1;
_requestID = _this select 2;
_requestMessage = _this select 3;
_callBack = _this select 4;

if (isPlayer _target) then {
	// Pass request on to target locality for player accept/decline.
	[[_caller, _target, _requestID, _requestMessage, _callBack], QUOTE(FUNC(receiveRequest)), _target, false] spawn EFUNC(common,execRemoteFnc);
} else {
	// accept it, since it's an AI.
	[_caller, _target, true] spawn compile _callBack;
};
