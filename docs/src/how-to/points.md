```@meta
CurrentModule = PhyloPicMakie
```

# Place silhouettes on points

To annotate plotted x and y coordinates, pass one PhyloPic node UUID per point.

```@setup point-silhouettes
using CairoMakie
using PhyloPicMakie
```

```@example point-silhouettes
figure = CairoMakie.Figure(size = (720, 360))
axis = CairoMakie.Axis(
    figure[1, 1];
    xlabel = "x coordinate",
    ylabel = "y coordinate",
    title = "Silhouettes on points",
)
x = [1.0, 2.5, 4.0]
y = [1.1, 2.3, 1.5]
node_uuids = [
    "8f901db5-84c1-4dc0-93ba-2300eeddf4ab",
    "36c04f2f-b7d2-4891-a4a9-138d79592bf2",
    nothing,
]
CairoMakie.lines!(axis, x, y; color = :gray65)
CairoMakie.scatter!(axis, x, y; color = :white, markersize = 14)

augment_phylopic!(
    axis,
    x,
    y;
    node_uuid = node_uuids,
    glyph_size = 0.32,
    placement = :bottom,
    yoffset = 0.12,
    on_missing = :placeholder,
)

CairoMakie.xlims!(axis, 0.4, 4.6)
CairoMakie.ylims!(axis, 0.5, 2.9)
mkpath("points") # hide
CairoMakie.save(joinpath("points", "points-silhouettes.png"), figure)
nothing # hide
```

![](points/points-silhouettes.png)

Expected result: the silhouette appears at each plotted coordinate.
If an image is unavailable, `on_missing = :placeholder` draws a visible
placeholder so the coordinate layout can still be checked.

If your code already has a decoded image matrix, pass that matrix with
`glyph` instead of `node_uuid`:

```julia
augment_phylopic!(axis, x, y; glyph = my_image_matrix)
```

See the [rendering reference](../api/rendering.md) for the complete option
set, [adjust silhouette placement](adjust-placement.md) to tune the visual
result, [choose PhyloPic images](choose-phylopic-images.md) to select another
image representation, or [handle missing images](handle-missing-images.md) to
choose another missing-image policy. The [fuller point-and-range example](../examples.md)
shows a larger panel.
