# running testbench for fp_ip
iverilog -g 2005 -s tb -o bin/tb_floating_point_ip tb/tb_floating_point_ip.v floating_point_IP/fp_constant.v
bin/tb_floating_point_ip 1> ../out/tb_floating_point_ip.txt