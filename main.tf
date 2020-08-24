data "terraform_remote_state" "platform" {
  backend = "remote"
  config = {
    organization = "georgiman"
    workspaces = {
      name = "random_pet_null"
    }
  }
}

provider "aws" {
  region = "us-east-1"  
}

resource "aws_security_group" "allow_tls" {
  name        = data.terraform_remote_state.platform.outputs.random_pet
  description = "Allow TLS inbound traffic"
  
    ingress {
    from_port   = 445
    to_port     = 445
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
  
  

resource "null_resource" "hello" {
  provisioner "local-exec" {
    command = "echo ${data.terraform_remote_state.platform.outputs.random_pet}"
  }
}
