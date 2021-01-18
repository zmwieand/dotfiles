# dotfiles
My Linux/MacOS configuration files

### Getting Started
1. Clone this repository
```bash
git clone git@github.com/zmwieand/dotfiles.git
```

2. Move into the direcotry containing the files
```bash
cd dotfiles/
```

3. Run the installation script
```bash
./install.sh
```
**NOTE**: open the script to make sure this is doing exactly what you expect.
This script is made for MacOS using `zsh` with homebrew installed.

### Components
##### brew (MacOS)
You will need to make sure [homebrew](https://brew.sh/) is installed.

```
ln -s -f `pwd`/brew/Brewfile ~/Brewfile
ln -s -f `pwd`/brew/Brewfile.lock.json ~/Brewfile.lock.json
brew bundle install
```

##### zsh/bash
If you are using `zsh`
```
ln -s -f `pwd`/zsh/zshrc ~/.zshrc
```
From there you can set a `.zprofile` for the specific machine.

If you are using `bash`
```
ln -s -f `pwd`/bash/bashrc ~/.bashrc
```
From there you can set a `.bash_profile` for the specific machine.

##### git
Includes a gitconfig with my information, various aliases and a global gitignore
```
ln -s -f `pwd`/git/gitconfig ~/.gitconfig
ln -s -f `pwd`/git/gitignore_global ~/.gitignore_global
```

##### vim
This includes vimrc configuration, colorschemes and pathogen plugins.

```
ln -s -f `pwd`/vim ~/.vim
ln -s -f `pwd`/vimrc ~/.vimrc
```

plugins:
- NERDTree

colorschemes:
- solarized

##### tmux
```
ln -s -f `pwd`/tmux.conf ~/.tmux.conf
```

##### Backups
Create a file `~/backuprc` in the following format
```yaml
nas:
  user: ___
  machineName: ___
  mountLocation: /path/to/mount/point
  server: 0.0.0.0

gpg
  recipient: 'email@example.con'

paths: []
```

I also recommend adding the following to `/etc/sudoers` or run `sudo visudo`
```
<user>  ALL = (ALL) NOPASSWD: /usr/bin/pkill
```

##### Crontab
Responsible for nightly backups at 3:05am. May need to adjust energy saving
preferences for laptops to wake before hand.
```
ln -s -f `pwd`/crontab ~/.crontab
crontab ~/.crontab
```

##### Custom Scripts
The following will add links to custom scripts to `/usr/local/bin/*.sh` so they
are on the `PATH`.

```
SCRIPTS=$(ls -1 ./scripts)
for script in ${SCRIPTS}
do
  ln -s -f `pwd`/scripts/${script} /usr/local/bin/${script}
done
```
