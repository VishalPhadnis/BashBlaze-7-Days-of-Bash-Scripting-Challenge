#!/bin/bash

#Task 1 - Comments

#Comments in shell scripting provide explanatory notes for code.
#They are ignored during execution. 
#Write using the "#" symbol.

#Task2 - Echo
#Echo command is use to print the text on terminal
#Sytax of command - echo text to print
echo "Hello world ! This is a message printed with the 'echo' command."

#Task3 - Variables
#Variables are used to store and manipulate data.
#They are represented by names that start with a dollar sign ($). 
#Variables can hold strings, numbers, or any other data type.
#Syntax- variable_name=value

day1_solution=1

#Task4 - Using Variables
#To access the value of a variable, use $ followed by the variable name:
#Syntax - echo $variable_name

echo $day1_solutions

echo # Prompt the user for the first number
read -p "Enter the first number: " num1

# Prompt the user for the second number
read -p "Enter the second number: " num2

# Calculate the sum
sum=$((num1 + num2))

# Print the result
echo "The sum of $num1 and $num2 is: $sum"


#Task5- Using Built-in Variables
#In addition to regular variables, shell scripting also provides built-in variables that carry useful information

# Bash script using built-in variables to display information

# Display the current user's name
echo "Current user: $USER"

# Display the current working directory
echo "Current directory: $PWD"

# Display the host name of the system
echo "Host name: $HOSTNAME"

#Task-6 Wildcards
#In shell scripting, wildcards (also known as globbing patterns) are special characters used to match filenames and paths in a flexible and concise manner. 
#They allow you to select multiple files or directories based on a pattern rather than specifying each name individually.

#Common wildcards are:

#1. `*` (Asterisk): Matches any sequence of characters (including none).
 #  Example: `file*` matches files starting with "file."

#2. `?` (Question Mark): Matches any single character.
 #  Example: `f?le` matches "file," "fule," but not "fle."

#3. `[ ]` (Square Brackets): Matches any single character specified within the brackets.
 #  Example: `f[ae]le` matches "fale" and "fele" but not "file."

#4. `[ - ]` (Range): Matches any single character within a range specified in the brackets.
 #  Example: `file[0-9]` matches "file0," "file1," up to "file9."

#5. `[^ ]` (Negation): Matches any single character not specified within the brackets.
#   Example: `file[^0-9]` matches "filea," "fileb," but not "file1."

#Wildcards are mainly used in commands like `ls`, `cp`, `mv`, and others when dealing with multiple files or directories that share a common pattern.

#For example:

# List all files starting with "document" and having any extension
echo "List all files starts wit document  in the current directory:"
ls document*
echo "list Files with .txt in the current directory:"
ls *.txt

# Copy all files with .txt extension to the "backup" directory
#cp *.txt backup/

# Delete all files with names ending in ".bak"
#rm *.bak


#Remember that wildcards are expanded by the shell before the command is executed, so the actual files that match the pattern will be used as arguments to the command. Be cautious when using wildcards to avoid unintended consequences.















