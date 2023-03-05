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

cof16 = [
0.7853981633974483,
0.46364760900080615,
0.24497866312686414,
0.12435499454676144,
0.06241880999595735,
0.031239833430268277,
0.015623728620476831,
0.007812341060101111,
0.0039062301319669718,
0.0019531225164788188,
0.0009765621895593195,
0.0004882812111948983,
0.00024414062014936177,
0.00012207031189367021,
6.103515617420877e-05,
3.0517578115526096e-05
]

print("--------------------------LookUpTable---------------------------")
# import math
# init = 1
# for i in range(16):
#     print(math.atan(init))
#     init = init / 2.0


for i, element in enumerate(cof16):
    decimal_num = element
    fixed_point_binary = decimal_to_fixed_point_binary(decimal_num)
    print(" 4'd", i, "  : rotateAngle = 32'b", fixed_point_binary, ";") 

# print("--------------------------1/K----------------------------")
# decimal_num = 0.607252935
# fixed_point_binary = decimal_to_fixed_point_binary(decimal_num)
# print(fixed_point_binary) 


# print("--------------------------Z----------------------------")
# #z = 0.525072872638702392578125
# z = 0
# # g = 0.52507287263870239258
# print("z: ", z)
# fixed_point_binary = decimal_to_fixed_point_binary(z)
# print(fixed_point_binary)
# for i, element in enumerate(cof):
#     if(z>=0): 
#         z-=element
#     else: 
#         z+=element
#     print("i:", i, "z: ", z)
#     decimal_num = z
#     fixed_point_binary = decimal_to_fixed_point_binary(decimal_num)
#     print(fixed_point_binary)


# print("----------------------------X-------------------------")
# # z = 0.525072872638702392578125
# z = 0
# x = 0.607252935
# y = 0

# next_x = 0
# next_y = 0
# print("x: ", x)
# fixed_point_binary = decimal_to_fixed_point_binary(x)
# print(fixed_point_binary)

# for i, element in enumerate(cof):
#     if(z>=0): 
#         z-=element
#         next_x = - y / (2**i)
#         next_y = x / (2**i)
#         x = x + next_x
#         y = y + next_y

#     else: 
#         z+=element
#         next_x = y / (2**i)
#         next_y = - x / (2**i)
#         x = x + next_x
#         y = y + next_y
    
#     print("i: ", i)
#     print("z: ", z)
#     decimal_num = z
#     fixed_point_binary = decimal_to_fixed_point_binary(decimal_num)
#     print("z: ",fixed_point_binary)

#     print("y: ", y)
#     decimal_num = y
#     fixed_point_binary = decimal_to_fixed_point_binary(decimal_num)
#     print("y: ",fixed_point_binary)

#     print("x: ", x)
#     decimal_num = x
#     fixed_point_binary = decimal_to_fixed_point_binary(decimal_num)
#     print("x: ",fixed_point_binary)

#     print("offset: ", next_x)
#     decimal_num = next_x
#     fixed_point_binary = decimal_to_fixed_point_binary(decimal_num)
#     print("offset: ", fixed_point_binary)

