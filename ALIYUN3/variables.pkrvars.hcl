artifact = {
  region                      = "cn-shanghai"
  instance_type               = "ecs.e-c1m1.large"
  source_image                = "aliyun_3_x64_20G_alibase_20260122.vhd"
  associate_public_ip_address = true
  internet_charge_type        = "PayByTraffic"
  user_data_file              = "user_data.sh"
  instance_name               = "goldimage-ALIYUN3"
  image_description           = "Automate Image Builds by HashiCorp Packer"
  image_share_account         = ["1924836684637231"]
  image_copy_regions          = ["cn-beijing"]
  tags = {
    builder = "packer"
    app     = "infra"
  }
  system_disk_mapping = {
    disk_category = "cloud_essd"
    disk_size     = 40
  }
  ssh_username = "root"
}