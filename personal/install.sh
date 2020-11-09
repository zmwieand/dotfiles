#!/bin/bash

echo "Installing zsh configuration..."
ln -s -f `pwd`/zshrc ~/.zshrc

echo "Installing ssh configuration..."
ln -s -f `pwd`/ssh/config ~/.ssh/config

echo "Installing vim configuration..."
DIR=$(pwd)
cd ~/
if [[ ! -d ~/.vim ]]; then
  echo "~/.vim dir DNE"
  ln -s -f ${DIR}/vim .vim
fi 
ln -s -f ${DIR}/vimrc .vimrc
cd ${DIR}

echo "Installing tmux configuration..."
ln -s -f `pwd`/tmux.conf ~/.tmux.conf

echo "Installing git configuration..."
ln -s -f `pwd`/gitignore_global ~/.gitignore_global
git config --global core.excludesfile ~/.gitignore_global

# Add my scripts to the PATH
echo "Installing custom scripts..."
SCRIPTS=$(ls -1 ./scripts)
for script in ${SCRIPTS}
do
  ln -s -f `pwd`/scripts/${script} /usr/local/bin/${script}
done
