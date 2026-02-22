#!/bin/sh
groupadd wheel
useradd -G wheel -m -s /bin/bash ecsadmin
echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/wheel
chmod 750 /home/ecsadmin
sed -i 's/wheel:x:1000:ecsadmin/wheel:x:1000:ecsadmin,root/' /etc/group
echo "AllowUsers *" >> /etc/ssh/sshd_config