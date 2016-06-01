// COMPONENT should be defined in the script_component.hpp and included BEFORE this hpp

#define MAINPREFIX z
#define PREFIX ace

#define MAJOR 3
#define MINOR 5
#define PATCHLVL 1
#define BUILD 0

#define VERSION MAJOR.MINOR.PATCHLVL.BUILD
#define VERSION_AR MAJOR,MINOR,PATCHLVL,BUILD

#define WEB_URL http://ace3mod.com/
#define PBO_URL url = QUOTE(WEB_URL)

// MINIMAL required version for the Mod. Components can specify others..
#define REQUIRED_VERSION 1.56
#define REQUIRED_CBA_VERSION {2,3,1}
