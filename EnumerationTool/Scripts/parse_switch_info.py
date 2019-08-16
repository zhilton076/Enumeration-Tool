#!/usr/bin/python3
"""

Author: Zack Hilton
Date of Creation: 6/20/2019

This program is designed to parse the output
of the core switch pull script and put the 
vlan information neatly into a spreadsheet.

"""

import re
import datetime

# grab current time for timestamp
current_time = datetime.datetime.now()

# open script output file
file = open("/root/EnumerationTool/Data/switchParse.txt", "r")
outFile = open("/root/EnumerationTool/Data/parse_switch_info.csv", "w+")

# print csv structure header
outFile.write("Switch model,Switch IP,VLAN ID,Timestamp" + "\n")

# open file and get ip (change to switch command later)
s = open("/root/EnumerationTool/Data/ipStore.txt")
ip = s.readline()
ip.strip() # strip newline char

# get switch model
switch = "Dell HPE 5130 4SFP 1-slot switch"

# initialize array for array storage
vlan = []

# open switchparse to get data for csv conversion
f = open("/root/EnumerationTool/Data/switchParse.txt", "r")

# parse vlan information
for line in file:
	if re.match(r"interface Vlan", line):
		vlan.append(line)

	# This will need to be changed for the core switch.
	if re.findall(r"Aruba ", line):
		switch.append(line)
file.close()

# strip newline chars at each line
for x in range(len(vlan)):
	vlan[x] = vlan[x].strip()

# error handling loop to format into csv
try:
	for x in range(len(vlan)):
		outFile.write(switch + ",")
		outFile.write(ip.rstrip() + ",")
		outFile.write(vlan[x] + ",")
		outFile.write(str(current_time) + "\n")
except IndexError:
		print("Index Errors")






#for x in range(len(switch)):
#	switch[x] = switch[x].strip()


