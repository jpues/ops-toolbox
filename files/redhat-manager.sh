#!/bin/bash
# Register/Unregister System with RedHat
register() {
  if ! subscription-manager status; then
    if [[ -n $RH_USERNAME ]] && [[ -n $RH_PASSWORD ]]; then
      subscription-manager register --username=$RH_USERNAME --password=$RH_PASSWORD --auto-attach
      subscription-manager usage --set "Development/Test"
      subscription-manager role --set "RHEL Server"
      subscription-manager service-level --set "Self-Support"
      subscription-manager repos --enable "codeready-builder-for-rhel-8-x86_64-rpms"
    else
      echo "Required arguments not found. Please set RH_USERNAME and RH_PASSWORD"
    fi
  fi
}

unregister() {
  if subscription-manager status; then
    subscription-manager unregister
  fi
}

action="$1"
[[ $action =~ ^(register|unregister)$ ]] || (echo "Invalid input!" && exit 1)

$action
