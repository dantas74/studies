#!/usr/bin/env python

import subprocess

subprocess.call('ifconfig eth2 down', shell=True)
subprocess.call('ifconfig eth2 hw ether 74:74:74:74:74:74', shell=True)
subprocess.call('ifconfig eth2 up', shell=True)
