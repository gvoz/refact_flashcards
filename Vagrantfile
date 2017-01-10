VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"
  #config.vm.box = "centos/7"
  config.vm.boot_timeout = 60
  config.ssh.forward_agent = true

  config.vm.provider "virtualbox" do |vb|
     vb.memory = "1024"
     vb.name = "v_flashcards"
  end

  config.vm.network "forwarded_port", guest: 3000, host: 3000
  config.vm.synced_folder ".", "/vagrant", type: "virtualbox"

  config.vm.provision :shell, path: "./bootstrap_u.sh"
end
