```@meta
CurrentModule = PhyloPicMakie
```

# Adjust silhouette placement

Use this guide when a silhouette is in the right figure but needs a different
size, alignment, offset, rotation, or horizontal reflection.

```@setup adjust-placement
using CairoMakie
using PhyloPicMakie
```

```@example adjust-placement
figure = CairoMakie.Figure(size = (900, 640))
size_axis = CairoMakie.Axis(
    figure[1, 1];
    title = "Size and placement",
    xlabel = "x coordinate",
    ylabel = "y coordinate",
)
orientation_axis = CairoMakie.Axis(
    figure[2, 1];
    title = "Offsets, rotation, and mirroring",
    xlabel = "x coordinate",
    ylabel = "y coordinate",
)

node_uuids = [
    "8f901db5-84c1-4dc0-93ba-2300eeddf4ab",
    "36c04f2f-b7d2-4891-a4a9-138d79592bf2",
]

for axis in (size_axis, orientation_axis)
    CairoMakie.scatter!(axis, [1.0, 2.5, 4.0], fill(1.0, 3); color = :white, markersize = 14)
    CairoMakie.xlims!(axis, 0.4, 4.6)
    CairoMakie.ylims!(axis, 0.2, 2.0)
end

PhyloPicMakie.augment_phylopic!(
    size_axis,
    [1.0, 2.5],
    [1.0, 1.0];
    node_uuid = node_uuids,
    glyph_size = 0.22,
    placement = :bottom,
    yoffset = 0.08,
    on_missing = :placeholder,
)
PhyloPicMakie.augment_phylopic!(
    size_axis,
    [4.0],
    [1.0];
    node_uuid = [node_uuids[1]],
    glyph_size = 0.42,
    placement = :center,
    on_missing = :placeholder,
)

PhyloPicMakie.augment_phylopic!(
    orientation_axis,
    [1.0],
    [1.0];
    node_uuid = [node_uuids[1]],
    glyph_size = 0.30,
    placement = :left,
    xoffset = 0.20,
    yoffset = 0.12,
    on_missing = :placeholder,
)
PhyloPicMakie.augment_phylopic!(
    orientation_axis,
    [2.5],
    [1.0];
    node_uuid = [node_uuids[2]],
    glyph_size = 0.30,
    placement = :bottom,
    rotation = 90,
    on_missing = :placeholder,
)
PhyloPicMakie.augment_phylopic!(
    orientation_axis,
    [4.0],
    [1.0];
    node_uuid = [node_uuids[1]],
    glyph_size = 0.30,
    placement = :bottom,
    mirror = true,
    on_missing = :placeholder,
)

mkpath("adjust-placement") # hide
CairoMakie.save(
    joinpath("adjust-placement", "placement-adjustments.png"),
    figure,
)
nothing # hide
```

![](adjust-placement/placement-adjustments.png)

Start by choosing `glyph_size`: it sets the silhouette's half-height in data
units. Then set `placement` to choose which part of the silhouette touches the
coordinate. In the first panel, `:bottom` puts the lower edge at the point,
while `:center` keeps the point at the centre.

Use `xoffset` and `yoffset` for small data-unit adjustments after choosing a
placement. Use `rotation` in 90-degree increments when the orientation needs
to change, and use `mirror = true` to flip a silhouette horizontally. The
example uses `on_missing = :placeholder` so an unavailable live image leaves a
visible marker while you tune the layout.

See the [rendering reference](../api/rendering.md) for the complete keyword
facts. See [handle missing images](handle-missing-images.md) when you need a
different missing-image policy.
