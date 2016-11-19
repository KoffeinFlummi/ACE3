/*
 * Author: Bohemia Interactive
 * Module function for initalizing zeus
 * Edited to remove eagle and global ascension message
 * Added "zeusUnitAssigned" event call
 *
 * Arguments:
 * 0: The module logic <LOGIC>
 * 1: units <ARRAY>
 * 2: activated <BOOL>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

#include "script_component.hpp"

params ["_logic", "_units", "_activated"];

if (_activated) then {

    //--- Terminate when not created on the server
    if (!isServer && local _logic && isNull (getAssignedCuratorUnit _logic)) exitwith {
        [format ["%1 is trying to create curator logic ModuleCurator_F",profileName],"bis_fnc_error",false] call BIS_fnc_MP;
        deleteVehicle _logic;
    };

    //--- Get curator owner
    _ownerVar = _logic getVariable ["owner",""];
    _ownerUID = parseNumber _ownerVar;
    if (cheatsEnabled) then {
        _ownerVarArray = toArray _ownerVar;
        _ownerVarArray resize 3;
        if (toString _ownerVarArray == "DEV") then {_ownerUID = 1;};
    };
    if (_ownerVar == "" && !isMultiplayer) then {
        ["Curator owner not defined, player used instead in singleplayer."] call bis_fnc_error;
        _ownerVar = player call BIS_fnc_objectVar;
    };
    if (_ownerUID > 0 && !isMultiplayer) then {
        _ownerVar = player call BIS_fnc_objectVar;
    };
    _isAdmin = _ownerVar == "#adminLogged" || _ownerVar == "#adminVoted";

    //--- Wipe out the variable so clients can't access it
    _logic setVariable ["owner",nil];

    //--- Server
    if (isServer) then {

        //--- Prepare admin variable
        _adminVar = "";
        if (_isAdmin) then {
            _letters = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"];
            _adminVar = "admin_";
            for "_i" from 0 to 9 do {_adminVar = _adminVar + selectRandom _letters};
            _logic setVariable ["adminVar",_adminVar,true];
        };

        //--- Get allowed addons
        _addonsType = _logic getVariable ["Addons",2];
        _addons = [];
        switch _addonsType do {

            //--- All (including unofficial ones)
            case 3: {
                _cfgPatches = configFile >> "CfgPatches";
                for "_i" from 0 to (count _cfgPatches - 1) do {
                    _class = _cfgPatches select _i;
                    if (isClass _class) then {_addons set [count _addons,configName _class];};
                };
                _addons call bis_fnc_activateaddons;
                removeAllCuratorAddons _logic;
                _logic addCuratorAddons _addons;
            };

            //--- All active
            case 2: {};

            //--- All mission
            case 1: {
                _addonsList = [];
                {
                    _addonsList = _addonsList + (unitAddons typeOf _x);
                } foreach (entities "all");
                removeAllCuratorAddons _logic;
                _logic addCuratorAddons _addonsList;
            };

            //--- None
            case 0: {
                removeAllCuratorAddons _logic;
            };
        };

        //--- Handle ownership
        [_logic,_ownerVar,_ownerUID,_adminVar] spawn {
            scriptName "BIS_fnc_moduleCurator: Owner";

            params ["_logic", "_ownerVar", "_ownerUID", "_adminVar"];

            if (_adminVar != "") then {_ownerVar = _adminVar;};

            _forced = _logic getVariable ["forced",0] > 0;
            _name = _logic getVariable ["name",""];
            if (_name == "") then {_name = localize "STR_A3_curator";};

            //--- Wait until mission starts
            waitUntil {time > 0}; // NOTE: DO NOT CHANGE TO CBA_missionTime, IT BREAKS THE MODULE

            //--- Refresh addon list, so it's broadcasted to clients
            _addons = curatorAddons _logic;
            removeAllCuratorAddons _logic;
            _logic addCuratorAddons _addons;

            while {true} do {
                //--- Wait for player to become Zeus
                switch true do {
                    case (_ownerUID > 0): {
                        waituntil {
                            sleep 0.01;
                            {getPlayerUID _x == _ownerVar} count playableUnits > 0 || isNull _logic
                        };
                    };
                    default {
                        waituntil {isPlayer (missionNamespace getVariable [_ownerVar,objNull]) || isNull _logic};
                    };
                };
                if (isNull _logic) exitwith {};

                //--- Assign
                _player = objNull;
                switch true do {
                    case (_ownerUID > 0): {
                        {
                            if (getPlayerUID _x == _ownerVar) exitwith {_player = _x;};
                        } foreach playableUnits;
                    };
                    default {
                        _player = missionNamespace getVariable [_ownerVar,objNull];
                    };
                };

                waituntil {unassignCurator _logic; isNull (getAssignedCuratorUnit _logic) || isNull _logic};
                waituntil {_player assignCurator _logic; getAssignedCuratorUnit _logic == _player || isNull _logic};
                if (isNull _logic) exitwith {};

                //--- Add radio channels
                {
                    _x radioChannelAdd [_player];
                } foreach (_logic getVariable ["channels",[]]);

                // Added by ace_zeus to delay ascension message code
                private _msgCode = {
                    params ["_logic","_player"];

                    //--- Sent notification to all assigned players
                    if ((_logic getVariable ["showNotification",true]) && GVAR(zeusAscension)) then {
                        {
                            if (isPlayer _x) then {
                                [["CuratorAssign",[_name,name _player]],"bis_fnc_showNotification",_x] call BIS_fnc_MP;
                            };
                        } forEach (curatorEditableObjects _logic);
                    };
                };

                // Added by ace_zeus to hide ascension messages
                if !(EGVAR(common,settingsInitFinished)) then {
                    EGVAR(common,runAtSettingsInitialized) pushBack [_msgCode, [_logic,_player]];
                } else {
                    [_logic,_player] call _msgCode;
                };

                [_logic,"curatorUnitAssigned",[_logic,_player]] call bis_fnc_callscriptedeventhandler;

                // Added by ace_zeus
                [QGVAR(zeusUnitAssigned), [_logic,_player]] call CBA_fnc_globalEvent;

                //--- Wait for player to stop being Zeus
                switch true do {
                    case (_ownerUID > 0): {
                        waituntil {
                            sleep 0.01;
                            {getPlayerUID _x == _ownerVar} count playableUnits == 0 || isNull _logic
                        };
                    };
                    default {
                        waituntil {_player != missionNamespace getVariable [_ownerVar,objNull] || isNull _logic};
                    };
                };
                if (isNull _logic) exitwith {};

                //--- Add radio channels
                {
                    _x radioChannelRemove [_player];
                } foreach (_logic getVariable ["channels",[]]);

                //--- Unassign
                waituntil {unassignCurator _logic; isNull (getAssignedCuratorUnit _logic) || isNull _logic};
                if (isNull _logic) exitwith {};
            };
        };

        // Added by ace_zeus to delay bird code
        private _birdCode = {
            params ["_logic"];

            if (GVAR(zeusBird)) then {
                //--- Create bird
                _birdType = _logic getVariable ["birdType","eagle_f"];
                if (_birdType != "") then {
                    _bird = createVehicle [_birdType,[100,100,100],[],0,"none"];
                    _logic setVariable ["bird",_bird,true];
                };

                //--- Locality changed
                _logic addEventHandler [
                    "local",
                    {
                        _logic = _this select 0;
                        _bird = _logic getVariable ["bird",objNull];
                        _bird setOwner owner _logic;
                    }
                ];
            };
        };

        // Added by ace_zeus to hide camera bird
        if !(EGVAR(common,settingsInitFinished)) then {
            EGVAR(common,runAtSettingsInitialized) pushBack [_birdCode, [_logic]];
        } else {
            [_logic] call _birdCode;
        };

        //--- Activated all future addons
        _addons = [];
        {
            if (typeOf _x == "ModuleCuratorAddAddons_F") then {
                _paramAddons = call compile ("[" + (_x getVariable ["addons",""]) + "]");
                {
                    if !(_x in _addons) then {_addons set [count _addons,_x];};
                    {
                        if !(_x in _addons) then {_addons set [count _addons,_x];};
                    } foreach (unitAddons _x);
                } foreach _paramAddons;
            };
        } foreach (synchronizedObjects _logic);
        _addons call bis_fnc_activateaddons;
    };

    //--- Player
    if (hasInterface) then {
        waituntil {local player};
        _serverCommand = if (_ownerVar == "#adminLogged") then {"#shutdown"} else {"#kick"};

        //--- Black effect until the interface is open
        _forced = _logic getVariable ["forced",0] > 0;
        if (_forced) then {
            _isCurator = switch true do {
                case (_ownerUID > 0): {
                    getPlayerUID player == _ownerVar
                };
                case (_isAdmin): {
                    isServer || serverCommandAvailable _serverCommand
                };
                default {
                    player == missionNamespace getVariable [_ownerVar,objNull]
                };
            };
            if (_isCurator) then {
                [true,true] spawn bis_fnc_forceCuratorInterface;
                ("RscDisplayCurator" call bis_fnc_rscLayer) cutText ["","black in",1e10];
            };
        };

        //--- Check if player is server admin
        if (_isAdmin) then {
            _adminVar = _logic getVariable ["adminVar",""];
            _logic setVariable ["adminVar",nil];
            if (isServer) then {
                //--- Host
                missionNamespace setVariable [_adminVar,player];
            } else {
                //--- Client
                [_logic,_adminVar,_serverCommand] spawn {
                    scriptName "BIS_fnc_moduleCurator: Admin check";

                    _logic = _this select 0;
                    _adminVar = _this select 1;
                    _serverCommand = _this select 2;
                    while {true} do {
                        waituntil {sleep 0.1; serverCommandAvailable _serverCommand};
                        missionNamespace setVariable [_adminVar,player];
                        publicVariable _adminVar;
                        _respawn = player addEventHandler ["respawn",format ["%1 = _this select 0; publicvariable '%1';",_adminVar]];

                        waituntil {sleep 0.1; !serverCommandAvailable _serverCommand};
                        missionNamespace setVariable [_adminVar,objNull];
                        publicVariable _adminVar;
                        player removeEventHandler ["respawn",_respawn];
                    };
                };
            };
        };

        [_logic] spawn {
            _logic = _this select 0;
            sleep 1;
            waituntil {alive player};

            //--- Show warning when Zeus key is not assigned
            if (count (actionKeys "curatorInterface") == 0) then {
                [
                    format [
                        localize "str_a3_cfgvehicles_modulecurator_f_keyNotAssigned",
                        (["IGUI","WARNING_RGB"] call bis_fnc_displaycolorget) call bis_fnc_colorRGBAtoHTML
                    ]
                ] call bis_fnc_guiMessage;
            };

            //--- Show hint about pinging for players
            if (
                isNil {profileNamespace getVariable "bis_fnc_curatorPinged_done"}
                &&
                {isTutHintsEnabled}
                &&
                {isNull getAssignedCuratorLogic player}
                &&
                {player in curatorEditableObjects _logic}
            ) then {
                sleep 0.5;
                [["Curator","Ping"]] call bis_fnc_advHint;
            };
        };

        //--- Add local event handlers
        _logic addEventHandler ["curatorFeedbackMessage",{_this call bis_fnc_showCuratorFeedbackMessage;}];
        _logic addEventHandler ["curatorPinged",{_this call bis_fnc_curatorPinged;}];
        _logic addEventHandler ["curatorObjectPlaced",{_this call bis_fnc_curatorObjectPlaced;}];
        _logic addEventHandler ["curatorObjectEdited",{_this call bis_fnc_curatorObjectEdited;}];
        _logic addEventHandler ["curatorWaypointPlaced",{_this call bis_fnc_curatorWaypointPlaced;}];

        _logic addEventHandler ["curatorObjectDoubleClicked",{(_this select 1) call bis_fnc_showCuratorAttributes;}];
        _logic addEventHandler ["curatorGroupDoubleClicked",{(_this select 1) call bis_fnc_showCuratorAttributes;}];
        _logic addEventHandler ["curatorWaypointDoubleClicked",{(_this select 1) call bis_fnc_showCuratorAttributes;}];
        _logic addEventHandler ["curatorMarkerDoubleClicked",{(_this select 1) call bis_fnc_showCuratorAttributes;}];

        player call BIS_fnc_curatorRespawn;
    };
};
