"""
KEY GENERATOR for AES 128-bit cipher
main function: generate_KEY for AES
Author: Syed Muhammad Muslim
Date: 12-04-24
"""  

import numpy as np

#S box for AES
sbox = [0x63, 0x7c, 0x77, 0x7b, 0xf2, 0x6b, 0x6f, 0xc5,
        0x30, 0x01, 0x67, 0x2b, 0xfe, 0xd7, 0xab, 0x76,
        0xca, 0x82, 0xc9, 0x7d, 0xfa, 0x59, 0x47, 0xf0,
        0xad, 0xd4, 0xa2, 0xaf, 0x9c, 0xa4, 0x72, 0xc0,
        0xb7, 0xfd, 0x93, 0x26, 0x36, 0x3f, 0xf7, 0xcc,
        0x34, 0xa5, 0xe5, 0xf1, 0x71, 0xd8, 0x31, 0x15,
        0x04, 0xc7, 0x23, 0xc3, 0x18, 0x96, 0x05, 0x9a,
        0x07, 0x12, 0x80, 0xe2, 0xeb, 0x27, 0xb2, 0x75,
        0x09, 0x83, 0x2c, 0x1a, 0x1b, 0x6e, 0x5a, 0xa0,
        0x52, 0x3b, 0xd6, 0xb3, 0x29, 0xe3, 0x2f, 0x84,
        0x53, 0xd1, 0x00, 0xed, 0x20, 0xfc, 0xb1, 0x5b,
        0x6a, 0xcb, 0xbe, 0x39, 0x4a, 0x4c, 0x58, 0xcf,
        0xd0, 0xef, 0xaa, 0xfb, 0x43, 0x4d, 0x33, 0x85,
        0x45, 0xf9, 0x02, 0x7f, 0x50, 0x3c, 0x9f, 0xa8,
        0x51, 0xa3, 0x40, 0x8f, 0x92, 0x9d, 0x38, 0xf5,
        0xbc, 0xb6, 0xda, 0x21, 0x10, 0xff, 0xf3, 0xd2,
        0xcd, 0x0c, 0x13, 0xec, 0x5f, 0x97, 0x44, 0x17,
        0xc4, 0xa7, 0x7e, 0x3d, 0x64, 0x5d, 0x19, 0x73,
        0x60, 0x81, 0x4f, 0xdc, 0x22, 0x2a, 0x90, 0x88,
        0x46, 0xee, 0xb8, 0x14, 0xde, 0x5e, 0x0b, 0xdb,
        0xe0, 0x32, 0x3a, 0x0a, 0x49, 0x06, 0x24, 0x5c,
        0xc2, 0xd3, 0xac, 0x62, 0x91, 0x95, 0xe4, 0x79,
        0xe7, 0xc8, 0x37, 0x6d, 0x8d, 0xd5, 0x4e, 0xa9,
        0x6c, 0x56, 0xf4, 0xea, 0x65, 0x7a, 0xae, 0x08,
        0xba, 0x78, 0x25, 0x2e, 0x1c, 0xa6, 0xb4, 0xc6,
        0xe8, 0xdd, 0x74, 0x1f, 0x4b, 0xbd, 0x8b, 0x8a,
        0x70, 0x3e, 0xb5, 0x66, 0x48, 0x03, 0xf6, 0x0e,
        0x61, 0x35, 0x57, 0xb9, 0x86, 0xc1, 0x1d, 0x9e,
        0xe1, 0xf8, 0x98, 0x11, 0x69, 0xd9, 0x8e, 0x94,
        0x9b, 0x1e, 0x87, 0xe9, 0xce, 0x55, 0x28, 0xdf,
        0x8c, 0xa1, 0x89, 0x0d, 0xbf, 0xe6, 0x42, 0x68,
        0x41, 0x99, 0x2d, 0x0f, 0xb0, 0x54, 0xbb, 0x16]
sbox = np.array(sbox)

#Round constants
RC = [0x00, 0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80, 0x1b, 0x36 ]
RC = np.array(RC)

