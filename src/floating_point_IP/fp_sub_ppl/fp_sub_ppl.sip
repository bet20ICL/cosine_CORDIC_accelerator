set_global_assignment -entity "fp_sub_ppl" -library "lib_fp_sub_ppl" -name IP_TOOL_NAME "altera_fp_functions"
set_global_assignment -entity "fp_sub_ppl" -library "lib_fp_sub_ppl" -name IP_TOOL_VERSION "18.1"
set_global_assignment -entity "fp_sub_ppl" -library "lib_fp_sub_ppl" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_fp_sub_ppl" -name SPD_FILE [file join $::quartus(sip_path) "fp_sub_ppl.spd"]

set_global_assignment -library "lib_fp_sub_ppl" -name MISC_FILE [file join $::quartus(sip_path) "fp_sub_ppl_sim/fp_sub_ppl.vo"]
