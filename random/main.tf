resource "random_pet" "always_new" {
  keepers = {
    uuid = uuid() # Force a new name each time
  }
  length = 3
}

resource "random_pet" "animal_trio" {
  count = 4
  length = 3
}

output "animal_names" {
  value = concat([random_pet.always_new.id], random_pet.animal_trio[*].id)
}

output "current_workspace" {
  value = terraform.workspace
}
