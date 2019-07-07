resource "random_pet" "dog" {
  byte_length = 8
}

output "random" {
  value = "${random_pet.dog.id}"
}
