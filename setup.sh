echo "--> Symlinking..." < `tty` > `tty`
homesick link dotfiles-castle < `tty` > `tty`

echo "--> Submodules init..." < `tty` > `tty`
git submodule update --init --recursive < `tty` > `tty`

echo "--> Symlink iTerm2 settings (only if its clean installation)..." < `tty` > `tty`
ln -s $HOME/.config/iterm/com.googlecode.iterm2.plist $HOME/Library/Preferences/com.googlecode.iterm2.plist < `tty` > `tty`

echo "--> Symlink corgi-emacs..." < `tty` > `tty`
ln -s $HOME/.config/corgi-emacs/sample-config $HOME/.emacs.d < `tty` > `tty`

echo "--> Symlink Dracula dircolors..." < `tty` > `tty`
ln -s $HOME/.config/dracula-dircolors/.dircolors $HOME/.dircolors < `tty` > `tty`
