```@meta
CurrentModule = PhyloPicMakie
```

# Rendering API

PhyloPicMakie renders silhouettes through the native `PhyloPicGlyphs` Makie
recipe. Discovery-aware augmentation functions resolve images first and then
delegate to that recipe; the recipe itself performs no network I/O.

## Native glyph recipe

Use `phylopicglyphs` or `phylopicglyphs!` when positions and decoded image
matrices are already available:

```julia
using CairoMakie

glyph = fill(RGBAf(0.1, 0.1, 0.1, 1.0), 40, 80)
positions = Point2f[(1, 2), (3, 1)]

fig = Figure()
ax = Axis(fig[1, 1])
plot = phylopicglyphs!(ax, positions, [glyph, glyph]; glyph_size = 0.4)
```

Numeric matrices are normalized to color matrices before they become scatter
markers, preventing Makie from interpreting floating-point pixels as
signed-distance-field markers. The recipe accepts matching data-space or
pixel-space position and size contracts. It owns all child plots and supports
ordinary Makie composition and lifecycle operations:

```julia
Makie.update!(plot; glyph_size = 0.6)
plot.visible[] = false
delete!(ax, plot)
```

A bang call may use an axis, scene, or plot accepted by Makie's recipe
composition API. Nesting under another plot makes the glyph recipe part of
that plot's child tree.

## Discovery-aware augmentation

Each augmentation call accepts exactly one image source:

- `taxon` resolves one scientific-name query per datum;
- `node_uuid` uses one already-known PhyloPic node UUID per datum;
- `glyph` broadcasts one preloaded image matrix.

Functions ending in `!` compose into an existing Makie parent and return the
`PhyloPicGlyphs` plot:

```julia
plot = augment_phylopic!(
    ax,
    [1.0],
    [2.0];
    taxon = ["Ursus arctos"],
)
```

`augment_phylopic` and `augment_phylopic_ranges` create a `Makie.Figure` and
`Makie.Axis` and return `Makie.FigureAxisPlot`:

```julia
result = augment_phylopic(
    [1.0],
    [2.0];
    taxon = ["Ursus arctos"],
    figure = (; size = (640, 480)),
    axis = (; title = "Silhouette overlay"),
)

fig, ax, plot = result
```

The `taxon_resolver` keyword defaults to
`PhyloPicDB.PhyloPicResolver()`. Pass `PhyloPicDB.GBIFResolver()` or
`PhyloPicDB.PBDBResolver()` to request one explicit external taxonomy
provider. `on_ambiguous = :error` prevents arbitrary selection; use `:skip`
to treat ambiguous entries as unavailable.

`on_missing` controls semantic absence: a not-found taxon, absent primary
image, absent rendering URL, or explicit `nothing` image. Operational
transport, HTTP, malformed-response, download, and decode failures throw.

Table methods accept a taxon-name column selector:

```julia
table = (x = [1.0], y = [2.0], scientific_name = ["Ursus arctos"])
plot = augment_phylopic!(
    ax,
    table;
    x = :x,
    y = :y,
    taxon = :scientific_name,
)
```

## Thumbnail galleries

`phylopic_thumbnail_grid` creates a figure; `phylopic_thumbnail_grid!` adds a
gallery to an existing axis. Galleries accept UUID strings, `PhyloPicNode`
values, or `TaxonResolution` values, which supports interactive candidate
inspection:

```julia
candidates = PhyloPicDB.search_nodes("Ursus arctos")
phylopic_thumbnail_grid(candidates)
```

## Migration from the pre-recipe API

- Bang augmentation calls return `PhyloPicGlyphs`, not `nothing`.
- Non-bang augmentation calls return `Makie.FigureAxisPlot`; use
  `fig, ax, plot = result` rather than `fig, ax = result`.
- Passing multiple image sources is an error; no source silently takes
  precedence.
- Operational failures throw instead of becoming missing glyphs.
- Private anchored-overlay helpers and proxy handles are replaced by
  `phylopicglyphs!` and Makie's native plot tree.

## Reference

```@docs
PhyloPicGlyphs
phylopicglyphs
phylopicglyphs!
augment_phylopic
augment_phylopic!
augment_phylopic_ranges
augment_phylopic_ranges!
phylopic_thumbnail_grid
phylopic_thumbnail_grid!
```
