#!/usr/bin/bash

`xset +fp /usr/share/fonts/local`
`xset fp rehash`
# Define the clock
Clock() {
        DATE=$(date "+%a %b %d, %T")

        echo -n "$DATE"
}

# Print the clock

while true; do
        echo -e "%{c}\u00B8 $(Clock)%{F-}"
        sleep 1;
done
