# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#  ____   _
# |_  /__| |_  _ _ __   - exoess
#  / /(_-< ' \| '_/ _|  - https://github.com/exoess/MyDots
# /___/__/_||_|_| \__|  - My zsh config

# __   __
# \ \ / /_ _ _ _ ___
#  \ V / _` | '_(_-<
#   |_|\__,_|_| /__/
export VISUAL='geany'
export EDITOR='nvim'
export TERMINAL='alacritty'
export BROWSER='google-chrome-stable'
export HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"

if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi

#  _                 _   ___           _
# | |   ___  __ _ __| | | __|_ _  __ _(_)_ _  ___
# | |__/ _ \/ _` / _` | | _|| ' \/ _` | | ' \/ -_)
# |____\___/\__,_\__,_| |___|_||_\__, |_|_||_\___|
#                                |___/
autoload -Uz compinit

for dump in ~/.config/zsh/zcompdump(N.mh+24); do
  compinit -d ~/.config/zsh/zcompdump
done

compinit -C -d ~/.config/zsh/zcompdump

autoload -Uz add-zsh-hook
autoload -Uz vcs_info
precmd () { vcs_info }
_comp_options+=(globdots)

zstyle ':completion:*' verbose true
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS} 'ma=48;5;197;1'
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:warnings' format "%B%F{red}No matches for:%f %F{magenta}%d%b"
zstyle ':completion:*:descriptions' format '%F{yellow}[-- %d --]%f'
zstyle ':vcs_info:*' formats ' %B%s-[%F{magenta}%f %F{yellow}%b%f]-'

# __      __    _ _   _             ___      _
# \ \    / /_ _(_) |_(_)_ _  __ _  |   \ ___| |_ ___
#  \ \/\/ / _` | |  _| | ' \/ _` | | |) / _ \  _(_-<
#   \_/\_/\__,_|_|\__|_|_||_\__, | |___/\___/\__/__/
#                           |___/
expand-or-complete-with-dots() {
  echo -n "\e[31m…\e[0m"
  zle expand-or-complete
  zle redisplay
}
zle -N expand-or-complete-with-dots
bindkey "^I" expand-or-complete-with-dots
#  _  _ _    _
# | || (_)__| |_ ___ _ _ _  _
# | __ | (_-<  _/ _ \ '_| || |
# |_||_|_/__/\__\___/_|  \_, |
#                        |__/
HISTFILE=~/.config/zsh/zhistory
HISTSIZE=5000
SAVEHIST=5000

#  ____   _       ___          _    ___       _   _
# |_  /__| |_    / __|___  ___| |  / _ \ _ __| |_(_)___ _ _  ___
#  / /(_-< ' \  | (__/ _ \/ _ \ | | (_) | '_ \  _| / _ \ ' \(_-<
# /___/__/_||_|  \___\___/\___/_|  \___/| .__/\__|_\___/_||_/__/
#                                       |_|
setopt AUTOCD              # change directory just by typing its name
setopt PROMPT_SUBST        # enable command substitution in prompt
setopt MENU_COMPLETE       # Automatically highlight first element of completion menu
setopt LIST_PACKED		   # The completion menu takes less space.
setopt AUTO_LIST           # Automatically list choices on ambiguous completion.
setopt HIST_IGNORE_DUPS	   # Do not write events to history that are duplicates of previous events
setopt HIST_FIND_NO_DUPS   # When searching history don't display results already cycled through twice
setopt COMPLETE_IN_WORD    # Complete from both ends of a word.

#  _____ _          ___                    _
# |_   _| |_  ___  | _ \_ _ ___ _ __  _ __| |_
#   | | | ' \/ -_) |  _/ '_/ _ \ '  \| '_ \  _|
#   |_| |_||_\___| |_| |_| \___/_|_|_| .__/\__|
#                                    |_|

#  ___ _           _
# | _ \ |_  _ __ _(_)_ _  ___
# |  _/ | || / _` | | ' \(_-<
# |_| |_|\_,_\__, |_|_||_/__/
#            |___/
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

#   ___ _                         _____              _           _      _____ _ _   _
#  / __| |_  __ _ _ _  __ _ ___  |_   _|__ _ _ _ __ (_)_ _  __ _| |___ |_   _(_) |_| |___
# | (__| ' \/ _` | ' \/ _` / -_)   | |/ -_) '_| '  \| | ' \/ _` | (_-<   | | | |  _| / -_)
#  \___|_||_\__,_|_||_\__, \___|   |_|\___|_| |_|_|_|_|_||_\__,_|_/__/   |_| |_|\__|_\___|
#                     |___/                                                     
function xterm_title_precmd () {
	print -Pn -- '\e]2;%n@%m %~\a'
	[[ "$TERM" == 'screen'* ]] && print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-}\e\\'
}

function xterm_title_preexec () {
	print -Pn -- '\e]2;%n@%m %~ %# ' && print -n -- "${(q)1}\a"
	[[ "$TERM" == 'screen'* ]] && { print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-} %# ' && print -n -- "${(q)1}\e\\"; }
}

if [[ "$TERM" == (kitty*|alacritty*|termite*|gnome*|konsole*|kterm*|putty*|rxvt*|screen*|tmux*|xterm*) ]]; then
	add-zsh-hook -Uz precmd xterm_title_precmd
	add-zsh-hook -Uz preexec xterm_title_preexec
fi

#    _   _ _
#   /_\ | (_)__ _ ___
#  / _ \| | / _` (_-<
# /_/ \_\_|_\__,_/__/
alias mirrors="sudo reflector --verbose --latest 5 --country 'United States' --age 6 --sort rate --save /etc/pacman.d/mirrorlist"

alias maintenance="yay -Sc && sudo pacman -Scc"
alias purge="sudo pacman -Rns $(pacman -Qtdq) ; sudo fstrim -av"
alias update="paru -Syu --nocombinedupgrade"

alias vm-on="sudo systemctl start libvirtd.service"
alias vm-off="sudo systemctl stop libvirtd.service"

alias ls='lsd -a --group-directories-first --icon never'
alias ll='lsd -la --group-directories-first --icon never'

alias exofetch='neofetch --config ~/.config/neofetch/exofetch/EXOfetch.conf'

#    _       _         ___ _            _
#   /_\ _  _| |_ ___  / __| |_ __ _ _ _| |_
#  / _ \ || |  _/ _ \ \__ \  _/ _` | '_|  _|
# /_/ \_\_,_|\__\___/ |___/\__\__,_|_|  \__|
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
