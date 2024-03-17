#!/bin/bash
# Install Ansible using Python
python_version="python3.11"

# Check if Python version is installed
if ! command -v $python_version &>/dev/null; then
    sudo dnf -y install epel-release
    sudo dnf -y install $python_version $python_version-pip $python_version-setuptools
    sudo $python_version -m pip install --upgrade pip
    if ! command -v ansible &>/dev/null; then
        sudo $python_version -m pip install ansible
    fi
fi
