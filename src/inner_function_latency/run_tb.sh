

# iverilog -s whole_function  


iverilog -g 2005 -s  tb_fixed_point_128.v ../floating_point_IP/fp_add_ppl/* ../floating_point_IP/fp_sub_ppl/* ../floating_point_IP/fp_mult_ppl/* fixed_point_subtract_divide/cordic_unroll4_var_fixed_point_input.v



# fixed_point_subtract_divide/* floating_point_IP/* fp_addsub_custom/*

# iverilog -g 2005 -s inner_function inner_function.v floating_point_IP/* fp_addsub_custom/* inner_function/*
