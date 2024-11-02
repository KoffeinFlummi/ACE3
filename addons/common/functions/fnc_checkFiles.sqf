#include "..\script_component.hpp"
/*
 * Author: commy2, johnb432, LinkIsGrim
 * Compares version numbers of PBOs and DLLs. Logs and displays error message on any version/addon errors in multiplayer.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call ace_common_fnc_checkFiles
 *
 * Public: No
 */

// Don't execute in scheduled environment
if (canSuspend) exitWith {
    [FUNC(checkFiles), nil] call CBA_fnc_directCall;
};

///////////////
// Check addons
///////////////
private _cfgPatches = configFile >> "CfgPatches";
private _mainVersion = getText (_cfgPatches >> "ace_main" >> "versionStr");
private _mainVersionAr = getArray (_cfgPatches >> "ace_main" >> "versionAr");
private _mainSource = configSourceMod (_cfgPatches >> "ace_main");

// CBA Versioning check - close main display if using incompatible version
private _cbaVersionAr = getArray (_cfgPatches >> "cba_main" >> "versionAr");
private _cbaRequiredAr = getArray (configFile >> "CfgSettings" >> "CBA" >> "Versioning" >> "ACE" >> "dependencies" >> "CBA") select 1;

private _cbaVersionStr = _cbaVersionAr joinString ".";
private _cbaRequiredStr = _cbaRequiredAr joinString ".";

INFO_3("ACE is version %1 - CBA is version %2 (min required %3)",_mainVersion,_cbaVersionStr,_cbaRequiredStr);

if ([_cbaRequiredAr, _cbaVersionAr] call CBA_versioning_fnc_version_compare) then {
    private _errorMsg = format ["CBA version %1 is outdated (required %2)", _cbaVersionStr, _cbaRequiredStr];
    ERROR(_errorMsg);

    if (hasInterface) then {
        ["[ACE] ERROR", _errorMsg] call FUNC(errorMessage);
    };
};

//private _addons = activatedAddons; // Broken with High-Command module, see #2134
private _addons = (CBA_common_addons select {(_x select [0, 4]) == "ace_"}) apply {toLowerANSI _x};

private _oldAddons = [];
private _oldSources = [];
private _oldCompats = [];

{
    private _addonCfg = configFile >> "CfgPatches" >> _x;
    private _addonVersion = getText (_addonCfg >> "versionStr");

    if (_addonVersion != _mainVersion) then {
        private _addonSource = configSourceMod _addonCfg;

        _oldSources pushBackUnique _addonSource;

        // Check ACE install
        call FUNC(checkFiles_diagnoseACE);

        // Don't block game if it's just an old compat pbo
        if ((_x select [0, 10]) != "ace_compat") then {
            _oldAddons pushBack _x;
        } else {
            _oldCompats pushBack [_x, _addonVersion];
        };
    };
} forEach _addons;

if (_oldAddons isNotEqualTo []) then {
    _oldAddons = _oldAddons apply {format ["%1.pbo", _x]};
    private _extraSources = _oldSources select {_x != _mainSource};
    private _conflictingInstall = _extraSources isNotEqualTo [];
    private _allSources = [_mainSource] + _extraSources;

    // Build the error message
    private _title = "[ACE] ERROR: OUTDATED FILES";
    private _reasonMsg = ["Reason: Mismatched addon versions within the same installation, it is likely corrupted.", "Reason: Conflicting ACE installations (see list below)."] select _conflictingInstall;
    private _fixMsg = ["Fix: Repair ACE or update your repack.", "Fix: Make sure to only load one version of ACE."] select _conflictingInstall;

    private _infoMsgLog = format ["The following files are outdated: %1.<br/>ACE Main version is %2 from folder ""%3"".<br/><br/>All mod folders with ACE files: %4", _oldAddons joinString ", ", _mainVersion, _mainSource, _allSources joinString ", "];
    private _infoMsg = if (count _oldAddons > 3) then {
        format ["The following files are outdated: %1, and %2 more.<br/>ACE Main version is %3 from folder ""%4"".<br/><br/>All mod folders with ACE files: %5", (_oldAddons select [0, 3]) joinString ", ", (count _oldAddons) - 3, _mainVersion, _mainSource, _allSources joinString ", "];
    } else {
        _infoMsgLog
    };

    // Log it
    private _logMsg = format ["%1: %2%5%3%5%5%4", _title, _reasonMsg, _fixMsg, _infoMsgLog, endl];
    _logMsg = _logMsg regexReplace ["<br\/>", endl];
    ERROR(_logMsg);

    // Display it
    if (hasInterface) then {
        private _errorMsg = format ["%1<br/>%2<br/><br/>%3", _reasonMsg, _fixMsg, _infoMsg];
        [_title, _errorMsg] call FUNC(errorMessage);
    };
};

