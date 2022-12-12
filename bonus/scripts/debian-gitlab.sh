sudo apt-get update
sudo apt-get install -y curl openssh-server ca-certificates perl




# Gitlab install
# curl -s https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash
# sudo apt install gitlab-ce -y


curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ee/script.deb.sh | sudo bash


sudo EXTERNAL_URL="http://192.168.56.110" apt-get install gitlab-ee



# Meow
# sudo sed -i '32s/.*/external_url "http\:\/\/192.168.56.110"/' /etc/gitlab/gitlab.rb

# Gitlab config
# Edit configs
# sudo vim /etc/gitlab/gitlab.rb
# sudo gitlab-ctl reconfigure

# Get root's default password
sudo cat /etc/gitlab/initial_root_password

# Change root's default password
sudo gitlab-rake "gitlab:password:reset[root]" << EOF
adminroot
adminroot
EOF

# Change grp visibility to allow public repos
# Change group visibility
#    On the top bar, select Menu > Groups and find your project.
#    On the left sidebar, select Settings > General .
#    Expand Naming, visibility .
#    Under Visibility level select either Private , Internal , or Public .
#    Select Save changes .
