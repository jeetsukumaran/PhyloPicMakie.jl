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

## Run the examples

Run any example from the repository root:

- `julia --project=examples examples/src/explicit_overlays.jl`
- `julia --project=examples examples/src/thumbnail_gallery.jl`
- `julia --project=examples examples/src/graph_anchors.jl`

Each script is a direct public example. In an interactive Julia session it
displays the figure. When run as a script, it saves a PNG in the current
working directory by default. Pass a custom path as the first argument if you
want the output somewhere else.

- `explicit_overlays.jl`: public explicit-coordinate and range-anchor overlays.
- `thumbnail_gallery.jl`: public thumbnail-grid rendering with grouped labels.
- `graph_anchors.jl`: a `GraphMakie` node-position snapshot hand-off that
  materializes `graphplot`, snapshots `p[:node_pos][]`, and forwards those
  explicit coordinates into `augment_phylopic!`. It does not claim live
  reactive overlay tracking.

## Live fetch examples

This gallery intentionally omits a required live `node_uuid` fetch example.
Ad hoc live UUID experiments can still be done interactively against the public
`augment_phylopic!` and `phylopic_thumbnail_grid!` APIs when network access is
desired.
