```@meta
CurrentModule = PhyloPicMakie
```

# PhyloPicMakie

Documentation for [PhyloPicMakie](https://github.com/jeetsukumaran/PhyloPicMakie.jl).

`PhyloPicMakie` provides Julia tools for working with [PhyloPic](https://www.phylopic.org/) silhouette images in Makie plots.

The package owns a generic anchored-overlay foundation for PhyloPic glyphs.
Public explicit-coordinate helpers use that same substrate internally, and
packages with rendered-object or projected-anchor workflows can build on the
same owner layer without reimplementing Makie projection logic.

## Example gallery

The repository ships a standalone `examples` environment that demonstrates the
public overlay interface without any `PaleobiologyDB.jl` dependency. See the
[Examples](examples.md) page for setup, manual run commands, output behavior,
and the `graph_anchors.jl` node-position snapshot hand-off note.

## Packages

| Module | Description |
|--------|-------------|
| [`PhyloPicMakie`](api/rendering.md) | Makie rendering primitives: overlay pre-resolved silhouettes on axes |
| [`PhyloPicMakie.PhyloPicDB`](api/phylopic_db.md) | PhyloPic HTTP API client: resolve taxa, fetch images and metadata |

## Quick Index

```@index
```
