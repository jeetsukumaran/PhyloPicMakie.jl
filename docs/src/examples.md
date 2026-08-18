```@meta
CurrentModule = PhyloPicMakie
```

# Examples

The repository includes a standalone `examples` environment for gallery
scripts. These scripts focus on local Makie rendering examples.

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
- `julia --project=examples examples/src/thumbnail_gallery.jl`
- `julia --project=examples examples/src/graph_anchors.jl`

In an interactive Julia session each script displays the figure. When run as a
script, each example saves a PNG in the current working directory by default.
Pass a custom path as the first argument if you want the output somewhere else.

- `explicit_overlays.jl`: point-coordinate and range-coordinate silhouettes.
- `thumbnail_gallery.jl`: a deterministic local rendering example; use
  [build a thumbnail gallery](how-to/thumbnail-gallery.md) for the
  PhyloPic UUID workflow.
- `graph_anchors.jl`: a `GraphMakie` plot whose node positions are read from
  `p[:node_pos][]` and passed to `augment_phylopic!`.

## Network-enabled examples

The gallery scripts are local rendering examples. The primer, tutorial, and
how-to guides show `node_uuid` calls for network-enabled PhyloPic use.
