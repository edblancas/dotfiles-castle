# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="ys"

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
plugins=(git common-aliases mvn vundle gitfast git-extras github sudo vi-mode web-search wd)

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

# Alias
alias ghm='cd ~/Documents/Glider/Multicurrency/GitHub/multicurrency'
alias ghfp='cd ~/Documents/Glider/Multicurrency/GitHub/FinancialPlatform'

# Para mac ports
export MANPATH=/opt/local/share/man:$MANPATH
export PATH=/opt/local/bin:/opt/local/sbin:$PATH

if [ "$TERM" != "dumb" ]; then
    export LS_OPTIONS='--color=auto'
    eval `gdircolors ~/.dir_colors`
fi

# Useful aliases
alias ls='gls $LS_OPTIONS -hF'
alias ll='gls $LS_OPTIONS -lhF'
alias l='gls $LS_OPTIONS -lAhF'
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
#M2_HOME=/usr/local/Cellar/maven/3.2.1
#M2=$M2_HOME/bin

# Maven 2
export M2_HOME=/Users/dan/Desktop/apache-maven-2.2.1
export M2=$M2_HOME/bin

#### COMMON STUFF ####
function gi() { curl http://www.gitignore.io/api/$@ ;}

# Home bin's
export PATH=${PATH}:${HOME}/bin
