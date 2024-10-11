import numpy as np 
from scipy import signal
import subprocess
import os
import math
import skimage.measure
from numpy.random import seed

#Function to convert from the Fixed point precision that our hardware is using to the float values that python actually uses
def fp_to_float(s,integer_precision,fraction_precision):       #s = input binary string
    number = 0.0
    i = integer_precision - 1
    j = 0
    if(s[0] == '1'):
        s_complemented = twos_comp((s[1:]),integer_precision,fraction_precision)
    else:
        s_complemented = s[1:]
    while(j != integer_precision + fraction_precision -1):
        number += int(s_complemented[j])*(2**i)
        i -= 1
        j += 1
    if(s[0] == '1'):
        return (-1)*number
    else:
        return number

#Function to convert between the actual float values and the fixed point values in the particular 
#precision that our hardware is using
def float_to_fp(num,integer_precision,fraction_precision):   
    if(num<0):
        sign_bit = 1                            #sign bit is 1 for negative numbers in 2's complement                                                 #representation
        num = -1*num
    else:
        sign_bit = 0
    precision = '0'+ str(integer_precision) + 'b'
    integral_part = format(int(num),precision)
    fractional_part_f = num - int(num)
    fractional_part = []
    for i in range(fraction_precision):
        d = fractional_part_f*2
        fractional_part_f = d -int(d)        
        fractional_part.append(int(d))
    fraction_string = ''.join(str(e) for e in fractional_part)
    if(sign_bit == 1):
        binary = str(sign_bit) + twos_comp(integral_part + fraction_string,integer_precision,fraction_precision)
    else:
        binary = str(sign_bit) + integral_part+fraction_string
    return str(binary)
#Function to calculate 2's complement of a binary number
def twos_comp(val,integer_precision,fraction_precision):
    flipped = ''.join(str(1-int(x))for x in val)
    length = '0' + str(integer_precision+fraction_precision) + 'b'
    bin_literal = format((int(flipped,2)+1),length)
    return bin_literal
#Function to perform convolution between an input array and a filter array
def strideConv(arr, arr2, s):
    return signal.convolve2d(arr, arr2[::-1, ::-1], mode='valid')[::s, ::s]
#setting random seed values for each call to random.uniform
seed(17)
#numpy array representing the input activation map
values = np.random.uniform(-1,1,36).reshape((6,6))
seed(2)
#numpy array representing the kernel of weights
weights = np.random.uniform(-1,1,9).reshape((3,3))
#2-D Convolution operation
conv = strideConv(values,weights,1)
#Activation function (alternatively this can be replaced by the Tanh function)
conv_relu = np.maximum(conv,0)
#Pooling function (alternatively np.max can be used as the last argument for max pooling)
pool = skimage.measure.block_reduce(conv_relu, (2,2), np.average)                                       
#Converting all our arrays into the fixed point format of our choice to feed it to hardware
values_fp =[]
weights_fp=[]
conv_relu_fp=[]
conv_fp=[]
pool_fp=[]
final_inp=[]
for a in values:
    for b in a:
        values_fp.append(float_to_fp(b, 3, 12))

values_fp_reshaped = np.reshape(values_fp,(6,6))
print('\n Image Values')
print(values)
print(values_fp_reshaped)

# cnt=0
# final_inp="b"
# for i in range(6):
#      for j in range(6):
#         # final_inp= final_inp+ str(values_fp_reshaped[i][j])+"_"  
          
#         print("input_data[",cnt,"]= 16'b",values_fp_reshaped[i][j],";")
#         cnt+=1  
print(final_inp)
for a in weights:
	for b in a:
		weights_fp.append(float_to_fp(b, 3, 12))

weights_fp = np.reshape(weights_fp,(3,3))
print('\n Kernel Weights')
print(weights)
print(weights_fp)

# cnt=0
# for i in range(3):
#      for j in range(3):
#           print("weight_data[",cnt,"]= 16'b",weights_fp[i][j],";")
#           cnt+=1 

for a in conv:
	for b in a:
		conv_fp.append(float_to_fp(b, 3, 12))

conv_fp = np.reshape(conv_fp,(4,4))
print('\n Convolved Output')
print(conv)
print(conv_fp)

for a in conv_relu:
    for b in a:
        conv_relu_fp.append(float_to_fp(b, 3, 12))

conv_fp = np.reshape(conv_fp,(4,4))
print('\n Relu Conv')
print(conv_relu)
print(conv_relu_fp)

for x in pool:
	for y in x:
		pool_fp.append(float_to_fp(y, 3, 12))

