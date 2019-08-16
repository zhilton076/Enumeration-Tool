#!/bin/bash

#Author: Zack Hilton
#Created on: 7/23/2019

#This program is meant to take parse subnets from 
#core switch program and screenshot all hosts services
#on ports 80 and 443.

# inform user of program start
echo "[+] Network Screenshot tool started...."
echo "[+] This can take a very long time..."

# get file
input="/root/EnumerationTool/WebCapture/scanInput.txt"


# change directory
cd /root/EnumerationTool/WebCapture/screenshots/


# loop file
while IFS= read -r line
do
	echo $line
	nmap -Pn -p 80 --script=default,http-screenshot $line -oA mnap_test_sh
done < "$input"

