def decimal_to_fixed_point_binary(decimal_num):
    fixed_point_num = int(decimal_num * 2**31)

    if fixed_point_num > 2**31 - 1 or fixed_point_num < -2**31:
        raise ValueError("Fixed-point number is out of range.")

    binary_str = bin(fixed_point_num & (2**32 - 1))[2:].zfill(32)

    int_part = binary_str[0]
    frac_part = binary_str[1:]
    return (binary_str)
    # return (int_part, frac_part)

cof = [
0.785398163, 		
0.463647609 ,		
0.244978663 ,		
0.124354994 ,		
0.062418810 ,	
0.031239833 ,		
0.015623728	,	
0.007812341 ,		
0.003906230	,	
0.001953123 ,	
]


for i, element in enumerate(cof):
    decimal_num = element
    fixed_point_binary = decimal_to_fixed_point_binary(decimal_num)
    print(" 4'd", i, "  : rotateAngle = 32'b", fixed_point_binary, ";") 

decimal_num = 0.607252935
fixed_point_binary = decimal_to_fixed_point_binary(decimal_num)
print(fixed_point_binary) 