#!/bin/bash
cd "$(dirname "${BASH_SOURCE}")"

function doIt() {
    exclude_list="setup.sh Monaco-Powerline.otf web_start.sh oh-my-zsh tmux-powerline .git .gitmodules .DS_store bootstrap.sh README.md more_python.txt . .. requirements.txt"

    for i in .*; do
        if ! [ -z ${i/*.swp/} ] && ! [[ $exclude_list =~ $i ]]
        then
            if [ -d ~/$i ]; then # ln is weird for directories.
                ln -s -i $(pwd)/$i ~
            else
                ln -s -i $(pwd)/$i ~/$i
            fi
        fi
    done
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
    doIt
else
    read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
	doIt
    fi
fi
unset doIt
source ~/.bash_profile
