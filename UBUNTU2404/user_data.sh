#!/bin/sh
groupadd wheel
useradd -G wheel -m -s /bin/bash ecs-admin
echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/wheel
chmod 750 /home/ecs-admin
sed -i 's/wheel:x:1000:ecs-admin/wheel:x:1000:ecs-admin,root/' /etc/group