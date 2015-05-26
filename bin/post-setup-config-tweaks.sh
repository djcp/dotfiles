#!/bin/bash

echo 'replace dash with bash. . . '
sudo dpkg-reconfigure dash

echo 'Set urxvt as the terminal'
sudo aptitude install rxvt-unicode-256color
sudo update-alternatives --config x-terminal-emulator

echo 'open magnet links with qBittorrent'
xdg-mime default qBittorrent.desktop x-scheme-handler/magnet

echo 'install ntp'
sudo aptitude install ntp

echo 'install iptables-persistent and relevant rules'
sudo aptitude install iptables-persistent
sudo ln -s /home/djcp/code/dotfiles/rules.v4 /etc/iptables/rules.v4
