# Yum update
sudo sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
sudo sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
# sudo yum update -y

# Gitlab dependancies
sudo yum -y install curl vim policycoreutils python3-policycoreutils

# Gitlab install
curl -s https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.rpm.sh | sudo bash
sudo yum install gitlab-ce -y

# Meow
sudo sed -i '32s/.*/external_url "http\:\/\/192.168.42.110"/' /etc/gitlab/gitlab.rb

# Gitlab config
# Edit configs
# sudo vim /etc/gitlab/gitlab.rb
sudo gitlab-ctl reconfigure

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
