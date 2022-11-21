#!/bin/bash

check_dependencies() {
    if ! [ -x "$(command -v python3)" ] 
    then
        echo "Need to Install Python3 and Pip"
        sudo apt install python3 python3-pip
    fi

    if ! [[ ":$PATH:" == *":$HOME/.local/bin:"* ]];
    then
        echo "Ensuring path is set correctly"
        export PATH="$PATH:$HOME/.local/bin"
    fi

    if ! [ -x "$(command -v ansible)" ] 
    then
        echo "Need to Install Ansible"
        pip3 install --user ansible
    fi
}

check_dependencies
ansible-playbook --ask-become ./configure.yaml
