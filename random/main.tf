resource "random_pet" "dog" {
}

output "random" {
  value = "${random_pet.dog.id}"
}
