import subprocess

# result = subprocess.run(["echo", "Hello World!"], capture_output=True)
# iverilog_command = "iverilog", "-s", "tb_cos", "-o", "tb_cos", "tb_cos.v", "cos_cordic.v"
iverilog_command = "iverilog -s tb_cos -o out/tb_cos src/tb_cos.v src/cos_cordic.v"
result = subprocess.run([iverilog_command.split(), "cos_cordic.v"], capture_output=True)
result = subprocess.run(["tb_cos"], capture_output=True)

print(result.stdout)