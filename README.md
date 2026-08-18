# PhyloPicMakie

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://jeetsukumaran.github.io/PhyloPicMakie.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://jeetsukumaran.github.io/PhyloPicMakie.jl/dev/)
[![Build Status](https://github.com/jeetsukumaran/PhyloPicMakie.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/jeetsukumaran/PhyloPicMakie.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Aqua](https://raw.githubusercontent.com/JuliaTesting/Aqua.jl/master/badge.svg)](https://github.com/JuliaTesting/Aqua.jl)

PhyloPicMakie places PhyloPic silhouettes in Makie figures. Start with the
[stable documentation](https://jeetsukumaran.github.io/PhyloPicMakie.jl/stable/)
or [development documentation](https://jeetsukumaran.github.io/PhyloPicMakie.jl/dev/)
for the reader map, then use the [example gallery](#example-gallery) to run
silhouette-annotated figures locally.

## Example gallery

A standalone examples environment lives in `examples/`, and version control
intentionally keeps only `examples/Project.toml` as the examples environment
file. On a clean checkout, run
`julia --project=examples -e 'import Pkg; Pkg.instantiate()'` to resolve a
fresh local `examples/Manifest.toml` from the current project constraints; that
local manifest stays ignored and untracked.

Run `julia --project=examples examples/src/explicit_overlays.jl`,
`julia --project=examples examples/src/thumbnail_gallery.jl`, or
`julia --project=examples examples/src/graph_anchors.jl` from the repository
root to run the gallery directly. In an interactive session each script
displays its figure. When run as a script, each example saves a PNG in the
current working directory by default, and the first argument can override that
output path.

The `graph_anchors.jl` example builds a `GraphMakie` plot, reads the node
positions from `p[:node_pos][]`, and passes those coordinates to
`augment_phylopic!`. It does not keep silhouettes attached while the graph
layout changes.

The gallery scripts are local rendering examples. The documentation shows
`node_uuid` calls for network-enabled PhyloPic use.
