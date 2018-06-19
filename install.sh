#!/bin/bash

me="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# install neobundle
$me/scripts/install-neobundle.sh

# create link ~/.vimrc
pushd ~
ln -s $me/vimrc .vimrc
popd

echo "Please install dependencies: "
echo "ack, cscope, ctags"
