set_global_assignment -entity "fp_mult_mxcyc" -library "lib_fp_mult_mxcyc" -name IP_TOOL_NAME "altera_fp_functions"
set_global_assignment -entity "fp_mult_mxcyc" -library "lib_fp_mult_mxcyc" -name IP_TOOL_VERSION "18.1"
set_global_assignment -entity "fp_mult_mxcyc" -library "lib_fp_mult_mxcyc" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_fp_mult_mxcyc" -name SPD_FILE [file join $::quartus(sip_path) "fp_mult_mxcyc.spd"]

set_global_assignment -library "lib_fp_mult_mxcyc" -name MISC_FILE [file join $::quartus(sip_path) "fp_mult_mxcyc_sim/fp_mult_mxcyc.vo"]
