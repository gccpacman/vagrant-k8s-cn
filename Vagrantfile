IMAGE_NAME = "bento/ubuntu-18.04"
SUBNET_CIDR = "192.168.17."
N = 2
BN = 2

Vagrant.configure("2") do |config|
    config.ssh.insert_key = false

    config.vm.provider "virtualbox" do |v|
        v.memory = 2048
        v.cpus = 2
    end

    config.vm.define "master" do |master|
        master.vm.box = IMAGE_NAME
        master.vm.network "private_network", ip: "#{SUBNET_CIDR}100"
        master.vm.hostname = "master"
        master.vm.provision "basic", type: "ansible" do |ansible|
            ansible.playbook = "basic-setup/basic-playbook.yml"
        end
        master.vm.provision "docker", type: "ansible" do |ansible|
            ansible.playbook = "docker-setup/docker-playbook.yml"
        end
        master.vm.provision "kubernetes", type: "ansible" do |ansible|
            ansible.playbook = "kubernetes-setup/kubernetes-playbook.yml"
            ansible.extra_vars = {
                node_ip: "#{SUBNET_CIDR}100",
            }
        end
        master.vm.provision "kubernetes-master", type:"ansible" do |ansible|
            ansible.playbook = "kubernetes-setup/master-playbook.yml"
        end
    end

    (1..N).each do |i|
        config.vm.define "node-#{i}" do |node|
            node.vm.box = IMAGE_NAME
            node.vm.network "private_network", ip: "#{SUBNET_CIDR}#{i + 100}"
            node.vm.hostname = "node-#{i}"

            node.vm.provision "basic", type: "ansible" do |ansible|
                ansible.playbook = "basic-setup/basic-playbook.yml"
            end
            node.vm.provision "docker", type: "ansible" do |ansible|
                ansible.playbook = "docker-setup/docker-playbook.yml"
            end
            node.vm.provision "kubernetes", type: "ansible" do |ansible|
                ansible.playbook = "kubernetes-setup/kubernetes-playbook.yml"
                ansible.extra_vars = {
                    node_ip: "#{SUBNET_CIDR}#{i + 100}",
                }
            end
            node.vm.provision "kubernetes-node-join", type: "ansible" do |ansible|
                ansible.playbook = "kubernetes-setup/node-playbook.yml"
            end
        end
    end

    (1..BN).each do |i|
        config.vm.define "bnode-#{i}" do |bnode|
            bnode.vm.box = IMAGE_NAME
            bnode.vm.network "private_network", ip: "#{SUBNET_CIDR}#{i + 10}"
            bnode.vm.hostname = "node-#{i}"
            bnode.vm.provision "basic", type: "ansible" do |ansible|
                ansible.playbook = "basic-setup/basic-playbook.yml"
            end
            bnode.vm.provision "docker", type: "ansible" do |ansible|
                ansible.playbook = "docker-setup/docker-playbook.yml"
            end
        end
    end

end
