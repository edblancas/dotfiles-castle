echo "--> Symlinking..." < `tty` > `tty`
homesick link dotfiles-castle < `tty` > `tty`

echo "-- Submodules init..." < `tty` > `tty`
git submodule update --init --recursive < `tty` > `tty`

echo "-- Symlink pure prompt..." < `tty` > `tty`
ln -s $HOME/.zfunction/pure/pure.zsh /usr/local/share/zsh/site-functions/prompt_pure_setup < `tty` > `tty`
ln -s $HOME/.zfunctions/pure/async.zsh /usr/local/share/zsh/site-functions/async < `tty` > `tty`

echo "-- Symlink spaceship prompt..." < `tty` > `tty`
ln -s "$HOME/.config/oh-my-zsh/custom/themes/spaceship-prompt/spaceship.zsh-theme" "$HOME/.config/oh-my-zsh/custom/themes/spaceship.zsh-theme" < `tty` > `tty`

echo "--> Installing nvim plugins with vundle..." < `tty` > `tty`
nvim +PluginInstall! +PluginClean +qall < `tty` > `tty`

echo "--> Done! Happy Vimming! :x" < `tty` > `tty`
