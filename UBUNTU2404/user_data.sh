#!/bin/sh
useradd -m -s /bin/bash ecs-admin
echo "ecs-admin   ALL=(ALL)        NOPASSWD:ALL" | tee -a /etc/sudoers