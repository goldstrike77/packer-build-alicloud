variable "artifact" {}

source "alicloud-ecs" "images" {
  region                      = lookup(var.artifact, "region", "cn-shanghai")
  instance_type               = lookup(var.artifact, "instance_type", "ecs.e-c1m1.large")
  source_image                = lookup(var.artifact, "source_image", "aliyun_3_x64_20G_alibase_20260122.vhd")
  associate_public_ip_address = lookup(var.artifact, "associate_public_ip_address", true)
  internet_charge_type        = lookup(var.artifact, "internet_charge_type", "PayByTraffic")
  user_data_file              = lookup(var.artifact, "user_data_file", "user_data.sh")
  instance_name               = lookup(var.artifact, "instance_name", "")
  image_name                  = "${var.artifact.instance_name}-${formatdate("YYYY-MM-DD-hhmm", timestamp())}"
  image_description           = lookup(var.artifact, "image_description", "Automate Image Builds by HashiCorp Packer")
  image_share_account         = lookup(var.artifact, "image_share_account", [])
  image_copy_regions          = lookup(var.artifact, "image_copy_regions", [])
  image_copy_names            = ["${var.artifact.instance_name}-${formatdate("YYYY-MM-DD-hhmm", timestamp())}"]
  tags                        = lookup(var.artifact, "tags", {})
  run_tags                    = lookup(var.artifact, "tags", {})
  system_disk_mapping {
    disk_category = lookup(var.artifact.system_disk_mapping, "disk_category", "cloud_essd")
    disk_size     = lookup(var.artifact.system_disk_mapping, "disk_size", 40)
  }
  ssh_username = lookup(var.artifact, "ssh_username", "root")
}

build {
  sources = [
    "sources.alicloud-ecs.images"
  ]
  provisioner "shell" {
    inline = [
      "sleep 5",
      "yum update -y > /dev/null 2>&1",
      "yum clean all > /dev/null 2>&1",
      "curl -ksSL https://goldstrike.oss-cn-shanghai.aliyuncs.com/hardening/scripts/cloud-level-protection.sh | bash"
    ]
  }
}
