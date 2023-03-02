import scapy.all as scapy


def scan(ip: str) -> None:
    scapy.arping(ip)


scan('192.168.15.1')
