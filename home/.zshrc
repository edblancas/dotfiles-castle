case `uname` in
  Darwin)
    source $HOME/.zsh/.zshrc.osx
    ;;
  Linux)
    source $HOME/.zsh/.zshrc.linux
    ;;
esac

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"
