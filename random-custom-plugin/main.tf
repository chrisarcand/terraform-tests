resource "sooper_custom_random_pet" "animal" {
  keepers = {
    uuid = "${uuid()}" # Force a new name each time
  }
  length = 3
}

output "random" {
  value = "${random_pet.animal.id}"
}
