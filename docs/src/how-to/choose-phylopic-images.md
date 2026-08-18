```@meta
CurrentModule = PhyloPicMakie
```

# Choose PhyloPic images

Use this guide when you have a PhyloPic node UUID or image records and need to
choose a silhouette or image quality for a figure or gallery.

For one figure, pass the UUIDs directly with `node_uuid`. The plotting call
selects each node's primary image and deduplicates repeated UUID strings within
that call.

```julia
using CairoMakie
using PhyloPicMakie

figure = Figure()
axis = Axis(figure[1, 1])

augment_phylopic!(
    axis,
    [1.0, 2.0],
    [1.0, 1.8];
    node_uuid = [
        "8f901db5-84c1-4dc0-93ba-2300eeddf4ab",
        "36c04f2f-b7d2-4891-a4a9-138d79592bf2",
    ],
    image_rendering = :thumbnail,
    on_missing = :placeholder,
)
```

Use `PhyloPicMakie.PhyloPicDB.primary_image` when you need one representative
image record before plotting. Use `PhyloPicMakie.PhyloPicDB.clade_images` for
images attached to a node or its descendants, and use
`PhyloPicMakie.PhyloPicDB.node_images` when you need only images attached
directly to the node. Select one record from an image list with
`PhyloPicMakie.PhyloPicDB.select_image`.

```julia
using PhyloPicMakie

const PPDB = PhyloPicMakie.PhyloPicDB
node_uuid = "36c04f2f-b7d2-4891-a4a9-138d79592bf2"

primary = PPDB.primary_image(node_uuid)
clade_pool = PPDB.clade_images(node_uuid; max_pages = 1)
node_pool = PPDB.node_images(node_uuid; max_pages = 1)
selected = PPDB.select_image(clade_pool, :first)
```

These calls can make live PhyloPic requests, so this page leaves them as Julia
code rather than running them during the documentation build.

For a repeated UUID collection, use the batch APIs when a later step needs the
image records. `PhyloPicDB.batch_primary_images` calls `DataCaches.autocache`
around primary-image queries, and `PhyloPicDB.batch_images` calls
`DataCaches.autocache` around image-list queries. Both batch functions
deduplicate UUIDs before querying.

```julia
image_records = PPDB.batch_primary_images([node_uuid, node_uuid])
image_pools = PPDB.batch_images([node_uuid]; filter = :clade, max_pages = 2)
```

This batch-record workflow differs from direct plotting. Direct `node_uuid`
plotting deduplicates UUIDs within its call; after selecting an image URL,
`_load_phylopic_image(url)` uses `DataCaches.autocache` for decoded image
matrices. Use [cache repeated PhyloPic queries](repeated-queries.md) for the
larger repeated-query workflow.

Choose `image_rendering = :thumbnail` for the default PNG thumbnail and
`:raster` for the largest raster file. Use `:og_image` for the Open Graph PNG.
Use `:vector` for an SVG silhouette and `:source_file` for the original upload;
those options may require an SVG-capable FileIO plugin in the active Julia
environment.

See the [rendering reference](../api/rendering.md) for every rendering keyword
and the [PhyloPicDB reference](../api/phylopic_db.md) for API-client facts.
