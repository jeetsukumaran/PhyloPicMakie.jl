# Example gallery

This directory contains a standalone `PhyloPicMakie.jl` gallery environment.
The required examples use pre-resolved image matrices and focus on the
package's public Makie interfaces.

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
- `julia --project=examples examples/src/figure_factories.jl`
- `julia --project=examples examples/src/thumbnail_gallery.jl`
- `julia --project=examples examples/src/graph_anchors.jl`
- `julia --project=examples examples/src/taxon_discovery.jl`

Each script is a direct public example. In an interactive Julia session it
displays the figure. When run as a script, it saves a PNG in the current
working directory by default. Pass a custom path as the first argument if you
want the output somewhere else.

- `explicit_overlays.jl`: public explicit-coordinate and range-anchor overlays.
- `figure_factories.jl`: figure-creating coordinate and range overlay methods.
- `thumbnail_gallery.jl`: public thumbnail-grid rendering with grouped labels.
- `graph_anchors.jl`: a `GraphMakie` node-position snapshot hand-off that
  materializes `graphplot`, snapshots `p[:node_pos][]`, and forwards those
  explicit coordinates into `augment_phylopic!`. It does not claim live
  reactive overlay tracking.
- `taxon_discovery.jl`: an optional live example that resolves bear names
  through PhyloPicMakie's built-in discovery layer and renders their primary
  silhouettes.

## Live fetch examples

The first four gallery scripts remain deterministic and offline.
`taxon_discovery.jl` requires network access to PhyloPic.
