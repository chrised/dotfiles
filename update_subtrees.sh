#!/bin/bash

SUBTREES=(
# shell
'bash-git-prompt                    https://github.com/magicmonty/bash-git-prompt.git           apps/bash/subtrees/git-prompt                 master'
# vim
'powerline-fonts                    https://github.com/chrised/fonts.git                        vim/subtrees/powerline-fonts                  master'
'vim-airline                        https://github.com/bling/vim-airline.git                    vim/subtrees/vim-airline                      master'
'vim-disapprove-deep-indentation    https://github.com/dodie/vim-disapprove-deep-indentation    vim/subtrees/vim-disapprove-deep-indentation  master'
'vim-erlang-skeletons               https://github.com/vim-erlang/vim-erlang-skeletons          vim/subtrees/vim-erlang-skeletons             master'
'vim-gitgutter                      https://github.com/airblade/vim-gitgutter                   vim/subtrees/vim-gitgutter                    master'
'vim-javascript-syntax              https://github.com/jelera/vim-javascript-syntax.git         vim/subtrees/vim-javascript-syntax            master'
'vim-logstash-syntax                https://github.com/vim-scripts/logstash.vim.git             vim/subtrees/logstash-syntax                  master'
'vim-monokai                        https://github.com/sickill/vim-monokai.git                  vim/subtrees/vim-monokai                      master'
'vim-node                           https://github.com/moll/vim-node.git                        vim/subtrees/vim-node                         master'
'vim-pathogen                       https://github.com/tpope/vim-pathogen.git                   vim/subtrees/pathogen                         master'
'vim-plist                          https://github.com/darfink/vim-plist.git                    vim/subtrees/vim-plist                        master'
'vim-syntastic                      https://github.com/scrooloose/syntastic.git                 vim/subtrees/syntastic                        master'
'vim-tagbar                         https://github.com/majutsushi/tagbar.git                    vim/subtrees/tagbar                           master'
'vim-trailing-whitespace            https://github.com/vim-scripts/trailing-whitespace.git      vim/subtrees/trailing-whitespace              master'
# emacs
'use-package                        https://github.com/jwiegley/use-package                     emacs.d/use-package                           master'
)



subtree_handle() {
    # subtree_handle remote_name remote_url relative_path branch
    if [ -z "${4}" ]; then
        echo "Not enough args"
        echo "${4}"
        return
    fi
    git remote add -f "${1}" "${2}"
    if [ ! -d "${3}" ]; then
        git subtree add -q --squash --prefix "${3}" "${1}" "${4}"
    fi
    git fetch "${1}"
    git merge --squash -s subtree -Xsubtree="${3}" -Xtheirs --allow-unrelated-histories --no-commit "${1}/${4}"
    git commit -m "Merge ${4} of ${1} to path ${3}"
    #git subtree pull -q --prefix "${3}" "${1}" "${4}" --squash -m "Merge ${4} of ${1} to path ${3}"
}

for subtree in "${SUBTREES[@]}"; do
    # shellcheck disable=SC2086
    subtree_handle ${subtree}
done


