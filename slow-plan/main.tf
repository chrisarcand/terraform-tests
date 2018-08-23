data "external" "slow-data-source" {
  program = ["bash", "-c", "sleep 600 && echo {}"]
}
