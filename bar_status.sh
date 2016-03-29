#!/usr/bin/bash

# Define the clock
Clock() {
    DATE=$(date "+%a %b %d, %T")

    echo -n "$DATE"
}

Music() {
    #STATUS=$(mpc status |grep -Po "[[a-z]*]")
    CURRENT=$(mpc current)

    if [ "$CURRENT" ]
    then
        if [ "`mpc |grep 'playing'`" ]
        then
            STATUS=""
        else
            STATUS=""
        fi
        CURRENT="`mpc status|grep -m1 -Po \" [0-9].* \"` $CURRENT"
    fi

    echo -n "$STATUS $CURRENT"
}

Volume() {
    VOL=$(amixer get Master |grep -Po "[0-9]*%")

    echo -n " $VOL"
}

# Print the clock

while true; do
    echo -e "   %{F#55aaff}$(Music)%{F#fff} %{c}$(Clock)%{F#00FFFF} %{r}$(Volume)   "
    sleep 1;
done
