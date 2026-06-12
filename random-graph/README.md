# random-graph

A parameterized, VCS-driven set of HCP Terraform workspaces that provisions a
deliberately interesting **cross-workspace dependency graph** using only the
`random`, `null`, and `tls` providers (plus a `random_pet`-only tree). Built to
demonstrate cross-workspace dependencies, provider/version variety, sensitive
outputs, and per-workspace resource graphs in HCP Terraform.

Nothing here touches real cloud infrastructure — every resource is free and
local to the providers, so it's safe to apply repeatedly.

## The graph

```
foundation ──> network ──┐
    │                     ├──> platform ──> app
    ├────────> data ──────┘
    └────────> pets        (random_pet-only, 10-layer binary tree = 1023 pets)
```

Each downstream workspace reads its upstream(s) with
`data "terraform_remote_state"`. That read creates an explicit dependency from
the consumer workspace to its upstream(s) — a **workspace edge** in the
dependency graph. The same edges are enforced at apply time by
`tfe_run_trigger`, so a change to `foundation` cascades through the whole graph.

| Workspace  | Consumes            | Providers declared        | random constraint style |
|------------|---------------------|---------------------------|-------------------------|
| foundation | —                   | random, null, tls         | `~> 3.6.0` (patch pin)  |
| network    | foundation          | random, null, tls         | `>= 3.5.0, < 3.7.0`     |
| data       | foundation          | random, null, tls         | `3.6.3` (exact)         |
| platform   | network, data       | random, null, tls         | `~> 3.5` (minor)        |
| app        | platform            | random, null, tls         | `>= 3.0.0` (lower only) |
| pets       | foundation          | random **only**           | `~> 3.6`                |

The constraint styles are intentionally different per workspace so the
provider/version views show variety. The provider *set* also varies: `pets`
declares only `random`.

## Layout

```
random-graph/
├── bootstrap/              # creates & wires the 6 workspaces (run once, by you)
├── modules/
│   ├── random_graph/       # ~100-resource layered DAG (random + null + tls)
│   └── pet_tree/           # full binary random_pet tree (configurable depth)
└── workspaces/
    ├── foundation/  network/  data/  platform/  app/  pets/
```

Child configs reference the shared modules via `../../modules/...`. Because each
workspace is VCS-connected to this whole repo (just with a different
`working_directory`), HCP Terraform clones the entire tree and those relative
paths resolve. There are deliberately **no `cloud {}`/`backend` blocks** in the
child configs — HCP Terraform injects the backend for VCS workspaces.

## Bootstrapping

The `bootstrap/` config uses the `tfe` provider to create the six workspaces,
connect them to VCS, set their working directories, wire the run-trigger DAG,
enable global remote state, and inject the addressing variables
(`tfe_organization`, `tfe_hostname`, `workspace_prefix`).

Bootstrap is **not** self-managing. Create its own workspace once, by hand:

1. In the HCP Terraform UI, create a workspace named `<prefix>-bootstrap`
   (VCS-driven, this repo, working directory `random-graph/bootstrap`).
2. Add a **sensitive environment variable** `TFE_TOKEN` = an HCP Terraform
   user/team API token with permission to manage workspaces in the org.
3. Set the Terraform variables from `bootstrap/terraform.tfvars.example`
   (at minimum `tfe_organization`, `vcs_repo_identifier`, and one of
   `vcs_oauth_token_id` / `vcs_github_app_installation_id`).
4. Queue a plan & apply.

After bootstrap applies, kick the cascade by queuing a run on
`<prefix>-foundation`; run triggers then flow through the rest of the graph
(workspaces are `auto_apply = true` by default).

> The `tfe` provider authenticates **only** from the `TFE_TOKEN` env var. The
> token is never written into any committed file.

## Tuning

- **Resource count** per `random_graph` workspace (~100 by default) — override
  the per-layer `*_count` variables in `modules/random_graph/variables.tf`.
- **Pet tree shape** — `branching`, `layers`, `max_layer_width` in the `pets`
  workspace (`branching = 2`, `layers = 10`, uncapped → 1023 pets).
- **Naming / placement / behaviour** — see `bootstrap/terraform.tfvars.example`
  (`workspace_prefix`, `project_name`/`project_id`, `execution_mode`,
  `auto_apply`, `terraform_version`, …).
