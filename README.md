# UART-verification-circuit
In the circuit, the USB-serial port of the Basys3 board is connected to the serial port of a PC. When 
we send a character from the PC, the received data word is stored in the UART receiver's fourword FIFO buffer. When retrieved (via the r_data port), the data word is incremented by 1 and 
then sent back to the transmitter (via the w_data port). The debounced pushbutton switch produces 
a single one-clock-cycle tick when pressed and it is connected to the rd_uart and wr_uart signals. 
When the tick is generated, it removes one word from the receiver's FIFO and writes the 
incremented word to the transmitter's FIFO for transmission. 
