```@meta
CurrentModule = PhyloPicMakie
```

# Examples

The repository includes a standalone `examples` environment for public-surface
gallery scripts. The gallery is isolated from `PaleobiologyDB.jl` and focuses
on deterministic Makie artifacts that are useful both for human exploration and
for regression smoke checks.

## Setup

Version control intentionally keeps only `examples/Project.toml` as the
versioned examples environment file. From the repository root, run:

```julia
julia --project=examples -e 'import Pkg; Pkg.instantiate()'
```

That command resolves a fresh local `examples/Manifest.toml` from the current
project constraints. The local manifest stays ignored and untracked.

## Deterministic gallery scripts

Run these commands from the repository root:

- `julia --project=examples examples/src/explicit_overlays.jl`
- `julia --project=examples examples/src/thumbnail_gallery.jl`
- `julia --project=examples examples/src/graph_anchors.jl`

Each script writes a PNG artifact into `examples/build/`.

- `explicit_overlays.jl`: public explicit-coordinate and range-anchor overlays.
- `thumbnail_gallery.jl`: public thumbnail-grid rendering.
- `graph_anchors.jl`: a `GraphMakie` node-position snapshot hand-off. The
  example materializes `graphplot`, snapshots `p[:node_pos][]`, and forwards
  those explicit coordinates into `augment_phylopic!`; it is not presented as a
  live reactive overlay example.

## Smoke verification

Run the full deterministic gallery smoke path with:

```julia
julia --project=examples examples/smoke.jl
```

This command renders every deterministic gallery script and errors if an
expected artifact is missing.

## Live fetch scope

The required gallery intentionally omits a live `node_uuid` fetch example.
That keeps the tranche's verification artifacts deterministic, offline-friendly,
and suitable for headless CI execution. Live UUID-driven experimentation can
still be done interactively through the documented public APIs when network
access is desired.
