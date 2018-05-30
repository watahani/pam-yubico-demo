#!/bash/sh

sudo yum -y --nogpgcheck groupinstall "GNOME Desktop" "Japanese Support"
sudo systemctl set-default graphical.target
sudo systemctl start graphical.targetvagrant up