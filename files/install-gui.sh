#!/bin/bash
# dnf groupinstall "Server with GUI"
# dnf groupinstall "Workstation"
gui="Server with GUI"
sudo dnf -y groupinstall "${gui}"
sudo systemctl set-default graphical
