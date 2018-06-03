#!/usr/bin/env bash
#   Copyright 2014 Steve Francia
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
############################  SETUP PARAMETERS
app_name='spf13-vim-leoatchina'
[ -z "$APP_PATH" ] && APP_PATH="$PWD"
[ -z "$REPO_URL" ] && REPO_URL='https://github.com/leoatchina/spf13-vim-leoatchina.git'
[ -z "$REPO_BRANCH" ] && REPO_BRANCH='master'
debug_mode='0'
update_setting='0'
[ -z "$PLUG_URL" ] && PLUG_URL="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
############################  BASIC SETUP TOOLS
msg() {
    printf '%b\n' "$1" >&2
}
success() {
    if [ "$ret" -eq '0' ]; then
        msg "\33[32m[✔]\33[0m ${1}${2}"
    fi
}

error() {
    msg "\33[31m[✘]\33[0m ${1}${2}"
    exit 1
}

debug() {
    if [ "$debug_mode" -eq '1' ] && [ "$ret" -gt '1' ]; then
        msg "An error occurred in function \"${FUNCNAME[$i+1]}\" on line ${BASH_LINENO[$i+1]}, we're sorry for that."
    fi
}

program_exists() {
    local ret='0'
    command -v $1 >/dev/null 2>&1 || { local ret='1'; }
    # fail on non-zero return value
    if [ "$ret" -ne 0 ]; then
        return 1
    fi
    return 0
}

program_must_exist() {
    program_exists $1
    # throw error on non-zero return value
    if [ "$?" -ne 0 ]; then
        error "You must have '$1' installed to continue."
    fi
}

variable_set() {
    if [ -z "$1" ]; then
        error "You must have your HOME environmental variable set to continue."
    fi
}

lnif() {
    if [ -e "$1" ] ; then
        ln -sf "$1" "$2"
    fi
    ret="$?"
    debug
}

############################ SETUP FUNCTIONS
create_symlinks() {
    local source_path="$1"
    local target_path="$2"
    lnif "$source_path/.vimrc"              "$target_path/.vimrc"
    lnif "$source_path/.vimrc.plugs"        "$target_path/.vimrc.plugs"
    lnif "$source_path/.vim-clean"          "$target_path/.vim-clean"
    lnif "$source_path/README.markdown"     "$target_path/.vimrc.md"
    if program_exists "nvim"; then
        mkdir -p "$target_path/.config/nvim"
        lnif "$source_path/.vimrc"          "$target_path/.config/nvim/init.vim"
    fi
    ret="$?"
    success "Setting up vim symlinks."
    debug
}

setup_plug() {
    local system_shell="$SHELL"
    export SHELL='/bin/sh'
    msg "Starting update/install plugins for $1"
    "$1" +PlugClean +PlugInstall +qall
    export SHELL="$system_shell"
    success "Successfully updated/installed plugins using vim-plug for $1"
    debug
}

install_vim_plug() {
    curl -fLo "$1/plug.vim" --create-dirs "$2" 
    success "Successfully installed/updated $3 for $4"
    debug
}

############################ MAIN()
variable_set "$HOME"
program_must_exist "git"
program_must_exist "curl"
mkdir -p "$HOME/.vim/session"

read -p "Do you want to update vimrc and vim-plug (Y for Yes , any other key for No)? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    update_setting='1'
fi
ret=0
if [ "$update_setting" -eq '1' ];then
    git pull
    success "Update to the latest version of spf13-vim-leoatchina"
fi

if [ -f $HOME/.vimrc.local ];then
    success "$HOME/.vimrc.local exists."
else
    cp $APP_PATH/.vimrc.local $HOME/
    success "$HOME/.vimrc.local does not exist, created it."
fi

create_symlinks "$APP_PATH" "$HOME"

if program_exists "vim"; then
    if [ "$update_setting" -eq '1' ];then
        install_vim_plug       "$HOME/.vim/autoload" "$PLUG_URL" "vim-plug" "vim"
    fi
    setup_plug "vim"
fi
if program_exists "nvim"; then
    if [ "$update_setting" -eq '1' ];then
        install_vim_plug       "$HOME/.local/share/nvim/site/autoload" "$PLUG_URL" "vim-plug" "nvim" 
    fi
    setup_plug "nvim"
fi

msg "\nThanks for installing leoatchina's vim config forked from http://vim.spf13.com"
msg "© `date +%Y` https://github.com/leoatchina/spf13-vim-leoatchina"