if (_oldCompats isNotEqualTo []) then {
    _oldCompats = _oldCompats apply {format ["%1 (%2)", _x select 0, _x select 1]};

    [{
        // Lasts for ~10 seconds
        ERROR_WITH_TITLE_3("The following ACE compatiblity PBOs are outdated","%1. ACE Main version is %2 from %3.",_this select 0,_this select 1,_this select 2);
    }, [_oldCompats, _mainVersion, _mainSource], 1] call CBA_fnc_waitAndExecute;
};

///////////////
// Check extensions
///////////////
private _platform = toLowerANSI (productVersion select 6);

if (_platform in ["linux", "osx"]) then {
    // Linux and OSX client ports do not support extensions at all
    if (hasInterface) then {
        WARNING("Operating system does not support extensions");
    } else {
        INFO("Operating system does not support extensions");
    };
} else {
    ("ace" callExtension ["version", []]) params [["_versionEx", "", [""]], ["_returnCode", -1, [-1]]];

    if (_returnCode != 0 || {_versionEx == ""}) then {
        private _errorMsg = format ["Extension not found. [Return Code: %1]", _returnCode];
        ERROR(_errorMsg);

        if (hasInterface) then {
            ["[ACE] ERROR", _errorMsg] call FUNC(errorMessage);
        };
    } else {
        _versionEx = _versionEx select [0, 8]; // git hash
        INFO_1("Extension [Version: %1]",_versionEx);
    };
};


