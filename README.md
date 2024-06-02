![image](https://github.com/Muslim-314/AES_over_UART/assets/101193416/2ce4767d-ca74-4e86-bcbe-787a6012a9dd)# AES-128 in UART 
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

| State         | hold | EnTx | tx_start | PISO_reset | en_crc | PISO_load | EN_UDR | Next State                     |
|---------------|------|------|----------|------------|--------|-----------|--------|--------------------------------|
| RESET         | 1    | 0    | 0        | 1          | 1      | 0         | 0      | start ? LOAD : IDEL            |
| LOAD          | 1    | 0    | 0        | 0          | 1      | 1         | 0      | LoadByteToUDR                  |
| LoadByteToUDR | 0    | 1    | 0        | 0          | 1      | 0         | 0      | START_UART_Tx                  |
| START_UART_Tx | 1    | 1    | 1        | 0          | 1      | 0         | 1      | WAIT_DONE                      |
| WAIT_DONE     | 1    | 1    | 0        | 0          | 1      | 0         | 1      | Done ? CHECK_EMPTY : WAIT_DONE |
| CHECK_EMPTY   | 1    | 0    | 0        | 0          | 1      | 0         | 0      | PISO_empty ? IDEL : LoadByteToUDR |
| IDEL          | 1    | 0    | 0        | 1          | 1      | 0         | 0      | start ? LOAD : IDEL            |
| default       | -    | -    | -        | -          | -      | -         | -      | RESET                          |

.
## Complete Transmitter Core
![image](https://github.com/Muslim-314/AES_over_UART/assets/101193416/633bc428-7d78-4bee-a9e7-876504b1b0ff)



