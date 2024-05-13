## VagrantFile
# box configs
box = "generic/rhel8"
box_name = "basic-box"
box_ip = "10.255.3.77"
box_mem = 4096
box_cpu = 2
box_gui = true
box_network = "private_network"
box_provider = "virtualbox"

# synced (mounted) folders
sync_folder_src = ".." # path on local machine; relative to this Vagrantfile
sync_folder_dst = "/shared" # absolute path on vagrant vm; destination to mount folder


# Vagrant configuration
Vagrant.configure("2") do |config|
  config.ssh.insert_key = true
  config.vm.box = box
  config.vm.synced_folder sync_folder_src, sync_folder_dst
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
  end
end
