set_global_assignment -entity "flt2fxd" -library "lib_flt2fxd" -name IP_TOOL_NAME "altera_fp_functions"
set_global_assignment -entity "flt2fxd" -library "lib_flt2fxd" -name IP_TOOL_VERSION "18.1"
set_global_assignment -entity "flt2fxd" -library "lib_flt2fxd" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_flt2fxd" -name SPD_FILE [file join $::quartus(sip_path) "flt2fxd.spd"]

set_global_assignment -library "lib_flt2fxd" -name MISC_FILE [file join $::quartus(sip_path) "flt2fxd_sim/flt2fxd.vo"]
