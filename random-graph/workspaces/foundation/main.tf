provider "random" {}
provider "null" {}
provider "tls" {}

# foundation is the root of the cross-workspace DAG: it has no upstreams and
# every other branch ultimately depends on it.
module "graph" {
  source      = "../../modules/random_graph"
  name_prefix = "${var.workspace_prefix}-foundation"
  upstream    = {}
}
