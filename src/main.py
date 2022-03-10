import os
import json
import random
import logging
import argparse
import requests
from pprint import pprint
from datetime import datetime
from lib import colors, headers


class thelordseye:
	def __init__(self,args):
		if args.auth:
		    if os.path.exists('.apikey.auth') and os.path.getsize('.apikey.auth') > 0:
		        exit(f'{colors.white}[{colors.green}={colors.white}] Already authenticated!\nIf you wish to re-authenticate with another api key, delete the current {colors.green}.api_key.txt{colors.white} file first.{colors.reset}')     
		            
		    else:
		        with open('.apikey.auth', 'w') as file:
		            self.api_key = args.auth
		            file.write(self.api_key)
		            file.close()
		        exit(f'{colors.white}[{colors.green}+{colors.white}] API key stored in {colors.green}.apikey.auth{colors.white}. Re-run program{colors.reset}')
		        
		with open('.apikey.auth', 'r') as file:
		    self.api_key = file.readline().rstrip('\n')
		self.api = f"https://api.shodan.io/"
		self.headers = {"User-Agent": f"random.choice(user_agents)"}
		
		if args.query:
			self.uri = f'{self.api}shodan/host/search?query={args.query}&page=1&key={self.api_key}'
			self.query_results()
		elif args.ip:
			self.uri = f'{self.api}shodan/host/{args.ip}?key={self.api_key}'
			print(self.ip())
		else:
			exit(f'{colors.white}thelordseye: use {colors.green}-h{colors.white}/{colors.green}--help{colors.white} to show usage.{colors.green}')

				
	# Return information relating to user search query	
	def query_results(self):
		response = requests.get(self.uri).json()
		if "matches" not in response:
			print(f'{colors.white}[{colors.red}-{colors.white}] No results found for \'{args.query}\'.{colors.reset}')
		else:
			if args.raw:
				pprint(response)
			else:
				count=0
				for result in response["matches"]:
				   data = f"""{colors.white}
{result['org']}
├──╼ L o c a t i o n 
├─ Country: {colors.green}{result['location']['country_name']}{colors.white}
├─ City: {colors.green}{result['location']['city']}{colors.white}
├─ Country code: {colors.green}{result['location']['country_code']}{colors.white}
├─ Region code: {colors.green}{result['location']['region_code']}{colors.white}
├─ Area code: {colors.green}{result['location']['area_code']}{colors.white}
├─ Postal code: {colors.green}{result['location']['postal_code']}{colors.white}
├─ Longitude: {colors.red}{result['location']['longitude']}{colors.white}
├─ Latitude: {colors.red}{result['location']['latitude']}{colors.white}
├──╼ N e t w o r k 
├─ IP Address: {colors.red}{result['ip_str']}{colors.white}
├─ OS: {colors.red}{result['os']}{colors.white}
├─ Hostnames: {colors.green}{result['hostnames']}{colors.white}
├─ Domains:  {colors.green}{result['domains']}{colors.white}
├─ Port:  {colors.red}{result['port']}{colors.white}
├─ Network Layer: {colors.green}{result['transport']}{colors.white}
└╼ Banner Information: {colors.green}{result['data']}{colors.white}{colors.reset}
"""
				   count+=1
				   print(f"{colors.white}{count}/{response['total']}{colors.green}")
				   print(data)
				   
				   if args.output:
				   	self.output(data)
			    
			    
	# Get information related to target IP address
	def ip(self):
		response = requests.get(self.uri).json()
		if "data" not in response:
			print(f'{colors.white}[{colors.red}-{colors.white}] No information found for \'{args.ip}\'.{colors.green}')
		else:
			if args.raw:
				pprint(response)
			else:
				result = response['data'][0]
				data = f"""{colors.white}
{result['org']}
├──╼ L o c a t i o n 
├─ Country: {colors.green}{result['location']['country_name']}{colors.white}
├─ City: {colors.green}{result['location']['city']}{colors.white}
├─ Country code: {colors.green}{result['location']['country_code']}{colors.white}
├─ Region code: {colors.green}{result['location']['region_code']}{colors.white}
├─ Longitude: {colors.red}{result['location']['longitude']}{colors.white}
├─ Latitude: {colors.red}{result['location']['latitude']}{colors.white}
├──╼ N e t w o r k 
├─ IP Address: {colors.red}{result['ip_str']}{colors.white}
├─ OS: {colors.red}{result['os']}{colors.white}
├─ Hostnames: {colors.green}{result['hostnames']}{colors.white}
├─ Domains:  {colors.green}{result['domains']}{colors.white}
├─ Port:  {colors.red}{result['port']}{colors.white}
├─ Network Layer: {colors.green}{result['transport']}{colors.white}
└╼ Banner Information: {colors.green}{result['data']}{colors.white}{colors.reset}
"""
				if args.output:
				    self.output(data)
				return data
				    

	# Write output to a file	
	def output(self,data):
	    if args.raw:
	    	object = json.dumps(response, indent=4)
	    	with open(args.output,"a") as file:
	    		file.write(object)
	    		file.close()
	    
	    else:
	    	with open(args.output, "a") as file:
	    		file.write(data)
	    		file.close()
	    		
	    		

parser = argparse.ArgumentParser(description=f'{colors.white}thelordseye - by rly0nheart{colors.green}', epilog=f'{colors.white}thelordseye searches and returns detailed information about devices that are directly connected to the internet [IoT] (Smart TV\'s, Fridges, Webcams, Traffic Lights etc).  Developed by Richard Mwewa | https://github.com/{colors.green}rly0nheart{colors.green}')
parser.add_argument('-q', '--query',help='search query', metavar='<query>')
parser.add_argument('-i', '--ip',help='return information of a target IP', metavar='<ip>')
parser.add_argument('-o', '--output',help='write output to a file', metavar=f'<path/to/file>')
parser.add_argument('-r', '--raw',help='return results in raw json format', action='store_true')
parser.add_argument('-v', '--verbose',help='enable verbosity', action='store_true')
parser.add_argument('-a','--auth',help=' api authentication with a valid shodan.io api key',metavar='<api_key>')
args = parser.parse_args()
start_time = datetime.now()
if args.verbose:
    logging.basicConfig(format=f'{colors.white}[{colors.green}*{colors.white}] %(message)s{colors.reset}',level=logging.DEBUG)
