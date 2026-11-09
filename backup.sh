#!/usr/bin/env bash
cd ~/dotfiles
cp ~/.bashrc .bashrc
cp ~/.config/ghostty/config ghostty/config
cp ~/.config/starship.toml starship/starship.toml
git add .
git commit -m "Actualización $(date +%F)" && git push
