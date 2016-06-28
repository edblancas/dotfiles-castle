function chip.up() {
    curl -H POST -F "file=@$1" http://www.chipocles.com/GliderUploader/upload.php > /dev/null
}

function chip.down() {
    curl http://www.chipocles.com/GliderUploader/server/php/files/$1 -o $1
}

# Set the credentials (modifies ~/.gitconfig)
git config --global user.name "Daniel Blancas"
git config --global user.email "edblancas@gmail.com"
