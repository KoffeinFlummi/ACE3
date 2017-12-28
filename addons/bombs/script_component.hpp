#define COMPONENT bombs
#define COMPONENT_BEAUTIFIED Bombs
#include "\z\ace\addons\main\script_mod.hpp"

//#define DEBUG_MODE_FULL
#define DRAW_GUIDANCE_INFO
#define DISABLE_COMPILE_CACHE
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_BALLISTICS
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_BALLISTICS
    #define DEBUG_SETTINGS DEBUG_SETTINGS_BALLISTICS
#endif

#ifdef DEBUG_MODE_FULL
    #define DRAW_GUIDANCE_INFO
#endif

#include "\z\ace\addons\main\script_macros.hpp"
