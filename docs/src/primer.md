```@meta
CurrentModule = PhyloPicMakie
```

# Place silhouettes in Makie figures

Most PhyloPicMakie plots start with two things: positions in a Makie figure
and PhyloPic node UUIDs for the silhouettes you want to draw.

```@setup primer-figure
using CairoMakie
using PhyloPicMakie
```

```@example primer-figure
figure = CairoMakie.Figure(size = (720, 360))
axis = CairoMakie.Axis(
    figure[1, 1];
    xlabel = "x coordinate",
    ylabel = "y coordinate",
    title = "Silhouettes at coordinates",
)
coordinates_x = [1.0, 2.4, 3.8, 5.2]
coordinates_y = [1.0, 2.5, 1.7, 2.9]
node_uuids = [
    "8f901db5-84c1-4dc0-93ba-2300eeddf4ab",
    "36c04f2f-b7d2-4891-a4a9-138d79592bf2",
    "8f901db5-84c1-4dc0-93ba-2300eeddf4ab",
    nothing,
]
CairoMakie.lines!(axis, coordinates_x, coordinates_y; color = :gray65)
CairoMakie.scatter!(axis, coordinates_x, coordinates_y; color = :white, markersize = 14)

PhyloPicMakie.augment_phylopic!(
    axis,
    coordinates_x,
    coordinates_y;
    node_uuid = node_uuids,
    glyph_size = 0.32,
    placement = :bottom,
    yoffset = 0.12,
    on_missing = :placeholder,
)

CairoMakie.xlims!(axis, 0.4, 5.8)
CairoMakie.ylims!(axis, 0.4, 3.6)
mkpath("primer") # hide
CairoMakie.save(joinpath("primer", "primer-silhouettes.png"), figure)
nothing # hide
```

![](primer/primer-silhouettes.png)

Each coordinate marks a silhouette position. `node_uuid` tells
PhyloPicMakie which PhyloPic image to request for that position. Repeated
UUIDs in the same call are looked up once for that call. `on_missing =
:placeholder` keeps the layout visible when a UUID has no usable image or the
request cannot complete.

If you already have a decoded image matrix, pass it with `glyph` instead of
`node_uuid`. That is a secondary path for local data or precomputed images:

```julia
augment_phylopic!(axis, coordinates_x, coordinates_y; glyph = my_image_matrix)
```

Continue with the [tutorial](tutorial.md) to build and save a first figure in
small steps. Use [adjust silhouette placement](how-to/adjust-placement.md)
when the first figure needs visual tuning, [choose PhyloPic images](how-to/choose-phylopic-images.md)
when you need image records or another rendering quality, and
[handle missing images](how-to/handle-missing-images.md) when placeholders do
not fit the workflow. The [how-to guide for repeated queries](how-to/repeated-queries.md)
shows where DataCaches-backed batch calls fit, and the
[rendering reference](api/rendering.md) records all plotting options.
