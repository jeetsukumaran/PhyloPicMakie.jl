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
    taxon = ["Ursus arctos"],
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
    taxon = ["Ursus arctos"],
)
```

Each overlay accepts exactly one image source:

- `taxon` resolves one scientific-name query per datum;
- `node_uuid` uses one already-known PhyloPic node UUID per datum;
- `glyph` broadcasts one preloaded image matrix.

The `taxon_resolver` keyword defaults to
`PhyloPicDB.PhyloPicResolver()`. Pass `PhyloPicDB.GBIFResolver()` or
`PhyloPicDB.PBDBResolver()` to request one explicit external taxonomy
provider. `on_ambiguous = :error` prevents arbitrary selection; use `:skip`
to treat ambiguous entries as unavailable. `on_missing` controls not-found
taxa, missing primary images, and image-loading failures.

Table methods accept a taxon-name column selector:

```julia
table = (x = [1.0], y = [2.0], scientific_name = ["Ursus arctos"])
augment_phylopic!(
    ax,
    table;
    x = :x,
    y = :y,
    taxon = :scientific_name,
)
```

Thumbnail galleries accept UUID strings, `PhyloPicNode` values, or
`TaxonResolution` values. This supports interactive candidate inspection:

```julia
candidates = PhyloPicDB.search_nodes("Ursus arctos")
phylopic_thumbnail_grid(candidates)
```

## Reference

```@docs
augment_phylopic
augment_phylopic!
augment_phylopic_ranges
augment_phylopic_ranges!
phylopic_thumbnail_grid
phylopic_thumbnail_grid!
```
