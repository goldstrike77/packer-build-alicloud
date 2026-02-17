variable "artifact" {}

source "alicloud-ecs" "images" {
  region                      = lookup(var.artifact, "region", "cn-shanghai")
  instance_type               = lookup(var.artifact, "instance_type", "ecs.u2a-c1m1.xlarge")
  source_image                = lookup(var.artifact, "source_image", "win2019_1809_x64_dtc_zh-cn_40G_alibase_20260114.vhd")
  associate_public_ip_address = lookup(var.artifact, "associate_public_ip_address", true)
  internet_charge_type        = lookup(var.artifact, "internet_charge_type", "PayByTraffic")
  internet_max_bandwidth_out  = lookup(var.artifact, "internet_max_bandwidth_out", 100)
  user_data_file              = lookup(var.artifact, "user_data_file", "user_data.ps1")
  instance_name               = lookup(var.artifact, "instance_name", "")
  image_name                  = "${var.artifact.instance_name}-${formatdate("YYYY-MM-DD-hhmm", timestamp())}"
  image_description           = lookup(var.artifact, "image_description", "Automate Image Builds by HashiCorp Packer")
  image_share_account         = lookup(var.artifact, "image_share_account", [])
  image_copy_regions          = lookup(var.artifact, "image_copy_regions", [])
  image_copy_names            = ["${var.artifact.instance_name}-${formatdate("YYYY-MM-DD-hhmm", timestamp())}"]
  communicator                = lookup(var.artifact, "communicator", "winrm")
  winrm_port                  = lookup(var.artifact, "winrm_port", 5985)
  winrm_username              = lookup(var.artifact, "winrm_username", "xadmin")
  winrm_password              = substr(base64encode("${var.artifact.instance_name}-${formatdate("YYYY-MM-DD-hhmm", timestamp())}"), 1, 20)
  tags                        = lookup(var.artifact, "tags", {})
  run_tags                    = lookup(var.artifact, "tags", {})
  system_disk_mapping {
    disk_category = lookup(var.artifact.system_disk_mapping, "disk_category", "cloud_essd")
    disk_size     = lookup(var.artifact.system_disk_mapping, "disk_size", 100)
  }
}

build {
  sources = [
    "sources.alicloud-ecs.images"
  ]
  provisioner "powershell" {
    elevated_user     = "SYSTEM"
    elevated_password = ""
    execution_policy  = "unrestricted"
    inline = [
      "Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force",
      "Install-Module -Name PSWindowsUpdate -RequiredVersion 2.2.1.5 -Force",
      "Install-WindowsUpdate -MicrosoftUpdate -AcceptAll -AutoReboot"
    ]
  }
  provisioner "windows-restart" {
    restart_timeout = "20m"
  }
  provisioner "powershell" {
    inline = ["Invoke-Expression (Invoke-WebRequest -Uri 'https://goldstrike.oss-cn-shanghai.aliyuncs.com/hardening/scripts/cloud-level-protection.ps1' -UseBasicParsing) | Out-Null"]
  }
}
