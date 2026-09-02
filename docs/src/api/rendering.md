```@meta
CurrentModule = PhyloPicMakie
```

# Rendering API

PhyloPicMakie provides separate figure-creating and axis-mutating entry points.

## Figure-creating functions

`augment_phylopic` and `augment_phylopic_ranges` create a new `Makie.Figure`
and `Makie.Axis`. They return a named tuple `(; figure, axis)`:

```julia
result = augment_phylopic(
    [1.0],
    [2.0];
    node_uuid = ["3c4b8687-2401-4e5b-afb5-19aa3e7e8b26"],
    figure = (; size = (640, 480)),
    axis = (; title = "Silhouette overlay"),
)

fig, ax = result
```

`phylopic_thumbnail_grid` creates and returns a `Makie.Figure` containing a
gallery.

## Axis-mutating functions

Functions ending in `!` add content to an existing axis:

```julia
using CairoMakie

fig = Figure()
ax = Axis(fig[1, 1])

augment_phylopic!(
    ax,
    [1.0],
    [2.0];
    node_uuid = ["3c4b8687-2401-4e5b-afb5-19aa3e7e8b26"],
)
```

All overlay functions also accept a preloaded image matrix through `glyph`.
The low-level vector methods accept one pre-resolved image matrix per datum.

Resolve identifiers from external databases before calling these functions.
PhyloPicMakie does not depend on a specific taxonomic database client.

## Reference

```@docs
augment_phylopic
augment_phylopic!
augment_phylopic_ranges
augment_phylopic_ranges!
phylopic_thumbnail_grid
phylopic_thumbnail_grid!
```
