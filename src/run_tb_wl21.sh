#!/bin/bash

set -euo pipefail

# iverilog -g 2005 -s tb -o bin/syntax syntax/syntax.v
# bin/syntax 1> out/syntax.txt

# VARIANT="cordic_unroll1_var"
# iverilog -g 2005 -s tb -o bin/tb_unroll_var tb/tb_unroll_var.v wl_21/cordic_unroll/${VARIANT}.v wl_21/cordic_unroll/cordic_op.v wl_21/helpers/*
# bin/tb_unroll_var 1> out/${VARIANT}.txt

VARIANT="cordic_unroll2_var"
iverilog -g 2005 -s tb_unroll_var -o bin/tb_unroll_var tb/tb_unroll_var.v wl_21/cordic_unroll/${VARIANT}.v wl_21/cordic_unroll/cordic_op.v wl_21/helpers/*
bin/tb_unroll_var 1> out/${VARIANT}.txt

# VARIANT="cordic_unroll4_var"
# iverilog -g 2005 -s tb_unroll_var -o bin/tb_unroll_var tb/tb_unroll_var.v wl_21/cordic_unroll/${VARIANT}.v wl_21/cordic_unroll/cordic_op.v wl_21/helpers/*
# bin/tb_unroll_var 1> out/${VARIANT}.txt

# VARIANT="cordic_unroll8_var"
# iverilog -g 2005 -s tb_unroll_var -o bin/tb_unroll_var tb/tb_unroll_var.v wl_21/cordic_unroll/${VARIANT}.v wl_21/cordic_unroll/cordic_op.v wl_21/helpers/*
# bin/tb_unroll_var 1> out/${VARIANT}.txt

# VARIANT="cordic_unroll1_var_mod"
# iverilog -g 2005 -s tb_unroll_var -o bin/tb_unroll_var tb/tb_unroll_var.v wl_21/cordic_unroll/${VARIANT}.v wl_21/cordic_unroll/cordic_op.v wl_21/helpers/* 
# bin/tb_unroll_var 1> out/${VARIANT}.txt

# VARIANT="cordic_unroll1_var_addsub"
# iverilog -g 2005 -s tb_unroll_var -o bin/tb_unroll_var tb/tb_unroll_var.v wl_21/cordic_unroll/${VARIANT}.v wl_21/cordic_unroll/cordic_op.v wl_21/helpers/* 
# bin/tb_unroll_var 1> out/${VARIANT}.txt

# iverilog -g 2005 -s tb -o bin/tb_pipeline tb/tb_pipeline.v wl_21/cordic_pipeline/cordic_pipeline.v wl_21/helpers/*
# bin/tb_pipeline 1> out/cordic_pipeline.txt






