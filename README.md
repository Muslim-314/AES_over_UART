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

| State         | hold | EnTx | tx_start | PISO_reset | en_crc | PISO_load | EN_UDR | Next State                     |
|---------------|------|------|----------|------------|--------|-----------|--------|--------------------------------|
| RESET         | 1    | 0    | 0        | 1          | 1      | 0         | 0      | start ? LOAD : IDEL            |
| LOAD          | 1    | 0    | 0        | 0          | 1      | 1         | 0      | LoadByteToUDR                  |
| LoadByteToUDR | 0    | 1    | 0        | 0          | 1      | 0         | 1      | START_UART_Tx                  |
| START_UART_Tx | 1    | 1    | 1        | 0          | 1      | 0         | 1      | WAIT_DONE                      |
| WAIT_DONE     | 1    | 1    | 0        | 0          | 1      | 0         | 1      | Done ? CHECK_EMPTY : WAIT_DONE |
| CHECK_EMPTY   | 1    | 0    | 0        | 0          | 1      | 0         | 0      | PISO_empty ? IDEL : LoadByteToUDR |
| IDEL          | 1    | 0    | 0        | 1          | 1      | 0         | 0      | start ? LOAD : IDEL            |
| default       | -    | -    | -        | -          | -      | -         | -      | RESET                          |

.
## Complete Tx Core
![image](https://github.com/Muslim-314/AES_over_UART/blob/main/images/Tx.jpeg)

## Complete Rx Core
![image](https://github.com/Muslim-314/AES_over_UART/blob/main/images/Rx.jpeg)

## Results
![image](https://github.com/Muslim-314/AES_over_UART/blob/main/images/Outputwave.png)

