```@meta
CurrentModule = PhyloPicMakie
```

# Build a thumbnail gallery

Use this guide when you need a labelled thumbnail gallery from a collection of
PhyloPic node UUIDs. The result is a figure with one primary image, when
available, for each UUID and the label you supply for its group.

```julia
using CairoMakie
using PhyloPicMakie

node_uuids = [
    "8f901db5-84c1-4dc0-93ba-2300eeddf4ab",
    "36c04f2f-b7d2-4891-a4a9-138d79592bf2",
]
node_labels = ["Example group A", "Example group B"]

figure = phylopic_thumbnail_grid(
    node_uuids;
    node_labels,
    image_filter = :primary,
    image_layout = :blocks,
    image_label = [:taxon_name],
    ncols = 2,
    title = "Example thumbnail gallery",
)

save("thumbnail-gallery.png", figure)
```

`node_labels` supplies the `:taxon_name` portion of each cell label. With
`image_layout = :blocks`, every non-empty UUID group starts on a fresh row and
cells in that group wrap at `ncols`. Use `:rows` when every non-empty group
should occupy one unwrapped row, or `:flat` when group boundaries should be
ignored.

`node_labels` must align one-for-one with `node_uuids`; supplying it provides
the displayed taxon-name context and avoids the default preferred-name lookup
request for each UUID.

Start with PhyloPic node UUIDs. `phylopic_thumbnail_grid` selects image records
internally; it does not take taxon names or `PhyloPicImage` records as direct
gallery input. If another package starts from taxon names, use
[`PaleobiologyDB.PBDBMakie`](https://jeetsukumaran.github.io/PaleobiologyDB.jl/dev/api/phylopic_makie/)
for that package's taxon-name workflow. Read [about PaleobiologyDB
workflows](../explanation/paleobiologydb-workflows.md) for the distinction.
If you already have decoded image matrices, the prebuilt-cell overload in the
[rendering reference](../api/rendering.md) is an advanced alternative.

Choose a primary image, another image filter, or an image quality with
[choose PhyloPic images](choose-phylopic-images.md). The direct gallery call
does not call `PhyloPicDB.batch_primary_images` or `PhyloPicDB.batch_images`.
After it selects an image URL, the decoded-image loader is DataCaches-backed.
When another step needs reusable image records, those batch functions deduplicate
UUIDs and cache their queries; see [cache repeated PhyloPic queries](repeated-queries.md).

See the [rendering reference](../api/rendering.md) for the full gallery keyword
reference and the [PhyloPicDB reference](../api/phylopic_db.md) for client API
details.
