### START OH-MY-ZSH ###
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME=""
plugins=(common-aliases zsh-syntax-highlighting history-substring-search web-search docker git-flow docker-compose zsh-autosuggestions zsh-vi-mode)

# Override custom dir, inside custom themes or plugins
ZSH_CUSTOM=$HOME/.config/oh-my-zsh/custom
source $ZSH/oh-my-zsh.sh
### END OH-MY-ZSH ###


### START PURE PROMPT ###
autoload -U promptinit; promptinit
prompt pure
### END PURE PROMPT ###


### START ZSH VIM MODE PLUGIN ###
# history-substring-search with vim mode
# https://github.com/zsh-users/zsh-history-substring-search
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# fix history-substring-search for zsh-vi-mode overwriting bindings
# https://github.com/jeffreytse/zsh-vi-mode#execute-extra-commands
# The plugin will auto execute this zvm_after_lazy_keybindings function
# bindkey: https://github.com/zsh-users/zsh-history-substring-search
function my_init() {
    bindkey '^[[A' history-substring-search-up
    bindkey '^[[B' history-substring-search-down
}
zvm_after_init_commands+=(my_init)
# Disable the cursor style feature
# With true the terminal slows down
ZVM_CURSOR_STYLE_ENABLED=false
# Change to Zsh's default readkey engine
# The default slows the terminal and vim
ZVM_READKEY_ENGINE=$ZVM_READKEY_ENGINE_ZLE
### END ZSH VIM MODE PLUGIN ###


### START CONFIGURATIONS ###
### Envs ###
export EDITOR='vim';
export VISUAL='vim';
# For good colors in tmux, TRUE COLOUR
export TERM='xterm-256color-italic'
# 1ms for key sequences, for zsh and vim, not zhs-vim-plugin
export KEYTIMEOUT=1
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

### Alias ###
alias zshconfig="vim $HOME/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"
alias stmux="tmux attach -t dev || tmux new -s dev"
alias c="clear"
alias e="exit"
alias ssh="ssh -X"
alias g="git"
alias d="docker"
# Reload the shell (i.e. invoke as a login shell)
alias reload="exec $SHELL -l"
alias update_dotfiles_submodules="cd ~/.homesick/repos/dotfiles-castle && git submodule update --init --recursive"
# Override system vi
alias vi='vim'
alias ssh='TERM=xterm-256color ssh'
# MVN alias
alias mvnis='mvn clean install -DskipTests -Djacoco.skip=true -Dcheckstyle.skip -DskipITs -Dfindbugs.skip=true'
alias mvnps='mvn clean package -DskipTests -Djacoco.skip=true -Dcheckstyle.skip -DskipITs -Dfindbugs.skip=true'
# Aliases for vim and kaleidoscope merge diff tool
alias gkdiff='git config diff.tool kaleidoscope; git difftool'
alias gkmerge='git config merge.tool kaleidoscope; git mergetool'
# Alias gls to ls for dircolors (brew install coreutils)
eval `gdircolors $HOME/.dircolors/dircolors-solarized/dircolors.ansi-dark` 
alias ls='gls --color -FGH'
alias update='sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup; update_dotfiles_submodules'
alias cloud="cd $HOME/Library/Mobile\ Documents/com~apple~CloudDocs"

### Functions ###
function nv() {
    if [ $# -eq 0 ]; then
        nvim .;
    else
        nvim "$@";
    fi;
}
# C-Z back to nvim, vim
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z
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
# `tre` is a shorthand for `tree` with hidden files and color enabled, ignoring
# the `.git` directory, listing directories first. The output gets piped into
# `less` with options to preserve color and line numbers, unless the output is
# small enough for one screen.
function tre() {
	tree -aC -I '.git|node_modules|bower_components' --dirsfirst "$@" | less -FRNX;
}

function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}
# Like switchjdk 1.6|1.7|1.8|9|12
function switchjdk() {
  if [ $# -ne 0 ]; then
   removeFromPath '$JAVA_HOME/bin'
   if [ -n "${JAVA_HOME+x}" ]; then
    removeFromPath $JAVA_HOME
   fi
   export JAVA_HOME=`/usr/libexec/java_home -v $@`
   export PATH=$JAVA_HOME/bin:$PATH
  fi
}

function removeFromPath() {
  export PATH=$(echo $PATH | sed -E -e "s;:$1;;" -e "s;$1:?;;")
}

### Completitions ###
# This is cause it was in the .path_macOS but when starting a tmux session the functions 
# where not available inside
[[ -s /usr/local/share/autojump/autojump.zsh ]] && source /usr/local/share/autojump/autojump.zsh
fpath=(/usr/local/share/zsh-completions $fpath)

### Node Settings ###
# Enable persistent REPL history for `node`.
export NODE_REPL_HISTORY=~/.node_history;
# Allow 32³ entries; the default is 1000.
export NODE_REPL_HISTORY_SIZE='32768';
# Use sloppy mode by default, matching web browsers.
export NODE_REPL_MODE='sloppy';

### Python Settings ###
# Make Python use UTF-8 encoding for output to stdin, stdout, and stderr.
export PYTHONIOENCODING='UTF-8';
alias qtpy='jupyter qtconsole --ConsoleWidget.font_family="MonoLisa" --ConsoleWidget.font_size=16'
### END CONFIGURATIONS ###


### PERSONAL OR WORK ###
# Conditional so we do not load the file again when we are inside tmux
if [[ -z $TMUX ]]; then
  if [[ $USER == "dan" ]]; then
    source $HOME/.personalrc
  else
    source $HOME/.nurc
  fi
fi

### COMMON SETTINGS ###
export PATH=$PATH:~/.config/nvim/plugged/vim-iced/bin
