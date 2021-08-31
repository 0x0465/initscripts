#!/bin/bash
dir=/home/"$(whoami)"
read -p  "Are you sure? [y/N]" -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
    then
        exit 1
        fi
        
# Ignore case-sensitive in autocompletion       
if [ ! -a ~/.inputrc ]; then echo '$include /etc/inputrc' > ~/.inputrc; fi
echo 'set completion-ignore-case On' >> ~/.inputrc     

cd "$dir" || exit
if [ -d "$dir"/dotfiles ];then
    read -p "Directory ~/dotfiles already exists, overwrite? [y/N]" -n 1 -r
    echo
    if [[ ! $REPLY =~ ^^[Yy]$ ]]
        then
        echo "Doing nothing, script aborted"
        exit 1
    else
        echo "Deleting ~/dotflies"
        rm -rf "$dir"/dotfiles
        rm "$dir"/.vimrc
        rm "$dir"/.tmux.conf
        echo "Downloading files from github"
        git clone https://github.com/dr6g1/dotfiles
        find "$dir"/dotfiles -maxdepth 1 -type f \( -name ".*" ! -name ".git" \) | while read file;do ln -s "$file" "$dir"/;done
    fi
else
     rm "$dir"/.vimrc
     rm "$dir"/.tmux.conf
     echo "Downloading files from github"
     git clone https://github.com/dr6g1/dotfiles
     find "$dir"/dotfiles -maxdepth 1 -type f \( -name ".*" ! -name ".git" \) | while read file;do ln -s "$file" "$dir"/;done
echo "Script ready"
fi
