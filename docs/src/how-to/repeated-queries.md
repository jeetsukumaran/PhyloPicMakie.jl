```@meta
CurrentModule = PhyloPicMakie
```

# Cache repeated PhyloPic queries

Use this guide when your data repeats node UUIDs or when you rerun the same
PhyloPic queries while building several figures.

For one figure, pass node UUIDs directly to the plotting function:

```julia
using CairoMakie
using PhyloPicMakie

figure = Figure()
axis = Axis(figure[1, 1])

uuids = [
    "8f901db5-84c1-4dc0-93ba-2300eeddf4ab",
    "36c04f2f-b7d2-4891-a4a9-138d79592bf2",
    "8f901db5-84c1-4dc0-93ba-2300eeddf4ab",
]

augment_phylopic!(
    axis,
    [1.0, 2.0, 3.0],
    [1.5, 2.5, 1.8];
    node_uuid = uuids,
    on_missing = :placeholder,
)
```

That call deduplicates repeated UUIDs within the plotting call. When it
downloads a selected image URL, it calls `_load_phylopic_image(url)`, which
uses `DataCaches.autocache` in `src/_image_cache.jl`.

When you need image records before plotting, call the DataCaches-backed batch
functions from `PhyloPicDB`:

```julia
using PhyloPicMakie

const PPDB = PhyloPicMakie.PhyloPicDB

uuids = [
    "8f901db5-84c1-4dc0-93ba-2300eeddf4ab",
    "36c04f2f-b7d2-4891-a4a9-138d79592bf2",
    "8f901db5-84c1-4dc0-93ba-2300eeddf4ab",
]

primary_images = PPDB.batch_primary_images(uuids)
image_pools = PPDB.batch_images(uuids; max_pages = 2)
```

`PhyloPicDB.batch_primary_images` caches calls to `PhyloPicDB.primary_image`.
`PhyloPicDB.batch_images` caches calls to `PhyloPicDB.fetch_images`. Both
functions call `DataCaches.autocache` in `src/PhyloPicDB/_bulk.jl`, and both
deduplicate repeated UUIDs before querying.

Use direct `augment_phylopic!` calls for one-off figures. Use the batch
functions when another step needs the image records, when you will reuse a UUID
set, or when a gallery workflow needs image pools before rendering.

See the [rendering reference](../api/rendering.md) for plotting keywords and
the [PhyloPicDB reference](../api/phylopic_db.md) for API-client details.
