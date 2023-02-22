#!/bin/bash

## Sees the host for IP
nslookup 1.2.3.4

## Get nameservers for DNS
dig example.com -t ns

## Get email servers for DNS
dig example.com -t mx

## DNS zone transfer
dig axrf example.com @second.ns.com

## Checks DNS subdomains, to populate with more entries for brute force just enter data to /usr/share/dnsenum/dns.txt
dnsenum example.com

## Checks if directory is present in provided host
dirb https://example.com /usr/share/dirb/wordlists/common.txt

## Use Sn1per to get open source intelligence (OSINT) and more reco information
sniper -t scanme.nmap.org -o -re

## Checks open source intelligence (OSINT) using bing limiting 200 results
theHarvester -d example.com -l 200 -b bing -s

## Detects hosts in same network and send them to results.txt
nmap -sn -n 192.168.0.0/16 | grep 192 | cut -d ' ' -f 5 > /vagrant/results.txt

## Checks which ports are open in
nmap -iL /vagrant/results.txt

## Checks if ports 21, 22 and 23 are open in local network
nmap -iL /vagrant/results.txt -p 21-23

## Makes remote host as proxy to the rest of network
sudo nmap -P0 -sI opened.host.ip.port another.host.ip.range

## Scan ports in Decoy mode, by simulating that all hosts in flag made port scan in host
nmap 192.168.15.1 -D 192.168.74.47

## Check which FTP service is running
ftp host.ip.address.without-port

## Uses Netcat to connect via port 80 in HTTP
nc host.ip.address.connection 80
HEAD -> Get the HEAD of connection
GET / -> Get the index of site

## Fingerprint analysis with nmap
sudo nmap -O host.ip.address # Checks OS fingerprint
nmap -sV host.ip.address # Checks Service fingerprint
nmap -A host.ip.address # Checks detailed Service fingerprints

## Runs Nmap scripts (mostly used in attacks)
nmap host.ip.address -p 25 --script script-name # Scripts are in /usr/share/nmap/scripts
nmap host.ip.address -p 25 --script --script-args arg-name=arg-value script-name # How run with arguments

## Sample scripts to enum
nmap host-range -p 25 --script banner
nmap host-range --script nfs-ls
nmap host-range --script smb-enum-shares
nmap host-range --script mysql-info
nmap host-range --script smtp-enum-users
nmap host-range --script ftp-anon
