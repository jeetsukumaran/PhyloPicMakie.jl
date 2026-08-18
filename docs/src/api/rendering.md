```@meta
CurrentModule = PhyloPicMakie
```

# Rendering API

Use this page when you need signatures, keyword meanings, return values, and
error behavior for silhouette plotting.

For task-oriented examples, see [adjust silhouette placement](../how-to/adjust-placement.md),
[build a thumbnail gallery](../how-to/thumbnail-gallery.md), and
[handle missing images](../how-to/handle-missing-images.md).

For the common path, pass one PhyloPic node UUID per point, range, or table
row with `node_uuid`. If another package resolves taxon names or PBDB records
to PhyloPic node UUIDs, pass those UUIDs here. For PBDB-integrated
taxon-name resolution, see [`PaleobiologyDB.PhyloPicPBDB`](https://jeetsukumaran.github.io/PaleobiologyDB.jl/dev/api/phylopic_makie/).

If you already have decoded image matrices, use `glyph` or the
vector-with-images method. Direct `node_uuid` plotting resolves repeated UUIDs
once within a plotting call. For repeated PhyloPic API queries across calls,
use `PhyloPicMakie.PhyloPicDB.batch_primary_images` or
`PhyloPicMakie.PhyloPicDB.batch_images`; those functions call
`DataCaches.autocache` in `src/PhyloPicDB/_bulk.jl`.

```@autodocs
Modules = [PhyloPicMakie]
```
