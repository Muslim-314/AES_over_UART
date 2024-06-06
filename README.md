# AES-128 in UART 

This project demonstrates secure communication using AES encryption over UART. It involves implementing the AES algorithm in Verilog, complemented by a CRC16 module for data validation, and an open-source UART core for serial data transmission. Data integrity is ensured by computing a CRC16 checksum for a 112-bit data block, appending it, and then encrypting the combined data. The encrypted data is converted from parallel to serial form, transmitted in 8-bit packets, received, converted back to parallel form, decrypted, and validated using the CRC16 checksum, ensuring secure and reliable data communication.



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
## Source Files
- `AES_in_UART/TOP_Tx.v`: transmitter top-level core
- `AES_in_UART/TOP_Rx.v`: receiver top-level core
- `AES_in_UART/core.v`  : test module to test the whole system 


## Results
![image](https://github.com/Muslim-314/AES_over_UART/blob/main/images/OUTPUT.png)
[source](https://github.com/Muslim-314/AES_over_UART/blob/main/AES_in_UART/core.v)

## References
TimRudy's [UART Core](https://github.com/TimRudy/uart-verilog?tab=readme-ov-file) <br />
Gourav Saini's [Medium Article](https://medium.com/@imgouravsaini/aes-algorithm-and-its-hardware-implementation-on-fpga-a-step-by-step-guide-2bef178db736)  <br />
AES Encryption [Wikipedia Article](https://en.wikipedia.org/wiki/Advanced_Encryption_Standard)  <br />
[Publication](https://informationsecurity.report/Resources/Whitepapers/1a0d13d0-83b3-46f3-b9b0-31c06caab19d_Implementation%20of%20AES%20Algorithm%20in%20UART%20Module%20for%20Secure%20Data%20Transmission.pdf) by M. RAMAKRISHNA and JAGAN MOHAN RAO  <br />
Ben Eater's [CRC16 Hardware Implementation](https://www.youtube.com/watch?v=sNkERQlK8j8&t=2809s&ab_channel=BenEater)

