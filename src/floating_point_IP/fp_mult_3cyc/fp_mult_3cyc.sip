set_global_assignment -entity "fp_mult_3cyc" -library "lib_fp_mult_3cyc" -name IP_TOOL_NAME "altera_fp_functions"
set_global_assignment -entity "fp_mult_3cyc" -library "lib_fp_mult_3cyc" -name IP_TOOL_VERSION "18.1"
set_global_assignment -entity "fp_mult_3cyc" -library "lib_fp_mult_3cyc" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_fp_mult_3cyc" -name SPD_FILE [file join $::quartus(sip_path) "fp_mult_3cyc.spd"]

set_global_assignment -library "lib_fp_mult_3cyc" -name MISC_FILE [file join $::quartus(sip_path) "fp_mult_3cyc_sim/fp_mult_3cyc.vo"]
