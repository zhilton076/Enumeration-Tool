#!/usr/bin/python3
"""

Author: Zack Hilton
Date of Creation: 6/11/2019

This program is designed to parse the output
of the core switch pull for the vlan information.

"""

import re
import sys


# open script output file
file = open("/root/EnumerationTool/Data/core_conf_utf8.txt", "r")
outFile = open("/root/EnumerationTool/Data/parseToTxt.txt", "w+")


# parse vlan information
for line in file:
	if re.match(r"interface Vlan", line):
		outFile.write(line)
		for x in range(15):
			if re.match(r"monitor session", str(line)):
				break
			else:
				outFile.write(next(file))

# grab lines of file and remove last ten
#f = open('/root/EnumerationTool/Data/parseToTxt.txt', 'r')
#lines = f.readlines()
#lines = lines[:-10]

# rewrite lines into file without last 10
#f = open("/root/EnumerationTool/Data/parseToTxt.txt", "w+")
#for line in lines:
#	f.write(line.rstrip())

		



