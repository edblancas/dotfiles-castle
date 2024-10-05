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
plugins=(git common-aliases zsh-syntax-highlighting history-substring-search web-search docker git-flow docker-compose zsh-autosuggestions zsh-vi-mode fzf-tab command-not-found)

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
    source <(fzf --zsh)
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
export EDITOR='nvim';
export VISUAL='nvim';
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
alias zshconf="nvim $HOME/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias nvimconf="cd ~/.config/nvim && nvim ."
alias kittyconf="cd ~/.config/kitty && nvim kitty.conf"
alias c="clear"
alias e="exit"
alias ssh="ssh -X"
alias g="git"
alias lg="lazygit"
alias d="docker"
# Reload the shell (i.e. invoke as a login shell)
alias reload="exec $SHELL -l"
alias update_dotfiles_submodules="cd ~/.homesick/repos/dotfiles-castle && git submodule update --init --recursive"
# Override system vi and vim
alias vi='nvim'
alias vim='nvim'
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
#alias l='gls $LS_OPTIONS -lhF'
# Zsh to use the same colors as ls
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

#alias update='sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup; update_dotfiles_submodules'
alias update='brew update; brew upgrade clojure-lsp/brew/clojure-lsp-native; brew cleanup; update_dotfiles_submodules; $HOME/.emacs.d/bin/doom upgrade'
alias cloud="cd $HOME/Library/Mobile\ Documents/com~apple~CloudDocs"
alias onest="cd $HOME/Documents/dev/onest"
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
alias fzfv='nvim $(fzf)'
export FZF_DEFAULT_OPTS='--no-height'
export FZF_DEFAULT_COMMAND='fd --hidden --strip-cwd-prefix --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_COMMAND='fd --type=d --hidden --strip-cwd-prefix --exclude .git'
show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"
export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza -tree -color=always {} | head -200'"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
# Use fd for listing path candidates
# - the first arg to the fn $1 is the bgase path to start traversal
# - see cod completion.zsh for details
# for ** files
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}
# for dirs when cd **
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}
# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo ${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

# cuz the current definition in
# ~/.fzf/shell/key-bindings.zsh
# don't work, as kitty terminal is passing
# that character instead of the actual alt-c
eval "zvm_bindkey viins 'ç' fzf-cd-widget"
eval "zvm_bindkey visual 'ç' fzf-cd-widget"
eval "zvm_bindkey vicmd 'ç' fzf-cd-widget"

### PERSONAL OR WORK ###
if [[ $USER == "dan" ]]; then
  source $HOME/.personalrc
else
  source $HOME/.nurc
fi

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

### fzf-git.sh ###
source ~/.utils/fzf-git.sh/fzf-git.sh
# replace conflicting keybindings
# https://github.com/junegunn/fzf-git.sh/issues/23
# Set keybindings for zsh-vi-mode insert mode
function zvm_after_init() {
    zvm_bindkey viins "^P" up-line-or-beginning-search
    zvm_bindkey viins "^N" down-line-or-beginning-search
    for o in files branches tags remotes hashes stashes lreflogs each_ref; do
        eval "zvm_bindkey viins '^g${o[1]}' fzf-git-$o-widget"
    done
}
# Set keybindings for zsh-vi-mode normal and visual modes
function zvm_after_lazy_keybindings() {
    for o in files branches tags remotes hashes stashes lreflogs each_ref; do
        eval "zvm_bindkey vicmd '^g${o[1]}' fzf-git-$o-widget"
        eval "zvm_bindkey visual '^g${o[1]}' fzf-git-$o-widget"
    done
}

export BAT_THEME=tokyonight_night


# look ugly, there is a web fzf theme generator
#export FZF_DEFAULT_OPTS="--color=fg:${fg},bg:${bg},hl:${purple},fg+:${fg},bg+:${bg_highlight},hl+:${purple},info:${blue},prompt:${cyan},pointer:${cyan},marker:${cyan},spinner:${cyan},header:${cyan}"
# --- setup fzf theme ---
#fg="#CBE0F0"
#bg="#011628"
#bg_highlight="#143652"
#purple="#B388FF"
#blue="#06BCE4"
#cyan="#2CF9ED"

# ---- Eza (better ls) -----
alias l="eza --color=always --long --git --icons=always --no-user --no-permissions"

# thefuck alias to fuck
eval $(thefuck --alias)
eval $(thefuck --alias fk)
alias cd="z"

