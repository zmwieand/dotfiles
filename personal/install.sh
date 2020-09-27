#!/bin/bash

echo "Installing bash configuration..."
ln -s `pwd`/bashrc ~/.bashrc

echo "Installing ssh configuration..."
ln -s `pwd`/ssh/config ~/.ssh/config

echo "Installing vim configuration..."
DIR=$(pwd)
cd ~/
if [[ ! -d ~/.vim ]]; then
  echo "~/.vim dir DNE"
  ln -s ${DIR}/vim .vim
fi 
ln -s ${DIR}/vimrc .vimrc
cd ${DIR}

echo "Installing tmux configuration..."
ln -s `pwd`/tmux.conf ~/.tmux.conf

echo "Installing git configuration..."
ln -s `pwd`/gitignore_global ~/.gitignore_global
git config --global core.excludesfile ~/.gitignore_global

# Add my scripts to the PATH
echo "Installing custom scripts..."
SCRIPTS=$(ls -1 ./scripts)
for script in ${SCRIPTS}
do
  ln -s `pwd`/scripts/${script} /usr/local/bin/${script}
done
