#!/bin/bash

me="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# install neobundle
$me/scripts/install-neobundle.sh

# create link ~/.vimrc
pushd ~
ln -s $me/vimrc .vimrc
popd

echo "dependencies: ack, cscope, ctags"
