Text Writer README

Welcome to the Spell Checker project! This program helps you check the spelling of words in a given input text. It utilizes shared memory and subprocesses to execute a spell-checking script.
Compilation

To compile the program, follow these steps:

    Clone the repository to your local machine.
    Compile the code using the following command:

gcc textwriter.c -o textwriter

Make the spellchecker.sh script executable by running the following command:

    chmod +x spellchecker.sh

    Ensure that you have the necessary dependencies installed: gcc, bash, and a C standard library.

Usage

    Run the program by executing:

    ./spellchecker

    You will be prompted to enter the text you want to check for spelling errors. Type in your text and press Enter.
    The program will utilize the spell-checking script (spellchecker.sh) to analyze your input. It will display any misspelled words found in your text.
    The original input text and the list of misspelled words will be displayed in the console.

Spell Checker Bash Script

The spell-checking script spellchecker.sh is an integral part of the program. It uses an algorithm to compare the input text against a list of known misspelled words. The script is automatically executed by the C program to perform the spell-checking process.
Example
applescript

Enter text for spell checking: This is a sampel text with misspelled words.

Original input:
This is a sampel text with misspelled words.

Misspelled words:
sampel

Known Issues

    The current implementation only displays the first misspelled word found in the input text, even if there are multiple misspelled words in the misspelled_words.txt file. Unfortunately, this issue couldn't be resolved at the moment.
    The program assumes that the misspelled_words.txt file exists in the same directory as the executable. Make sure to place it there, or modify the code to provide the correct path to the file.

