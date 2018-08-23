resource "null_resource" "slow-provisioner" {
  provisioner "local-exec" {
    command = "sleep 600"
  }
}
