# OH-MY-ZSH
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="ys"
COMPLETION_WAITING_DOTS="true"
plugins=(common-aliases mvn vi-mode zsh-syntax-highlighting history-substring-search autojump npm web-search)
# brew, brew-cask, git, gradle, jira, jsontools, osx, pip, pyenv, python, tmux (ya tengo lo que tiene), tmuxinator
# Override custom dir, inside custom themes or plugins
ZSH_CUSTOM=$HOME/.config/oh-my-zsh/custom
source $ZSH/oh-my-zsh.sh

# Specific OS PATH
case `uname` in
  Darwin)
    PATH_FILE=$HOME/.zsh/.path_macOS.sh
    ;;
  Linux)
    PATH_FILE=$HOME/.zsh/.path_linux.sh
    ;;
esac
source $PATH_FILE

# User configuration
# EXTRA
alias zshconfig="nvim $HOME/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias stmux="tmux attach -t dev || tmux new -s dev"
alias c="clear"
alias e="exit"
alias ssh="ssh -X"
alias g="git"
alias d="docker"
# Reload the shell (i.e. invoke as a login shell)
alias reload="exec $SHELL -l"
alias update_fzf="cd ~/.fzf && git pull && ./install"
alias update_dotfiles_submodules="cd ~/.homesick/repos/dotfiles-castle && git submodule update --init --recursive"

# Is replaced with fzf
bindkey '^R' history-incremental-pattern-search-backward

function nv() {
    if [ $# -eq 0 ]; then
        nvim .;
    else
        nvim "$@";
    fi;
}

# UTILS
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

#[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# EXPORTS
export EDITOR='nvim';
# For good colors in tmux
export TERM='xterm-256color'
# 10ms for key sequences, for zsh and vim
export KEYTIMEOUT=1

# Enable persistent REPL history for `node`.
export NODE_REPL_HISTORY=~/.node_history;
# Allow 32³ entries; the default is 1000.
export NODE_REPL_HISTORY_SIZE='32768';
# Use sloppy mode by default, matching web browsers.
export NODE_REPL_MODE='sloppy';

# Make Python use UTF-8 encoding for output to stdin, stdout, and stderr.
export PYTHONIOENCODING='UTF-8';

# Increase Bash history size. Allow 32³ entries; the default is 500.
export HISTSIZE='32768';
export HISTFILESIZE="${HISTSIZE}";
# Omit duplicates and commands that begin with a space from history.
export HISTCONTROL='ignoreboth';

# Prefer US English and use UTF-8.
export LANG='en_US.UTF-8';
export LC_ALL='en_US.UTF-8';

# Highlight section titles in manual pages.
export LESS_TERMCAP_md="${yellow}";

# Don’t clear the screen after quitting a manual page.
export MANPAGER='less -X';

# FUNCTIONS

# Create a new directory and enter it
function mkd() {
	mkdir -p "$@" && cd "$_";
}

# Determine size of a file or total size of a directory
function fs() {
	if du -b /dev/null > /dev/null 2>&1; then
		local arg=-sbh;
	else
		local arg=-sh;
	fi
	if [[ -n "$@" ]]; then
		du $arg -- "$@";
	else
		du $arg .[^.]* ./*;
	fi;
}

# Syntax-highlight JSON strings or files
# Usage: `json '{"foo":42}'` or `echo '{"foo":42}' | json`
function json() {
	if [ -t 0 ]; then # argument
		python -mjson.tool <<< "$*" | pygmentize -l javascript;
	else # pipe
		python -mjson.tool | pygmentize -l javascript;
	fi;
}

# Decode \x{ABCD}-style Unicode escape sequences
function unidecode() {
	perl -e "binmode(STDOUT, ':utf8'); print \"$@\"";
	# print a newline unless we’re piping the output to another program
	if [ -t 1 ]; then
		echo ""; # newline
	fi;
}

# Get a character’s Unicode code point
function codepoint() {
	perl -e "use utf8; print sprintf('U+%04X', ord(\"$@\"))";
	# print a newline unless we’re piping the output to another program
	if [ -t 1 ]; then
		echo ""; # newline
	fi;
}

# `o` with no arguments opens the current directory, otherwise opens the given
# location
function o() {
	if [ $# -eq 0 ]; then
		open .;
	else
		open "$@";
	fi;
}

# `tre` is a shorthand for `tree` with hidden files and color enabled, ignoring
# the `.git` directory, listing directories first. The output gets piped into
# `less` with options to preserve color and line numbers, unless the output is
# small enough for one screen.
function tre() {
	tree -aC -I '.git|node_modules|bower_components' --dirsfirst "$@" | less -FRNX;
}

# SOURCE PERSONAL
source ~/.personal.sh

# Specific OS
case `uname` in
  Darwin)
    ZSHRC_FILE=$HOME/.zsh/.zshrc.osx
    ;;
  Linux)
    ZSHRC_FILE=$HOME/.zsh/.zshrc.linux
    ;;
esac
source $ZSHRC_FILE

