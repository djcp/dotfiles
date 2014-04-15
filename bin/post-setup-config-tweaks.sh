#!/bin/bash

echo 'replace dash with bash. . . '
sudo dpkg-reconfigure dash

echo 'Set urxvt as the terminal'
sudo aptitude install rxvt-unicode-256color
sudo update-alternatives --config x-terminal-emulator
