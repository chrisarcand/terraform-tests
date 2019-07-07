resource "random_pet" "dog" {
  length = 2
}

output "random" {
  value = "${random_pet.dog.id}"
}
