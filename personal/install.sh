#!/bin/bash

echo "Installing bash configuration..."
ln -s `pwd`/bash_profile ~/.bash_profile

echo "Installing ssh configuration..."
ln -s `pwd`/ssh/config ~/.ssh/config.

echo "Installing vim configuration..."
ln -s `pwd`/vim ~/.vim
ln -s `pwd`/vimrc ~/.vimrc

echo "Installing tmux configuration..."
ln -s `pwd`/tmux.conf ~/.tmux.conf

echo "Installing git configuration..."
ln -s `pwd`/gitignore_global ~/.gitignore_global
git config --global core.excludesfile ~/.gitignore_global

# Add my scripts to the PATH
SCRIPTS=$(ls -1 ./scripts)
for script in ${SCRIPTS}
do
  ln -s `pwd`/scripts/${script} /usr/local/bin/${script}
done
