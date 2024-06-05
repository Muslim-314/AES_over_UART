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
![image1](https://github.com/Muslim-314/AES_over_UART/blob/main/images/State_Machine.png)

| **State**      | **hold** | **EnTx** | **tx_start** | **PISO_reset** | **en_crc** | **PISO_load** | **EN_UDR** | **Next State** |
|----------------|----------|----------|--------------|----------------|------------|---------------|------------|----------------|
| RESET          | 1'b1     | 1'b0     | 1'b0         | 1'b1           | 1'b1       | 1'b0          | 1'b0       | (start) ? LOAD : IDEL |
| LOAD           | 1'b1     | 1'b0     | 1'b0         | 1'b0           | 1'b1       | 1'b1          | 1'b0       | LoadByteToUDR  |
| LoadByteToUDR  | 1'b0     | 1'b1     | 1'b0         | 1'b0           | 1'b1       | 1'b0          | 1'b0       | START_UART_Tx  |
| START_UART_Tx  | 1'b1     | 1'b1     | 1'b1         | 1'b0           | 1'b1       | 1'b0          | 1'b1       | WAIT_DONE      |
| WAIT_DONE      | 1'b1     | 1'b1     | 1'b1         | 1'b0           | 1'b1       | 1'b0          | 1'b1       | (Done) ? WAIT_UNDONE : WAIT_DONE |
| WAIT_UNDONE    | 1'b1     | 1'b1     | 1'b0         | 1'b0           | 1'b1       | 1'b0          | 1'b1       | (!Done) ? CHECK_EMPTY : WAIT_UNDONE |
| CHECK_EMPTY    | 1'b1     | 1'b0     | 1'b0         | 1'b0           | 1'b1       | 1'b0          | 1'b0       | PISO_empty ? IDEL : LoadByteToUDR |
| IDEL           | 1'b1     | 1'b0     | 1'b0         | 1'b1           | 1'b1       | 1'b0          | 1'b0       | start ? LOAD : IDEL |
| default        | -        | -        | -            | -              | -          | -             | -          | RESET          |


.
## Complete Tx Core
![image](https://github.com/Muslim-314/AES_over_UART/blob/main/images/Tx.jpeg)

## Complete Rx Core
![image](https://github.com/Muslim-314/AES_over_UART/blob/main/images/Rx.jpeg)

## Results
![image](https://github.com/Muslim-314/AES_over_UART/blob/main/images/WAVE_OUTPUT.png)

