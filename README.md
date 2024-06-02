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


## Transmitter State Machine

| Signal       | RESET  | LOAD   | LoadByteToUDR | START_UART_Tx | WAIT_DONE | CHECK_EMPTY | IDEL  | default |
|--------------|--------|--------|---------------|---------------|-----------|-------------|-------|---------|
| `hold`       | 1      | 1      | 0             | 1             | 1         | 1           | 1     | -       |
| `EnTx`       | 0      | 0      | 1             | 1             | 1         | 0           | 0     | -       |
| `tx_start`   | 0      | 0      | 0             | 1             | 0         | 0           | 0     | -       |
| `PISO_reset` | 1      | 0      | 0             | 0             | 0         | 0           | 1     | -       |
| `en_crc`     | 1      | 1      | 1             | 1             | 1         | 1           | 1     | -       |
| `PISO_load`  | 0      | 1      | 0             | 0             | 0         | 0           | 0     | -       |
| `EN_UDR`     | 0      | 0      | 0             | 1             | 1         | 0           | 0     | -       |
| `Next State` | start ? LOAD : IDEL | LoadByteToUDR | START_UART_Tx | WAIT_DONE | Done ? CHECK_EMPTY : WAIT_DONE | PISO_empty ? IDEL : LoadByteToUDR | start ? LOAD : IDEL | RESET  |

Note:
- `-` indicates the signal value is not specified in the `default` state and will fall back to `RESET`.



