import optparse
import re
import subprocess
import typing


class ReturnArguments(typing.Dict):
    interface: str
    new_mac: str


def get_arguments() -> ReturnArguments:
    parser = optparse.OptionParser()
    parser.add_option('-i', '--interface', dest='interface', help='Interface to change the MAC address.')
    parser.add_option('-m', '--mac', dest='new_mac', help='New MAC address.')
    (options, arguments) = parser.parse_args()

    if not options.interface:
        parser.error('[-] Please specify a interface, use --help for more info.')
    elif not options.new_mac:
        parser.error('[-] Please specify a new MAC address, use --help for more info.')

    return options


def change_mac(interface: str, new_mac: str) -> None:
    print(f'[+] Changing MAC address for {interface} to {new_mac}')
    subprocess.call(['ifconfig', interface, 'down'])
    subprocess.call(['ifconfig', interface, 'hw', 'ether', new_mac])
    subprocess.call(['ifconfig', interface, 'up'])


def get_current_mac(interface: str) -> str:
    ifconfig_result = subprocess.check_output(['ifconfig', interface])
    mac_address_search_result = re.search(r'\w\w:\w\w:\w\w:\w\w:\w\w:\w\w', ifconfig_result.decode('utf-8'))

    if mac_address_search_result:
        return mac_address_search_result.group(0)
    else:
        print('[-] Could not read MAC address')
        exit(1)


def validate_interface(interface: str) -> None:
    ifconfig_result = subprocess.check_output(['ifconfig'])
    possible_interfaces = re.findall(r'^(?! ).*:', ifconfig_result.decode('utf-8'), re.M)
    print(possible_interfaces)

    if interface not in [possible_interface.rstrip(':') for possible_interface in possible_interfaces]:
        print('[-] Interface not found')
        exit(1)


if __name__ == '__main__':
    options = get_arguments()

    validate_interface(options.interface)

    curr_mac = get_current_mac(options.interface)
    print(f'Current MAC is {curr_mac}')

    change_mac(options.interface, options.new_mac)

    curr_mac = get_current_mac(options.interface)
    print(f'Current MAC is {curr_mac}')

    if curr_mac == options.new_mac:
        print(f'[+] MAC address was successfully changed to {curr_mac}')
    else:
        print('[-] MAC address was not changed')
        exit(1)
