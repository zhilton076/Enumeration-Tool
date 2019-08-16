/bin/echo -e "\e[34m-------------------------------------------------" ; 	echo ""
echo	"Author: Zack Hilton"
echo	"Date of Creation: 5/31/2019" ; 									echo ""

echo "This script is designed for automation of network
      enumeration using multiple tools." ; 									echo ""
echo "-------------------------------------------------" 	
																			echo ""
																			echo ""
															# echos are for spacing

# funciton to grab ip and nmap subnet
nmapScan() {
	echo "[+] Launching Nmap scan on subnet!"
	printf "[+] Enter desired output file name:" ; read outputFile
	echo $outputFile
	/sbin/ifconfig eth0 | awk '/Mask:/{print $4;} '
	nmap -T4 -F -sV $(ip -o -f inet addr show | awk '/scope global/ {print $4}') \
	-oX $ouputFile
}

# function for dns zone transfer
dnsEnum() {
	echo "[+] Launching DNS Enumeration Script!"
	printf "[+] Enter target domain: " ; read domainName
	dnsenum $domainName

}

# function to run switch pull program
switchPull(){
	echo "[+] Launching Switch Pull script!"
	#./EnumerationTool/Scripts/CoreSwitchPull.py
	echo "[+] Switch pull finished..."
	echo "[+] Starting file parsing..."
	./EnumerationTool/Scripts/switchInfo.py
	./EnumerationTool/Scripts/parseToTxt.py
	sed '/monitor session 1/,$d' EnumerationTool/Data/parseToTxt.txt > EnumerationTool/Data/parse_to_txt.txt
	rm EnumerationTool/Data/parseToTxt.txt
	./EnumerationTool/Scripts/parse_switch_info.py
	echo "[+] Parsing Finished...starting nmap on vlans..."
	echo "[+] This proccess may take a while. "
	./EnumerationTool/Scripts/parse_to_nmap.py
	echo "[+] VlAN nmapping Finshed!"
	sed "s/$/,/g" EnumerationTool/Data/parse_to_txt.txt > \
			EnumerationTool/Data/vlanTestComma.txt
	#echo "[+] File with trailing commas: vlanTestComma.txt" 
	echo "[+] All results located in EnumerationTool/Data/..."


}

# screenshot all host services
screenshot(){
#	./EnumerationTool/Scripts/screenshot.py
#	eyewtiness -f screenshotInput.txt --all-protocols
#	cd EnumerationTool/Web\ Capture/screenshots/
#	nmap -A -Pn --script=default,http-screenshot 10.138.89.0/24 -oA service_grab

	./EnumerationTool/Scripts/screenshot.py
	./EnumerationTool/WebCapture/cutycapt.sh

}

# function to scan enumerate ftp on host
ftpEnum(){
	printf "[+] Please enter target IP:" ; read ip
	printf "[+] Please enter target Port:" ; read port
	echo "[+] Launching ftp enumeration script!"
	nmap -sV -Pn -vv -p $port --script=ftp-anon,ftp-bounce,ftp-libopie,\
	ftp-proftpd-backdoor,ftp-vsftpd-backdoor,ftp-vuln-cve2010-4221 $ip
}

# function to netdiscover subnet
netdiscoverScan() {
	echo "[+] Launching netdiscover for subnet!"
	/sbin/ifconfig eth0 | awk '/Mask:/{print $4;} '
	netdiscover -r $(ip -o -f inet addr show | awk '/scope global/ {print $4}') \
	-P
	# echo "[+] Opening File!"
	# xdg-open netdiscover_scan.xml
}

# funtion to run Nikto
niktoScan() {
	echo "[+] Please enter desired hostname/server address to scan: "
	printf "hostname/IP: "
	read userInput
	echo "[+] Launching Nikto scan on web server/app!"
	nikto -h $userInput
}

# function to run Dirbuster
gobusterBrute() {
	echo "[+] Launching dirbuster!"
	echo "[+] Wordlists under /usr/share/Dirbuster/wordlists/"
	dirbuster
}

# function to launch dsniff
dsniff () {
	echo "[+] Opening new terminal and launching dsniff!"
	gnome-terminal -e dsniff
}

