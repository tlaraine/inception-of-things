#docker stop $(docker ps -a -q)
#docker rm $(docker ps -a -q)

# ===============k3d installation===============

wget -q -O - https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
echo "source <(k3d completion bash)" >> ~/.bashrc

sudo k3d cluster create TlaraineS
sudo kubectl create namespace dev

sudo kubectl create namespace argocd
sudo kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
wget https://github.com/argoproj/argo-cd/releases/download/v2.5.2/argocd-linux-amd64 argocd -O argocd
chmod +x argocd
sudo cp argocd /usr/bin/
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
sudo kubectl apply -f confs/wil-app.yml

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

# ===========DELETE ALL===========
# sudo k3d cluster delete mycluster
