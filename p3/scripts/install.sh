# ===============Docker installation===============
#sudo sh /usr/local/bin/k3s-uninstall.sh
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