def g_function(w, round):
  """
  w: 1D np array with 4 elements contining the individual bytes
  round: (int) current round
  """
  # print(w)
  B = [w[1], w[2], w[3],w[0]]
  B_prime = [sbox[B[0]], sbox[B[1]], sbox[B[2]], sbox[B[3]]]

  # print(hex(sbox[w[1]]), hex(sbox[w[2]]), hex(sbox[w[3]]), hex(sbox[w[0]]))

  Round_constant = [RC[round] , 0x00, 0x00,0x00]
  w_prime = np.array(B_prime) ^ np.array( Round_constant)
  return np.array(w_prime)

def key_for_next_round(w0,w1,w2,w3,round):
  """
  w0,w1,w2,w3: 1D numpy array each having 4 elements (4 bytes)
  round: current round
  """
  gout = g_function(w3,round);
  w_prime_0 = gout ^ w0
  w_prime_1 = w_prime_0 ^ w1
  w_prime_2 = w_prime_1 ^ w2
  w_prime_3 = w_prime_2 ^ w3
  return w_prime_0, w_prime_1, w_prime_2, w_prime_3
w1 = [1,2,3,4]
w2 = [5,6,7,8]
w3 = [9,0,9,8]
w4 = [7,6,5,4]
w1,w2,w3,w4 = np.array(key_for_next_round(w1,w2,w2,w4,1))
# for i in w1:
#   print(hex(i))

#parameters
TOTAL_ROUNDS = 10 #for AES-128 block chiper

def generate_key_matrix(key):
    """
    input:
        key:  128 bit integer (msut contain 32 digits)
    output:
        state_array: 4x4 matrix of integers
    """
    key = str(key)
    if len(key) != 16:
        print("Invalid key length")
    else:
        rows = 4
        columns = 4
        total_chars = rows * columns
        key_padded = key + ' ' * (total_chars - len(key))
        state_array = [[int(key_padded[i * columns + j]) for j in range(columns)] for i in range(rows)]
        return state_array

# KEY = 1234567890987654  # Wrap key in quotes to keep it as a string
# key_matrix = generate_key_matrix(KEY)
# print(key_matrix)

def generate_KEY(key):
  """
  input:
   key_text: 1D array
  output:
   round_key: 1D np.array containing 11 elements
  """
  round_key = [0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0]
  if(len(str(key))<16):
    print("Invalid Key length: Minimum letters should be 16 for AES128")
  else:

    w = generate_key_matrix(key)
    # round-0
    round_key[0] = np.array(w,dtype = np.uint8)

    # round-1
    w4,w5,w6,w7 = key_for_next_round(w[0],w[1],w[2],w[3],1)
    round_key[1] =np.array( [ w4,w5,w6,w7 ] )

    #round-2
    w8,w9,w10,w11 = key_for_next_round(w4,w5,w6,w7,2)
    round_key[2] =np.array( [ w8,w9,w10,w11 ] )

    #round-3
    w12,w13,w14,w15 = key_for_next_round(w8,w9,w10,w11,3)
    round_key[3] =np.array( [ w12,w13,w14,w15 ] )

    #round-4
    w16,w17,w18,w19 = key_for_next_round(w12,w13,w14,w15,4)
    round_key[4] =np.array( [ w16,w17,w18,w19 ] )

    #round-5
    w20,w21,w22,w23 = key_for_next_round(w16,w17,w18,w19,5)
    round_key[5] =np.array( [ w20,w21,w22,w23 ] )

    # round-6
    w24,w25,w26,w27 = key_for_next_round(w20,w21,w22,w23,6)
    round_key[6] =np.array( [ w24,w25,w26,w27 ] )

    #round-7
    w28,w29,w30,w31 = key_for_next_round(w24,w25,w26,w27,7)
    round_key[7] =np.array( [ w28,w29,w30,w31 ] )

    #round-8
    w32,w33,w34,w35 = key_for_next_round(w28,w29,w30,w31,8)
    round_key[8] =np.array( [ w32,w33,w34,w35  ] )

    #round-9
    w36,w37,w38,w39 = key_for_next_round(w32,w33,w34,w35,9)
    round_key[9] =np.array( [ w36,w37,w38,w39] )

    #round-10
    w40,w41,w42,w43 = key_for_next_round(w36,w37,w38,w39,10)
    round_key[10] =np.array( [ w40,w41,w42,w43 ] )

  return np.array(round_key)


#testing the KEY Generator
KEY = 1234567890987654
ROUND_KEY = generate_KEY(KEY)
print(ROUND_KEY)
