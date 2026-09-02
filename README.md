# PhyloPicMakie

[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://jeetsukumaran.github.io/PhyloPicMakie.jl/dev/)
[![Build Status](https://github.com/jeetsukumaran/PhyloPicMakie.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/jeetsukumaran/PhyloPicMakie.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Aqua](https://raw.githubusercontent.com/JuliaTesting/Aqua.jl/master/badge.svg)](https://github.com/JuliaTesting/Aqua.jl)

`PhyloPicMakie` adds [PhyloPic](https://www.phylopic.org/) silhouettes to
[Makie](https://docs.makie.org/stable/) figures. It provides coordinate and
range overlays, thumbnail galleries, image loading, and a supported nested
client for the PhyloPic v2 API at `PhyloPicMakie.PhyloPicDB`.

## Installation

After the package is registered in Julia General, install it with:

```julia
import Pkg
Pkg.add("PhyloPicMakie")
```

To use the current development version before registration:

```julia
import Pkg
Pkg.add(url = "https://github.com/jeetsukumaran/PhyloPicMakie.jl")
```

PhyloPicMakie supports Julia 1.11 and later and Makie 0.24.

## Quick start

Non-bang augmentation functions return Makie's conventional figure-axis-plot
container. Bang functions add silhouettes to a Makie parent and return the
native recipe plot.

```julia
using CairoMakie
using PhyloPicMakie

result = augment_phylopic(
    [1.0],
    [2.0];
    taxon = ["Ursus arctos"],
    glyph_size = 0.4,
    axis = (; title = "PhyloPic silhouette"),
)

fig, ax, plot = result
plot.visible[] = false
```

Access the same objects as `result.figure`, `result.axis`, and `result.plot`.
The plot handle supports `Makie.update!`, visibility changes, nesting under
another plot, and `delete!(ax, plot)` through Makie's normal lifecycle.

The `taxon` source resolves scientific names directly through PhyloPic. Use
the nested API namespace for inspectable REPL results, batch resolution,
external taxonomy providers, or image metadata:

```julia
using PhyloPicMakie

const PhyloPicDB = PhyloPicMakie.PhyloPicDB
resolution = PhyloPicDB.resolve_taxon("Ursus arctos")
image = PhyloPicDB.primary_image(resolution)

if !isnothing(image)
    println(image.license)
    println(image.attribution)
end
```

## Public interfaces

- `phylopicglyphs` and `phylopicglyphs!` are the discovery-free native Makie
  recipe constructors for decoded images and positions.
- `augment_phylopic` and `augment_phylopic_ranges` create a figure and axis and
  return `Makie.FigureAxisPlot`.
- `augment_phylopic!` and `augment_phylopic_ranges!` add images to an existing
  Makie parent and return `PhyloPicGlyphs`.
- `phylopic_thumbnail_grid` creates a silhouette gallery.
- `phylopic_thumbnail_grid!` adds a gallery to an existing axis.
- `PhyloPicMakie.PhyloPicDB` provides typed PhyloPic node and image records,
  native name search, explicit GBIF and PBDB resolvers, identifier resolution,
  pagination, image selection, and batch requests.

See the [development documentation](https://jeetsukumaran.github.io/PhyloPicMakie.jl/dev/)
for complete examples and API details. The repository also contains a compact
beginner-to-advanced gallery in [`examples/`](examples/README.md).

## Migration from the pre-recipe API

- Bang augmentation calls now return `PhyloPicGlyphs` instead of `nothing`.
- Non-bang augmentation calls now return `Makie.FigureAxisPlot`; destructure
  them as `fig, ax, plot`, not `fig, ax`.
- Passing more than one of `taxon`, `node_uuid`, and `glyph` is an error.
- A 404 or genuine missing image remains a semantic absence. Transport, HTTP,
  malformed-response, download, and decode failures now throw.
- Replace uses of private anchored-overlay helpers with `phylopicglyphs!`.

## Image licensing and attribution

The package license does not determine the license of an individual PhyloPic
image. Each `PhyloPicImage` can carry its own `license`, `license_url`,
`attribution`, and `contributor_href`. Inspect and retain those fields when
publishing or redistributing a silhouette. Follow the terms attached to the
specific image.

## Relationship to Phylopic

The registered [`Phylopic`](https://github.com/PoisotLab/SpeciesDistributionToolkit.jl)
component of `SpeciesDistributionToolkit.jl` retrieves silhouettes for species
distribution workflows. `PhyloPicMakie` focuses on Makie-native placement and
gallery rendering and includes a typed client for the PhyloPic v2 API.

## Development disclosure

Generative AI tools have contributed to source code, tests, and documentation
in this repository. The package maintainer remains responsible for reviewing,
understanding, and validating all released code.
