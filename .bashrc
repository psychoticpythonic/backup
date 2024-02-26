# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#auto startx
if [ "$(tty)" = "/dev/tty1" ]; then
    startx
fi

eval "$(zoxide init bash)"
BAT_THEME=ansi
alias rwm="bspc wm -r"
alias rhk="pkill -USR1 -x sxhkd"
alias cat="bat --theme=ansi "
alias ls='lsd'
alias lss="lsd -a"
alias grep='grep --color=auto'
alias t="tmux -f ~/.config/tmux/conf"
alias p="yay -Syu"
alias punlock="sudo rm -rf  /var/lib/pacman/db.lck"
alias brc="nano ~/.bashrc"
alias al="alias"
alias py="python"
alias sctl="sudo systemctl enable --now"
alias kpb="killall -q polybar"
alias k="killall -q"
alias cd="z"
alias e="nano -l"
alias installd="sudo pacman -Qqen"
alias l="lynx google.com --accept_all_cookies"
alias bsprc="nano /home/notroot/.config/bspwm/bspwmrc"
alias sxhrc="nano /home/notroot/.config/sxhkd/sxhkdrc"
alias yay="yay --color always"
alias kx="k Xorg"
alias bsr="bspc wm -r"

#echo "finished scripts/apps names saved w/o extension suffix & dir added to \$PATH"
#echo "ORGANISE ALL CODE INTO 1 DIR THEN \$PATH THE DIR"
#echo "\"https://www.commandlinefu.com/commands/browse/sort-by-votes/plaintext\""
#echo "ABOVE WEBSITE, CURL FOR BASH SNIPPETS"
task
echo
echo look@gitify \(github notifications for menubar\)
echo PASSWORD MANAGER. PASS INIT + UPDATE ACCOUNTS PASSWORDS \(GMAIL, TUTA, GITHUB\)


