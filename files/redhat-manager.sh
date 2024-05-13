#!/bin/bash
# register/unregister system with redhat

redhat_register() {
  if ! subscription-manager status; then
    if [[ -n $RH_USERNAME ]] && [[ -n $RH_PASSWORD ]]; then
      subscription-manager register --username=$RH_USERNAME --password=$RH_PASSWORD --auto-attach
      subscription-manager usage --set "$usage"
      subscription-manager role --set "$role"
      subscription-manager service-level --set "$service_level"
      subscription-manager repos --enable "$repos"
    else
      echo "Required arguments not found. Please set RH_USERNAME and RH_PASSWORD"
      exit 1
    fi
  fi
}

redhat_unregister() {
  if subscription-manager status; then
    subscription-manager unregister
  fi
}

# Validate arguments
if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <register | unregister>"
  exit 1
fi

# static
usage="Development/Test"
role="RHEL Server"
service_level="Self-Support"
repos="codeready-builder-for-rhel-8-x86_64-rpms"


action="$1"
case $action in
register) redhat_register ;;
unregister) redhat_unregister ;;
*)
  echo "Invalid input!"
  exit 1
  ;;
esac
