#!/bin/bash
# By Mohammad Fauzan R | Wa 0895703796928
dd if=/dev/zero of=/swapfile bs=1024 count=1024k

# buat swap
mkswap /swapfile

# jalan swapfile
swapon /swapfile

#auto star saat reboot
wget https://raw.githubusercontent.com/mfauzan199812/ram/master/ram/fstab
mv ./fstab /etc/fstab
chmod 644 /etc/fstab
sysctl vm.swappiness=50
#permission swapfile
chown root:root /swapfile 
chmod 0600 /swapfile