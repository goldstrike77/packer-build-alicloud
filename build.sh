
#!/bin/bash

OS="ALIYUN3 UBUNTU2404"

for i in $OS; do
  cd $i
  packer build -var-file=variables.pkrvars.hcl build.pkr.hcl
  cd ..
done