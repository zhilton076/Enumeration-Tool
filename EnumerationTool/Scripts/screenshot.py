#!/usr/bin/python3

"""
Author: Zack Hilton
Date of Creation: 7/17/2019

This program is designed to parse a spreadsheet
containing network vlans, then use the results 
to screenshot services running on network host machines.

lookimg at 80b
"""

import re
import nmap

# nmap handling
nm = nmap.PortScanner()

# initialization
ips = []

# open vlan file, store in v
infile = open("/root/EnumerationTool/Data/parse_to_txt.txt", "r")

# open file for nmap results
#outFile = open("/root/EnumerationTool/Eyewitness/screenshotInput.txt", "w+")
outFile = open("/root/EnumerationTool/WebCapture/scanInput.txt", "w+")
outFile2 = open("/root/EnumerationTool/WebCapture/scanInputFull.txt", "w+")

# iterate through the file, parsing to outfile
for line in infile:

	# find IP addresses in line, pull, and add /24 to end
	if re.findall(r"\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b", line):
		target = re.findall(r"\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b", line)
		target = target[0].rstrip()
		# remove last octect and add .0
		target = (".".join(target.split('.')[0:-1]))

		# check if subnet already scanned, if not, scan.
		if target in ips:
			continue
		else:

			# append to array (first three octets.)
			ips.append(target)

			# write subnet
			outFile.write(target + '.0/24' + "\n")			

			# iterate through every /24 host for each target
			for x in range (256):
				outFile2.write(str(target) + "." + str(x) + "\n")

infile.close()
outFile.close()



