#!/bin/bash

SUBTREES=(
# shell
'bash-git-prompt                    https://github.com/magicmonty/bash-git-prompt.git           apps/bash/subtrees/git-prompt                   master'
# vim
'vim-pathogen                       https://github.com/tpope/vim-pathogen.git                   vim/subtrees/pathogen                         master'
'vim-airline                        https://github.com/bling/vim-airline.git                    vim/subtrees/vim-airline                      master'
'vim-nerdtree                       https://github.com/scrooloose/nerdtree.git                  vim/subtrees/nerdtree                         master'
'vim-tagbar                         https://github.com/majutsushi/tagbar.git                    vim/subtrees/tagbar                           master'
'vim-monokai                        https://github.com/sickill/vim-monokai.git                  vim/subtrees/vim-monokai                      master'
'vim-node                           https://github.com/moll/vim-node.git                        vim/subtrees/vim-node                         master'
'vim-javascript-syntax              https://github.com/jelera/vim-javascript-syntax.git         vim/subtrees/vim-javascript-syntax            master'
'vim-syntastic                      https://github.com/scrooloose/syntastic.git                 vim/subtrees/syntastic                        master'
'vim-trailing-whitespace            https://github.com/vim-scripts/trailing-whitespace.git      vim/subtrees/trailing-whitespace              master'
'vim-logstash-syntax                https://github.com/vim-scripts/logstash.vim.git             vim/subtrees/logstash-syntax                  master'
'vim-syntax-extra                   https://github.com/justinmk/vim-syntax-extra.git            vim/subtrees/vim-syntax-extra                 master'
'vim-ctrlp                          https://github.com/kien/ctrlp.vim.git                       vim/subtrees/ctrlp                            master'
'vim-plist                          https://github.com/darfink/vim-plist.git                    vim/subtrees/vim-plist                        master'
'powerline-fonts                    https://github.com/chrised/fonts.git                        vim/subtrees/powerline-fonts                  master'
'vim-erlang-runtime                 https://github.com/vim-erlang/vim-erlang-runtime            vim/subtrees/vim-erlang-runtime               master'
'vim-erlang-compiler                https://github.com/vim-erlang/vim-erlang-compiler           vim/subtrees/vim-erlang-compiler              master'
'vim-erlang-tags                    https://github.com/vim-erlang/vim-erlang-tags               vim/subtrees/vim-erlang-tags                  master'
'vim-erlang-skeletons               https://github.com/vim-erlang/vim-erlang-skeletons          vim/subtrees/vim-erlang-skeletons             master'
'vim-gitgutter                      https://github.com/airblade/vim-gitgutter                   vim/subtrees/vim-gitgutter                    master'
'dash.vim                           https://github.com/rizzatti/dash.vim                        vim/subtrees/dash.vim                         master'
'vim-disapprove-deep-indentation    https://github.com/dodie/vim-disapprove-deep-indentation    vim/subtrees/vim-disapprove-deep-indentation  master'
# emacs
'use-package                        https://github.com/jwiegley/use-package                     emacs.d/use-package                             master'
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
    git subtree pull -q --prefix "$3" "$1" "$4" --squash -m "Merge ${4} of ${1} to path ${3}"
}

for subtree in "${SUBTREES[@]}"; do
    subtree_handle $subtree
done


