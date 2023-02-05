#!/bin/bash

# TODO Create robust install script

DEPENDENCY_LIST="curl python3 python3-pip"

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

# Dependency Installation Functions
install_dependencies_debian() {
    apt update && apt install -y $DEPENDENCY_LIST
}

install_dependencies_Ubuntu() {
    install_dependencies_debian
}

detect_os_versions() {
    if [ -f /etc/os-release ]; then
        # freedesktop.org and systemd
        . /etc/os-release
        OS=$NAME
        VER=$VERSION_ID
    elif type lsb_release >/dev/null 2>&1; then
        # linuxbase.org
        OS=$(lsb_release -si)
        VER=$(lsb_release -sr)
    elif [ -f /etc/lsb-release ]; then
        # For some versions of Debian/Ubuntu without lsb_release command
        . /etc/lsb-release
        OS=$DISTRIB_ID
        VER=$DISTRIB_RELEASE
    fi
}

detect_os_versions
install_dependencies_$OS

echo $OS
echo $VER
# install_dependencies_debian
