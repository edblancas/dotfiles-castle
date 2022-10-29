# dracula zsh syntax highlighting before activating the plugin oh-my-zsh
source $HOME/.config/dracula_zsh-syntax-highlighting/zsh-syntax-highlighting.sh

### START OH-MY-ZSH ###
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME=""
plugins=(common-aliases zsh-syntax-highlighting history-substring-search web-search docker git-flow docker-compose zsh-autosuggestions zsh-vi-mode)

# Override custom dir, inside custom themes or plugins
ZSH_CUSTOM=$HOME/.config/oh-my-zsh/custom
source $ZSH/oh-my-zsh.sh
### END OH-MY-ZSH ###

# https://gist.github.com/zulhfreelancer/9c410cad5efa9c5f7c74cd0849765865
# man strftime
RPROMPT="[%D{%a %f %b} %D{%T}]"

### START PURE PROMPT ###
fpath+=($HOME/.zsh/pure)

autoload -U promptinit; promptinit

# Options
zstyle :prompt:pure:git:stash show yes
zstyle :prompt:pure:git:fetch only_upstream yes

prompt pure
### END PURE PROMPT ###


### START ZSH VIM MODE PLUGIN ###
# history-substring-search with vim mode
# https://github.com/zsh-users/zsh-history-substring-search
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# fix history-substring-search for zsh-vi-mode overwriting bindings
# without this, if you start writing e.g. `ls ` up and down only 
# goes forward and backwards command history, and the correct behavior 
# must be that search with the first chars entered.
# https://github.com/jeffreytse/zsh-vi-mode#execute-extra-commands
# The plugin will auto execute this zvm_after_lazy_keybindings function
# bindkey: https://github.com/zsh-users/zsh-history-substring-search
function my_init() {
    bindkey '^[[A' history-substring-search-up
    bindkey '^[[B' history-substring-search-down
    # fzf: install useful key bindings and fuzzy completition
    # so it not conflicts with zsh-vim-mode and source it at
    # the end of all the zsh plugins
    [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
}
zvm_after_init_commands+=(my_init)
# Disable the cursor style feature
# With true the terminal slows down
# and really slows down vim
ZVM_CURSOR_STYLE_ENABLED=false
# Change to Zsh's default readkey engine
# The default slows the terminal and vim
ZVM_READKEY_ENGINE=$ZVM_READKEY_ENGINE_ZLE
ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
# for yank to send to macos clipboard
# https://github.com/jeffreytse/zsh-vi-mode/issues/19
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
eval $(/opt/homebrew/bin/gdircolors $HOME/.dircolors)
export LS_OPTIONS='--color=auto'
alias ls='gls $LS_OPTIONS -FGH'
alias la='gls $LS_OPTIONS -lAhF'
alias l='gls $LS_OPTIONS -lhF'
# Zsh to use the same colors as ls
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

alias update='sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup; update_dotfiles_submodules'
alias cloud="cd $HOME/Library/Mobile\ Documents/com~apple~CloudDocs"
alias notes="cd $HOME/Dropbox/dev/current/notes"
# Alias for datomic
alias sdatomic='$HOME/opt/datomic-pro-1.0.6269/bin/transactor config/dev-transactor-template.properties'
# Alias for closh
alias closh="$HOME/Dropbox/bin/closh-zero.jar"

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
[[ -s /opt/homebrew/share/autojump/autojump.zsh ]] && source /opt/homebrew/share/autojump/autojump.zsh
fpath=(/opt/homebrew/share/zsh-completions $fpath)

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

### Alias from nu .bash_profile ###
alias path='echo -e ${PATH//:/\\n}'         # path:         Echo all executable Paths
# System shortcuts
alias flushdns='sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder;say cache flushed'
alias sha1='/usr/bin/openssl sha1'
alias md5='md5 -r'
alias md5sum='md5 -r'
alias running_services="sudo lsof -nPi -sTCP:LISTEN"
alias whatismyipaddress='dig +short myip.opendns.com @resolver1.opendns.com'
alias localip='ipconfig getifaddr en0'
alias chrome='open -a "Google Chrome" --args --user-data-dir=/tmp/chrome-$((1 + RANDOM % 10))'
# Utils
alias uuid="python -c 'import sys,uuid; sys.stdout.write(str(uuid.uuid4()))' | pbcopy && pbpaste && echo"
## get top process eating memory
alias psmem='ps aux | sort -nr -k 4'
alias psmem10='ps aux | sort -nr -k 4 | head -10'
## get top process eating cpu ##
alias pscpu=' ps aux | sort -nr -k 3 '
alias pscpu10=' ps aux | sort -nr -k 3 | head -10 '

### Only pipe the stdout from echo `echo something >&1 | other_command` ###
# https://thoughtbot.com/blog/input-output-redirection-in-the-shell#zsh-users-take-note
unsetopt MULTIOS

### fzf ###
alias fzfnv='nvim $(fzf)'
alias fzfv='vim $(fzf)'
# use the silver searcher instead of `find`
export FZF_DEFAULT_COMMAND='ag --hidden --follow --ignore .git -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS='--preview "bat --style=numbers --color=always --line-range :500 {}"'
export FZF_CTRL_T_OPTS="--select-1 --exit-0"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
export FZF_ALT_C_OPTS="--select-1 --exit-0"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
export FZF_TMUX=1
export FZF_TMUX_OPTS="-p 90%,80%"

### PERSONAL OR WORK ###
# Conditional so we do not load the file again when we are inside tmux
if [[ -z $TMUX ]]; then
  if [[ $USER == "dan" ]]; then
    source $HOME/.personalrc
  else
    source $HOME/.nurc
  fi
fi

### WORKAROND ###
# when starting tmux the function and commands are not sourced, so in tmux session
# are not found, e.g. nurefresh is not found, and was in .nurc.
# if we remove the conditional `if [[-x $TMUX]];then` then the exports are run again and the
# PATH have duplicated entries
# we only check if its nu macbook
if [[ $USER == "daniel.blancas" ]];then
  # zsh completition
  autoload -Uz compinit bashcompinit && compinit && bashcompinit
  source "$NU_HOME/nucli/nu.bashcompletion"
  # fzf for a command: not works in zsh
  #complete -o bashdefault -o default -F _fzf_path_completion nu
  #complete -o bashdefault -o default -F _fzf_path_completion nu-mx
  #complete -o bashdefault -o default -F _fzf_path_completion nu-br

  function nurefresh() {
    if [[ $# -eq 0 ]] ; then
      echo "Refreshing okta and nu-mx staging!"
      nu aws credentials refresh --okta && nu-mx auth get-refresh-token --env staging && nu-mx auth get-access-token --env staging
    else
      if [ $# -lt 2 ]; then
        echo "Zero or two args must passed, first mx|br, and second staging|prod."
      else
        co="$1"
        env="$2"
        if [ $co != "mx" ] && [ $co != "br" ]; then
          echo "Invalid country $co! Must be mx or br!"
        else
          if [ $env != "staging" ] && [ $env != "prod" ]; then
            echo "Invalid environment $env! Must be staging or prod!"
          else
            echo "Refreshing okta and nu-$co $env!"
            nu aws credentials refresh --okta && nu auth get-refresh-token --env $env --country $co && nu auth get-access-token --env $env --country $co
          fi
        fi
      fi
    fi
  }
fi
### END WORKAROUND ###

### COMMON PATH SETTINGS ###
export PATH=$PATH:~/.config/nvim/plugged/vim-iced/bin

