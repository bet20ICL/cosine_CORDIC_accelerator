import random
import struct
import math

num_random_numbers = 10






with open('random_numbers.txt', 'w') as f:
    f.write('input ')
    f.write('cos(single_precision_float)=>double_precision_float')
    f.write('\n')
    for i in range(num_random_numbers):
        random_number = random.uniform(-1, 1)
        
        f.write(str(random_number))
        f.write(' ')
        f.write(str(math.cos(random_number)))
        f.write('\n')
        single_precision_binary_float = struct.pack('f', random_number)
        double_precision_binary_float = struct.pack('d', random_number)
        # binary_inv = ' '.join(format(b, '08b') for b in binary_float[::-1])
        f.write(''.join(format(b, '08b') for b in single_precision_binary_float[::-1]))
        f.write(' ')
        f.write(''.join(format(b, '08b') for b in double_precision_binary_float[::-1]))
        f.write('\n')