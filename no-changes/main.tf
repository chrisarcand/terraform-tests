resource "random_pet" "animal" {
  length = 3
}

output "random" {
  value = "${random_pet.animal.id}"
}
