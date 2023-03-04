def decimal_to_fixed_point_binary(decimal_num):
    fixed_point_num = int(decimal_num * 2**31)

    if fixed_point_num > 2**31 - 1 or fixed_point_num < -2**31:
        raise ValueError("Fixed-point number is out of range.")

    binary_str = bin(fixed_point_num & (2**32 - 1))[2:].zfill(32)
    int_part = binary_str[0]
    frac_part = binary_str[1:]
    return (binary_str)

def decimal_to_fixed_point_binary_in_hex(decimal_num):
    fixed_point_num = int(decimal_num * 2**31)

    if fixed_point_num > 2**31 - 1 or fixed_point_num < -2**31:
        raise ValueError("Fixed-point number is out of range.")

    binary_str = bin(fixed_point_num & (2**32 - 1))[2:].zfill(32)
    hex_str = bin(fixed_point_num & (2**32 - 1))[2:].zfill(8)

    return (hex_str)


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

print("--------------------------LookUpTable---------------------------")
for i, element in enumerate(cof):
    decimal_num = element
    fixed_point_binary = decimal_to_fixed_point_binary(decimal_num)
    print(" 4'd", i, "  : rotateAngle = 32'b", fixed_point_binary, ";") 

print("--------------------------1/K----------------------------")
decimal_num = 0.607252935
fixed_point_binary = decimal_to_fixed_point_binary(decimal_num)
print(fixed_point_binary) 


print("--------------------------Z----------------------------")
z = 0.525072872638702392578125
# g = 0.52507287263870239258
print("z: ", z)
fixed_point_binary = decimal_to_fixed_point_binary(z)
print(fixed_point_binary)
for i, element in enumerate(cof):
    if(z>0): 
        z-=element
    else: 
        z+=element
    print("i:", i, "z: ", z)
    decimal_num = z
    fixed_point_binary = decimal_to_fixed_point_binary(decimal_num)
    print(fixed_point_binary)


print("----------------------------X-------------------------")
z = 0.525072872638702392578125
x = 0.607252935
y = 0

next_x = 0
next_y = 0
print("x: ", x)
fixed_point_binary = decimal_to_fixed_point_binary(x)
print(fixed_point_binary)

for i, element in enumerate(cof):
    if(z>0): 
        z-=element
        next_x = - y / (2**i)
        next_y = x / (2**i)
        x = x + next_x
        y = y + next_y

    else: 
        z+=element
        next_x = y / (2**i)
        next_y = - x / (2**i)
        x = x + next_x
        y = y + next_y

    print("i:", i, "x: ", x)
    decimal_num = x
    fixed_point_binary = decimal_to_fixed_point_binary(decimal_num)
    print(fixed_point_binary)

