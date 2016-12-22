# PATH
export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.7.0_79.jdk/Contents/Home"
# Maven 3.2.5, last to support Java 6
export M2_HOME="$HOME/opt/apache-maven-3.2.5"
export M2="$M2_HOME/bin"
# local apps installed like vim from github
export HOME_LOCAL="$HOME/local"
# Homebrew binaries, the paths are not exclusive of homebrew!
export HOMEBREW="/usr/local"
export HOMEBREW_COREUTILS="/usr/local/opt/coreutils/libexec"
export PATH="$JAVA_HOME/bin:$HOME_LOCAL/bin:$M2:$HOMEBREW_COREUTILS/gnubin:$HOMEBREW/bin:/opt/local/bin:/opt/local/sbin:$PATH"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:/opt/local/share/man:$MANPATH"

