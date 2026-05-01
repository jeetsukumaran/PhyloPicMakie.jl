# Example gallery

This directory contains a standalone `PhyloPicMakie.jl` gallery environment.
It stays isolated from `PaleobiologyDB.jl` and focuses on the package's public
Makie overlay surface.

## Deterministic examples

Run any example from the repository root:

- `julia --project=examples examples/src/explicit_overlays.jl`
- `julia --project=examples examples/src/thumbnail_gallery.jl`
- `julia --project=examples examples/src/graph_anchors.jl`

Each script writes a PNG artifact into `examples/build/`.

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