///////////////
// Check server version/addons
///////////////
if (isMultiplayer) then {
    // Don't check optional addons
    _addons = _addons select {getNumber (_cfgPatches >> _x >> "ACE_isOptional") != 1};

    if (isServer) then {
        // Send server's version of ACE to all clients
        GVAR(serverVersion) = _mainVersion;
        GVAR(serverVersionAr) = _mainVersionAr;
        GVAR(serverAddons) = _addons;
        GVAR(serverSource) = _mainSource;

        publicVariable QGVAR(serverVersion);
        publicVariable QGVAR(serverVersionAr);
        publicVariable QGVAR(serverAddons);
        publicVariable QGVAR(serverSource);
    } else {
        GVAR(clientVersion) = _mainVersion;
        GVAR(clientVersionAr) = _mainVersionAr;
        GVAR(clientAddons) = _addons;

        private _fnc_diagnose_versionMismatch = {
            private _title = "[ACE] ERROR: VERSION MISMATCH";
            private _fixMsg = format ["Fix: %1", "Make sure versions of server and client match. You may be using ACE from different Steam Workshop items, or just haven't updated properly."];

            // If versions don't match, someone's outdated, if it's not the client, then it's the server
            private _clientIsOutdated = [GVAR(serverVersionAr), GVAR(clientVersionAr)] call CBA_versioning_fnc_version_compare;
            private _reasonMsg = format ["Reason: %1", ["Reason: Server is outdated (client version is higher than server's).", "Reason: Client is outdated (client version is lower than server's)."] select _clientIsOutdated];

            private _infoMsg = format ["Server version is %1, Client version is %2.<br/>Server mod folder is named ""%3"".", GVAR(serverVersion), GVAR(clientVersion), GVAR(serverSource)];

            [_title, _reasonMsg, _fixMsg, _infoMsg, _infoMsg] // return
        };

        private _fnc_diagnose_addonMismatch = {
            private _title = "[ACE] ERROR: ADDON MISMATCH";

            // We don't need to know what's happening to build info here
            private _infoMsgLog = format ["Client has additional addons: %1.<br/>Server mod folder is named ""%2"".", _additionalAddons joinString ", ", GVAR(serverSource)]; // Build the whole thing so we can log it to RPT

            private _infoMsg = if (count _additionalAddons > 3) then { // Truncate it for display
                format ["Client has additional addons: %1, and %2 more.<br/>Server mod folder is named ""%3"".", (_additionalAddons select [0, 3]) joinString ", ", (count _additionalAddons) - 3, GVAR(serverSource)];
            } else {
                _infoMsgLog
            };

            // Figure out why we have a mismatch and where it's coming from
            // Integrated compats are the usual culprit
            private _additionalCompats = _addons select {(_x select [0, 10]) == "ace_compat"};

            if (_additionalCompats isNotEqualTo []) exitWith { // CDLC/content mod with integrated compats is loaded when it shouldn't be
                // Fix is easy
                _fixMsg = format ["Fix: %1", "Make sure your mod list matches. Check your server files and '-mod=' parameter if you're the server administrator."];

                private _additionalMods = [];
                private _loadedModsInfo = getLoadedModsInfo;
                private _defaultModDirs = [_mainSource] + (_loadedModsInfo select {_x select 2} apply {_x select 1}); // Skip ACE itself and anything vanilla

                { // Evil O(n^infinityAndBeyond) loop, can't do much about it.
                    { // Get the real mod name for the compats we're loading
                        private _sourceModDir = configSourceMod (_cfgPatches >> _x);
                        if !(_sourceModDir in _defaultModDirs) then {
                            _additionalMods pushBackUnique (_loadedModsInfo select {_x select 1 == _sourceModDir} select 0 select 0);
                        };
                    } forEach (getArray (_cfgPatches >> _x >> "requiredAddons"));
                } forEach _additionalCompats;

                private _reasonMsg = format ["Reason: %1", "Client has extra mods requiring compats loaded (see list below)"];
                private _additionalModsString = format ["<br/><br/>Additional compatibility is being loaded for: %1", _additionalMods joinString ", "];
                _infoMsg = _infoMsg + _additionalModsString;
                _infoMsgLog = _infoMsgLog + _additionalModsString;

                [_title, _reasonMsg, _fixMsg, _infoMsg, _infoMsgLog] // return
            };

            // Server most likely just uses a different ACE repack with some components removed
            private _reasonMsg = format ["Reason: %1", "Client has ACE addons not present on the server."];
            private _fixMsg = format ["Fix: %1", "Make sure you're using ACE from the same Steam Workshop item or repository as the server."];

            [_title, _reasonMsg, _fixMsg, _infoMsg, _infoMsgLog] // return
        };

        private _fnc_multiplayerCheck = {
            // Check if we'll actually throw an error
            private _versionMismatch = GVAR(clientVersion) != GVAR(serverVersion);
            private _additionalAddons = GVAR(clientAddons) - GVAR(serverAddons);
            private _addonMismatch = _additionalAddons isNotEqualTo [];

            // Should have all possibilities
            if (_versionMismatch || _addonMismatch) then {
                // Check ACE install
                call FUNC(checkFiles_diagnoseACE);

                // Build the error message
                // Could be a simple select but leaving the switch so it's easier to expand later
                private _errorBuilder = switch (true) do {
                    case _versionMismatch: {_fnc_diagnose_versionMismatch};
                    case _addonMismatch: {_fnc_diagnose_addonMismatch};
                };
                (call _errorBuilder) params ["_title", "_reasonMsg", "_fixMsg", "_infoMsg", "_infoMsgLog"];

                // Log it
                private _logMsg = format ["%1: %2%5%3%5%5%4", _title, _reasonMsg, _fixMsg, _infoMsgLog, endl];
                _logMsg = _logMsg regexReplace ["<br\/>", endl];
                ERROR(_logMsg);

                // Display it
                if (hasInterface) then {
                    private _errorMsg = format ["%1<br/>%2<br/><br/>%3", _reasonMsg, _fixMsg, _infoMsg];
                    [_title, _errorMsg] call FUNC(errorMessage);
                };

            };
        };

        // Clients have to wait for the variables
        if (isNil QGVAR(serverVersion) || isNil QGVAR(serverAddons)) then {
            QGVAR(serverVersion) addPublicVariableEventHandler _fnc_multiplayerCheck;
        } else {
            call _fnc_multiplayerCheck;
        };
    };
};