# function to convert xml to csv
xmlToCsv() {

	printf "Enter name of xml file: " ; read xmlFile
	printf "Enter desired name of csv File: " ; read csvFile
	python3 /root/EnumerationTool/Scripts/Nmap-Scan-to-CSV/nmap_xml_parser.py -f 		/root/EnumerationTool/Data/$xmlFile -csv /root/EnumerationTool/Data/$csvFile
	# removes extra scan fields
	sed -i 's/\Service,.*/Service/' EnumerationTool/Data/$csvFile
	# removes trailing commas
	sed -i 's/,*\r*$//' EnumerationTool/Data/$csvFile
	echo "[+] Opening File!"
	sleep 2
	xdg-open /root/EnumerationTool/Data/$csvFile
}

# function to convert txt to csv
txtToCsv() {
	printf "Enter name of txt file: " ; read txtFile
	printf "Enter desired name of csv file: " ; read csvFile
	echo "[+] Converting file from txt to csv."
	sed 's/ \+/,/g' /root/EnumerationTool/Data/$txtFile > \
	/root/EnumerationTool/Data/$csvFile 
}

# function to convert nmap xml to html
xmlToHtml(){
	echo "[+] Launching xml to html script!"
	printf "Enter nmap input file: " ; read nmapXml
	printf "Enter desired output file name: " ; read outFile 
	xsltproc /root/EnumerationTool/Data/$nmapXml -o \
	/root/EnumerationTool/Data/$outFile
	echo "[+] Opening File!"
	sleep 2
	xdg-open /root/EnumerationTool/Data/$outFile

}

# function to call search program
quickSearch() {
	echo "[+] Launching quick search!"
	./EnumerationTool/Scripts/serviceFinder.py
}

# function call elastic program
upload_to_elastic() {
	echo "[+] Launching Logstash Pipeline and sending data!"
	echo "[+] This may take a while..."
	#./csvToElasticSearch.sh
	./EnumerationTool/Scripts/logstash_to_ElasticSearch.sh 
	echo "[+] File uploaded!"
}

# function to start kibana and Elastic
start_Kib_Elas(){
	su - user /root/Downloads/elasticsearch-7.2.0/bin/./elasticsearch
	xdotool key shift+ctrl+t
	xdotool key alt+2
	/root/Downloads/kibana-7.2.0-linux-x86_64/bin/./kibana --allow-root
	
}


# options menu
######################################################################
/bin/echo -e "\e[1;33mZack's Enumeration Automation Tool\e[0m"
echo "------------------------------------------------------"
/bin/echo -e "\e[96mNetwork Enumeration: "
echo "1.	Scan subnet for hosts and services - nmap" #nmap
echo "2.	Scan subnet hosts - netdiscover" # netdiscover
echo "3. 	DNS Zone Transfer on a target domain - dnsenum" #dnsenum
echo "4.	Pull VlAN information from switch + scan all vlans" # my scripts + nmap
echo "5.	Screenshot all network hosts' services." #nmap SC script
echo "------------------------------------------------------"
echo "Vulnerability Scanning"
echo "6.	Scan server/domain for Vulns. - nikto" # nikto
echo "7. 	Scan target ip + port for ftp Vulns. - nmap" #nmap 
echo "8.	Scan web serv/app for dir + file name. dirbuster" # dirbuster
echo "9.	Passive sniffing for interesting files. - dsniff" #dsniff
echo "------------------------------------------------------"
echo "FILE CONVERSIONS: "
echo "10.	Convert a file from XML to CSV."
echo "11.	Convert a file from TXT to CSV."
echo "12. 	Convert a file from XML to HTML." 
echo "------------------------------------------------------"
echo "SEARCHING: "
echo "13.	Quick Search a CSV file."
echo "------------------------------------------------------"
echo "DATABASE: "
echo "14.	Start Elasticsearch and Kibana."
echo "15.	Upload Nmap CSV file to Elastic."
echo "------------------------------------------------------"
echo "MISC: "
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
	        1) nmapScan ;;
		2) netdiscoverScan ;;
		3) dnsEnum ;;
		4) switchPull ;;
		5) screenshot ;; 
		6) niktoScan ;;
		7) ftpEnum ;;
		8) gobusterBrute ;;
		9) dsniff ;;
		10) xmlToCsv ;;
		11) txtToCsv ;;
		12) xmlToHtml ;; 
		13) quickSearch ;;
		14) start_Kib_Elas ;;
		15) upload_to_elastic ;;
		0) false ;;
	esac

