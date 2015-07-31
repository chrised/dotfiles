#!/bin/bash
############################
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

function result() {
    if [ $? = 0 ]; then
        printf ' [\033[0;32mOK\033[0m]\n'
    else
        printf ' [\033[0;31mERROR\033[0m]\n'
    fi
}

########## Variables
dir=~/.dotfiles                    # dotfiles directory
olddir=~/.dotfiles_old             # old dotfiles backup directory
files="bashrc vimrc gvimrc vim gitconfig gitignore_global subversion eslintrc"    # list of files/folders to symlink in homedir

datestr=$(date -u "+%m%d%H%M%Y")

########## Update Submodules

# hack to make sure we get the latest committed versions
rm -rf "$dir/vim/submodules/"
mkdir "$dir/vim/submodules"

git submodule update --init --recursive $dir

########## Create symlinks

# create dotfiles_old in homedir
echo "Creating $olddir-$datestr for backup of any existing dotfiles in ~"
if [ ! -d "$olddir-$datestr" ]; then
    mkdir -p "$olddir-$datestr"
fi

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks
echo "Backing up dotfiles to files from ~ to $olddir-$datestr/"
for file in $files; do
    if [ -f ~/."$file" ]; then
        cp -L ~/."$file" "$olddir-$datestr"/
        rm -f ~/."$file"
    elif [ -d ~/."$file" ]; then
        cp -LR ~/."$file" "$olddir-$datestr"/
        rm -rf ~/."$file"
    fi
    echo -n "Creating symlink to $file in home directory."
    ln -s "$dir/$file" "$HOME/.$file"
    result
done

# Handle the bashrc/bash_profile mess
[[ -f ~/.bash_profile ]] && cp -LR ~/.bash_profile "$olddir-$datestr"/ && rm -rf ~/.bash_profile
echo -n "Making a mess of bashrc and bash_profile"
ln -s ~/.bashrc ~/.bash_profile
result


# Finally, set up powerline-fonts
echo "Installing powerline-fonts"
"$HOME/.vim/powerline-fonts/install.sh"

# local bashrc hint
[[ ! -f ~/.bashrc.local ]] && echo "Note: Custom bashrc/profile options can be added in ~/.bashrc.local"

missing_linters=0
linters="shellcheck syntaxerl eslint"
for linter in $linters; do
    if [ ! "$(which "$linter")" ]; then
        missing_linters="$((missing_linters + 1))"
        echo "$linter not found. Please install"
    fi
done

# javascript linting hints
jslinters="jslint jshint eslint"
for linter in $jslinters; do
    if [ ! "$(which "$linter")" ]; then
        missing_linters="$((missing_linters + 1))"
        echo "$linter not found, install with:"
        echo "npm install -g $linter"
    fi
done

if [[ $missing_linters -gt 0 ]]; then
    printf "You are missing %s linters [\033[0;31mERROR\033[0m]\n" "$missing_linters"
else
    printf "All expected linters were detected. [\033[0;32mOK\033[0m]\n"
fi

echo
echo "Dotfiles bootstrap complete."

