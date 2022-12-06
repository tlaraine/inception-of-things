#!/bin/bash

echo "alias k='kubectl'" >> /home/vagrant/.bashrc
echo "alias c='clear'" >> /home/vagrant/.bashrc

curl -sfL https://get.k3s.io | K3S_KUBECONFIG_MODE="644" INSTALL_K3S_EXEC="--flannel-iface eth1" sh -s -

kubectl apply -f /vagrant/confs/apps.yaml

kubectl apply -f /vagrant/confs/ingress.yaml