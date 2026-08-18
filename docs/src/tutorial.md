```@meta
CurrentModule = PhyloPicMakie
```

# Make your first silhouette-annotated figure

In this tutorial, we will place PhyloPic silhouettes at 4 coordinates and save
the completed figure.

![](tutorial/tutorial-first-figure.png)

The figure uses PhyloPic node UUIDs. It can make live requests for image data;
if a request cannot complete, the example keeps the plotted layout visible with
placeholders.

## 1. Load the packages

```@example first-figure
using CairoMakie
using PhyloPicMakie
```

Expected result: CairoMakie creates the figure, and PhyloPicMakie places the
silhouettes.

## 2. Mark the coordinates

```@example first-figure
figure = Figure(size = (720, 360))
axis = Axis(
    figure[1, 1];
    xlabel = "x coordinate",
    ylabel = "y coordinate",
    title = "My first silhouette figure",
)
coordinates_x = [1.0, 2.4, 3.8, 5.2]
coordinates_y = [1.0, 2.5, 1.7, 2.9]
lines!(axis, coordinates_x, coordinates_y; color = :gray65)
scatter!(axis, coordinates_x, coordinates_y; color = :white, markersize = 14)
xlims!(axis, 0.4, 5.8)
ylims!(axis, 0.4, 3.6)
nothing # hide
```

Expected result: the axis contains 4 outlined points connected by a light
line.

## 3. Add PhyloPic node UUIDs

```@example first-figure
node_uuids = [
    "8f901db5-84c1-4dc0-93ba-2300eeddf4ab",
    "36c04f2f-b7d2-4891-a4a9-138d79592bf2",
    "8f901db5-84c1-4dc0-93ba-2300eeddf4ab",
    nothing,
]
nothing # hide
```

Expected result: `node_uuids` has one entry per coordinate. The repeated UUID
is intentional; PhyloPicMakie resolves a repeated UUID once within this call.

## 4. Add silhouettes and save the figure

```@example first-figure
augment_phylopic!(
    axis,
    coordinates_x,
    coordinates_y;
    node_uuid = node_uuids,
    glyph_size = 0.32,
    placement = :bottom,
    yoffset = 0.12,
    on_missing = :placeholder,
)

mkpath("tutorial") # hide
CairoMakie.save(joinpath("tutorial", "tutorial-first-figure.png"), figure)
nothing # hide
```

Expected result: the saved figure shows a silhouette above each point, like the
completed figure at the start of this lesson. A gray placeholder means that no
image was available for that entry during the run.

For focused tasks, continue with the [how-to guides](how-to/index.md). See the
[placement guide](how-to/adjust-placement.md) when the first figure needs
visual tuning, [choose PhyloPic images](how-to/choose-phylopic-images.md) when
you need image records or another rendering quality, and
[handle missing images](how-to/handle-missing-images.md) for another missing-image
policy. See the [how-to guide for repeated queries](how-to/repeated-queries.md)
when you will reuse the same UUIDs across analyses, or the
[rendering reference](api/rendering.md) when you need the complete list of
options.
