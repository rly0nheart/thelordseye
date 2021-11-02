#!/usr/bin/env python3

import json
import time
import random
import logging
import argparse
import requests
from pprint import pprint
from datetime import datetime
from api.config import api_key
from lib.headers import user_agents
from lib.colors import red,white,green,reset



class thelordseye:
	def __init__(self,args):
		self.base = f"https://api.shodan.io/"
		self.headers = {"User-Agent": f"random.choice(user_agents)"}		
		
	def main(self):
		if args.query:
			self.query()
		
		elif args.ip:
			self.ip()
			
		elif args.ports:
			self.ports()
			
		else:
			exit(f"{white}thelordseye: try {green}eye -h {white}or {green}eye --help {white} to view help message.{reset}") 
	
	# Return information relating to user search query	
	def query(self):
		base = self.base + f"shodan/host/search?query={args.query}&page=1&key={api_key}"
		response = requests.get(base, headers=self.headers).json()
		if "matches" not in response:
			exit(f"{white}* information {red}not found{reset}")

		count=0
		for result in response["matches"]:
		    count+=1
		    data = f"""{white}
{args.query}
├ Total: {green}{response['total']}{white}
└╼ Result Number: {green}{count}{white}

{result['org']}
├──╼ L o c a t i o n
├─ Country: {green}{result['location']['country_name']}{white}
├─ City: {green}{result['location']['city']}{white}
├─ Country code: {green}{result['location']['country_code']}{white}
├─ Region code: {green}{result['location']['region_code']}{white}
├─ Area code: {green}{result['location']['area_code']}{white}
├─ Postal code: {green}{result['location']['postal_code']}{white}
├─ DMA code: {green}{result['location']['dma_code']}{white}
├─ Longitude: {red}{result['location']['longitude']}{white}
├─ Latitude: {red}{result['location']['latitude']}{white}
├──╼ N e t w o r k
├─ IP Address: {red}{result['ip_str']}{white}
├─ OS: {red}{result['os']}{white}
├─ Hostnames: {green}{result['hostnames']}{white}
├─ Domains:  {green}{result['domains']}{white}
├─ Port:  {red}{result['port']}{white}
├─ Network Layer: {green}{result['transport']}{white}
└╼ Banner Information: {green}{result['data']}{white}{reset}
"""
		    if args.raw:
		    	self.raw(data)
		    
		    else:
		    	print(data)
		    	
		    if args.output:
		    	self.output(data)

	# Get information related to target IP address
	def ip(self):
		base = self.base+f"shodan/host/{args.ip}?key={api_key}"
		response = requests.get(base, headers=self.headers).json()
		if "data" not in response:
			exit(f"{white}* information {red}not found{reset}")
		
		result = response['data'][0]
		data = f"""{white}
{result['org']}
├──╼ L o c a t i o n
├─ Country: {green}{result['location']['country_name']}{white}
├─ City: {green}{result['location']['city']}{white}
├─ Country code: {green}{result['location']['country_code']}{white}
├─ Region code: {green}{result['location']['region_code']}{white}
├─ Area code: {green}{result['location']['area_code']}{white}
├─ Postal code: {green}{result['location']['postal_code']}{white}
├─ DMA code: {green}{result['location']['dma_code']}{white}
├─ Longitude: {red}{result['location']['longitude']}{white}
├─ Latitude: {red}{result['location']['latitude']}{white}
├──╼ N e t w o r k
├─ IP Address: {red}{result['ip_str']}{white}
├─ OS: {red}{result['os']}{white}
├─ Hostnames: {green}{result['hostnames']}{white}
├─ Domains:  {green}{result['domains']}{white}
├─ Port:  {red}{result['port']}{white}
├─ Network Layer: {green}{result['transport']}{white}
└╼ Banner Information: {green}{result['data']}{white}{reset}
"""
		if args.raw:
			self.raw(data)
			
		else:
				print(data)
				if args.output:
				    self.output(data)
				    
				    
	# Get a list of ports that are currently being scanned by Shodan.io 
	def ports(self):
		base = self.base + f"shodan/ports?key={api_key}"
		response = requests.get(base).json()
		print(f"{white}├──╼ P o r t s")
		for port in response:
			print(f"├─ {green}{port}{white}")
		if args.raw:
			pprint(response)

	# Write output to a file	
	def output(self,data):
	    if args.raw:
	    	object = json.dumps(response, indent=4)
	    	with open(args.output,"a") as raw:
	    		raw.write(object)
	    		raw.close()
	    
	    else:
	    	with open(args.output, "a") as file:
	    		file.write(data)
	    		file.close()
	    		
	    if args.verbose:
	      print(f"\n{white}* Output written to .{green}/{args.output}{reset}")

	    	
	# Return output in raw json format    	
	def raw(self,data):
		pprint(response)
		if args.output:
			self.output(data)
			


parser = argparse.ArgumentParser(description=f"{green}The Lord's Eye{white}: IoT OSINT tool that searches for devices directly connected to the internet (Smart TV's, Fridges, Webcams, Traffic Lights, etc).  developed by {green}Richard Mwewa {white}| {green}https://github.com/{white}rlyonheart{reset}")
parser.add_argument("-q", "--query", dest="query", help=f"{white}search query; {green}if query contains spaces, put it inside quote symbols {white}' '{reset}", metavar=f"{white}QUERY{reset}")
parser.add_argument("-i", "--ip", dest="ip", help=f"{white}return information relating to specified {green} IP Address{reset}", metavar=f"{white}IP{reset}")
parser.add_argument("-p", "--ports", dest="ports", help=f"{white}return a list of {green}ports{white} that are currently being scanned by {green}Shodan.io{reset}", action="store_true")
parser.add_argument("-o", "--output", dest="output", help=f"{white}write output to a specified {green}file{reset}", metavar=f"{white}FILENAME{reset}")
parser.add_argument("-r", "--raw", dest="raw", help=f"{white}return output in raw {green}json{white} format{reset}", action="store_true")
parser.add_argument("-v", "--verbose", dest="verbose", help=f"{white}run thelordseye in {green}verbose{white} mode{reset}", action="store_true")
args = parser.parse_args()
start = datetime.now()
if __name__ == "__main__":
	while True:
		try:
		    if args.verbose:
		        logging.basicConfig(format=f"{white}* %(message)s{reset}",level=logging.DEBUG)
		    thelordseye(args).main()
		    if args.verbose:
		    	exit(f"\n{white}* Stopped in {green}{datetime.now()-start}{white} seconds.{reset}")
		    break
			
		except KeyboardInterrupt:
		    if args.verbose:
		    	exit(f"\n{white}* Interrupted with {red}Ctrl{white}+{red}C{reset}")
		    break
			
		except Exception as e:
		    if args.verbose:
		        print(f"{white}* Error: {red}{e}{reset}")
		        print(f"{white}* Retrying...{reset}")
