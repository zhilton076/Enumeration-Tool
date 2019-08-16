#!/usr/bin/python3

"""
Author: Zack Hilton
Date of Creation: 6/10/2019

This program is designed to parse a spreadsheet
containing network vlans, then use the results 
to nmap the network.
"""

import re
import nmap

# initialization
ips = []

# open vlan file, store in v
infile = open("/root/EnumerationTool/Data/parse_to_txt.txt", "r")

# open file for nmap results
outFile = open("/root/EnumerationTool/Data/fullNmapResults.csv", "w+")

# nmap handling
nm = nmap.PortScanner()

# iterate through the file, scanning each IP range
for line in infile:

	# check if description field
	if re.match(r" description", line):
		outFile.write(line)

	# find IP addresses in line, pull, and add /24 to end
	if re.findall(r"\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b", line):
		target = re.findall(r"\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b", line)
		target = target[0].rstrip()
		# remove last octect and add .0 and /24
		target = (".".join(target.split('.')[0:-1])) + ".0" + "/28"

		# check if subnet already scanned, if not, scan.
		if target in ips:
			print("already scanned: " + target)

		# This is a one case scenario...need a better fix (ignores last four IPs in conf.)
		elif len(ips) >= 105:
			print("max subnets reached")

		else:
			# scan IP
			print("scanning: " + target)
			nm.scan(hosts='' + target, arguments='')
			print(nm.command_line())
			# print(nm.scan(target.rstrip()))
			# write results to file
			print('Scan of ' + target + ' subnet Finshed...')
			print(nm.csv()) , print('\n')
			outFile.write(nm.csv())		
			# append to array (first three octets.)
			ips.append(target)

# close file
outFile.close()
print('Number of subnets scanned: ', end = ''), print(len(ips))

# cycle ip print
print('Subnets Listed: ')
for x in range(len(ips)):
	print(ips[x])

# open outfile and loop to delete extra headers.
f = open("/root/EnumerationTool/Data/fullNmapResults.csv", "r")
lines = f.readlines()
f.close()

f = open("/root/EnumerationTool/Data/fullNmapResults.csv", "w")
count = 0
for line in lines:
	if count == 0:
		f.write(line)
		count = count + 1
	#elif re.findall(r"host", line) and count > 0:
	#	print("nope")
	else:
		f.write(line)
	


#print(re.sub(r'.*10', '10', line))
#nm.scan(re.sub(r'.*10', '10', line), '22-443')
#outFile.write(nm.csv())
# waste of time
'''		if target.startswith('1') == False:
			print("hello")
			print(target)
			target = re.su
			print(target)
			#nm.scan(target)
			#outFile.write(nm.csv())
		else:
			target = target + "/24"
			print(target)
			#nm.scan(target)
			#outFile.write(nm.csv())
outFile.close()
'''
