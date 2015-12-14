# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# Favs: robbyrussell, ys
ZSH_THEME="robbyrussell"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to disable command auto-correction.
# DISABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git common-aliases mvn vundle gitfast git-extras github vim-interaction Helena Bonhamweb-search wd brew taskwarrior)

source $ZSH/oh-my-zsh.sh

# User configuration
export PATH="/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/git/bin:$HOME/rvm/bin"
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

#THIS MUST BE AT THE END OF THE FILE FOR GVM TO WORK!!!
[[ -s "$HOME/.gvm/bin/gvm-init.sh" ]] && source "$HOME/.gvm/bin/gvm-init.sh"

# Sublime Text
# alias subl='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl'
# export EDITOR='subl -w'

# MVIM
alias vim='mvim -v'
alias vi='mvim -v'
# Por que solo con la de arriba al hacer 'git commit' sigue llamando a el vim del SO
export EDITOR='mvim -v'

#### PARA QUE TOME EL VIM COMPLIADO EN ~/local/bin/
#alias vim='$HOME/local/bin/vim'
#alias vi='$HOME/local/bin/vim'
#export EDITOR='$HOME/local/bin/vim'

# Alias
#alias ghm='cd ~/Documents/Glider/Multicurrency/GitHub/multicurrency'
#alias ghfp='cd ~/Documents/Glider/Multicurrency/GitHub/FinancialPlatform'
alias ghh='cd ~/Documents/Glider/HERA/GitHub/'

# Para mac ports
export MANPATH=/opt/local/share/man:$MANPATH
export PATH=/opt/local/bin:/opt/local/sbin:$PATH

# Useful aliases
alias c="clear"
alias e="exit"
alias ssh="ssh -X"

# WildFLy Hombrew
export JBOSS_HOME=/usr/local/opt/wildfly-as/libexec
export PATH=${PATH}:${JBOSS_HOME}/bin

# Alias for rc's
alias zshconfig="mvim ~/.zsh/.osx.zshrc"
alias ohmyzsh="mvim ~/.oh-my-zsh"

# Alias for intellij para que vea todas las variables de entorno
alias open-idea='open -a /Applications/IntelliJ\ IDEA\ 13.app/'

# Maven 3
M2_HOME=/usr/local/Cellar/maven/3.2.1/libexec
M2=$M2_HOME/bin

# Maven 2
#export M2_HOME=/Users/dan/Desktop/apache-maven-2.2.1
#export M2=$M2_HOME/bin

export PATH=${HOME}/local/bin:${HOME}/.vim/bin:${PATH}:${M2}

#### COMMON STUFF ####
function gi() { curl http://www.gitignore.io/api/$@ ;}

# Home bin's and vim-s bin
#export PATH=${HOME}/local/bin

# Aliases for vim and kaleidoscope merge diff tool
alias gkdiff='git config diff.tool kaleidoscope; git difftool'
alias gvdiff='git config diff.tool mvimdiff; git difftool'
alias gkmerge='git config merge.tool kaleidoscope; git mergetool'
alias gvmerge='git config merge.tool mvimdiff; git mergetool'

# Function for plugin vim-interaction
# At the end of the callvim function we invoke the postCallVim function if it exists. 
# If you're using MacVim, for example, you could define a function that brings window focus to it 
# after the file is loaded.
function postCallVim
{
  osascript -e 'tell application "MacVim" to activate'
}

### http://dougblack.io/words/zsh-vi-mode.html ###

# Use vim cli mode
bindkey '^P' up-history
bindkey '^N' down-history

# backspace and ^h working even after
# returning from command mode
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char

# ctrl-w removed word backwards
bindkey '^w' backward-kill-word

# ctrl-r starts searching history backward
bindkey '^r' history-incremental-search-backward

# Kill the lag 
export KEYTIMEOUT=1
