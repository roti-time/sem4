#include <stdio.h>

// Define op codes as constants or an enum
enum OpCode {
    ADD = 0,    // Addition
    SUB = 1,    // Subtraction
    LOAD = 2,   // Load from memory
    STORE = 3,
    HALT = 5,  // Store to memory
    JMP = 4     // Jump to a different instruction
};

// Define a data structure (e.g., an array) to represent memory
#define MEMORY_SIZE 100
int memory[MEMORY_SIZE];

int choice = 1;

// Define CPU registers
int accumulator = 0; // A special register for arithmetic operations
int programCounter = 0; // Keeps track of the currently executing instruction

// Define sample programs
int program1[] = {ADD, 5, SUB, 3, LOAD, 10, HALT};
int program2[] = {LOAD, 30, ADD, 10, ADD, 10, HALT};

// Function to execute an instruction
void executeInstruction(int opcode, int operand) {
    switch (opcode) {
        case ADD:
            accumulator += operand;
            break;
        case SUB:
            accumulator -= operand;
            break;
        case LOAD:
            accumulator = memory[operand];
            break;
        case STORE:
            memory[operand] = accumulator;
            break;
        case JMP:
            programCounter = operand;
            break;
        default:
            printf("Invalid opcode: %d\n", opcode);
            break;
    }
}

int main() {
    	//this loop runs through both codes:
	for(int i=0; i<=1; i++){
	
		if(i==1){
			// Initialize memory with the first program (program1)
        		for (int i = 0; i<sizeof(program1); i++) {
		            memory[i] = program1[i];
            
        		}
        		
			// Reset CPU registers
       			accumulator = 0;
		        programCounter = 0;

		        //printf("Run %d:\n", i);
		        printf("sizeof(program1) == %lu \n",sizeof(program1));

		        // Execute the fetch-decode-execute cycle
		        while (programCounter < sizeof(program1)) {
       	
		            int opcode = memory[programCounter];
		            printf("\nprogram counter == %d\n", programCounter);
		            printf("opcode = %d\n", opcode);
            
		            if(opcode == 5){
		            	printf("\n	in HALT, breaking function\n\n");
		            	break;
		            }
            
		            int operand = memory[programCounter + 1];
		            printf("operand = %d\n", operand);
            
		            // Print the state before executing the instruction
		            printf("Before: PC=%d ACC=%d MEM[%d]=%d\n", programCounter, accumulator, operand, memory[operand]);
            
            
	            	executeInstruction(opcode, operand);
            
	            	// Print the state after executing the instruction
		            printf("After:  PC=%d ACC=%d MEM[%d]=%d\n\n", programCounter, accumulator, operand, memory[operand]);
            
		            programCounter += 2; // Move to the next instruction
				}
			}
		else{
		
			// Initialize memory with the first program (program1)
        		for (int i = 0; i<sizeof(program2); i++) {
		            memory[i] = program2[i];
            
        		}
        		
			// Reset CPU registers
        		accumulator = 0;
		        programCounter = 0;

        		//printf("Run %d:\n", i);
        		printf("sizeof(program2) == %lu \n",sizeof(program2));
        		// Execute the fetch-decode-execute cycle
        		while (programCounter < sizeof(program2)) {
       
        		    int opcode = memory[programCounter];
        		    printf("\nprogram counter == %d\n", programCounter);
        		    printf("opcode = %d\n", opcode);
            
		            if(opcode == 5){
 		           	printf("in HALT, breaking function\n\n");
 		           	break;
 		           }
 	           
        		    int operand = memory[programCounter + 1];
        		    printf("operand = %d\n", operand);
            
        		    // Print the state before executing the instruction
        		    printf("Before: PC=%d ACC=%d MEM[%d]=%d\n", programCounter, accumulator, 	operand, memory[operand]);
            
 		           executeInstruction(opcode, operand);
            
 		           // Print the state after executing the instruction
 		           printf("After:  PC=%d ACC=%d MEM[%d]=%d\n\n", programCounter, accumulator, operand, memory[operand]);
            
 		           programCounter += 2; // Move to the next instruction
			}
		}
	
        
        }
        
        printf("\n");

    return 0;
}

