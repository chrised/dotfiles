#!/bin/bash
############################
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/.dotfiles                    # dotfiles directory
olddir=~/.dotfiles_old             # old dotfiles backup directory
files="bashrc vimrc vim gitconfig subversion"    # list of files/folders to symlink in homedir

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
for file in $files; do
    echo "Backing up dotfiles to files from ~ to $olddir-$datestr/"
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


[[ ! -f ~/.bashrc.local ]] && echo "Note: Custom bashrc/profile options can be added in ~/.bashrc.local"
