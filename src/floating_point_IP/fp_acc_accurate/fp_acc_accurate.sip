set_global_assignment -entity "fp_acc_accurate" -library "lib_fp_acc_accurate" -name IP_TOOL_NAME "altera_fp_acc_custom"
set_global_assignment -entity "fp_acc_accurate" -library "lib_fp_acc_accurate" -name IP_TOOL_VERSION "18.1"
set_global_assignment -entity "fp_acc_accurate" -library "lib_fp_acc_accurate" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_fp_acc_accurate" -name SPD_FILE [file join $::quartus(sip_path) "fp_acc_accurate.spd"]

set_global_assignment -library "lib_fp_acc_accurate" -name MISC_FILE [file join $::quartus(sip_path) "fp_acc_accurate_sim/dspba_library_package.vhd"]
set_global_assignment -library "lib_fp_acc_accurate" -name MISC_FILE [file join $::quartus(sip_path) "fp_acc_accurate_sim/dspba_library.vhd"]
set_global_assignment -library "lib_fp_acc_accurate" -name MISC_FILE [file join $::quartus(sip_path) "fp_acc_accurate_sim/fp_acc_accurate.vhd"]
