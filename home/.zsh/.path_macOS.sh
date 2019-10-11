# PATH

# Java Home default to version 8 at the begining. Use this cause it can differ from
# one mac to another (rappi, personal, 13"). And cause the 1.8 is the more used.
export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
# Maven 3.2.5, last to support Java 6
export M2_HOME="$SDKMAN_DIR/candidates/maven/current"
export M2="$M2_HOME/bin"
# local apps installed like vim from github
export HOME_LOCAL="$HOME/local"
# Homebrew binaries, the paths are not exclusive of homebrew!
export HOMEBREW="/usr/local"
export HOMEBREW_COREUTILS="/usr/local/opt/coreutils/libexec"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# yarn via script
export PATH="$JAVA_HOME/bin:$M2:$HOMEBREW_COREUTILS/gnubin:$HOMEBREW/bin:$HOMEBREW/sbin:/opt/local/bin:/opt/local/sbin:$PATH"

# rustup
export PATH="$HOME/.cargo/bin:$PATH"

export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:/opt/local/share/man:$MANPATH"

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# BIN HOME
export PATH="$HOME/bin:$PATH"

export GOPATH="$HOME/opt/go"
export PATH="$PATH:$GOPATH/bin:$HOME/.cargo/bin"

export SDKMAN_DIR="$HOME/.sdkman"

export NVM_DIR="$HOME/.nvm"
