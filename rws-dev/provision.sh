#!/bin/bash

### personal ###
# run my dotfiles sync script
curl -fsSL sync.mjfs.us | fish

### asdf-vm ###
# install asdf vm
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.7.7
echo 'source ~/.asdf/asdf.fish' >> ~/.config/fish/config.fish
cp ~/.asdf/completions/asdf.fish ~/.config/fish/completions

# install various tools/languages with asdf
. $HOME/.asdf/asdf.sh
export PATH=$PATH:$HOME/.asdf/bin/

asdf plugin add neovim
asdf install neovim 0.4.3
asdf global neovim 0.4.3

asdf plugin add dotnet-core
asdf install dotnet-core 3.1.200
asdf global dotnet-core 3.1.200
