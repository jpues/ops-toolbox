#!/bin/bash

# Function to add user group
add_user_group() {
  local group_name="$1"
  groupadd "$group_name" >/dev/null 2>&1
}

# Function to add user
add_user() {
  local username="$1"
  local password="$2"
  useradd -m -s /bin/bash "$username" >/dev/null 2>&1
  echo -e "$password" | passwd "$username" >/dev/null 2>&1
  sudo usermod -aG wheel "$username" >/dev/null 2>&1
}

# Function to allow passwordless sudo
allow_passwordless_sudo() {
  local group_name="$1"
  echo "%$group_name ALL=(ALL) NOPASSWD: ALL" | (EDITOR="tee -a" visudo)
  if [ $? -eq 0 ]; then
    echo "Passwordless sudo access granted for group $group_name."
  else
    echo "Error: Failed to grant passwordless sudo access for group $group_name." >&2
  fi
}

# Parse command-line options
while getopts ":u:p:" opt; do
  case $opt in
  u) os_username="$OPTARG" ;;
  p) os_password="$OPTARG" ;;
  \?)
    echo "Usage: $0 -u <username> -p <password>"
    exit 1
    ;;
  esac
done
shift $((OPTIND - 1))

# If username and password are not provided via flags, check for environment variables
[[ -n $os_username ]] || os_username="$OS_USERNAME"
[[ -n $os_password ]] || os_password="$OS_PASSWORD"

# Check if username and password are defined
if [ -n "$os_username" ] && [ -n "$os_password" ]; then
  add_user_group "$os_username"
  add_user "$os_username" "$os_password"
  allow_passwordless_sudo "$os_username"
else
  echo "Error: Username and/or password not provided." >&2
  exit 1
fi
