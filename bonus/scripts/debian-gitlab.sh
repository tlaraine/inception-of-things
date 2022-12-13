echo "================debian-gitlab================"
echo "================sudo apt-get update================"
sudo apt-get update
echo "======sudo apt-get install -y curl openssh-server ca-certificates perl====="

# sudo apt-get install -y curl openssh-server ca-certificates perl
sudo apt-get -y install curl openssh-server ca-certificates tzdata #apt-transport-https gnupg2 -y


# Gitlab install
# curl -s https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash
# sudo apt install gitlab-ce -y

echo "================.gitlab download================"
# curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash
curl -sS https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash
# manual https://serveradmin.ru/ustanovka-i-nastroyka-gitlab/

# sudo apt update
# sudo apt upgrade -y
echo "================.gitlab install================"

sudo EXTERNAL_URL="http://192.168.56.110" apt-get install -y gitlab-ce
# sudo apt-get install gitlab-ce



echo "===========END=========="
# sudo sed -i '32s/.*/external_url "http\:\/\/192.168.56.110"/' /etc/gitlab/gitlab.rb
# sudo gitlab-ctl reconfigure

# # Gitlab config
# # Edit configs
# # sudo vim /etc/gitlab/gitlab.rb
# # sudo gitlab-ctl reconfigure
# echo "===========Get root's default password==========="
# # Get root's default password
# sudo cat /etc/gitlab/initial_root_password

# echo "===========Change root's default password==========="
# # Change root's default password
# sudo gitlab-rake "gitlab:password:reset[root]" << EOF
# adminroot
# adminroot
# EOF

# # Change grp visibility to allow public repos
# # Change group visibility
# #    On the top bar, select Menu > Groups and find your project.
# #    On the left sidebar, select Settings > General .
# #    Expand Naming, visibility .
# #    Under Visibility level select either Private , Internal , or Public .
# #    Select Save changes .
