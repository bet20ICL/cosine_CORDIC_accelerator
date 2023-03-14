set_global_assignment -entity "fp_addsub_1cyc" -library "lib_fp_addsub_1cyc" -name IP_TOOL_NAME "altera_fp_functions"
set_global_assignment -entity "fp_addsub_1cyc" -library "lib_fp_addsub_1cyc" -name IP_TOOL_VERSION "18.1"
set_global_assignment -entity "fp_addsub_1cyc" -library "lib_fp_addsub_1cyc" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_fp_addsub_1cyc" -name SPD_FILE [file join $::quartus(sip_path) "fp_addsub_1cyc.spd"]

set_global_assignment -library "lib_fp_addsub_1cyc" -name MISC_FILE [file join $::quartus(sip_path) "fp_addsub_1cyc_sim/fp_addsub_1cyc.vo"]
