#!/bin/bash

#Set Hostname:
sudo hostnamectl set-hostname K8s-Master

#Update and Install Docker:
sudo apt-get update 
sudo apt-get install -y docker.io
#Configure Docker Access:
sudo usermod -aG docker ubuntu
newgrp docker
sudo chmod 777 /var/run/docker.sock
#Add Kubernetes Repository and Install Packages:
sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

sudo tee /etc/apt/sources.list.d/kubernetes.list <<EOF
deb https://apt.kubernetes.io/ kubernetes-xenial main     
EOF

sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
#Install kube-apiserver using Snap:
sudo snap install kube-apiserver

#Initialize Kubernetes Master:
sudo kubeadm init --pod-network-cidr=10.244.0.0/16

# in case your in root exit from it and run below commands
#Set Up Kubernetes Configuration:
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

#Apply Flannel Network Configuration:
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

#cd .kube/
#cat config
#copy all the data and paste it in secret file. 