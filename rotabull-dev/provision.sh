#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

main() {
  sudo apt-get update

  configure_system
  install_project_deps
  install_docker
  install_fish
  install_heroku
  install_m_env
  install_asdf
  install_erlang
  install_elixir
  install_node
  install_neovim
}

# configure_system configures various system level settings
configure_system() {
  # set timezone
  sudo ln -fs /usr/share/zoneinfo/US/Eastern /etc/localtime
  sudo dpkg-reconfigure -f noninteractive tzdata

  # set locale
  sudo sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
  sudo locale-gen

  # set inotify max_user_watches
  echo | sudo tee -a /etc/sysctl.conf
  echo '# Set inotify max watches' | sudo tee -a /etc/sysctl.conf
  echo 'fs.inotify.max_user_watches=524288' | sudo tee -a /etc/sysctl.conf
}

# install_project_deps installs binary project dependencies (e.g chrome-driver)
install_project_deps() {
  sudo apt-get install --yes chromium-driver inotify-tools
}

# install_fish installs fish from the recommended fish repos
install_fish() {
  sudo apt-get install --yes curl gpg

  echo 'deb http://download.opensuse.org/repositories/shells:/fish:/release:/3/Debian_10/ /' | sudo tee /etc/apt/sources.list.d/shells:fish:release:3.list 
  curl -fsSL https://download.opensuse.org/repositories/shells:fish:release:3/Debian_10/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/shells:fish:release:3.gpg > /dev/null

  sudo apt-get update
  sudo apt-get install --yes fish

  # change vagrant user's default shell to fish
  sudo chsh -s /usr/bin/fish vagrant
}

# install_docker installs docker from their official repos
install_docker() {
  sudo apt-get install --yes \
    apt-transport-https ca-certificates curl \
    gnupg2 software-properties-common

  # install docker-ce
  curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
  sudo add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/debian \
    $(lsb_release -cs) \
    stable"

  sudo apt-get update
  sudo apt-get install --yes docker-ce docker-ce-cli containerd.io

  # install docker-compose
  sudo curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose

  # add vagrant user to docker group
  sudo adduser vagrant docker
}

# install_heroku installs heroku using their script which sets up their apt repos
install_heroku() {
  curl https://cli-assets.heroku.com/install-ubuntu.sh | sh
}

# install_m_env syncs m's dotfiles
install_m_env() {
  sudo apt-get install --yes git curl rsync tmux kitty-terminfo

  # sync dotfiles
  curl -L mjfs.us/sync | fish
}

# install_asdf installs asdf from the git repo to the vagrant home dir
install_asdf() {
  sudo apt-get install --yes \
    automake autoconf libreadline-dev \
    libncurses-dev libssl-dev libyaml-dev \
    libxslt-dev libffi-dev libtool \
    unixodbc-dev unzip curl

  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.7.8

  echo 'source ~/.asdf/asdf.fish' >> ~/.config/fish/config.fish
  cp ~/.asdf/completions/asdf.fish ~/.config/fish/completions

  . $HOME/.asdf/asdf.sh
}

# install_erlang installs erlang using asdf
install_erlang() {
  sudo apt-get install --yes \
    build-essential autoconf m4 \
    libncurses5-dev libwxgtk3.0-gtk3-dev libgl1-mesa-dev \
    libglu1-mesa-dev libpng-dev libssh-dev \
    unixodbc-dev xsltproc fop \
    libxml2-utils libncurses-dev openjdk-11-jdk

  asdf plugin add erlang
  asdf install erlang 23.0.2
  asdf global erlang 23.0.2
}

# install_elixir installs elixir using asdf
install_elixir() {
  asdf plugin add elixir
  asdf install elixir 1.10.3-otp-23
  asdf global elixir 1.10.3-otp-23
}

# install_node installs node using asdf
install_node() {
  asdf plugin add nodejs
  bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring
  asdf install nodejs 12.18.2
  asdf global nodejs 12.18.2
  npm -g install npm@6.14
}

# install_neovim installs neovim using asdf
install_neovim() {
  asdf plugin add neovim
  asdf install neovim 0.4.3
  asdf global neovim 0.4.3
}

main
