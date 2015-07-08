#!/bin/bash
############################
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/.dotfiles                    # dotfiles directory
olddir=~/.dotfiles_old             # old dotfiles backup directory
files="bashrc vimrc vim gitconfig gitignore_global subversion"    # list of files/folders to symlink in homedir

datestr=$(date -u "+%m%d%H%M%Y")

########## Update Submodules

git submodule update --init --recursive $dir

########## Create symlinks

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
if [ ! -d $olddir-$datestr ]; then
    mkdir -p $olddir-$datestr
fi

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks
echo "Backing up dotfiles to files from ~ to $olddir-$datestr/"
for file in $files; do
    if [ -f ~/.$file ]; then
        cp -L ~/.$file $olddir-$datestr/
        rm -f ~/.$file
    elif [ -d ~/.$file ]; then
        cp -LR ~/.$file $olddir-$datestr/
        rm -rf ~/.$file
    fi
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done

# Handle the bashrc/bash_profile mess
[[ -f ~/.bash_profile ]] && cp -LR ~/.bash_profile $olddir-$datestr/ && rm -rf ~/.bash_profile
ln -s ~/.bashrc ~/.bash_profile


# Finally, set up powerline-fonts
echo "Installing powerline-fonts"
~/.vim/powerline-fonts/install.sh

# local bashrc hint
[[ ! -f ~/.bashrc.local ]] && echo "Note: Custom bashrc/profile options can be added in ~/.bashrc.local"

# create some whitespace
echo

# javascript linting hints
if [ ! $(which jslint) ]; then
    echo "jslint not found, install with:"
    echo "npm install -g jslint"
fi
if [ ! $(which jshint) ]; then
    echo "jshint not found, install with:"
    echo "npm install -g jshint"
fi

echo
echo "DONE"


