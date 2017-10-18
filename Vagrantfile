# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
#VAGRANTFILE_API_VERSION = "2"

#Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|


#  config.vm.box = "ubuntu/trusty64"
#  config.vm.hostname = "nbddata.dev"

#  config.vm.network :private_network, ip: "192.168.111.110"
#  config.vm.synced_folder "./", "/var/www/nbddata", id: "nginx", type: "nfs", mount_options: ["nolock"]

#  config.ssh.forward_agent = true

#  config.vm.provider :virtualbox do |v|
#    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
#    v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
#    v.customize ["modifyvm", :id, "--memory", 1024]
#    v.customize ["modifyvm", :id, "--cpus"  , 1]
#  end

#  config.vm.provision "shell", path: "ansible/vagrant-bootstrap.sh"
#end


# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # server1.example.com (Bootstrap server)
  config.vm.define :svr1 do |svr1|
    svr1.vm.box      = "ubuntu/trusty64"
    svr1.vm.hostname = "server1.example.com"
    svr1.hostsupdater.aliases = ["server1.example.com"]
    svr1.vm.network :private_network, ip: "192.0.2.1"
    #svr1.vm.network "public_network", ip: "192.0.2.1"
    #svr1.vm.synced_folder "./", "/var/www/miyagi", id: "nginx", type: "nfs", mount_options: ["nolock"]
    svr1.ssh.forward_agent = true
    svr1.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
      v.customize ["modifyvm", :id, "--memory", 512]
      v.customize ["modifyvm", :id, "--cpus"  , 1]
    end


	[
		{ 'play' => "ansible/playbooks/consul", 'tags' => [ "build", "download_application" ] },
		#{ 'play' => "environment", 'tags' => [ "build", "configure" ] },
		{ 'play' => "ansible/playbooks/consul", 'tags' => [ "configure_bootstrap", "check" ] }
	].each do | run |
		svr1.vm.provision "ansible" do |ansible|
			ansible.playbook = "#{run['play']}.yml"
			ansible.extra_vars = {
			    'hosts' => 'svr1',
				'pwd' => File.expand_path('../../'),
				'svr2_ip' => '192.0.2.2',
				'svr3_ip' => '192.0.2.3',
				'private_ip' => '192.0.2.1'
			}
			#ansible.inventory_path = "ansible/inventory/localhost"
			ansible.tags = run['tags']
			ansible.verbose = "vvvv"
		end
	end


    #svr1.vm.provision "shell", path: "ansible/vagrant-bootstrap.sh"


  end





  # server2.example.com
  config.vm.define :svr2 do |svr2|
    svr2.vm.box      = "ubuntu/trusty64"
    svr2.vm.hostname = "server2.example.com"
    svr2.hostsupdater.aliases = ["server2.example.com"]
    svr2.vm.network :private_network, ip: "192.0.2.2"
    #svr2.vm.network "public_network", ip: "192.0.2.2"
    svr2.ssh.forward_agent = true
    svr2.vm.provider :virtualbox do |v|
      #v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      #v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
      v.customize ["modifyvm", :id, "--memory", 512]
      v.customize ["modifyvm", :id, "--cpus"  , 1]
    end


	[
		{ 'play' => "ansible/playbooks/consul", 'tags' => [ "build" ] },
		#{ 'play' => "environment", 'tags' => [ "build", "configure" ] },
		{ 'play' => "ansible/playbooks/consul", 'tags' => [ "configure", "check" ] }
	].each do | run |
		svr2.vm.provision "ansible" do |ansible|
			ansible.playbook = "#{run['play']}.yml"
			ansible.extra_vars = {
			    'hosts' => 'svr2',
				'pwd' => File.expand_path('../../'),
				'hostname' => svr2.vm.hostname,
				'private_ip' => '192.0.2.2'
			}
			#ansible.inventory_path = "ansible/inventory/localhost"
			ansible.tags = run['tags']
			ansible.verbose = "vvvv"
		end
	end
  end


  # server3.example.com
  config.vm.define :svr3 do |svr3|
    svr3.vm.box      = "ubuntu/trusty64"
    svr3.vm.hostname = "server3.example.com"
    svr3.hostsupdater.aliases = ["server3.example.com"]
    svr3.vm.network :private_network, ip: "192.0.2.3"
    #svr3.vm.network "public_network", ip: "192.0.2.3"
    svr3.ssh.forward_agent = true
    svr3.vm.provider :virtualbox do |v|
      #v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      #v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
      v.customize ["modifyvm", :id, "--memory", 512]
      v.customize ["modifyvm", :id, "--cpus"  , 1]
    end


	[
		{ 'play' => "ansible/playbooks/consul", 'tags' => [ "build" ] },
		#{ 'play' => "environment", 'tags' => [ "build", "configure" ] },
		{ 'play' => "ansible/playbooks/consul", 'tags' => [ "configure", "check" ] }
	].each do | run |
		svr3.vm.provision "ansible" do |ansible|
			ansible.playbook = "#{run['play']}.yml"
			ansible.extra_vars = {
			    'hosts' => 'svr3',
				'pwd' => File.expand_path('../../'),
				'hostname' => svr3.vm.hostname,
				'private_ip' => '192.0.2.3'
			}
			#ansible.inventory_path = "ansible/inventory/localhost"
			ansible.tags = run['tags']
			ansible.verbose = "vvvv"
		end
	end
  end


  # agent1.example.com
  config.vm.define :agent1 do |agent1|
    agent1.vm.box      = "ubuntu/trusty64"
    agent1.vm.hostname = "agent1.example.com"
    agent1.hostsupdater.aliases = ["agent1.example.com"]
    agent1.vm.network :private_network, ip: "192.0.2.53"
    #agent1.vm.network "public_network", ip: "192.0.2.53"
    agent1.ssh.forward_agent = true
    agent1.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
      v.customize ["modifyvm", :id, "--memory", 512]
      v.customize ["modifyvm", :id, "--cpus"  , 1]
    end


	[
		{ 'play' => "ansible/playbooks/consul", 'tags' => [ "build", "build_webserver" ] },
		#{ 'play' => "environment", 'tags' => [ "build", "configure" ] },
		{ 'play' => "ansible/playbooks/consul", 'tags' => [ "configure_agent", "configure_webserver", "check" ] }
	].each do | run |
		agent1.vm.provision "ansible" do |ansible|
			ansible.playbook = "#{run['play']}.yml"
			ansible.extra_vars = {
			    'hosts' => 'agent1',
				'pwd' => File.expand_path('../../'),
				'hostname' => agent1.vm.hostname,
				'private_ip' => '192.0.2.53',
				'svr2_ip' => '192.0.2.2'
			}
			#ansible.inventory_path = "ansible/inventory/localhost"
			ansible.tags = run['tags']
			ansible.verbose = "vvvv"
		end
	end
  end




  # Db for Miyagi
  config.vm.define :db do |db|
    db.vm.box = "ubuntu/trusty64"
    db.vm.network :private_network, ip: "192.168.111.103"
    config.vm.synced_folder "./", "/var/www/timeout", id: "vagrant-root", type: "nfs", mount_options: ["nolock"]
    db.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
      v.customize ["modifyvm", :id, "--memory", 512 ]
      v.customize ["modifyvm", :id, "--cpus"  , 1 ]
    end
    db.vm.provision :shell, :path => "ansible/build_db.sh"
  end
end
