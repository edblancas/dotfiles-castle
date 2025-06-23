source ~/.zoxide.nu
source ~/.cache/carapace/init.nu

alias l = ls
alias la = ls --all
alias tree = eza --tree
alias cd = z
alias nv = nvim
alias vim = nvim
alias v = nvim
alias g = git
alias c = clear
alias k = kubectl

mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

zoxide init nushell | save -f ~/.zoxide.nu

# autocompletions
$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
mkdir ~/.cache/carapace
carapace _carapace nushell | save --force ~/.cache/carapace/init.nu

$env.EDITOR = 'nvim'

def nvimconf [] { cd ~/.config/nvim; nvim . }

def nv [] {
    if ($in.is_empty) {
        nvim .
    } else {
        nvim $in
    }
}

def --env y [...args] {
    let tmp = (mktemp -t "yazi-cwd.XXXXXX")
    yazi ...$args --cwd-file $tmp
    let cwd = (open $tmp)
    if $cwd != "" and $cwd != $env.PWD {
        cd $cwd
    }
    rm -fp $tmp
}

def mkd [dir: string] {
    mkdir $dir
    cd $dir
}

def gi [args: string] {
    let keywords = ($args | str join ",")
    curl -L -s $"https://www.gitignore.io/api/($keywords)"
}

def ff [] {
    aerospace list-windows --all | fzf --bind 'enter:execute(bash -c "aerospace focus --window-id {1}")+abort'
}

