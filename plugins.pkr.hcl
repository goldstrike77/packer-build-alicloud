packer {
  required_plugins {
    alicloud = {
      version = "= 1.1.2"
      source  = "github.com/hashicorp/alicloud"
    }
    windows-update = {
      version = "= 0.17.2"
      source  = "github.com/rgl/windows-update"
    }
  }
}