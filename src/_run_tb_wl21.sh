# #!/bin/bash

set -euo pipefail

# iverilog -g 2012 -s tb -o bin/syntax syntax/syntax.v
# bin/syntax 1> out/syntax.txt

# # bare cordic
# iverilog -g 2005 -s tb_bare_cordic -o bin/tb_bare_cordic tb/tb_bare_cordic.v wl_21/bare_cordic.v wl_21/cordic_unroll/cordic_op.v
# bin/tb_bare_cordic 1> out/bare_cordic_out.txt


# VARIANT="cordic_unroll1_var"
# iverilog -g 2005 -s tb_unroll_var -o bin/tb_unroll_var tb/tb_unroll_var.v wl_21/cordic_unroll/${VARIANT}.v wl_21/cordic_unroll/cordic_op.v wl_21/helpers/*
# bin/tb_unroll_var 1> out/${VARIANT}.txt

# VARIANT="cordic_unroll2_var"
# iverilog -g 2005 -s tb_unroll_var -o bin/tb_unroll_var tb/tb_unroll_var.v wl_21/cordic_unroll/${VARIANT}.v wl_21/cordic_unroll/cordic_op.v wl_21/helpers/*
# bin/tb_unroll_var 1> out/${VARIANT}.txt

# VARIANT="cordic_unroll4_var"
# iverilog -g 2005 -s tb_unroll_var -o bin/tb_unroll_var tb/tb_unroll_var.v wl_21/cordic_unroll/${VARIANT}.v wl_21/cordic_unroll/cordic_op.v wl_21/helpers/*
# bin/tb_unroll_var 1> out/${VARIANT}.txt

# VARIANT="cordic_unroll8_var"
# iverilog -g 2005 -s tb_unroll_var -o bin/tb_unroll_var tb/tb_unroll_var.v wl_21/cordic_unroll/${VARIANT}.v wl_21/cordic_unroll/cordic_op.v wl_21/helpers/*
# bin/tb_unroll_var 1> out/${VARIANT}.txt

# VARIANT="cordic_ppl_5cyc"
# iverilog -g 2005 -s tb_pipeline -o bin/tb_pipeline tb/tb_pipeline.v wl_21/cordic_pipeline/${VARIANT}.v wl_21/helpers/*
# bin/tb_pipeline 1> out/${VARIANT}.txt

# VARIANT="cordic_ppl_2cyc"
# iverilog -g 2005 -s tb_pipeline -o bin/tb_pipeline tb/tb_pipeline.v wl_21/cordic_pipeline/${VARIANT}.v wl_21/cordic_pipeline/cordic_rot_param.v wl_21/helpers/*
# bin/tb_pipeline 1> out/${VARIANT}.txt

# VARIANT="cordic_ppl_1cyc"
# iverilog -g 2005 -s tb_pipeline -o bin/tb_pipeline tb/tb_pipeline.v wl_21/cordic_pipeline/${VARIANT}.v wl_21/cordic_pipeline/cordic_rot_param.v wl_21/helpers/*
# bin/tb_pipeline 1> out/${VARIANT}.txt

# VARIANT="cordic_unroll1_var"
# iverilog -g 2012 -s tb_cordic_rd_file -o bin/tb_cordic_rd_file tb/tb_cordic_rd_file.sv wl_21/cordic_unroll/${VARIANT}.v wl_21/cordic_unroll/cordic_op.v wl_21/helpers/*.v
# bin/tb_cordic_rd_file 1> out/output1.txt

# iverilog -g 2012 -s tb_cordic_rd_file -o bin/tb_cordic_rd_file tb/tb_cordic_rd_file.sv wl_22/cordic_unroll1_wl22.v
# bin/tb_cordic_rd_file 1> out/output2.txt

# TB_NAME="tb_fxd"
# iverilog -g 2012 -s ${TB_NAME} -o bin/${TB_NAME} tb/${TB_NAME}.v wl_21/helpers/converters.v
# bin/${TB_NAME}

# NAME="syntax"
# iverilog -g 2012 -s tb -o bin/syntax syntax/syntax.v
# bin/${NAME} 1> out/${NAME}.txt

TB_NAME="tb_test_dma"
iverilog -g 2012 -s ${TB_NAME} -o bin/${TB_NAME} tb/${TB_NAME}.v wl_21/helpers/converters.v full_fn/full_fn_msgdma.v
bin/${TB_NAME}