#!/bin/sh
useradd -G wheel -m -s /bin/bash ecs-admin
echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/wheel