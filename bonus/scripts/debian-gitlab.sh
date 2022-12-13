echo "================debian-gitlab================"
sudo apt-get update

# Gitlab dependancies
sudo apt-get -y install curl openssh-server ca-certificates tzdata 

echo "================gitlab download================"
curl -sS https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash

echo "================gitlab install================"

sudo EXTERNAL_URL="http://192.168.56.110" apt-get install -y gitlab-ce

# Get root's default password
sudo cat /etc/gitlab/initial_root_password
echo "===========END=========="