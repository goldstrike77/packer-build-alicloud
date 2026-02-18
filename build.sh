
#!/bin/bash

OS="ALIYUN3 UBUNTU2404 WIN2019CN WIN2022CN"

for i in $OS; do
  cd $i
  packer build -var-file=variables.pkrvars.hcl build.pkr.hcl
  cd ..
done