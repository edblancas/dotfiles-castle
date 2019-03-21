# PATH
export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_201.jdk/Contents/Home"
# Maven 3.2.5, last to support Java 6
export M2_HOME="$SDKMAN_DIR/candidates/maven/current"
export M2="$M2_HOME/bin"
# local apps installed like vim from github
export HOME_LOCAL="$HOME/local"
# Homebrew binaries, the paths are not exclusive of homebrew!
export HOMEBREW="/usr/local"
export HOMEBREW_COREUTILS="/usr/local/opt/coreutils/libexec"

YARN="$HOME/.yarn/bin"

export PATH="$JAVA_HOME/bin:$M2:$HOMEBREW_COREUTILS/gnubin:$HOMEBREW/bin:$HOMEBREW/sbin:/opt/local/bin:/opt/local/sbin:$PATH:$YARN"

# rustup
export PATH="$HOME/.cargo/bin:$PATH"

export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:/opt/local/share/man:$MANPATH"

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# BIN HOME
export PATH="$HOME/bin:$PATH"

export GOPATH="$HOME/opt/go"
export PATH="$PATH:$GOPATH/bin:$HOME/.cargo/bin"

[[ -s /usr/local/share/autojump/autojump.zsh ]] && source /usr/local/share/autojump/autojump.zsh

export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# fzf autocompletition for zsh
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#source $HOME/.zsh/.ng-completion
