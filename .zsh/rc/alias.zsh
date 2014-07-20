#alias mydf="df -hPT | column -t"
alias ls="ls --color"
alias ll="ls -lah"
alias rm="rm -i"
alias cp="cp -i"
# alias ls="ls -G"
alias l="ls -ail"
#alias cl="clear"
#alias unlda="launchctl unload -w /Syste/Library/LaunchAgents/"
#alias unldd="launchctl unload -w /Syste/Library/LaunchDaemons/"
#alias reboot="shutdown -r now"
#alias getbat="./.zsh/rc/getbat"
alias pi="DISPLAY=pi:0"

# do a du -hs on each dir on current path
alias lsdir="for dir in *;do;if [ -d \$dir ];then;du -hsL \$dir;fi;done"

if [ -x /usr/libexec/mc/mc-wrapper.sh ]
then
	alias mc='. /usr/libexec/mc/mc-wrapper.sh'
fi

