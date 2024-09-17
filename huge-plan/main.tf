terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
  }
}

provider "null" {}

variable "resource_count" {
  default = 50
  description = "The number of resources to create, each using the dummy base64 file. 50 resources will generate a ~2GB plan file."
}

resource "null_resource" "large_file_data" {
  count = var.resource_count

  triggers = {
    file_data = file("${path.module}/file_base64.txt")
    instance  = count.index
  }
}

output "file_data_length" {
  value = length(file("${path.module}/file_base64.txt"))
}
