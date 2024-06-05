# AES-128 in UART 
The repo contains an implementation of Advanced Encryption Standard 128-bit block cipher in UART for serial communication.
## Selection 
+ UART for serial communication
+ AXI Stream Interface for UART 
+ Encryption for secure transmission
  + AES encryption module
  + AES deception module
+ Cyclic Redundancy Check (CRC-16) for data validation

##  Encryption Module
![Takes 128Bit text input and generate cipher text of the same length](images/enryption.png)


# Tx State Machine 
![image1](https://github.com/Muslim-314/AES_over_UART/blob/main/images/Tx%20FSM.jpeg)


| **State**      | **hold** | **EnTx** | **tx_start** | **PISO_reset** | **en_crc** | **PISO_load** | **EN_UDR** | **Next State**                           |
|----------------|----------|----------|--------------|----------------|------------|---------------|------------|------------------------------------------|
| RESET          | 1        | 0        | 0            | 1              | 1          | 0             | 0          | (start) ? LOAD : IDEL                    |
| LOAD           | 1        | 0        | 0            | 0              | 1          | 1             | 0          | LoadByteToUDR                            |
| LoadByteToUDR  | 0        | 1        | 0            | 0              | 1          | 0             | 0          | START_UART_Tx                            |
| START_UART_Tx  | 1        | 1        | 1            | 0              | 1          | 0             | 1          | WAIT_DONE                                |
| WAIT_DONE      | 1        | 1        | 1            | 0              | 1          | 0             | 1          | (Done) ? WAIT_UNDONE : WAIT_DONE         |
| WAIT_UNDONE    | 1        | 1        | 0            | 0              | 1          | 0             | 1          | (!Done) ? CHECK_EMPTY : WAIT_UNDONE      |
| CHECK_EMPTY    | 1        | 0        | 0            | 0              | 1          | 0             | 0          | PISO_empty ? IDEL : LoadByteToUDR        |
| IDEL           | 1        | 0        | 0            | 1              | 1          | 0             | 0          | start ? LOAD : IDEL                      |
| default        | -        | -        | -            | -              | -          | -             | -          | RESET                                    |



.
## Complete Tx Core
![image](https://github.com/Muslim-314/AES_over_UART/blob/main/images/Tx.jpeg)

## Rx State Machine
![image1](https://github.com/Muslim-314/AES_over_UART/blob/main/images/Rx%20FSM.jpeg)

| **State**      | **Wr** | **EnRx** | **En_valadation** | **SIPO_reset** | **EnDec** | **Next State**                           |
|----------------|--------|----------|-------------------|----------------|-----------|------------------------------------------|
| START_RX       | 0      | 1        | 1                 | 0              | 0         | (Done) ? SIPO_WRITE : START_RX           |
| SIPO_WRITE     | 1      | 1        | 1                 | 0              | 0         | (full) ? EN_COMB : WAIT_UNDONE           |
| WAIT_UNDONE    | 0      | 1        | 1                 | 0              | 0         | (!Done) ? START_RX : WAIT_UNDONE         |
| EN_COMB        | 0      | 0        | 1                 | 0              | 1         | IDEL                                     |
| IDEL           | 0      | 0        | 1                 | 0              | 1         | (!tx_out) ? START_RX : IDEL              |
| default        | -      | -        | -                 | -              | -         | IDEL                                     |


## Complete Rx Core
![image](https://github.com/Muslim-314/AES_over_UART/blob/main/images/Rx.jpeg)

## Results
![image](https://github.com/Muslim-314/AES_over_UART/blob/main/images/WAVE_OUTPUT.png)

## References
TimRudy's [UART Core](https://github.com/TimRudy/uart-verilog?tab=readme-ov-file) 
Gourav Saini's [Medium Article](https://medium.com/@imgouravsaini/aes-algorithm-and-its-hardware-implementation-on-fpga-a-step-by-step-guide-2bef178db736)
AES Encryption [Wikipedia Article](https://en.wikipedia.org/wiki/Advanced_Encryption_Standard)
[Publication](https://informationsecurity.report/Resources/Whitepapers/1a0d13d0-83b3-46f3-b9b0-31c06caab19d_Implementation%20of%20AES%20Algorithm%20in%20UART%20Module%20for%20Secure%20Data%20Transmission.pdf) by M. RAMAKRISHNA and JAGAN MOHAN RAO

