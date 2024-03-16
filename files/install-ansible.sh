#!/bin/bash
# install ansible using python
py="python3.11"
if ! command -v $py 2>&1 >/dev/null; then
    sudo dnf -y install epel-release
    sudo dnf -y install $py $py-pip $py-setuptools
    sudo $py -m pip install --upgrade pip
    if ! command -v ansible 2>&1 >/dev/null; then
        $py -m pip install ansible
    fi
fi
