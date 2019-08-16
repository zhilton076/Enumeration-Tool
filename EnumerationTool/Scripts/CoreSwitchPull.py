#!/usr/bin/python3
"""

Author: Zachary Hilton
Date of Creation: 6/25/2019

This pyhton script is designed to automate the task
of connecting to the Core Switch, querying for
data, and recording the data to a file.

"""

from pykeyboard import PyKeyboard
import paramiko
import netmiko
import getpass
import time
import sys
import os

# function to connect to switch
def connect(ip, username, password):
	return netmiko.ConnectHandler(device_type = 'dell_os', ip = ip, 
				    username = username, password = password)

# file creation
file = open("/root/EnumerationTool/Data/switchInfo.txt", "w+")

# begin script
try:
	# Prompt for IP of SW
	ip = input("IP: ")

	# store ip for secondary programs
	s = open("/root/EnumerationTool/Data/ipStore.txt")
	s.write(ip)

	# prompt for username
	username = input("Username: ")

	# prompt for password:
	passwd = getpass.getpass()

	# connect to device
	connection = connect(ip, username, passwd)

	# initialaze keyboard
	keyboard = PyKeyboard()

	# send commands and record output to file
	connection.send_command('x')
	connection.send_command_timing('enable', \
						strip_command = False, strip_prompt = False)
	model = connection.send_command_timing('show dhcp client vendor-specific', \
						strip_command = False, strip_prompt = False)
	'''
	connection.send_command_timing('terminal length 1000', \
	'''						strip_command = False, strip_prompt = False)
	output = connection.send_command_timing('sho run', strip_command = False, \
						strip_prompt = False)

	# write outputs and close file
	file.write(ip)
	file.write('\n')
	file.write(model)
	file.write(output)
	file.close()

	# disconnect from device
	connection.disconnect()
	print("[+] Device Disconnected...Switch Pull executed properly.")

# catch errors...handle them
except:
	print ("Something went wrong...Restarting program.")
	print ("")
	os.execl(sys.executable, sys.executable, *sys.argv)

