#!/bin/bash

echo username?
read username
echo paste pub key
read pubkey

useradd -m -s /bin/bash $username
su - $username -c "mkdir ~/.ssh"
su - $username -c "echo $pubkey $username >> ~/.ssh/authorized_keys"
su - $username -c "chmod 700 /home/$username/.ssh"
su - $username -c "chmod 600 /home/$username/.ssh/authorized_keys"

# check if root access needs to be provided or not
while true; do
    read -p "Do you want to provide root access?" yn
    case $yn in
        [Yy]* ) echo "$username ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$username; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done
