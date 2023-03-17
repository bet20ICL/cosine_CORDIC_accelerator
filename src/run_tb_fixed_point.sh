# iverilog -g 2005 -s tb -o bin/tb_floating_point_ip tb/tb_floating_point_ip.v floating_point_IP/fp_constant.v
# bin/tb_floating_point_ip 1> ./out/tb_floating_point_ip.txt


iverilog -g 2005 -s tb_fixed_point_128 -o bin/tb_fixed_point tb/tb_fixed_point_128.v test_timing.v wl_21/helpers/converters.v
bin/tb_fixed_point #1> ./out/tb_fixed_point.txt