#include <iostream>
#include <string>
#include <ctime>
#include <cstdlib>
#include <cmath>
using namespace std;

long add(long a, long b) // function to add two numbers when opcode is 2
{
    return a + b;
}
long sub(long a, long b) // function to subtract two numbers when opcode is 3
{
    return a - b;
}
long mul(long a, long b)
{
    return a * b;
}

int main()
{
    long memory[10] = {0};
    long opcodePC[10] = {505, 302, 606, 504, 605, 505, 201, 404, 609, 100};
    // 100 = terminate this operation and move to the next
    // 2 = add
    // 3 = sub
    // 4 = mul
    // 5 = load
    // 6 = store
    srand(time(0));
    for (long i = 0; i < 10; i++)
    {
        memory[i] = rand() % 50;
    }
    long IR = 0; // INSTRUCTION REGISTER
    long AC = 0; // ACCUMULATOR REGISTER

    for (long i = 0; i < sizeof(opcodePC); i++)
    {
        IR = opcodePC[i];
        if (IR == 100)
        {
            cout << "Terminate the next operation" << endl
                 << endl;
            i++;
            break;
        }
        else
        {
            long opcode = IR / 100;
            long operand = IR % 100;
            if (opcode == 2)
            {
                cout << "Program counter is: " << i << endl;
                cout << "OpCode is: " << opcode << endl;
                cout << "Operand memory Locations is: " << operand << endl;
                AC = add(AC, memory[operand]);
                cout << "Addition of memory[" << operand << "] and AC is " << AC << endl
                     << endl;
                cout << "Memory after the operation" << endl;
                for (long i = 0; i < 10; i++)
                {
                    cout << memory[i] << " ";
                }
            }
            else if (opcode == 3)
            {
                cout << "Program counter is: " << i << endl;
                cout << "OpCode is: " << opcode << endl;
                cout << "Operand memory Locations is: " << operand << endl;

                AC = sub(AC, memory[operand]);
                cout << "Subtraction of memory[" << operand << "] and AC is " << AC << endl
                     << endl;
                     cout << "Memory after the operation" << endl;
                for (long i = 0; i < 10; i++)
                {
                    cout << memory[i] << " ";
                }
            }
            else if (opcode == 4)
            {
                cout << "Program counter is: " << i << endl;
                cout << "OpCode is: " << opcode << endl;
                cout << "Operand memory Locations is: " << operand << endl;
                AC = mul(AC, memory[operand]);
                cout << "Multiplication of memory[" << operand << "] and AC is " << AC << endl
                     << endl;

                     cout << "Memory after the operation" << endl;
                for (long i = 0; i < 10; i++)
                {
                    cout << memory[i] << " ";
                }
            }
            else if (opcode == 5)
            {
                cout << "Program counter is: " << i << endl;
                cout << "OpCode is: " << opcode << endl;
                cout << "Operand memory Locations is: " << operand << endl;
                AC = memory[operand];
                cout << "Load the value of memory[" << operand << "] to AC is " << AC << endl
                     << endl;

                     cout << "Memory after the operation" << endl;
                for (long i = 0; i < 10; i++)
                {
                    cout << memory[i] << " ";
                }
            }
            else if (opcode == 6)
            {
                cout << "Program counter is: " << i << endl;
                cout << "OpCode is: " << opcode << endl;
                cout << "Operand memory Locations is: " << operand << endl;
                memory[operand] = AC;
                cout << "Store the value of AC to memory[" << operand << "] is " << memory[operand] << endl
                     << endl;

                     cout << "Memory after the operation" << endl;
                for (long i = 0; i < 10; i++)
                {
                    cout << memory[i] << " ";
                }
            }
        }
    }
    cout << "Memory after the operations" << endl;
    for (long i = 0; i < 10; i++)
    {
        cout << memory[i] << " ";
    }
    return 0;
}