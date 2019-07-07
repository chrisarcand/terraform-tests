resource "random_pet" "dog" {
  keepers = {
    uuid = "${uuid()}" # Force a new name each time
  }
  length = 3
}

output "random" {
  value = "${random_pet.dog.id}"
}
