#!/bin/sh

volume() {
	volstat="$(pamixer --get-volume-human)"
	volicon=""
	volcol="\x03"
	[ "$volstat" = "muted" ] && volicon="" && volcol="\x04"
	echo "$volcol $volicon $volstat"
}

cpu() {
	read cpu a b c previdle rest < /proc/stat
	prevtotal=$((a+b+c+previdle))
	sleep 0.05
	read cpu a b c idle rest < /proc/stat
	total=$((a+b+c+idle))
	cpu="$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))"
	echo "$cpu%"
}

memory() {
	free --si -h | awk '/Mem:/ { print $3 }'
}

battery() {
	battery_perc="$(acpi | grep -Eo '[0-9]+\%' | cut -d'%' -f1)"

	battery_icon="BAT"
	battery_color='\x02'

	if [ "$battery_perc" -gt "90" ]; then
		battery_icon="" ;
	elif [ "$battery_perc" -gt "60" ]; then
		battery_icon="" ;
	elif [ "$battery_perc" -gt "40" ]; then
		battery_icon="" ;
	elif [ "$battery_perc" -gt "20" ]; then
		battery_icon="" ;
	elif [ "$battery_perc" -gt "0" ]; then
		battery_icon="" ;
	fi

	if [ "$battery_perc" -lt "25" ]; then
		battery_color='\x04' ;
	fi

	echo "${battery_color} ${battery_icon} ${battery_perc}%"
}

datetime() {
	date '+ %A, %b %d \x02  %H:%M:%S'
}

while true; do
	stat="$(volume) \x02  $(cpu) \x03  $(memory) $(battery) \x03 $(datetime) "
	# Use the bash echo
	xsetroot -name "$(/bin/echo -en "$stat")"
	sleep 1;
done
