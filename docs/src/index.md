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
    node_uuid = ["3c4b8687-2401-4e5b-afb5-19aa3e7e8b26"],
    glyph_size = 0.4,
)

result.figure
```

`augment_phylopic` creates a figure and axis and returns them as
`(; figure, axis)`. Use `augment_phylopic!` to add silhouettes to an existing
axis.

## API sections

| Section | Description |
|:--|:--|
| [Rendering API](api/rendering.md) | Overlay and thumbnail-gallery functions for Makie |
| [PhyloPicDB](api/phylopic_db.md) | Supported nested namespace for PhyloPic nodes, images, resolution, and batch requests |
| [Examples](examples.md) | Offline gallery scripts and live-fetch guidance |

## Image licensing

PhyloPic images can use different licenses. Inspect the `license`,
`license_url`, `attribution`, and `contributor_href` fields on each
`PhyloPicDB.PhyloPicImage` before publishing or redistributing it.

## Index

```@index
```
