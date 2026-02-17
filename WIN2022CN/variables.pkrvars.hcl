artifact = {
  region                      = "cn-shanghai"
  instance_type               = "ecs.u2a-c1m1.xlarge"
  source_image                = "win2022_21H2_x64_dtc_zh-cn_40G_uefi_alibase_20260114.vhd"
  associate_public_ip_address = true
  internet_charge_type        = "PayByTraffic"
  internet_max_bandwidth_out  = 100
  user_data_file              = "user_data.ps1"
  instance_name               = "goldimage-WIN2022CN"
  image_description           = "Automate Image Builds by HashiCorp Packer"
  image_share_account         = ["1924836684637231"]
  image_copy_regions          = ["cn-beijing"]
  communicator                = "winrm"
  winrm_port                  = 5985
  winrm_username              = "xadmin"
  tags = {
    builder = "packer"
    app     = "infra"
  }
  system_disk_mapping = {
    disk_category = "cloud_essd"
    disk_size     = 100
  }
}