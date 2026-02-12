
#!/bin/bash

OS="HCEOS20 UBUNTU2404"

for i in $OS; do
  packer build -var-file=$i/variables.pkrvars.hcl $i/build.pkr.hcl
done