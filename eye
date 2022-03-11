#!/usr/bin/env python3

from src.main import *
from datetime import datetime
from lib import colors,banner

print(banner.banner)
if __name__ == '__main__':
	while True:
		try: 
		    thelordseye(args)
		    break
		except KeyboardInterrupt:
		    if args.verbose:
		    	print(f'\n{colors.white}[{colors.red}x{colors.white}] Process interrupted with {colors.red}Ctrl{colors.white}+{colors.red}C{colors.reset}')
		    	break
		    break
			
		except Exception as e:
		    if args.verbose:
		        print(f'{colors.white}[{colors.red}!{colors.white}] Error: {colors.red}{e}{colors.reset}')
		        
	if args.verbose:
		print(f'{colors.white}[{colors.green}-{colors.white}] Stopped in {colors.green}{datetime.now()-start_time}{colors.white} seconds.{colors.reset}')
