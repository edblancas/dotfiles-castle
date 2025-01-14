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

export EDITOR='nvim'
export VISUAL='nvim'

### START OH-MY-ZSH ###
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME=""
plugins=(zsh-syntax-highlighting history-substring-search zsh-autosuggestions zsh-vi-mode fzf-tab)

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
autoload bashcompinit && bashcompinit

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
    # for some reason this not woks at the end of this file
    bindkey -r '^F' 
    bindkey '^F' forward-word
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
# 1ms for key sequences, for zsh and vim, not zhs-vim-plugin
export KEYTIMEOUT=1
# Increase Bash history size. Allow 32³ entries; the default is 500.
export HISTSIZE='32768'
export HISTFILESIZE="${HISTSIZE}"
# Omit duplicates and commands that begin with a space from history.
export HISTCONTROL='ignoreboth'
# Prefer US English and use UTF-8.
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'
# Highlight section titles in manual pages.
export LESS_TERMCAP_md="${yellow}"
# Don’t clear the screen after quitting a manual page.
export MANPAGER='less -X'

### Alias ###
alias zshrc="nvim $HOME/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias nvimconf="cd ~/.config/nvim && nvim ."
alias kittyconf="cd ~/.config/kitty && nvim kitty.conf"
alias c="clear"
alias e="exit"
alias g="git"
alias lg="lazygit"
alias d="docker"
# Reload the shell (i.e. invoke as a login shell)
alias reload="exec $SHELL -l"
alias update_dotfiles_submodules="cd ~/.homesick/repos/dotfiles-castle && git submodule update --init --recursive"
# Override system vi and vim
alias vi='nvim'
alias vim='nvim'
alias nv='nvim'
# Aliases for vim and kaleidoscope merge diff tool
alias gkdiff='git config diff.tool kaleidoscope; git difftool'
alias gkmerge='git config merge.tool kaleidoscope; git mergetool'

# Alias gls to ls for dircolors (brew install coreutils)
# commented out for tokyo-night-night colors in eza config
#eval $(gdircolors $HOME/.config/dracula-dircolors/.dircolors)
export LS_OPTIONS='--color=auto'
alias ls='gls $LS_OPTIONS -FGH'
#alias la='gls $LS_OPTIONS -lAhF'
#alias l='gls $LS_OPTIONS -lhF'
# Zsh to use the same colors as ls
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

#alias update='sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup; update_dotfiles_submodules'
alias update='brew update; brew upgrade clojure-lsp/brew/clojure-lsp-native; brew cleanup; update_dotfiles_submodules; $HOME/.emacs.d/bin/doom upgrade'
alias cloud="cd $HOME/Library/Mobile\ Documents/com~apple~CloudDocs"

### Functions ###
function v() {
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

function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}

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
alias chrome='open -a "Google Chrome" --args --disable-web-security --user-data-dir=/tmp/chrome-$((1 + RANDOM % 10))'
# Utils
alias uuid="python3 -c 'import sys,uuid; sys.stdout.write(str(uuid.uuid4()))' | pbcopy && pbpaste && echo"
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
#export FZF_DEFAULT_OPTS='--no-height'  # no tmux
export FZF_DEFAULT_OPTS='--height 80% --tmux bottom,80% --layout reverse --border top'
export FZF_DEFAULT_COMMAND='fd --hidden --strip-cwd-prefix --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_COMMAND='fd --type=d --hidden --strip-cwd-prefix --exclude .git'
show_file_or_dir_preview() { [[ -d "$1" ]] && eza --tree --color=always "$1" | head -200 || bat -n --color=always --line-range :500 "$1"}
export FZF_CTRL_T_OPTS="--preview 'zsh -c $(functions show_file_or_dir_preview); show_file_or_dir_preview {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"
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

# fzf tokyo-night-night colors
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
  --highlight-line \
  --info=inline-right \
  --ansi \
  --layout=reverse \
  --border=none
  --color=bg+:#283457 \
  --color=bg:#16161e \
  --color=border:#27a1b9 \
  --color=fg:#c0caf5 \
  --color=gutter:#16161e \
  --color=header:#ff9e64 \
  --color=hl+:#2ac3de \
  --color=hl:#2ac3de \
  --color=info:#545c7e \
  --color=marker:#ff007c \
  --color=pointer:#ff007c \
  --color=prompt:#2ac3de \
  --color=query:#c0caf5:regular \
  --color=scrollbar:#27a1b9 \
  --color=separator:#ff9e64 \
  --color=spinner:#ff007c \
"

# cuz the current definition in
# ~/.fzf/shell/key-bindings.zsh
# don't work, as kitty terminal is passing
# that character instead of the actual alt-c
#eval "zvm_bindkey viins 'ç' fzf-cd-widget"
#eval "zvm_bindkey visual 'ç' fzf-cd-widget"
#eval "zvm_bindkey vicmd 'ç' fzf-cd-widget"
### use in kitty: macos_option_as_alt left to avoid the above ###

### PERSONAL OR WORK PATH settings ###
if [[ $USER == "dan" ]]; then
  source $HOME/.personalrc
#else
# I use the same mbp for work and personal
  source $HOME/.onestrc.zsh
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
# Created by `pipx` on 2024-05-02 19:24:48
export PATH="$PATH:$HOME/.local/bin"
eval "$(register-python-argcomplete pipx)"

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

# ---- Eza (better ls) -----
alias l="eza --color=always --long --git --icons=always --no-user --no-permissions"
alias la="l --all"
alias tree="eza --tree"

# thefuck alias to fuck
eval $(thefuck --alias)
eval $(thefuck --alias fk)

alias cd="z"
alias n="cd $HOME/Documents/dev/notes/ && nv"
alias notes="cd $HOME/Documents/dev/notes/"
alias icat="kitten icat"

# yazi shell wrapper
# press q to quit, you'll see the CWD changed
# if you don't want to change, press Q to quit.
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

. "/Users/dan/.deno/env"

# aws completion
complete -C '/usr/local/bin/aws_completer' aws

# nvchad - neovim config
alias vc='NVIM_APPNAME=nvim-nvchad nvim' # NvChad

alias vf='NVIM_APPNAME=nvim-fennel nvim' # nvim fennel config

alias zs="~/bin/zellij-smart-sessionizer/zellij-smart-sessionizer"

alias ts='tmux-sessionizer -rp ~/projects/onest ~/projects/current'
alias tf='tmuxinator-fzf-start'
