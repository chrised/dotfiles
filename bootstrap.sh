#!/bin/bash
############################
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/.dotfiles                    # dotfiles directory
olddir=~/.dotfiles_old             # old dotfiles backup directory
files="bashrc vimrc vim gitconfig subversion"    # list of files/folders to symlink in homedir

datestr=$(date -ju "+%m%d%H%M%Y")

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
for file in $files; do
    echo "Backing up dotfiles to files from ~ to $olddir-$datestr"
    cp -LR ~/.$file $olddir-$datestr
    rm ~/.$file
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done



