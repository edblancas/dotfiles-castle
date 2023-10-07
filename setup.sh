echo "--> Symlinking..." < `tty` > `tty`
homesick link dotfiles-castle < `tty` > `tty`

echo "--> Submodules init..." < `tty` > `tty`
git submodule update --init --recursive < `tty` > `tty`
