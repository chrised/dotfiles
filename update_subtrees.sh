#!/bin/bash

SUBTREES=(
# vim
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
'vim-erlang-runtime      https://github.com/vim-erlang/vim-erlang-runtime        vim/submodules/vim-erlang-runtime    master'
'vim-erlang-compiler     https://github.com/vim-erlang/vim-erlang-compiler       vim/submodules/vim-erlang-compiler   master'
'vim-erlang-tags         https://github.com/vim-erlang/vim-erlang-tags           vim/submodules/vim-erlang-tags       master'
'vim-erlang-skeletons    https://github.com/vim-erlang/vim-erlang-skeletons      vim/submodules/vim-erlang-skeletons  master'
'vim-gitgutter           https://github.com/airblade/vim-gitgutter               vim/submodules/vim-gitgutter         master'
# emacs
'use-package             https://github.com/jwiegley/use-package                 emacs.d/use-package                  master'
)



subtree_handle() {
    # subtree_handle remote_name remote_url relative_path branch
    if [ -z $4 ]; then
        echo "Not enough args"
        echo $4
        return
    fi
    git remote add -f "$1" "$2"
    if [ ! -d "$3" ]; then
        git subtree add -q --squash --prefix "$3" "$1" "$4"
    fi
    git fetch "$1"
    git subtree pull -q --prefix "$3" "$1" "$4" --squash
}

for subtree in "${SUBTREES[@]}"; do
    subtree_handle $subtree
done


