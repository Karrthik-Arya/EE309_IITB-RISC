This project was made by
-- Karrthik Arya   200020068
-- Kaishva Shah    200020066
-- Ronil Mandavia  20D180020
-- Siddhant Das    20D070075

IITB-RISC-22 is a 16-bit microprocessor having 64 bytes of data memory and 64 bytes of instruction memory.
instructions can be given to the processor using the memory.vhd file in which the instructions can be 
directly fed into the instruction memory array. the output after the entire code has finished running 
can be seen in the RTL simulation. 

Owing to the fixed encoding in RISC architecture we have made the PC move 2 bytes at a time.
To command the PC to stop we added an additional state with state id 111111 which serves as an 
equivalent to here: jmp here instruction used in assembly level language. 

The instruction register IR stores the current instruction. Eight 16-bit registers from R0-R8 were implemented 
using an array. The writing operation for all memory elements was done on the negative clock edge. Sign extender
and shifters are used as required to send the input to ALU to the required format. ALU was made using behavioral 
modeling and it can perform addition, subtraction, NAND, and compare operations as well as check the zero and 
carry flags. An FSM was made to control the flow of states depending on the current instruction and we have sent
the state signal to every component to control which operation is performed by them.