resource "random_id" "random1" {
  keepers {
    uuid = "${uuid()}"
  }

  byte_length = 8
}
resource "random_id" "random2" {
  keepers {
    uuid = "${uuid()}"
  }

  byte_length = 8
}
resource "random_id" "random3" {
  keepers {
    uuid = "${uuid()}"
  }

  byte_length = 8
}
resource "random_id" "random4" {
  keepers {
    uuid = "${uuid()}"
  }

  byte_length = 8
}
resource "random_id" "random5" {
  keepers {
    uuid = "${uuid()}"
  }

  byte_length = 8
}
resource "random_id" "random6" {
  keepers {
    uuid = "${uuid()}"
  }

  byte_length = 8
}
resource "random_id" "random7" {
  keepers {
    uuid = "${uuid()}"
  }

  byte_length = 8
}
resource "random_id" "random8" {
  keepers {
    uuid = "${uuid()}"
  }

  byte_length = 8
}
resource "random_id" "random9" {
  keepers {
    uuid = "${uuid()}"
  }

  byte_length = 8
}
resource "random_id" "random10" {
  keepers {
    uuid = "${uuid()}"
  }

  byte_length = 8
}
resource "random_id" "random11" {
  keepers {
    uuid = "${uuid()}"
  }

  byte_length = 8
}
resource "random_id" "random12" {
  keepers {
    uuid = "${uuid()}"
  }

  byte_length = 8
}

output "random" {
  value = "${random_id.random1.hex}"
}
