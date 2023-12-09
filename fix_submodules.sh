#!/bin/sh

cd $(dirname ${0})

git submodule foreach git reset HEAD .
git submodule foreach git checkout .
git submodule foreach git clean -dfx .
./update
