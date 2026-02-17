packer {
  required_plugins {
    alicloud = {
      version = "= 1.1.2"
      source  = "github.com/hashicorp/alicloud"
    }
    # https://github.com/rgl/packer-plugin-windows-update/issues/91
    windows-update = {
      version = "= 0.17.2"
      source  = "github.com/rgl/windows-update"
    }
  }
}