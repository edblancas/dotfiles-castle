# Maven 3.2.5, last to support Java 6
set -x M2_HOME $HOME/opt/apache-maven-3.2.5
set -x M2 $M2_HOME/bin

# gnu is for use coreutils by default, like gls is ls
# /opt/local is for mac ports
set -x PATH /usr/local/opt/coreutils/libexec/gnubin /opt/local/bin /opt/local/sbin $M2 $PATH
set -x MANPATH /usr/local/opt/coreutils/libexec/gnuman /opt/local/share/man $MANPATH

set -x TERM xterm-256color

# Enable color in grep
set -x GREP_OPTIONS '--color=auto'
set -x GREP_COLOR '3;33'

set -x PAGER 'less'
set -x EDITOR 'nvim'

# vi mode
fish_vi_key_bindings
# Force mode prompt, issue 47
set -g __fish_vi_mode 0

bass (gdircolors $HOME/.dircolors/dircolors-solarized/dircolors.ansi-dark)

[ -f /usr/local/share/autojump/autojump.fish ]; and source /usr/local/share/autojump/autojump.fish

string match -q "$TERM_PROGRAM" "kiro" and . (kiro --locate-shell-integration-path fish)

# Added by LM Studio CLI (lms)
set -gx PATH $PATH /Users/daniel.blancas/.lmstudio/bin
# End of LM Studio CLI section