pool_fp = np.reshape(pool_fp,(2,2))
print('\n Pooled Output')
print(pool)
print(pool_fp)




# values
# [[-0.41066999  0.06117351 -0.61695843 -0.86419928  0.57397092  0.31266704]
#  [ 0.27504179  0.15120579 -0.92187417 -0.28437279  0.89136637 -0.87991064]
#  [ 0.72808421  0.75458105 -0.89761267  0.30483723  0.10350274  0.19502651]
#  [-0.03294275 -0.43402368 -0.40454856  0.12301781 -0.20790513  0.57740142]
#  [-0.16303123 -0.71219216 -0.69818661 -0.8895173   0.43607439 -0.41536529]
#  [-0.60245226  0.66272784  0.13598224 -0.8353205   0.08999715 -0.68208251]]
# [['1111100101101110' '0000000011111010' '1111011000100001'
#   '1111001000101101' '0000100100101110' '0000010100000000']
#  ['0000010001100110' '0000001001101011' '1111000101000001'
#   '1111101101110100' '0000111001000011' '1111000111101100']
#  ['0000101110100110' '0000110000010010' '1111000110100100'
#   '0000010011100000' '0000000110100111' '0000001100011110']
#  ['1111111101111010' '1111100100001111' '1111100110000111'
#   '0000000111110111' '1111110010101101' '0000100100111101']
#  ['1111110101100101' '1111010010011011' '1111010011010101'
#   '1111000111000101' '0000011011111010' '1111100101011011']
#  ['1111011001011101' '0000101010011010' '0000001000101100'
#   '1111001010100011' '0000000101110000' '1111010100010111']]

# weights
# [[-0.1280102  -0.94814754  0.09932496]
#  [-0.12935521 -0.1592644  -0.33933036]
#  [-0.59070273  0.23854193 -0.40069065]]
# [['1111110111110100' '1111000011010101' '0000000110010110']
#  ['1111110111101111' '1111110101110100' '1111101010010011']
#  ['1111011010001101' '0000001111010001' '1111100110010111']]

# convolved output
# [[ 0.29603207 -0.06693776  1.37891319 -0.44264833]
#  [-0.10188546  0.87896483  0.86022961 -1.3718567 ]
#  [-0.48097811  1.47415119 -0.03505743  0.49937723]
#  [ 1.20645719  0.93217962 -0.31713869  1.21348448]]
# [['0000010010111100' '1111111011101110' '0001011000010000'
#   '1111100011101011']
#  ['1111111001011111' '0000111000010000' '0000110111000011'
#   '1110101000001101']
#  ['1111100001001110' '0001011110010110' '1111111101110001'
#   '0000011111111101']
#  ['0001001101001101' '0000111011101010' '1111101011101101'
#   '0001001101101010']]



#  relu conv
# [[0.29603207 0.         1.37891319 0.        ]
#  [0.         0.87896483 0.86022961 0.        ]
#  [0.         1.47415119 0.         0.49937723]
#  [1.20645719 0.93217962 0.         1.21348448]]
# ['0000010010111100', '0000000000000000', '0001011000010000', '0000000000000000', '0000000000000000', '0000111000010000', '0000110111000011', '0000000000000000', '0000000000000000', '0001011110010110', '0000000000000000', '0000011111111101', '0001001101001101', '0000111011101010', '0000000000000000', '0001001101101010']

# pooled output
# [[0.29374922 0.5597857 ]
#  [0.903197   0.42821543]]
# [['0000010010110011' '0000100011110100']
#  ['0000111001110011' '0000011011011001']]


# acc_op: 0000010010110011
# acc_op: 0000100011110001
# acc_op: 0000111001101111
# acc_op: 0000011011011000

# Acc OP: 0.29345703125
# Acc OP: 0.55859375
# Acc OP: 0.90185546875
# Acc OP: 0.427734375

pool = pool.reshape(1,4)
pool_fp = pool_fp.reshape(1,4)

print("\n\n \nXXXXXXXXXXXXXXXXXXXXXX Output from the Device XXXXXXXXXXXXXXXXXXXXXX \n ")
acc_op = [ '0000010010110011', '0000100011110001', '0000111001101111', '0000011011011000']

for i in range(4):
    print("Pool Output:",pool[0,i], "Floating Point Value:",pool_fp[0,i])
    print("Device OP : \t",fp_to_float(acc_op[i],3,12) , "\t Floating Point Value:", acc_op[i])
print("\n ")




    
# Access Token : FXASCzV5AWUBUygr2cwX