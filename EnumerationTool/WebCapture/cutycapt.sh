#!/bin/bash

#Author: Zack Hilton
#Created on: 7/24/2019

#This program is meant to take parse subnets from 
#core switch program and screenshot all hosts services
#on ports 80 and 443.

# get file
input="/root/EnumerationTool/WebCapture/scanInputFull.txt"

# change directory for output
cd /root/EnumerationTool/WebCapture/screenshots/


screenshot(){
	# loop file
	while IFS= read -r line
	do
		echo $line
		cutycapt --url="http://$line" --out="$line.png" --max-wait=5000 --insecure
		#nmap -Pn -p 80 --script=default,http-screenshot $line -oA mnap_test_sh
	done < "$input"

	# find and delete all blank images
	find . -size 4k -delete
}


# nmap for rdp services and grep open ports
rdpScan(){
cd ..
nmap -p 3389 --script rdp-enum-encryption 10.138.89.0/24 -oA /root/EnumerationTool/Data/rdpScan > /dev/null
grep "open" /root/EnumerationTool/Data/rdpScan.gnmap
}


# ssh scan
sshScan(){
cd ..
nmap -Pn -p 22 10.138.89.0/24 -oA /root/EnumerationTool/Data/sshScan > /dev/null
grep "open" /root/EnumerationTool/Data/sshScan.gnmap
}

# options menu
######################################################################
/bin/echo -e "\e[1;33mOPTIONS MENU\e[0m"
echo "------------------------------------------------------"
echo "1.	Screenshot network hosts"
echo "2.	Scan for open rdp ports."
echo "3.	Scan for open ssh ports."
echo "0. 	Exit Program"
echo "------------------------------------------------------"
######################################################################


# prompt for input
printf "Select desired option\e[0m: "

# read user option input
read option

# handle options, calls functions 
case "${option}"
	in
	    1) screenshot ;;
		2) rdpScan ;;
		3) sshScan ;;
		0) false ;;
	esac





