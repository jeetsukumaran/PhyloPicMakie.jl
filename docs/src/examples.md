```@meta
CurrentModule = PhyloPicMakie
```

# Examples

The repository includes a standalone `examples` environment for public Makie
gallery scripts. The required examples use pre-resolved image matrices and do
not require network access.

## Setup

Version control intentionally keeps only `examples/Project.toml` as the
versioned examples environment file. From the repository root, run:

```julia
julia --project=examples -e 'import Pkg; Pkg.instantiate()'
```

That command resolves a fresh local `examples/Manifest.toml` from the current
project constraints. The local manifest stays ignored and untracked.

## Run the gallery scripts

Run these commands from the repository root:

- `julia --project=examples examples/src/explicit_overlays.jl`
- `julia --project=examples examples/src/figure_factories.jl`
- `julia --project=examples examples/src/thumbnail_gallery.jl`
- `julia --project=examples examples/src/graph_anchors.jl`
- `julia --project=examples examples/src/taxon_discovery.jl`

In an interactive Julia session each script displays the figure. When run as a
script, each example saves a PNG in the current working directory by default.
Pass a custom path as the first argument if you want the output somewhere else.

- `explicit_overlays.jl`: public explicit-coordinate and range-anchor overlays.
- `figure_factories.jl`: figure-creating coordinate and range overlay methods.
- `thumbnail_gallery.jl`: public thumbnail-grid rendering with grouped labels.
- `graph_anchors.jl`: a `GraphMakie` node-position snapshot hand-off. The
  example materializes `graphplot`, snapshots `p[:node_pos][]`, and forwards
  those explicit coordinates into `augment_phylopic!`; it is not presented as a
  live reactive overlay example.
- `taxon_discovery.jl`: a live, built-in taxon-name resolution example that
  prints typed results and renders bear silhouettes without pre-discovered
  node UUIDs.

## Live fetch scope

The first four scripts remain offline. `taxon_discovery.jl` is an optional
live example and requires access to the PhyloPic service.
