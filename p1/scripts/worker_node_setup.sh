#!/bin/bash

# add k3s master node token
export TOKEN_FILE="/vagrant/scripts/node-token"
# sudo apt install net-tools -y
#sudo cp /usr/sbin/ifconfig /usr/bin/
echo "alias k='kubectl'" >> /home/vagrant/.bashrc
echo "alias c='clear'" >> /home/vagrant/.bashrc
# add k3s master node ip and worker node ip
export INSTALL_K3S_EXEC="agent --server https://$1:6443 --token-file $TOKEN_FILE --node-ip=$2"

#fix The connection to the server localhost:8080 was refused - did you specify the right host or port?

# download and run k3s agent
curl -sfL https://get.k3s.io | sh -


sudo mkdir -p /etc/rancher/k3s
sudo cp /vagrant/scripts/k3s.yaml /etc/rancher/k3s/

sudo mkdir -p /home/vagrant/.kube/
sudo cp /vagrant/scripts/k3s.yaml  /home/vagrant/.kube/config