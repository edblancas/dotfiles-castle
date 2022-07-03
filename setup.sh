echo "--> Symlinking..." < `tty` > `tty`
homesick link dotfiles-castle < `tty` > `tty`

echo "--> Submodules init..." < `tty` > `tty`
git submodule update --init --recursive < `tty` > `tty`

echo "--> Symlink pure prompt..." < `tty` > `tty`
ln -s $HOME/.config/oh-my-zsh/custom/themes/pure/pure.zsh /usr/local/share/zsh/site-functions/prompt_pure_setup < `tty` > `tty`
ln -s $HOME/.config/oh-my-zsh/custom/themes/pure/async.zsh /usr/local/share/zsh/site-functions/async < `tty` > `tty`

echo "--> Symlink iTerm2 settings (only if its clean installation)..." < `tty` > `tty`
ln -s $HOME/.config/iterm/com.googlecode.iterm2.plist $HOME/Library/Preferences/com.googlecode.iterm2.plist < `tty` > `tty`

echo "--> Installing nvim plugins with Plug..." < `tty` > `tty`
nvim +PluginInstall! +PluginClean +qall < `tty` > `tty`

echo "--> Install Coc Plugins in vim..." < `tty` > `tty`
nvim -c ':CocInstall coc-diagnostic | quit' < `tty` > `tty`
nvim -c ':CocInstall coc-snippets | quit' < `tty` > `tty`

echo "--> Done! Happy Vimming! :x" < `tty` > `tty`

echo "--> Symlink corgi-emacs..." < `tty` > `tty`
ln -s $HOME/.config/corgi-emacs/sample-config $HOME/.emacs.d < `tty` > `tty`
