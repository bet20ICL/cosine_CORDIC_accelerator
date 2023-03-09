#!/bin/bash

set -euo pipefail

# # iverilog -g 2005 -o ../../out/a cordic_unroll_slave_variable.v
# iverilog -g 2005 -s tb -o ../../out/tb cordic_unroll_slave_variable_tb.v cordic_unroll_slave_variable.v
# # iverilog -g 2005 -s tb -o ../../out/tb cordic_unroll_slave_tb.v cordic_unroll_slave.v
# ../../out/tb


# --------------------
# Jeffrey
# --------------------

# iverilog -g 2005 -s tb -o ../../../../out/cordic_unroll_slave_variable_tb cordic_unroll_slave_variable_tb.v cordic_unroll1_slave_variable.v

# iverilog -g 2005 -s tb -o ../../../../out/cordic_unroll_slave_variable_tb cordic_unroll_slave_variable_tb.v cordic_unroll2_slave_variable.v

iverilog -g 2005 -s tb -o ../../../../out/cordic_unroll_slave_variable_tb cordic_unroll_slave_variable_tb.v cordic_unroll4_slave_variable.v

# iverilog -g 2005 -s tb -o ../../../../out/cordic_unroll_slave_variable_tb cordic_unroll_slave_variable_tb.v cordic_unroll8_slave_variable.v

../../../../out/cordic_unroll_slave_variable_tb