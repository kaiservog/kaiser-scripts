from tpb import TPB
from tpb import CATEGORIES, ORDERS

t = TPB('https://thepiratebay.org')
result = t.search('$1').order(ORDERS.SEEDERS.ASC).page(1)

for torrent in result: 

	print(torrent.description)

