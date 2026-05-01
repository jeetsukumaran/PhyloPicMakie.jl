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

A standalone examples environment lives in `examples/`. Run
`julia --project=examples examples/src/explicit_overlays.jl`,
`julia --project=examples examples/src/thumbnail_gallery.jl`, or
`julia --project=examples examples/src/graph_anchors.jl` from the repository
root to generate deterministic offline gallery artifacts in `examples/build/`.

For CI-friendly verification, run `julia --project=examples examples/smoke.jl`.
The required gallery intentionally omits a live UUID-fetch example so the
smoke path stays deterministic and headless-friendly.
