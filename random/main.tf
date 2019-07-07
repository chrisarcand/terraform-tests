resource "random_pet" "dog" {
  length = 4
}

output "random" {
  value = "${random_pet.dog.id}"
}
