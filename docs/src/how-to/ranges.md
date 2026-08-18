```@meta
CurrentModule = PhyloPicMakie
```

# Place silhouettes on ranges

To annotate interval data, draw the ranges, choose an anchor along each one,
and pass one PhyloPic node UUID per row.

```@setup range-silhouettes
using CairoMakie
using PhyloPicMakie
```

```@example range-silhouettes
figure = CairoMakie.Figure(size = (720, 420))
axis = CairoMakie.Axis(
    figure[1, 1];
    xlabel = "interval coordinate",
    ylabel = "row",
    title = "Start, midpoint, and stop anchors",
)
xstart = [0.8, 0.8, 0.8]
xstop = [4.8, 4.8, 4.8]
y = [3.0, 2.0, 1.0]
node_uuids = [
    "8f901db5-84c1-4dc0-93ba-2300eeddf4ab",
    "36c04f2f-b7d2-4891-a4a9-138d79592bf2",
    "8f901db5-84c1-4dc0-93ba-2300eeddf4ab",
]

for index in eachindex(y)
    CairoMakie.lines!(axis, [xstart[index], xstop[index]], [y[index], y[index]]; color = :gray55, linewidth = 4)
    CairoMakie.scatter!(axis, [xstart[index], xstop[index]], [y[index], y[index]]; color = :white, markersize = 10)
end

augment_phylopic_ranges!(
    axis, [xstart[1]], [xstop[1]], [y[1]];
    node_uuid = [node_uuids[1]],
    at = :start,
    glyph_size = 0.24,
    placement = :bottom,
    yoffset = 0.16,
    on_missing = :placeholder,
)
augment_phylopic_ranges!(
    axis, [xstart[2]], [xstop[2]], [y[2]];
    node_uuid = [node_uuids[2]],
    at = :midpoint,
    glyph_size = 0.24,
    placement = :bottom,
    yoffset = 0.16,
    on_missing = :placeholder,
)
augment_phylopic_ranges!(
    axis, [xstart[3]], [xstop[3]], [y[3]];
    node_uuid = [node_uuids[3]],
    at = :stop,
    glyph_size = 0.24,
    placement = :bottom,
    yoffset = 0.16,
    on_missing = :placeholder,
)
CairoMakie.text!(
    axis,
    ["start", "midpoint", "stop"];
    position = CairoMakie.Point2f.([0.8, 2.8, 4.8], y .- 0.35),
    align = (:center, :top),
)

CairoMakie.xlims!(axis, 0.4, 5.2)
CairoMakie.ylims!(axis, 0.5, 3.5)
mkpath("ranges") # hide
CairoMakie.save(joinpath("ranges", "ranges-silhouettes.png"), figure)
nothing # hide
```

![](ranges/ranges-silhouettes.png)

Expected result: the three silhouettes occupy the start, midpoint, and stop of
otherwise identical intervals. `at` selects where along each interval the
silhouette is placed.

See the [rendering reference](../api/rendering.md) for the complete option
set.
