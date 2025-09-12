#echo -e "\033]777;notify;your title;your body\007"!/bin/bash

set -e

INSTALL_DIR="$HOME/tmp/neovim"
BRANCH="${1:-stable}"   # default branch is stable, fallback to master if passed

GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

cd "$INSTALL_DIR" || { log_error "install directory not found: $INSTALL_DIR"; exit 1; }

log_info "checking out branch: $BRANCH"
git fetch origin

# switch to the requested branch
git checkout "$BRANCH"

LOCAL=$(git rev-parse @)
REMOTE=$(git rev-parse @{u})
BASE=$(git merge-base @ @{u})

if [[ $LOCAL = $REMOTE ]]; then
    log_info "no updates available on $BRANCH"
    exit 0
elif [[ $LOCAL = $BASE ]]; then
    log_info "updates found on $BRANCH, pulling..."
    git pull
else
    log_error "local and remote are out of sync on $BRANCH, please resolve manually"
    exit 1
fi

log_info "building neovim ($BRANCH)..."
make CMAKE_BUILD_TYPE=RelWithDebInfo

log_info "installing neovim..."
# Ghostty notification
# https://github.com/ghostty-org/ghostty/discussions/3555#discussioncomment-11687079
# https://github.com/ghostty-org/ghostty/discussions/8527#discussioncomment-14381405
echo -e "\033]9;Enter passwor to install neovim\007"
sudo make install

log_success "neovim ($BRANCH) installation complete"
