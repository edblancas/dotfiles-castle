case `uname` in
  Darwin)
    source $HOME/.zsh/.osx.zshrc
    ;;
  Linux)
    source $HOME/.zsh/.linux.zshrc
    ;;
esac

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
