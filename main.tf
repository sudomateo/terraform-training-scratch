terraform {
  # Partial backend configuration.
  backend "s3" {
    bucket         = "terraform-training20230426161451011500000001"
    key            = "terraform/states/vm"
    region         = "us-east-1"
    dynamodb_table = "terraform-training"
  }


  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configured via environment variables.
provider "aws" {}

resource "aws_key_pair" "sudomateo" {
key_name_prefix = "sudomateo"
public_key      = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIETEma9o59PQm3venxMkocCM8mifE0hspFm5XsYeccw8"
}

module "sudomateo_vm" {
  source = "github.com/sudomateo/terraform-aws-terraform-training-vm?ref=main"

  for_each = {
    foo = {
      ingress_rules = [
        {
          description = "SSH"
          from_port   = 22
          to_port     = 22
          protocol    = "tcp"
        },
      ]
    }
  }

  name          = each.key
  key_name      = aws_key_pair.sudomateo.key_name
  ingress_rules = each.value.ingress_rules
}
