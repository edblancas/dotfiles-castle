# dracula zsh syntax highlighting before activating the plugin oh-my-zsh
source $HOME/.config/dracula_zsh-syntax-highlighting/zsh-syntax-highlighting.sh

# Homebrew installation
# Homebrew binaries, the paths are not exclusive of homebrew!
export HOMEBREW=$(brew --prefix)
export HOMEBREW_COREUTILS="$HOMBREW/opt/coreutils/libexec"

### zsh-completions ###
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

### Hombrew completions ###
FPATH="$HOMEBREW/share/zsh/site-functions:${FPATH}"

### START OH-MY-ZSH ###
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME=""
plugins=(git common-aliases zsh-syntax-highlighting history-substring-search web-search docker git-flow docker-compose zsh-autosuggestions zsh-vi-mode fzf-tab sudo command-not-found)

# zsh-autosuggest plugin settings
# https://github.com/zsh-users/zsh-autosuggestions
# without this alacritty doesn't show the suggestions with dracula-pro
# e.g.
# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ff00ff,bg=cyan,bold,underline"

# Override custom dir, inside custom themes or plugins
ZSH_CUSTOM=$HOME/.config/oh-my-zsh/custom
source $ZSH/oh-my-zsh.sh
### END OH-MY-ZSH ###

## Load completions
autoload -Uz compinit && compinit

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
eval $(gdircolors $HOME/.config/dracula-dircolors/.dircolors)
export LS_OPTIONS='--color=auto'
alias ls='gls $LS_OPTIONS -FGH'
alias la='gls $LS_OPTIONS -lAhF'
alias l='gls $LS_OPTIONS -lhF'
# Zsh to use the same colors as ls
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

#alias update='sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup; update_dotfiles_submodules'
alias update='brew update; brew upgrade clojure-lsp/brew/clojure-lsp-native; brew cleanup; update_dotfiles_submodules; $HOME/.emacs.d/bin/doom upgrade'
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
alias fzfnv='nvim $(fzf-tmux)'
alias fzfv='vim $(fzf-tmux)'
export FZF_TMUX=1
# not working, I think cuz fzf-tmux script doesn't support preview
export FZF_TMUX_OPTS='-p80%,60%'
export FZF_DEFAULT_OPTS='--no-height'
# use the silver searcher instead of `find`
export FZF_DEFAULT_COMMAND='ag --hidden --follow --ignore .git -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS='--preview "bat --style=numbers --color=always --line-range :500 {}"'
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

### PERSONAL OR WORK ###
if [[ $USER == "dan" ]]; then
  source $HOME/.personalrc
else
  source $HOME/.nurc
fi

# Fuzzy git checkout
# https://polothy.github.io/post/2019-08-19-fzf-git-checkout/
fzf-git-branch() {
  git rev-parse HEAD > /dev/null 2>&1 || return

  git branch --color=always --all --sort=-committerdate |
    grep -v HEAD |
    fzf --height 50% --ansi --no-multi --preview-window right:65% \
      --preview 'git log -n 50 --color=always --date=short --pretty="format:%C(auto)%cd %h%d %s" $(sed "s/.* //" <<< {})' |
    sed "s/.* //"
}

fzf-git-checkout() {
  git rev-parse HEAD > /dev/null 2>&1 || return

  local branch

  branch=$(fzf-git-branch)
  if [[ "$branch" = "" ]]; then
    echo "No branch selected."
    return
  fi

  # If branch name starts with 'remotes/' then it is a remote branch. By
  # using --track and a remote branch name, it is the same as:
  # git checkout -b branchName --track origin/branchName
  if [[ "$branch" = 'remotes/'* ]]; then
    git checkout --track $branch
  else
    git checkout $branch;
  fi
}

# Enter will view the commit
# Ctrl-o will checkout the selected commit
function fzf-git-log() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort --preview \
         'f() { set -- $(echo -- "$@" | grep -o "[a-f0-9]\{7\}"); [ $# -eq 0 ] || git show --color=always $1 ; }; f {}' \
      --header "enter to view, ctrl-o to checkout" \
      --bind "q:abort,ctrl-f:preview-page-down,ctrl-b:preview-page-up" \
      --bind "ctrl-o:become:(echo {} | grep -o '[a-f0-9]\{7\}' | head -1 | xargs git checkout)" \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF" --preview-window=right:60%
}

alias fgb='fzf-git-branch'
alias fgc='fzf-git-checkout'
alias fgl='fzf-git-log'

### BABASHKA ###
# tab-complete feature on ZSH.
# https://book.babashka.org/#_terminal_tab_completion
_bb_tasks() {
    local matches=(`bb tasks |tail -n +3 |cut -f1 -d ' '`)
    compadd -a matches
    _files # autocomplete filenames as well
}
compdef _bb_tasks bb
## END BABASHKA ###

### COMMON PATH SETTINGS ###
export PATH=$PATH:~/.config/nvim/plugged/vim-iced/bin

# Created by `pipx` on 2024-05-02 19:24:48
export PATH="$PATH:$HOME/.local/bin"

eval "$(register-python-argcomplete pipx)"

# Seems this path env is only for linux, meh replicating here
export XDG_CONFIG_HOME="$HOME/.config"

### PTPYTHON ###
export PTPYTHON_CONFIG_HOME="$XDG_CONFIG_HOME/ptpython"

### fzf-tab ###
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'gls --color -A $realpath'

### zoxide ###
zstyle ':fzf-tab:complete:z:*' fzf-preview 'gls --color -A $realpath'
eval "$(zoxide init zsh)"

