packer {
  required_plugins {
    alicloud = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/alicloud"
    }
  }
}