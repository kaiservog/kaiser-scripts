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
	cpu_temp=`sensors | grep -oP "Package id 0:\s*\+\K(\d*\.\d.C)"`

	echo -e "💻 $cpu% [$cpu_temp]"
}

mem(){
	mem=`free | awk '/Mem/ {printf "%d/%d\n", $3 / 1024.0, $2 / 1024.0 / 1024.0}'`
	echo -e "🖪 $mem"
}

btc() {
	saida=`curl -s https://www.mercadobitcoin.net/api/BTC/ticker | jq -r '.ticker.sell' | cut -d . -f 1`
	echo -e "₿ $saida"
}

batt() {
	msg=`cat /tmp/batt.log`
	echo -e "cel: $msg%"
}

LOOPS=0
BTC=$(btc)

while true; do
	LOOPS=$((LOOPS+1))
	xsetroot -name " $(batt) | $BTC | $(cpu) | $(mem) | $(dte)"
	sleep 10s

	if [ LOOPS=60 ]
	then
		BTC=$(btc)
		LOOPS=0	
	fi
done &
