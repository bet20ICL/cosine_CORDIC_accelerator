import random
import struct
import math

num_random_numbers = 4096


f1 = open("test/input/random_numbers.txt", "w")
f2 = open("test/output/random_numbers.txt", "w")
f3 = open("test/input/random_numbers_binary.txt", "w")
f4 = open("test/output/random_numbers_binary.txt", "w")

for i in range(num_random_numbers):
    random_number = random.uniform(-1, 1)
    # f.write('input ')
    # f.write('cos(single_precision_float)=>double_precision_float')
    # f.write('\n')

 
    f1.write(str(random_number))
    f1.write('\n')


    f2.write(str(math.cos(random_number)))
    f2.write('\n')


    single_precision_binary_float = struct.pack('f', random_number)
    # binary_inv = ' '.join(format(b, '08b') for b in binary_float[::-1])
    f3.write(''.join(format(b, '08b') for b in single_precision_binary_float[::-1]))
    f3.write('\n')

 
    double_precision_binary_float = struct.pack('d', random_number)
    f4.write(''.join(format(b, '08b') for b in double_precision_binary_float[::-1]))
    f4.write('\n')