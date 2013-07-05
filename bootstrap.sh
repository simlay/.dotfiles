#!/bin/bash
cd "$(dirname "${BASH_SOURCE}")"

function doIt() {
    export exclude_list="echo setup.sh Monaco-Powerline.otf web_start.sh oh-my-zsh tmux-powerline .git .gitmodules .DS_store bootstrap.sh README.md more_python.txt .*swp . .. requirements.txt"

    for i in .*; do
        if echo $i | grep -v 'swp' > /dev/null 2> /dev/null && ! [[ $exclude_list =~ $i ]]
        then
            ln -s -i $(pwd)/$i ~/$i
        fi
    done

    #rsync --exclude "setup.sh" --exclude "Monaco-Powerline.otf" --exclude "web_start.sh" \
    #    --exclude "oh-my-zsh" --exclude "tmux-powerline" --exclude ".git/" \
    #    --exclude ".gitmodules" \
    #    --exclude ".DS_Store" --exclude "bootstrap.sh" --exclude "README.md" \
    #    --exclude "requirements.txt" --exclude "more_python.txt" \
    #    -av . ~
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
