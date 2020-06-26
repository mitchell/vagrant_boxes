#!/bin/bash

### timezone and locale ###
# set timezone
ln -fs /usr/share/zoneinfo/US/Eastern /etc/localtime
dpkg-reconfigure -f noninteractive tzdata

# set locale
sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
locale-gen

### personal ###
# deps for my dotfiles
apt-get update
apt-get install -y git curl rsync tmux kitty-terminfo

### fish shell ###
# deps for installing fish
apt-get install -y wget gpg

# adding the fish repo and installing fish
echo 'deb http://download.opensuse.org/repositories/shells:/fish:/release:/3/Debian_10/ /' > /etc/apt/sources.list.d/shells:fish:release:3.list
wget -nv https://download.opensuse.org/repositories/shells:fish:release:3/Debian_10/Release.key -O Release.key
apt-key add - < Release.key
rm Release.key
apt-get update
apt-get install -y fish

# change vagrant user's default shell to fish
chsh -s /usr/bin/fish vagrant

### docker ###
# deps for docker
apt-get install -y \
  apt-transport-https ca-certificates curl \
  gnupg2 software-properties-common

# install docker-ce
curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
add-apt-repository \
  "deb [arch=amd64] https://download.docker.com/linux/debian \
  $(lsb_release -cs) \
  stable"
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io

# install docker-compose
curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# add vagrant user to docker group
adduser vagrant docker

### asdf-vm ###
# deps for asdf-vm
apt-get install -y \
  automake autoconf libreadline-dev \
  libncurses-dev libssl-dev libyaml-dev \
  libxslt-dev libffi-dev libtool \
  unixodbc-dev unzip curl

### awscli ###
# install awscliv2
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install
rm awscliv2.zip
rm -r ./aws
