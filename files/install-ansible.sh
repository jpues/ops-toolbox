#!/bin/bash
# install ansible using python
python_version="python3.11"
if ! command -v $python_version &>/dev/null; then
    sudo dnf -y install epel-release
    sudo dnf -y install $python_version $python_version-pip $python_version-setuptools
    sudo $python_version -m pip install --upgrade pip
    if ! command -v ansible &>/dev/null; then
        $python_version -m pip install ansible
    fi
fi
