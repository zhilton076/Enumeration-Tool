#!/usr/bin/python3
"""

Author: Zack Hilton
Date of Creation: 6/19/19

This program is designed to parse switch information
including SW model, IP address, subnet mask, and timsestamp
and convert information to csv for importing into ES.

"""

import re
import datetime

# read in file for parsing
file = open("/root/EnumerationTool/Data/core_conf_utf8.txt", "r")

# create output file
outFile = open("/root/EnumerationTool/Data/switchParse.txt", "w+")

# Get IP from first line of file
'''ip = file.readline()
outFile.write(ip)'''    # this needs a better method

# open file and parse information
for line in file:
	# look for sw model (vendor command not executed yet)
	#if re.match(r'Vendor', line):
	#	line = re.sub(r'.*A', 'Aruba', line)
	#	outFile.write(line)
	# attempt vlan grab
	if re.match(r"interface Vlan", line):
		outFile.write(line)

# record time
currentTime = str(datetime.datetime.now())

# write time to file
outFile.write(currentTime)


