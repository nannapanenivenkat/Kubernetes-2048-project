#!/bin/bash

##Set Hostname:
sudo hostnamectl set-hostname K8s-Worker

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

#sudo kubeadm join 10.0.1.123:6443 --token 1kvqtd.6ulwlb93fn9c8q3v \ --discovery-token-ca-cert-hash sha256:18a8801887fce673bc9de1ab512abecb0835ba67e79b60ce0322b92504c759dd
#sudo kubeadm join <master-node-ip>:<master-node-port> --token <token> --discovery-token-ca-cert-hash <hash>