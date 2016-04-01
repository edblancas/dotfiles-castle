echo "--> Symlinking..." < `tty` > `tty`
homesick link dotfiles-castle < `tty` > `tty`

echo "-- Submodules init..." < `tty` > `tty`
git submodule init < `tty` > `tty`

echo "--> Installing nvim plugins with vundle..." < `tty` > `tty`
nvim +PluginInstall! +PluginClean +qall < `tty` > `tty`

echo "--> Done! Happy Vimming! :x" < `tty` > `tty`
