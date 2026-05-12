terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "buckets" {
  count  = 99
  bucket = "my-bucket-${count.index + 1}"

  tags = {
    Name  = "Bucket ${count.index + 1}"
    Index = count.index + 1
  }
}
