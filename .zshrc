# Functions
fpath=($HOME/.zsh/functions $fpath)

autoload -U zutil
autoload -U compinit
autoload -U complist
autoload -U colors

bindkey '\e[A' history-search-backward
bindkey '\e[B' history-search-forward
bindkey '^K' kill-whole-line
bindkey "\e[H" beginning-of-line        # Home (xorg)
bindkey "\e[1~" beginning-of-line       # Home (console)
bindkey "\e[4~" end-of-line             # End (console)
bindkey "\e[F" end-of-line              # End (xorg)
bindkey "\e[2~" overwrite-mode          # Ins
bindkey "\e[3~" delete-char             # Delete
bindkey '\eOH' beginning-of-line
bindkey '\eOF' end-of-line

# Activation
compinit
colors

# Resource files
for file in $HOME/.zsh/rc/*.zsh; do
	source $file
done

# Prompts
export "PROMPT=
%{$fg[blue]%}%m %{$fg[red]%}$ %{$reset_color%}"
export "RPROMPT=%{$fg[red]%}%~%f%b"

case $TERM in
    xterm*|*rxvt*)
        precmd () {print -Pn "\e]0;%n@%m: %~\a"}
        ;;
esac

if [ -x /usr/libexec/path_helper ]; then
	eval `/usr/libexec/path_helper -s`
fi

#eval `dircolors /home/ville/.config/dircolors.256dark`
eval `dircolors $HOME/.zsh/solarized_dircolors`
export TERM=xterm-256color
