# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# The following lines were added by compinstall
# ==== Oh My Zsh core ====
export ZSH="$HOME/.oh-my-zsh"

# Use Powerlevel10k theme (you already cloned it into ~/.oh-my-zsh/custom/themes)
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins (add more later if you want)
plugins=(git)

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Load Powerlevel10k config if it exists (created by `p10k configure`)
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# ==== Completion options (from compinstall) ====
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' max-errors 2 numeric
zstyle :compinstall filename "$HOME/.zshrc"
# NOTE: we do NOT call `compinit` here; oh-my-zsh already does it.


# ==== Node via nvm ====
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# User-level scripts (pip, etc.)
export PATH="$HOME/.local/bin:$PATH"

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' max-errors 2 numeric
zstyle :compinstall filename '/home/orson-dev/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

ZSH_THEME="agnoster"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
export PATH="HOME/.local/bin:$PATH"
# export PATH="$HOME/anaconda3/bin:$PATH"  # commented out by conda initialize

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/orson-dev/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/orson-dev/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/orson-dev/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/orson-dev/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

