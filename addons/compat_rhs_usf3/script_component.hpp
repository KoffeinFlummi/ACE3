#define COMPONENT compat_rhs_usf3
#define COMPONENT_BEAUTIFIED RHS USAF Compatibility

#include "\z\ace\addons\main\script_mod.hpp"

#include "\z\ace\addons\main\script_macros.hpp"
#include "\z\ace\addons\hearing\script_macros_hearingProtection.hpp"

// Backwards compatibility
#undef GVAR
#define GVAR(var) TRIPLES(PREFIX,COMPONENT,var)
