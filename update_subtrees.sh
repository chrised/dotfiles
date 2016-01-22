#!/bin/bash

SUBTREES=(
'vim-pathogen            https://github.com/tpope/vim-pathogen.git               vim/submodules/pathogen              master'
'vim-airline             https://github.com/bling/vim-airline.git                vim/submodules/vim-airline           master'
'vim-nerdtree            https://github.com/scrooloose/nerdtree.git              vim/submodules/nerdtree              master'
'vim-tagbar              https://github.com/majutsushi/tagbar.git                vim/submodules/tagbar                master'
'vim-monokai             https://github.com/sickill/vim-monokai.git              vim/submodules/vim-monokai           master'
'vim-node                https://github.com/moll/vim-node.git                    vim/submodules/vim-node              master'
'vim-javascript-syntax   https://github.com/jelera/vim-javascript-syntax.git     vim/submodules/vim-javascript-syntax master'
'vim-syntastic           https://github.com/scrooloose/syntastic.git             vim/submodules/syntastic             master'
'vim-trailing-whitespace https://github.com/vim-scripts/trailing-whitespace.git  vim/submodules/trailing-whitespace   master'
'vim-lusty               https://github.com/sjbach/lusty.git                     vim/submodules/lusty                 master'
'vim-logstash-syntax     https://github.com/vim-scripts/logstash.vim.git         vim/submodules/logstash-syntax       master'
'vim-syntax-extra        https://github.com/justinmk/vim-syntax-extra.git        vim/submodules/vim-syntax-extra      master'
'vim-ctrlp               https://github.com/kien/ctrlp.vim.git                   vim/submodules/ctrlp                 master'
'vim-expw-syntax         https://github.com/chrised/vim-expw-syntax.git          vim/submodules/vim-expw-syntax       master'
'vim-plist               https://github.com/darfink/vim-plist.git                vim/submodules/vim-plist             master'
'powerline-fonts         https://github.com/chrised/fonts.git                    vim/submodules/powerline-fonts       master'
)



subtree_handle() {
    # subtree_handle remote_name remote_url relative_path branch
    if [ -z $4 ]; then
        echo "Not enough args"
        echo $4
        return
    fi
    git remote add -f "$1" "$2"
    git fetch "$1"
    git subtree pull --prefix "$3" "$1" "$4" --squash
}

for subtree in "${SUBTREES[@]}"; do
    subtree_handle $subtree
done


