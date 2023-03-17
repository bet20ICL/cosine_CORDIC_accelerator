#cordic unroll (8 4 2 1)
cordic_cyc_Hz = {
    3:38,
    5:59,
    9:108,
    17:134
}

fp_mult_cyc_Hz = {2: 50, 3: 94, 4: 125, 5:175}

fp_add_cyc_Hz = {
    1:	32,
    2:	48,
    3:	65,
    4:	71,
    5:	90,
    6:	103,
    7:	121,
    8:	141,
    9:	142,
    10:	145,
    11:	178}

result = []

product_map1 = 1
for key1,value1 in cordic_cyc_Hz.items():
    for key2,value2 in fp_add_cyc_Hz.items():
        for key3,value3 in fp_mult_cyc_Hz.items():
            cap = min(value1,value2,value3)
            time = 1/cap * (key1+key2*2+key3*2+1)
            result.append([key1,key2,key3,cap,time])
            #print("cordic:{}, mult: {}, add:{} cap_rate:{} time:{}".format(key1,key2,key3,cap,time))

result.sort(key = lambda i: i[4])
# print(result)
for i in result[0:90]:
    print(i)
# print(result.sort(key = lambda i: i[3]))


# product_map1 = 1
# for value in fp_mult_cyc_Hz.values():
#     product_map1 *= value

# # Calculate the product of all values in map2
# product_map2 = 1
# for value in fp_add_cyc_Hz.values():
#     product_map2 *= value

# # Calculate the product of both maps
# product = product_map1 * product_map2

# print(product)
