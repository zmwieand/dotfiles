#!/bin/bash

echo "Installing brew configuration..."
ln -s -f `pwd`/brew/Brewfile ~/Brewfile

echo "Installing zsh configuration..."
ln -s -f `pwd`/zsh/zshrc ~/.zshrc

echo "Installing vim configuration..."
DIR=$(pwd)
cd ~/
if [[ ! -d ~/.vim ]]; then
  ln -s -f ${DIR}/vim .vim
fi 
ln -s -f ${DIR}/vimrc .vimrc
cd ${DIR}

echo "Installing tmux configuration..."
ln -s -f `pwd`/tmux.conf ~/.tmux.conf

echo "Installing git configuration..."
ln -s -f `pwd`/git/gitconfig ~/.gitconfig
ln -s -f `pwd`/git/gitignore_global ~/.gitignore_global

echo "Installing crontab for user..."
ln -s -f `pwd`/crontab ~/.crontab
crontab ~/.crontab

# Add my scripts to the PATH
echo "Installing custom scripts..."
SCRIPTS=$(ls -1 ./scripts)
for script in ${SCRIPTS}
do
  ln -s -f `pwd`/scripts/${script} /usr/local/bin/${script}
done
