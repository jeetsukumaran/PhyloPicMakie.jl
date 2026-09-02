```@meta
CurrentModule = PhyloPicMakie
```

# Examples

The repository includes a standalone `examples` environment for public Makie
gallery scripts. The examples form a short progression rather than an
exhaustive recipe collection.

| Level | Example | Main interface |
|:--|:--|:--|
| Beginner | Minimal overlay | `augment_phylopic` |
| Intermediate | Range overlay | `augment_phylopic_ranges!` |
| Intermediate | Taxon discovery | `PhyloPicDB.resolve_taxa` and `phylopic_thumbnail_grid` |
| Advanced | Graph anchors | `GraphMakie.graphplot` and `augment_phylopic!` |

## Setup

Version control intentionally keeps only `examples/Project.toml` as the
versioned examples environment file. From the repository root, run:

```julia
julia --project=examples -e 'import Pkg; Pkg.instantiate()'
```

That command resolves a fresh local `examples/Manifest.toml` from the current
project constraints. The local manifest stays ignored and untracked.

## Run the gallery scripts

Run these commands from the repository root:

- `julia --project=examples examples/src/minimal_overlay.jl`
- `julia --project=examples examples/src/range_overlay.jl`
- `julia --project=examples examples/src/taxon_discovery.jl`
- `julia --project=examples examples/src/graph_anchors.jl`

In an interactive Julia session each script displays the figure. When run as a
script, each example saves a PNG in the current working directory by default.
Pass a custom path as the first argument if you want the output somewhere else.

## Minimal overlay

Start with the figure-creating function and one taxon query:

```julia
result = augment_phylopic(
    [0.0],
    [0.0];
    taxon = ["Ursus arctos"],
    glyph_size = 0.45,
)

figure, axis, plot = result
```

`result` is a `Makie.FigureAxisPlot`. Its fields provide the new figure, axis,
and `PhyloPicGlyphs` plot.

## Range overlay

Use the bang function to compose silhouettes with a range plot in an existing
axis:

```julia
plot = augment_phylopic_ranges!(
    axis,
    minimum_mass,
    maximum_mass,
    row;
    taxon,
    at = :midpoint,
    placement = :bottom,
)
```

The complete example draws representative body-mass intervals first, then
anchors one silhouette at each interval midpoint.

## Taxon discovery

Resolve taxon queries explicitly when the result status or selected PhyloPic
node needs inspection:

```julia
resolutions = PhyloPicDB.resolve_taxa(taxa)
figure = phylopic_thumbnail_grid(
    resolutions;
    ncols = 2,
    image_label = [:taxon_name, :license],
)
```

The thumbnail gallery accepts the typed taxon resolutions directly. The
example includes each PhyloPic image's license in its label.

## Graph anchors

GraphMakie exposes the calculated node positions through `graph_plot[:node_pos]`.
The advanced example snapshots selected tip positions and passes their explicit
coordinates to the parent-composing function:

```julia
tip_positions = graph_plot[:node_pos][][tip_indices]
plot = augment_phylopic!(
    axis,
    first.(tip_positions),
    last.(tip_positions);
    taxon = tip_taxa,
)
```

This handoff is a position snapshot. Moving GraphMakie nodes later does not
move the silhouettes automatically.

## Network and image licenses

All gallery scripts require access to the PhyloPic service for taxon queries.
Downloaded images use the package cache. PhyloPic images can use different
licenses; inspect the `license`, `license_url`, `attribution`, and
`contributor_href` fields before publishing or redistributing an image.
