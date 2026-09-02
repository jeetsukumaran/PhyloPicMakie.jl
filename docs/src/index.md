```@meta
CurrentModule = PhyloPicMakie
```

# PhyloPicMakie

`PhyloPicMakie` adds [PhyloPic](https://www.phylopic.org/) silhouettes to Makie
figures. It supports explicit coordinate overlays, range-relative overlays,
thumbnail galleries, and typed access to the PhyloPic v2 API.

```@docs
PhyloPicMakie
PhyloPicDB
```

## Installation

```julia
import Pkg
Pkg.add("PhyloPicMakie")
```

## Quick start

```julia
using CairoMakie
using PhyloPicMakie

result = augment_phylopic(
    [1.0],
    [2.0];
    taxon = ["Ursus arctos"],
    glyph_size = 0.4,
)

result.figure
```

The `taxon` source searches PhyloPic directly; users do not need to discover a
node UUID first. `augment_phylopic` returns a `Makie.FigureAxisPlot` containing
the new figure, axis, and `PhyloPicGlyphs` plot. Use `augment_phylopic!` to add
silhouettes to an existing Makie parent and receive the plot handle directly.

## API sections

| Section | Description |
|:--|:--|
| [Rendering API](api/rendering.md) | Overlay and thumbnail-gallery functions for Makie |
| [PhyloPicDB](api/phylopic_db.md) | Supported nested namespace for PhyloPic nodes, images, resolution, and batch requests |
| [Examples](examples.md) | Progressive gallery scripts and live-fetch guidance |

## Image licensing

PhyloPic images can use different licenses. Inspect the `license`,
`license_url`, `attribution`, and `contributor_href` fields on each
`PhyloPicDB.PhyloPicImage` before publishing or redistributing it.

## Index

```@index
```
