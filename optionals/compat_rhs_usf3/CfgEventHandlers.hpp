class Extended_PreStart_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_SCRIPT(XEH_preStart));
    };
};

class Extended_PreInit_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_SCRIPT(XEH_preInit));
    };
};

class Extended_InitPost_EventHandlers {
    class rhsusf_props_ScepterMFC_OD {
        class ADDON {
            init = QUOTE(call EFUNC(refuel,makeJerryCan));
        };
    };
};
