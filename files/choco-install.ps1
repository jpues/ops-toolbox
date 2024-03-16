# Check if running with Admin
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    # Relaunch the script as an admin
    Start-Process powershell.exe -Verb RunAs -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`""
    Exit
}

# Chocolatey
function InstallChoco {
    if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
        # Install Chocolatey (Package Manager for Windows)
        Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
        Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
        # Verify Chocolatey installation
        choco --version
        choco feature enable -n useFipsCompliantChecksums
    }
    else {
        Write-Host "Chocolatey is already installed."
    }
}

# Vagrant
function InstallVagrant {
    if (-not (Get-Command vagrant -ErrorAction SilentlyContinue)) {
        Write-Host "Vagrant is not installed. Installing..."
        choco install vagrant -y
    }
    else {
        Write-Host "Vagrant is already installed."
    }
}

# Packer
function InstallPacker {
    if (-not (Get-Command packer -ErrorAction SilentlyContinue)) {
        Write-Host "Packer is not installed. Installing..."
        choco install packer -y
    }
    else {
        Write-Host "Packer is already installed."
    }
}

# Virtualbox
function InstallVirtualbox {
    if (-not (Get-Command VBoxManage -ErrorAction SilentlyContinue)) {
        Write-Host "VirtualBox is not installed. Installing..."
        choco install virtualbox -y
    }
    else {
        Write-Host "VirtualBox is already installed."
    }
}

InstallChoco
InstallVagrant
InstallPacker
InstallVirtualbox

# Sleep before exiting script
Write-Host "Installations complete! (script will exit in 10 seconds)"
Start-Sleep -Seconds 10
