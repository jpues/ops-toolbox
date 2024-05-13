## VagrantFile
# box configs
box = "generic/rhel8"
box_name = "rhel8-toolbox"
box_ip = "10.255.7.17"
box_mem = 4096
box_cpu = 2
box_gui = true
box_network = "private_network"
box_provider = "virtualbox"
redhat_username  = "<%= ENV['RH_USERNAME'] %>" # environment var RH_USERNAME
redhat_password  = "<%= ENV['RH_PASSWORD'] %>" # environment var RH_PASSWORD

# provisioner files
redhat_manager = "files/redhat-manager.sh"
install_ansible = "files/install-ansible.sh"
install_gui = "files/install-gui.sh"

# synced/mounted folders
synced_folder_src = ".." # path to mount to vm; relative to this file
synced_folder_dest = "/shared" # path on vm to mount to

# exit if RH_USERNAME and RH_PASSWORD aren't set
if !redhat_username or !redhat_password
  puts 'Required environment variables not found. Please set RH_USERNAME and RH_PASSWORD'
  abort
end

# Vagrant configuration
Vagrant.configure("2") do |config|
  config.ssh.insert_key = true
  config.vm.box = box
  config.vm.synced_folder synced_folder_src, synced_folder_dest
  config.vm.define box_name do |box|
    box.vm.hostname = box_name
    box.vm.network box_network, ip: box_ip
    config.vbguest.auto_update = false # disable for initial `vagrant up`, can run manually/enable later
    config.vm.provider box_provider do |v|
      v.gui = box_gui
      v.memory = box_mem
      v.cpus = box_cpu
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--ioapic", "on"]
      v.customize ["modifyvm", :id, "--graphicscontroller", "vmsvga"]
      v.customize ["modifyvm", :id, "--vram", "128"]
      v.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
    end
    # provisioners - set environment variables before running `vagrant up`
    box.vm.provision "shell" do |shell|
      shell.path = redhat_manager
      shell.args = "register"
      shell.env = {
        "RH_USERNAME"=>ENV['RH_USERNAME'],
        "RH_PASSWORD"=>ENV['RH_PASSWORD']
      }
    end
    box.vm.provision "shell", path: install_ansible
    box.vm.provision "shell", path: install_gui
  end
  # if `vagrant destroy` is run, unregister from redhat
  config.trigger.before :destroy do |trigger|
    trigger.name = "Before Destroy trigger"
    trigger.info = "Unregistering this VM from RedHat Subscription Manager..."
    trigger.warn = "If this fails, unregister VM manually at https://access.redhat.com/management/systems"
    trigger.run_remote = {
      path: redhat_manager,
      args: "unregister"
    }
    trigger.on_error = :continue
  end
end
