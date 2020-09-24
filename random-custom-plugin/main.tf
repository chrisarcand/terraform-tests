resource "soopercustomrandom_pet" "animal" {
  keepers = {
    uuid = "${uuid()}" # Force a new name each time
  }
  length = 3
}

output "random" {
  value = "${soopercustomrandom_pet.animal.id}"
}
