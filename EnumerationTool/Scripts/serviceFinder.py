#!/usr/bin/python3

"""
 Author: Zack Hilton
 Date: 5/30/19
 
 The purpose of this program is to search through the
 enumartion script's output for hosts running unauthorized services
 pose of this program is to search through the\nenumartion script's output for hosts running unauthorized services"
	 
"""
import re

# prompt user for file
file = input("Enter csv file name you wish to search: ")
file = "/root/EnumerationTool/Data/" + file
# intialize answer variable
answer = "start"
while answer != "x":
	
	# prompt user for service
	answer = input("Enter keyword to quick search(x to exit): ")

	# cast to str
	str(answer)

	# call method to quick search
	with open(file) as search:
		for line in search:
			line = line.rstrip()
			if answer in line:
				print(line)
	
		
		
