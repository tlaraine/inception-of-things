#!/bin/bash

sudo k3d cluster create iot-cluster --api-port 6443 -p 8080:80@loadbalancer --agents 2 --wait

sudo kubectl create namespace argocd
sudo kubectl create namespace dev

sudo kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# kubectl get pods -n argocd

sudo kubectl wait --for=condition=Ready pods --all -n argocd

sudo kubectl -n argocd patch secret argocd-secret \
  -p '{"stringData": {
    "admin.password": "$2a$12$xyk8mlgC6l6gWQhTA.LF8uqlX5ng6Ju5BU7zhJ4Sp4VuCzQT7szIm",
    "admin.passwordMtime": "'$(date +%FT%T%Z)'"
  }}'

sudo kubectl apply -f ../confs/project.yaml -n argocd

sudo kubectl apply -f ../confs/application.yaml -n argocd

sudo kubectl wait --for=condition=Ready pods --all -n argocd

echo "Argo CD is deployed, run the following command to access the dashboard:"
echo "sudo kubectl port-forward svc/argocd-server --address 10.11.1.253 -n argocd 8081:80 2>&1 >/dev/null &"
echo "run the following command to access wil's app:"
echo "sudo kubectl port-forward svc/wil-playground -n dev 8888:8888 2>&1 >/dev/null &"
echo "..::OK::.."