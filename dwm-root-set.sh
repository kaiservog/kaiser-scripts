#!/bin/sh

dte() {
	echo -e "$(date +%d/%m/%Y) $(date +%H:%M)"
}

cpu(){
	read cpu a b c previdle rest < /proc/stat
 	prevtotal=$((a+b+c+previdle))
	sleep 0.5
	read cpu a b c idle rest < /proc/stat
	total=$((a+b+c+idle))
	cpu=$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))
	echo -e "💻 $cpu%"
}

mem(){
	mem=`free | awk '/Mem/ {printf "%d/%d\n", $3 / 1024.0, $2 / 1024.0 / 1024.0}'`
	echo -e "🖪 $mem"
}

btc() {
	saida=`curl -s https://www.mercadobitcoin.net/api/BTC/ticker | jq -r '.ticker.sell' | cut -d . -f 1`
	echo -e "₿$saida"
}

URL=xxx
TOKEN=xxx

batt() {
	saida=`curl -s -w "|%{http_code}" -H "Authorization: $TOKEN" $URL`
	estado=`echo $saida | rev | cut --complement -c 4- | rev`

	if [ $estado -eq 200 ]
	then
		msg=`echo $saida | rev | cut -c 5- | rev`
		msg=`echo $msg | grep -Eo '[0-9]{1,4}'`
		echo "$msg" > /tmp/batt.log
	else
		msg=`cat /tmp/batt.log`
	fi
	echo -e "cel: $msg%"
}

LOOPS=0
BTC=$(btc)

while true; do
	LOOPS=$((LOOPS+1))
	xsetroot -name "$(batt) | $BTC | $(cpu) | $(mem) | $(dte)"
	sleep 10s

	if [ LOOPS=60 ]
	then
		BTC=$(btc)
		LOOPS=0	
	fi
done &
