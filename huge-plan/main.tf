terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
  }
}

provider "null" {}


variable "large_data" {
  default = <<EOT
    iVBORw0KGgoAAAANSUhEUgAAAoAAAAGwCAYAAADlnkSmAAAIJ0lEQVR4Xu3dQW5UMQwF0ODqf9N3g0Q8AQ0RjTph
    9Z/vHb8Zcf9ZzDBfJdNvExEAAAxGAfFxAIJMIUAAAIgBAABiAABgwAAAAaAAEAAIAAAGQFQACACAAAAMAAAGAAABm
    AQAAIAABgAAAQkAAAIgAAADIACAgAASAAAAAABkAAADIACAgAAAIAQACABAAAQAIAIAgAAAIAIAgAAQACACAgAAAA
    MAAQACAAACACAgAAAAQAIAAQAACAAACACAgAAAAIAAgAAAIAACAgAAAAIAAgAAAQACAgAAAAIAQAAAAIAAAIAAgAAA
    MAAACAgAAAAIAAgAAAQAACAgAAAIAAgAAAQAIAAgAAAIAAgAAAIAAgAAAIAAAAACAgAA
    EOT
}


resource "null_resource" "large_data_example" {
  count = 10

  triggers = {
    large_data = var.large_data
    instance   = count.index
  }
}

output "example_output" {
  value = null_resource.large_data_example[*].id
}
