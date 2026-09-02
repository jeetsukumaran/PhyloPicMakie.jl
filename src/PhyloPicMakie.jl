"""
    PhyloPicMakie

Standalone Makie + FileIO package providing image-loading, rendering, and
PhyloPic-native visualization utilities for
[PhyloPic](https://www.phylopic.org/) silhouette images.

`PhyloPicMakie.PhyloPicDB` is the supported nested namespace for the package's
typed PhyloPic v2 API client. Its public exports follow the same compatibility
policy as the top-level rendering API.

## Namespace hierarchy

```
PhyloPicMakie                  ← this module (Makie + image rendering)
PhyloPicMakie.PhyloPicDB       ← the PhyloPicDB data-access module
```

## Public API

### Glyph overlay

| Function | Description |
|---|---|
| `phylopicglyphs[!](positions, images; ...)` | Native, discovery-free `PhyloPicGlyphs` recipe |
| `augment_phylopic!(parent, xs, ys; taxon, ...)` | Discover and add one glyph per datum; return the recipe plot |
| `augment_phylopic(xs, ys; taxon, ...)` | Create and return `Makie.FigureAxisPlot` |
| `augment_phylopic!(parent, xs, ys, images; ...)` | Low-level convenience wrapper for decoded image matrices |
| `augment_phylopic_ranges!(parent, xstart, xstop, y; taxon, ...)` | Range-relative glyphs; return the recipe plot |
| `augment_phylopic_ranges(xstart, xstop, y; taxon, ...)` | Create and return `Makie.FigureAxisPlot` |
| `augment_phylopic!(parent, table; x, y, taxon, ...)` | Table-oriented variant |
| `augment_phylopic_ranges!(parent, table; xstart, xstop, y, taxon, ...)` | Table range variant |

All vector-API variants accept exactly one of `taxon`, `node_uuid`, or a
preloaded `glyph::AbstractMatrix`.

### Thumbnail gallery

| Function | Description |
|---|---|
| `phylopic_thumbnail_grid!(ax, node_uuids; ...)` | Gallery in an existing axis |
| `phylopic_thumbnail_grid(node_uuids; ...)` | Factory: creates `Figure` + `Axis` |
| `phylopic_thumbnail_grid!(ax, images, labels, group_sizes; ...)` | Low-level: pre-built cell data |
| `phylopic_thumbnail_grid(images, labels, group_sizes; ...)` | Low-level factory |

Single-UUID and table-oriented variants are also available for all functions above.
Thumbnail galleries also accept `PhyloPicNode` and `TaxonResolution` values.

## Internal helpers

The following `_`-prefixed symbols are implementation details. They are not
covered by the public compatibility policy:

| Symbol | Description |
|---|---|
| `_load_phylopic_image(url)` | Download + decode + cache a PNG image |
| `_resolve_images_by_uuid(uuids, glyph, n; ...)` | UUID vector → image matrix vector |
| `_resolve_taxon_node_uuids(taxa, resolver, n; ...)` | Taxon queries → node UUID vector |
| `_compute_image_bbox(x, y, w, h; ...)` | Data-space bounding box with scale correction |
| `_augment_resolved_phylopic_anchored!(parent, anchors, images; ...)` | Shared render-preparation path for pre-resolved images |
| `_axis_scale_correction_obs(scene)` | Reactive `(ypx/unit) / (xpx/unit)` correction |
| `_apply_rotation(img, deg)` | Rotate image matrix by multiples of 90° |
| `_range_anchor(xstart, xstop, at)` | Resolve range endpoint to an x coordinate |
| `_extract_column(table, selector)` | Generic table-column extractor |
| `_fetch_node_image_pool(uuid, filter, pages)` | Fetch image pool for one PhyloPic node |
| `_build_node_grid_cells(uuids, labels, ...)` | Build flat cell data for grid rendering |
| `_apply_image_selector(pool, selector)` | Select images from a `PhyloPicImage` pool |
| `_select_image_url(img, rendering)` | Extract URL from `PhyloPicImage` by rendering symbol |
| `_download_image(img, label; rendering)` | Download and decode one `PhyloPicImage` |
| `_build_label(name, k, multi, img, label, sep)` | Build the display label for a grid cell |
"""
module PhyloPicMakie

include("PhyloPicDB/PhyloPicDB.jl")
import .PhyloPicDB

import Makie
import FileIO
import Downloads
import DataCaches: autocache
using Makie: RGBA, N0f8, Colorant

export augment_phylopic!
export augment_phylopic
export augment_phylopic_ranges!
export augment_phylopic_ranges
export PhyloPicGlyphs
export phylopicglyphs
export phylopicglyphs!
export phylopic_thumbnail_grid!
export phylopic_thumbnail_grid

include("_image_cache.jl")
include("_coordinates.jl")
include("_anchored_overlay.jl")
include("_phylopic_glyphs.jl")
include("_render_core.jl")
include("_thumbnail_grid.jl")
include("_glyph_resolution.jl")
include("_augment_api.jl")
include("_node_thumbnail_grid.jl")

end # module PhyloPicMakie
