
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

#!/bin/sh
export ZDOTDIR=$HOME/.config/zsh
HISTFILE=~/.zsh_history
setopt appendhistory

# prevernt conda-auto activate 
conda config --set auto_activate_base false

# Some useful options (man zshoption)
# {...}


# Beeping is annoying
unsetopt BEEP


# Completions
# {...}


# Syntax Highlighting Colors: https://github.com/zsh-users/zsh-syntax-highlighting/issues/464
# Declare the variable
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[suffix-alias]="fg=blue,underline"
ZSH_HIGHLIGHT_STYLES[precommand]="fg=blue,underline"
ZSH_HIGHLIGHT_STYLES[arg0]="fg=blue"


# source user-defined functions file, so that we can use it here
source "$ZDOTDIR/zsh-functions"


# source file using user-defined function "zsh_add_file"
zsh_add_file "zsh-exports"
zsh_add_file "zsh-aliases"
#zsh_add_file "zsh-prompt"



# source Plugins using "zsh_add_plugin"
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"


# activate powerlevel10k
source '/opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme' # powerlevel10k might change its installation, so just keep the path correct


# history setup for commands (like nvim/vim)
HISTFILE=$HOME/.zsh_history
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# bind keys for scrolling up & down
# e.g. >> vim [up/down key]
# then it scrolls the history with specific command prefix
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward


