
#!/bin/bash

set -e

INSTALL_DIR="$HOME/.local/share/aerospace-swipe"

GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

cd "$INSTALL_DIR" || { log_error "install directory not found: $INSTALL_DIR"; exit 1; }

log_info "checking for updates..."
git fetch origin

LOCAL=$(git rev-parse @)
REMOTE=$(git rev-parse @{u})
BASE=$(git merge-base @ @{u})

if [[ $LOCAL = $REMOTE ]]; then
    log_info "no updates available"
    exit 0
elif [[ $LOCAL = $BASE ]]; then
    log_info "updates found, pulling..."
    git pull
else
    log_error "local and remote are out of sync, please resolve manually"
    exit 1
fi

if [[ ! -f "makefile" ]]; then
    log_error "makefile not found in source directory"
    exit 1
fi

log_info "installing aerospace-swipe..."
make install

log_success "installation complete"
