# Example gallery

This directory contains a standalone `PhyloPicMakie.jl` gallery environment.
The 4 scripts progress from a minimal overlay to range data, typed taxon
resolution, and graph composition. They focus on the package's public Makie
interfaces and use live PhyloPic records.

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

- `julia --project=examples examples/src/minimal_overlay.jl`
- `julia --project=examples examples/src/range_overlay.jl`
- `julia --project=examples examples/src/taxon_discovery.jl`
- `julia --project=examples examples/src/graph_anchors.jl`

Each script is a direct public example. In an interactive Julia session it
displays the figure. When run as a script, it saves a PNG in the current
working directory by default. Pass a custom path as the first argument if you
want the output somewhere else.

- `minimal_overlay.jl`: a minimal figure-creating call using a taxon query.
- `range_overlay.jl`: range bars with silhouettes anchored at range midpoints.
- `taxon_discovery.jl`: typed taxon resolutions rendered as a thumbnail gallery
  with image license labels.
- `graph_anchors.jl`: a `GraphMakie` node-position snapshot passed to
  `augment_phylopic!` for tip silhouettes. The overlay is a snapshot, not live
  reactive tracking.

## Network and image licenses

All 4 scripts require network access to PhyloPic for taxon queries. Downloaded
images use the package cache. Each PhyloPic image retains its own license and
attribution terms; inspect those fields before publishing an output.
