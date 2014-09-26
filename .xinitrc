#/home/ville/.detect_screens &
#sleep .5
xrdb /home/ville/.Xresources &
setxkbmap fi &
feh --bg-scale /home/ville/.background.jpg &
unclutter &
#sh /home/ville/bin/bar_status.sh |bar -p -f  "-misc-termsyn.icons-medium-*-normal-*-12-*-*-*-c-*-*-*" 
exec i3
