# ops-toolbox
Virtual machine repo for DevOps tools

## pre-requisites
- git
- Vagrant
- VirtualBox
- RedHat Developer Subscription (optional) > https://developers.redhat.com

(_run `choco-install.ps1` in Windows Command Prompt/Powershell to install pre-reqs if using Windows_)
```
powershell -ExecutionPolicy Bypass -File choco-install.ps1
```
### Environment Variables
Set environment variables prior to running `vagrant up` command (these are not required)

|Variable|Description|If provided|Default|
|--------|-----------|-----------|-------|
|RH_USERNAME|username for RedHat subscription|Registers system with RedHat||
|RH_PASSWORD|password for RedHat subsecrition|Registers system with RedHat||

## vagrant
To launch this VM using Vagrant
- Open Git terminal
- clone ops-toolbox repository to local
- navigate to ops-toolbox directory
- run `vagrant up` (ensure environment variables are set prior to running if necessary)
```
git clone https://github.com/jpues/ops-toolbox.git
cd ops-toolbox
vagrant up
```
