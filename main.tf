terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {}

module "todo" {
  source = "github.com/sudomateo/terraform-aws-terraform-training-todo?ref=main"

  ssh_public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIInO4M/dxw0LD+3tKUG39z2FokczSQumYUBYmYE3/tXb vm-fedora"
  ingress_port   = 8888

  app = {
    version = "dev"
  }

  db = {
    password = "ifitsfreeitsterraforme"
  }
}

output "app_url" {
  value = module.todo.app_url
}

