```@meta
CurrentModule = PhyloPicMakie
```

# Use table columns

To keep coordinate, PhyloPic node UUID, and label data together, store them in
one table-like value and pass column selectors to the table method.

```@setup table-columns
using CairoMakie
using PhyloPicMakie
```

```@example table-columns
records = (
    x = [1.0, 2.7, 4.4],
    y = [1.2, 2.4, 1.8],
    node_uuid = [
        "8f901db5-84c1-4dc0-93ba-2300eeddf4ab",
        "36c04f2f-b7d2-4891-a4a9-138d79592bf2",
        nothing,
    ],
    label = ["Sample A", "Sample B", "Sample C"],
)
figure = CairoMakie.Figure(size = (720, 420))
axis = CairoMakie.Axis(
    figure[1, 1];
    xlabel = "x coordinate",
    ylabel = "y coordinate",
)
CairoMakie.scatter!(axis, records.x, records.y; color = :white, markersize = 14)

augment_phylopic!(
    axis,
    records;
    x = :x,
    y = :y,
    node_uuid = :node_uuid,
    glyph_size = 0.28,
    aspect = :preserve,
    placement = :bottom,
    xoffset = 0.0,
    yoffset = 0.14,
    rotation = 0.0,
    mirror = false,
    on_missing = :placeholder,
)
CairoMakie.text!(
    axis,
    records.label;
    position = CairoMakie.Point2f.(records.x, records.y .- 0.30),
    align = (:center, :top),
)

CairoMakie.xlims!(axis, 0.4, 5.0)
CairoMakie.ylims!(axis, 0.5, 3.0)
mkpath("table-columns") # hide
CairoMakie.save(joinpath("table-columns", "table-columns-silhouettes.png"), figure)
nothing # hide
```

![](table-columns/table-columns-silhouettes.png)

Expected result: each available PhyloPic silhouette appears above its
coordinate with the matching label below it. A placeholder marks a row whose
image was unavailable during the run.

The table method accepts `x`, `y`, and optional `node_uuid` column selectors.
It has no label selector, so this recipe adds labels with `CairoMakie.text!`.
See the [rendering reference](../api/rendering.md) for complete behavior.

## Use a prepared image matrix

When each row already has a decoded image matrix, call the vector-with-images
method directly. That path is useful for local image data, but it is not the
normal PhyloPic lookup path.

```julia
augment_phylopic!(
    axis,
    records.x,
    records.y,
    records.image_matrices;
    glyph_size = 0.28,
)
```
