# Example gallery

This directory contains a standalone `PhyloPicMakie.jl` gallery environment.
It stays isolated from `PaleobiologyDB.jl` and focuses on the package's public
Makie overlay surface.

## Setup

Version control intentionally keeps only `examples/Project.toml` as the versioned
environment file. From the repository root, run:

```julia
julia --project=examples -e 'import Pkg; Pkg.instantiate()'
```

That resolves a fresh local `examples/Manifest.toml` from the current
`examples/Project.toml` constraints. The local manifest stays ignored and
untracked.

## Deterministic examples

Run any example from the repository root:

- `julia --project=examples examples/src/explicit_overlays.jl`
- `julia --project=examples examples/src/thumbnail_gallery.jl`
- `julia --project=examples examples/src/graph_anchors.jl`

Each script writes a PNG artifact into `examples/build/`.

- `explicit_overlays.jl`: public explicit-coordinate and range-anchor overlays.
- `thumbnail_gallery.jl`: public thumbnail-grid rendering.
- `graph_anchors.jl`: a `GraphMakie` node-position snapshot hand-off that
  materializes `graphplot`, snapshots `p[:node_pos][]`, and forwards those
  explicit coordinates into `augment_phylopic!`. It does not claim live
  reactive overlay tracking.

## Smoke verification

Run the deterministic gallery smoke path with:

```julia
julia --project=examples examples/smoke.jl
```

The smoke runner renders every deterministic example and errors if an expected
artifact is missing.

## Live fetch examples

This gallery intentionally omits a required live `node_uuid` fetch example.
The tranche prioritizes deterministic, headless-friendly, offline regression
artifacts for CI and local verification. Ad hoc live UUID experiments can still
be done interactively against the public `augment_phylopic!` and
`phylopic_thumbnail_grid!` APIs when network access is desired.
