resource "random_pet" "dog" {
  length = 3
}

output "random" {
  value = "${random_pet.dog.id}"
}
