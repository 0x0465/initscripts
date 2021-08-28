#!/bin/bash
dir=/home/"$(whoami)"
read -p  "Będziem robić init, gotowy? [y/N]" -n 1 -r
echo    
if [[ ! $REPLY =~ ^[Yy]$ ]]
    then
        exit 1
	fi
cd "$dir" || exit 
if [ -d "$dir"/dotfiles ]; then
    read -p "Katalog już istnieje, czy chcesz usunąć i pobrać od nowa? [y/N]" -n 1 -r
    echo
    if [[ ! $REPLY =~ ^^[Yy]$ ]]
	then 
	echo "Nic nie robię"
	exit 1
    else
	echo "Usuwam dotfiles"
	rm -rf "$dir"/dotfiles
	rm "$dir"/.vimrc
        rm "$dir"/.tmux.conf
        echo "Ściągam z gita"
        git clone https://github.com/dr6g1/dotfiles
        find "$dir"/dotfiles -maxdepth 1 -type f \( -name ".*" ! -name ".git" \) | while read file;do ln -s "$file" "$dir"/;done
    fi
echo "Skrypt gotowy"
fi
