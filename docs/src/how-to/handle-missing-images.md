```@meta
CurrentModule = PhyloPicMakie
```

# Handle missing images

Use this guide when some positions have no PhyloPic image or when a live image
request cannot complete. Choose the missing-image policy that matches the role
of the figure.

```@setup missing-image-policy
using CairoMakie
using PhyloPicMakie
```

```@example missing-image-policy
figure = CairoMakie.Figure(size = (840, 360))
skip_axis = CairoMakie.Axis(
    figure[1, 1];
    title = "Skip missing images",
    xlabel = "x coordinate",
    ylabel = "y coordinate",
)
placeholder_axis = CairoMakie.Axis(
    figure[1, 2];
    title = "Show placeholders",
    xlabel = "x coordinate",
    ylabel = "y coordinate",
)

for axis in (skip_axis, placeholder_axis)
    CairoMakie.scatter!(axis, [1.0, 2.0], [1.0, 1.0]; color = :white, markersize = 14)
    CairoMakie.xlims!(axis, 0.5, 2.5)
    CairoMakie.ylims!(axis, 0.4, 1.8)
end

missing_uuids = [nothing, nothing]
PhyloPicMakie.augment_phylopic!(
    skip_axis,
    [1.0, 2.0],
    [1.0, 1.0];
    node_uuid = missing_uuids,
    glyph_size = 0.25,
    on_missing = :skip,
)
PhyloPicMakie.augment_phylopic!(
    placeholder_axis,
    [1.0, 2.0],
    [1.0, 1.0];
    node_uuid = missing_uuids,
    glyph_size = 0.25,
    on_missing = :placeholder,
)

mkpath("handle-missing-images") # hide
CairoMakie.save(
    joinpath("handle-missing-images", "missing-image-policies.png"),
    figure,
)
nothing # hide
```

![](handle-missing-images/missing-image-policies.png)

Use `on_missing = :skip` when absent silhouettes should leave their positions
empty. Use `on_missing = :placeholder` when readers need to see which plotted
positions could not receive an image. The placeholder keeps the coordinate
layout visible; it does not select a fallback silhouette.

Use `on_missing = :error` when a missing image should stop a pipeline. Catch
the error only when the calling workflow can report or recover from it.

```@example missing-image-policy
error_figure = CairoMakie.Figure()
error_axis = CairoMakie.Axis(error_figure[1, 1])

error_message = try
    PhyloPicMakie.augment_phylopic!(
        error_axis,
        [1.0],
        [1.0];
        node_uuid = [nothing],
        glyph_size = 0.25,
        on_missing = :error,
    )
    "no error"
catch error
    sprint(showerror, error)
end

error_message
```

See the [rendering reference](../api/rendering.md) for the exact error and
keyword behavior.
