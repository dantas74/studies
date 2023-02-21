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
