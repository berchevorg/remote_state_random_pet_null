data "terraform_remote_state" "platform" {
  backend = "remote"
  config = {
    organization = "georgiman"
    workspaces = {
      name = "random_pet_null"
    }
  }
}

resource "null_resource" "hello" {
  provisioner "local-exec" {
    command = "echo ${data.terraform_remote_state.platform.outputs.random_pet}"
  }
}
