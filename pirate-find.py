import sys
import re
from tpb import TPB
from tpb import CATEGORIES, ORDERS

seeking = sys.argv[1]
minSize = sys.argv[2]
scale = sys.argv[3]

if scale == 'G': scale = "GiB"
elif scale == 'M': scale = "MiB"
else: exit(1)

print('Seeking for ' + seeking)

t = TPB('https://thepiratebay.org')
result = t.search(seeking).order(ORDERS.SEEDERS.ASC).page(1)

files = []
for torrent in result: 
	match = re.match(r'.*Size ([\d\.]*?)\s(\w\w\w).*', torrent.description.text)
	if match:
		files.append({'size': match.group(1), 'scale': match.group(2)})



files = filter(lambda e: e['scale'] == scale and e['size'] >= minSize, files)

for file in files: print(file)

