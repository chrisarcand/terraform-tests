# leafy-graphs

Five HCP Terraform workspaces wired into an organic ("leafy") dependency graph,
used to exercise dependency-graph / relationship views with realistic shapes.

Unlike a textbook example with a single root that connects to everything, each
workspace here is built from **several independent pockets** (disconnected
sub-graphs), often clustered by provider, with **multiple roots** and **leaves at
varied depths**. Edges within a pocket are implicit references (a resource's
`triggers` / `keepers` referencing another resource's attribute), so the graph
fans out and back in instead of forming neat layers.

Every provider used is **in-memory only** — nothing reaches an external API or
creates real infrastructure:

- `hashicorp/null` — `null_resource` backbone nodes
- `hashicorp/random` — `random_id`, `random_pet`, `random_string`, `random_integer`, `random_password`
- `hashicorp/time` — `time_static`, `time_offset`
- `hashicorp/tls` — `tls_private_key` → `tls_self_signed_cert`

## Cross-workspace topology

The workspaces also form an organic graph *between* each other via
`terraform_remote_state`, with skip-level edges and fan-in:

```
roots ─┬─> trunk ─┬─> branch ─┬─> canopy ─┬─> leaves
       │          │           │           │
       └────────> branch      └─> canopy  └─> leaves
                  (skip)                  (branch -> leaves skip)
```

| workspace | upstreams (remote_state) | rough size | pockets |
|-----------|--------------------------|-----------:|--------:|
| roots     | — (root)                 | ~22 nodes  | 3       |
| trunk     | roots                    | ~34 nodes  | 6       |
| branch    | roots, trunk             | ~52 nodes  | 6       |
| canopy    | trunk, branch            | ~70 nodes  | 7       |
| leaves    | branch, canopy           | ~28 nodes  | 5       |

Each non-root workspace folds its upstreams' `primary_seed` / `pet_name` outputs
into a single pocket's seed node, so the remote-state read is real and recorded —
the other pockets in that workspace stay independent.

## Layout

```
leafy-graphs/
  workspaces/
    roots/   trunk/   branch/   canopy/   leaves/
      main.tf       # providers, remote_state inputs, the pocketed node graph
      variables.tf  # tfe_organization / tfe_hostname / workspace_prefix (injected)
      outputs.tf    # primary_seed, pet_name, node/edge/pocket counts, samples
      versions.tf   # provider version constraints (intentionally varied per workspace)
```

Workspaces are VCS-driven (each `working-directory` points at one folder here) and
auto-apply on upstream changes via run triggers that mirror the topology above.
