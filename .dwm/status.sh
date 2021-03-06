#!/bin/sh

trap 'update' 5

volume() {
	volstat="$(pamixer --sink 0 --get-volume-human)"
	volicon=""
	volcol="\x02"
	[ "$volstat" = "muted" ] && volicon="" && volcol="\x04"
	echo " $volicon $volstat $volcol"
}

temp() {
	tempcolor="\x03"
	temp="$(sensors -u -j 2>/dev/null | jq '.["coretemp-isa-0000"]["Core 0"]["temp2_input"]' | cut -d. -f1)"

	if [ "$temp" -ge "60" ] ; then
		tempcolor="\x04" ;
	fi

	echo " $temp°C $tempcolor"
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
	acpiout="$(acpi)"
	battery_perc="$(echo "$acpiout" | grep -Eo '[0-9]+\%' | cut -d'%' -f1)"

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

	$(echo "$acpiout" | grep -qi " charging") && battery_color='\x01'

	echo "${battery_icon} ${battery_perc}% ${battery_color}"
}

calendar() {
	echo -n ' '
	calcurse -Q --days 1 | grep -e '->' | wc -l
}

datetime() {
	date '+ %a %b %d \x03  %H:%M '
}

update() {
	stat="$(volume) $(temp)   $(cpu) \x02  $(memory) \x03 $(battery) $(datetime)\x02 $(calendar)\x03"
	xsetroot -name "$(/bin/echo -en "$stat")"
}

while true; do
	update ;
	sleep 3s &
	wait
done
