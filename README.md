# Enumeration-Tool

This tool is a Kali Linux based framework designed for the purposes of enumerating a given network for live hosts, open ports, and web services runnning. The tool also has other functions built in for enumeration, pentesting, file conversion, and database storage.

# Options:

- Network Enumeration:

      1) Scan current subnet for hosts and services.

      2) Scan current subnet hosts.

      3) DNS Zone Transfer on a target domain.

      4) Pull VLAN informaiton from switch + scan all VLANs.

      5) Screenshot all network hosts' running web services.
  
- Vulnerability Scanning:

      6) Scan server/domain for vulnerabilities.

      7) Scan target IP + port for ftp vulnerabilities.

      8) Scan web service/app for directories and filenames.

      9) Passive sniffing for interesting files.

- File Conversion:

      10) Convert a file from XML to CSV.

      11) Convert a file from TXT to CSV.

      12) Convert a file from XML to HTML.

- Searching:

      13) Quick search a CSV file.

- Database:

      14) Start ElasticSearch and Kibana.

      15) Upload Nmap CSV file to Elastic.

      0) Exit Program
  
# Dependecies
- OS:
    1. Kali Linux
    
 - Linux packages:
    Uses all preinstalled Kali tools.
  
Full Installations: 
    1. ElasticSearch 
    2. Logstash
    3. Kibana

 - Python Packages:
    1. paramiko
    2. pykeyboard
    2. netmiko
    3. getpass
    4. re
    5. nmap
      
