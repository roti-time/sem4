Instruction Simulator README

Welcome to the Instruction Simulator project! This program simulates the execution of a simple CPU with defined op codes and memory layout. It includes two sample programs to demonstrate the functionality.
Compilation

To compile and run the program, follow these steps:

    Copy the provided code into a file called instruction_simulator.c.
    Open a terminal and navigate to the directory where instruction_simulator.c is located.
    Compile the code using the following command:

gcc instruction_simulator.c -o instruction_simulator

Run the program by executing:

    ./instruction_simulator

Outputs

The program will execute two separate runs, each with a different sample program. Here's an explanation of the output you will see:

    The size of the program being executed is displayed to indicate the number of op codes and operands in the program.
    The program counter (PC) indicates the index of the currently executing instruction in the memory.
    The opcode and operand of the current instruction are displayed.
    Before executing the instruction, the state of the program is printed, including the values of the program counter, accumulator (ACC), and memory operand.
    The instruction is then executed using the executeInstruction function.
    After executing the instruction, the updated state of the program is printed, showing the new values of the program counter, accumulator, and memory operand.
    The program counter is incremented by 2 to move to the next instruction.
    The execution continues until a HALT opcode is encountered, at which point the program terminates.

Op Codes

Op codes are represented as constants or an enum in the code. Here's a description of the available op codes:

    ADD (0): Performs addition. Adds the value of the operand to the accumulator.
    SUB (1): Performs subtraction. Subtracts the value of the operand from the accumulator.
    LOAD (2): Loads a value from memory. Sets the accumulator to the value stored in the memory at the operand index.
    STORE (3): Stores a value in memory. Sets the value in the memory at the operand index to the value in the accumulator.
    JMP (4): Jumps to a different instruction. Sets the program counter to the operand value.
    HALT (5): Halts the program execution.

Memory Layout

The memory is represented as an array in the code. The MEMORY_SIZE constant defines the size of the memory. Each element in the memory array stores an op code or an operand value.
Sample Programs

The program includes two sample programs (program1 and program2) to demonstrate the CPU execution. Here's a brief description of each program:

    program1: Performs addition, subtraction, loading, and halting. It showcases the basic functionality of the CPU.
    program2: Loads a value from memory, performs addition, and halts. It demonstrates the use of memory operations.

