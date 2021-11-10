#! /bin/bash

# script to echo out the values of the command line arguments
echo $1 # $0 is actually the script name itself
echo "Enbed the value of $2 in text"
echo "The number of arguments passed are $#"
echo "Here are all arguments: $@. We can iterate over this"

