#!/usr/bin/python3
import random
machineid = ''.join(random.choices('0123456789abcdef', k=32))
print(machineid)
