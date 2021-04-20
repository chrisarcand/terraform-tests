resource "random_pet" "animal1" {
  keepers = {
    uuid = uuid() # Force a new name each time
  }
  length = 3
}

resource "random_pet" "animal2" {
  keepers = {
    uuid = uuid() # Force a new name each time
  }
  length = 3
}

output "random" {
  value = random_pet.animal1.id
}
