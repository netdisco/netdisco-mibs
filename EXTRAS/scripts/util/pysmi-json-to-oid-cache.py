#!/usr/bin/env python3

import sys
import json

'''
Makes netdisco-mibs oids cache from a pysmi JSON representation of a MIB.

Standard input to standard output.
'''

data = json.load(sys.stdin)
module = data['meta']['module']

for value in data.values():
    if not('name' in value and 'oid' in value):
        continue
    
    leaf = value['name'].replace('_','-')
    description = value.get('description', '')

    # .1.3.6.1.6.3.10.3.1.1,SNMP-FRAMEWORK-MIB::snmpFrameworkMIBCompliance,,,,,,The description...
    print(f".{value['oid']},{module}::{leaf},,,,,,{description}")
