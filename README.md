# PhyloPicMakie

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://jeetsukumaran.github.io/PhyloPicMakie.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://jeetsukumaran.github.io/PhyloPicMakie.jl/dev/)
[![Build Status](https://github.com/jeetsukumaran/PhyloPicMakie.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/jeetsukumaran/PhyloPicMakie.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Aqua](https://raw.githubusercontent.com/JuliaTesting/Aqua.jl/master/badge.svg)](https://github.com/JuliaTesting/Aqua.jl)

`PhyloPicMakie` provides Makie-native rendering utilities for pre-resolved
PhyloPic silhouette images. Public explicit-coordinate overlay calls now route
through a shared internal anchored-overlay substrate, so both data-space and
projected pixel-space anchor workflows keep aspect, placement, and resize
behavior inside `PhyloPicMakie` instead of reimplementing Makie-space
projection mechanics in client packages.

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

The `graph_anchors.jl` example is a `GraphMakie` node-position snapshot
hand-off: it materializes `graphplot`, snapshots `p[:node_pos][]`, and routes
those explicit coordinates into the public `augment_phylopic!` surface. It is
not a live reactive overlay example.

The gallery intentionally omits a required live UUID-fetch example. Ad hoc
live UUID experiments can still be done interactively against the public
overlay and thumbnail-grid APIs when network access is desired.
