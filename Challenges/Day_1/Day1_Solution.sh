#!/bin/bash 

# The "shebang," or initial line of the file, instructs the interpreter which shell to use when running this script. 
# Since the bash shell will be used in this script, the first line refers to the bash shell at /bin/bash.


# Comments are used in bash scripts to offer explanations or turn off specific sections of code. 
# You must write a bash script that includes comments outlining what it does.



# PRINTING THE STANDARD OUTPUT:
# "echo" command tells the shell to print the output that was given within the double quotation marks.

echo "HELLO WORLD"



# VARIABLES IN SHELL SCRIPTING :
# A variable is a character string to which we assign a value.

First_name="Rahul"
Last_name="Pradhan"
age="23"

# printing the value of the variables using echo command.
echo "My name is $First_name $Last_name and I am $age years old."



# READING INPUT FROM USER: 

read -p "first number: " num1
read -p "second number: " num2 
sum=$(($num1 + $num2))
echo "The sum is $sum."



#USING BUILD-IN VARIABLES:

echo "My current bash path: $BASH"
echo "Bash version I am using: $BASH_VERSION"
echo "PID of bash I am running: $$"
echo "Home directory of current user: $HOME"
echo "Present working directory of current user: $PWD"



# WILDCARDS:
echo "searching files with .sh extension"
ls .sh
