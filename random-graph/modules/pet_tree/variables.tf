variable "name_prefix" {
  type        = string
  description = "Prefix applied to every random_pet name in the tree."
  default     = "pet"
}

variable "branching" {
  type        = number
  description = <<-EOT
    Children per node. The width of layer i is branching^i (so branching=2 is a
    binary tree, branching=1 is a simple linear chain). Each node in layer i is
    the child of node floor(index / branching) in layer i-1.
  EOT
  default     = 2

  validation {
    condition     = var.branching >= 1 && floor(var.branching) == var.branching
    error_message = "branching must be a whole number >= 1."
  }
}

variable "layers" {
  type        = number
  description = "Number of layers in the tree (1-10). Layers beyond this are created with count = 0."
  default     = 10

  validation {
    condition     = var.layers >= 1 && var.layers <= 10
    error_message = "layers must be between 1 and 10 (the module defines 10 layer blocks)."
  }
}

variable "max_layer_width" {
  type        = number
  description = "Cap on the number of pets in any single layer. 0 means uncapped (a true branching^i tree)."
  default     = 0
}

variable "pet_length" {
  type        = number
  description = "Number of words in each pet name."
  default     = 2
}

variable "separator" {
  type        = string
  description = "Separator used between words in pet names."
  default     = "-"
}

variable "root_seed" {
  type        = string
  description = "Upstream value (e.g. a terraform_remote_state output) woven into the root layer's keepers."
  default     = ""
}
