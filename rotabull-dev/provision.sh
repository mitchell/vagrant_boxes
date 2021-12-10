#!/bin/bash

### personal ###
# run my dotfiles sync script
curl -fsSL sync.mjfs.us | fish

### project tools ###
# install heroku cli
curl https://cli-assets.heroku.com/install-ubuntu.sh | sh

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

asdf plugin add erlang
asdf install erlang 23.0.2
asdf global erlang 23.0.2

asdf plugin add elixir
asdf install elixir 1.12.3-otp-23
asdf global elixir 1.12.3-otp-23

asdf plugin add terraform
asdf install terraform 0.13.5
asdf global terraform 0.13.5

asdf plugin add packer
asdf install packer 1.6.4
asdf global packer 1.6.4

asdf plugin add nodejs
asdf install nodejs 12.18.4
asdf global nodejs 12.18.4
npm install --global npm
