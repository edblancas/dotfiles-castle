# PATH
export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk-11.jdk/Contents/Home"
# Maven 3.2.5, last to support Java 6
export M2_HOME="$SDKMAN_DIR/candidates/maven/current"
export M2="$M2_HOME/bin"
# local apps installed like vim from github
export HOME_LOCAL="$HOME/local"
# Homebrew binaries, the paths are not exclusive of homebrew!
export HOMEBREW="/usr/local"
export HOMEBREW_COREUTILS="/usr/local/opt/coreutils/libexec"

YARN="$HOME/.yarn/bin"

export PATH="$JAVA_HOME/bin:$M2:$HOMEBREW_COREUTILS/gnubin:$HOMEBREW/bin:/opt/local/bin:/opt/local/sbin:$PATH:$YARN"

# rustup
export PATH="$HOME/.cargo/bin:$PATH"

export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:/opt/local/share/man:$MANPATH"

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# BIN HOME
export PATH="$HOME/bin:$PATH"

export GOPATH="$HOME/opt/go"
export PATH="$PATH:$GOPATH/bin:$HOME/.cargo/bin"
