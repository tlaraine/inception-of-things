# Delte previous cluster
sudo k3d cluster delete mycluster

# ===============Docker installation===============

# Dependencies
sudo apt -y update
sudo apt -y install apt-transport-https ca-certificates curl gnupg2 software-properties-common

# Import Docker GPG key
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --yes --dearmor -o /etc/apt/trusted.gpg.d/docker-archive-keyring.gpg

# Add Docker repo to debian
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"

# Docker install
sudo apt -y update
sudo apt install docker-ce docker-ce-cli containerd.io -y

# Start service
sudo systemctl enable --now docker

sudo groupadd docker
sudo usermod -aG docker $USER

# ===============kubectl installation===============

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
# Output must be "kubectl: Ok"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
rm -f kubectl

# ===============k3d installation===============

wget -q -O - https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
echo "source <(k3d completion bash)" >> ~/.bashrc

# Create gitlab namespace
sudo kubectl create namespace gitlab

sudo k3d cluster create mycluster
sudo kubectl create namespace dev

sudo kubectl create namespace argocd
sudo kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
wget https://github.com/argoproj/argo-cd/releases/download/v2.5.2/argocd-linux-amd64 argocd -O argocd
chmod +x argocd

# Check if cluster is up
# sudo kubectl get nodes

# Check if pods are up
# sudo kubectl get pods -n argocd

# Check namespaces
# sudo kubectl get ns

# =========wil app===========
# sudo kubectl apply -f confs/wil-app.yml
# Connect ArgoCD to that repository
sudo kubectl apply -f confs/config.yml

while [ true ]
	do
		i=$(sudo kubectl get pod -n argocd | grep "1/1" | wc -l)
		if [ $i = 7 ]
		then
			echo "\rReady!"
			break
		else
			echo -n "\rInitializing cluster..."
		fi
	done;


# ===========ArgoCD UI=============
# Enable port redirection
while true
  do sudo kubectl port-forward -n argocd svc/argocd-server 8080:443 1>/dev/null 2>/dev/null
done &

while true
  do sudo kubectl port-forward -n dev svc/wil-playground 8888:8888 1>/dev/null 2>/dev/null
done &

# Package to copy passwd to clipboard
sudo apt-get install xclip -y

# Check the argoCD ui
# firefox https://localhost:8080

# Connect to the argocd app (https://localhost:8080)
# Username: admin
# Get the password
echo "\n======Credentials======"
echo "Login: admin"
echo -n "Password: "
sudo kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath=”{.data.password}” | sed 's/^.//;s/.$//' | base64 -d | xclip -sel clip
sudo kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath=”{.data.password}” | sed 's/^.//;s/.$//' | base64 -d
echo "\n=======================\n"
echo "Password is copied to the clipboard :)"

# Change the version of wil ap
# sed -i 's/wil42\/playground\:v1/wil42\/playground\:v2/g' ./wil-app.yml
