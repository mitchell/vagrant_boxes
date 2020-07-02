#!/bin/bash

### personal ###
# run my dotfiles sync script
curl -L mjfs.us/sync | fish

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
asdf install elixir 1.10.3-otp-23
asdf global elixir 1.10.3-otp-23

asdf plugin add nodejs
bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring
asdf install nodejs 12.18.2
asdf global nodejs 12.18.2
npm -g install npm@6.14
