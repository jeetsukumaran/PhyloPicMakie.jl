# ---------------------------------------------------------------------------
# PhyloPicMakie — PhyloPic-native public augment_phylopic! API
#
# Provides the public PhyloPic-native entry points for adding PhyloPic
# silhouette glyphs to a Makie axis.  All functions are keyed on PhyloPic
# node UUIDs, taxon-name queries, or pre-loaded image matrices.
#
# Also contains `_extract_column`, the table-column extractor used by this
# package's table-oriented entry points.
#
# Call graph:
#
#   augment_phylopic!                         (parent-composing vector API)
#   augment_phylopic                          (figure/axis vector factory)
#   augment_phylopic! / augment_phylopic      (table APIs)
#   augment_phylopic_ranges!                  (parent-composing range vector API)
#   augment_phylopic_ranges                   (figure/axis range vector factory)
#   augment_phylopic_ranges! / augment_phylopic_ranges (range table APIs)
#       ├─► _resolve_taxon_node_uuids(taxa, resolver, n; ...)
#       └─► _resolve_images_by_uuid(node_uuids, glyph, n; image_rendering)
#               └─► augment_phylopic!(parent, xs, ys, images; ...)  [_render_core.jl]
#                       └─► phylopicglyphs!(parent, ...)        [_phylopic_glyphs.jl]
# ---------------------------------------------------------------------------

# ---------------------------------------------------------------------------
# Internal: generic table column extraction
# ---------------------------------------------------------------------------

"""
    _extract_column(table, col_selector) -> AbstractVector

Extract a column from a table-like object using `col_selector`, which may be
a `Symbol` or `String` (column name) or `Integer` (one-based column index).

Works with any object that supports `propertynames` / `getproperty`
(e.g. `DataFrame`, `NamedTuple`), as well as integer-index access via
`propertynames`.

Throws `ArgumentError` if the column is not found or the index is out of
range.
"""
function _extract_column(table, col_selector)::AbstractVector
    if col_selector isa Symbol
        available = propertynames(table)
        col_selector ∈ available || throw(
            ArgumentError(
                "column `:$col_selector` not found. " *
                    "Available columns: " * join(string.(Symbol.(":", available)), ", ") * "."
            )
        )
        return getproperty(table, col_selector)
    elseif col_selector isa AbstractString
        return _extract_column(table, Symbol(col_selector))
    elseif col_selector isa Integer
        available = propertynames(table)
        1 ≤ col_selector ≤ length(available) || throw(
            ArgumentError(
                "column index $col_selector is out of range " *
                    "(table has $(length(available)) columns)."
            )
        )
        return getproperty(table, available[col_selector])
    else
        throw(
            ArgumentError(
                "column selector must be a Symbol, String, or Integer. " *
                    "Got $(typeof(col_selector))."
            )
        )
    end
end

# ---------------------------------------------------------------------------
# Public: core vector API (PhyloPic-native)
# ---------------------------------------------------------------------------

"""
    augment_phylopic!(
        parent,
        x::AbstractVector{<:Real},
        y::AbstractVector{<:Real};
        node_uuid::Union{AbstractVector, Nothing} = nothing,
        taxon::Union{AbstractVector, Nothing} = nothing,
        glyph::Union{AbstractMatrix, Nothing} = nothing,
        taxon_resolver::PhyloPicDB.AbstractTaxonResolver = PhyloPicDB.PhyloPicResolver(),
        build::Union{Int, Nothing} = nothing,
        placement::Symbol = :center,
        xoffset::Real = 0.0,
        yoffset::Real = 0.0,
        glyph_size::Real = 0.4,
        aspect::Symbol = :preserve,
        rotation::Real = 0.0,
        mirror::Bool = false,
        image_rendering::Symbol = :thumbnail,
        on_missing::Symbol = :skip,
        on_ambiguous::Symbol = :error,
        request = PhyloPicDB.phylopic_get,
        taxonomy_request = nothing,
    ) -> PhyloPicGlyphs

Add one PhyloPic silhouette glyph per datum to an existing Makie `parent`,
anchored at positions `(x[i], y[i])` in data coordinates. The parent may be
an axis, scene, or plot accepted by Makie's normal recipe composition API.

This is the PhyloPic-native public API. It can discover nodes from taxon names,
use already-known node UUIDs, or render a preloaded glyph.

## Arguments

- `x`, `y`: anchor coordinates in axis data space.  Must have equal length.

### Image source (exactly one required)

- `node_uuid`: per-datum PhyloPic node UUID strings.  `nothing` entries are
  handled according to `on_missing`.
- `taxon`: per-datum scientific-name queries. The default `taxon_resolver`
  searches PhyloPic directly. Pass an explicit `GBIFResolver` or
  `PBDBResolver` to use that provider.
- `glyph`: a single pre-loaded image matrix (e.g. from `FileIO.load`),
  broadcast to every data point.
- `build`: optional PhyloPic build pinned across name and image requests.

### Placement

- `placement`: anchor position on the glyph relative to the data coordinate.
  One of `:center` (default), `:left`, `:right`, `:top`, `:bottom`,
  `:topleft`, `:topright`, `:bottomleft`, `:bottomright`.
- `xoffset`, `yoffset`: additional offset in data units applied after
  anchoring.

### Sizing

- `glyph_size`: half-height of the rendered glyph in data units (total
  height = `2 * glyph_size`).  Default `0.4`.
- `aspect`: `:preserve` (default) maintains the original image aspect ratio;
  `:stretch` renders as a square.

### Rendering

- `image_rendering`: which PhyloPic image URL to fetch.  Default `:thumbnail`.
  Ignored when `glyph` is supplied directly.

  | `image_rendering` | Format |
  |---|---|
  | `:thumbnail` *(default)* | PNG; square thumbnail, largest available |
  | `:raster`    | PNG; full-resolution, largest available |
  | `:og_image`  | PNG; Open Graph social-media preview |
  | `:vector`    | SVG; black silhouette on transparent — requires SVG-capable `FileIO` plugin |
  | `:source_file` | SVG or raster — format matches the original upload |

- `rotation`: clockwise rotation in degrees.  Supported values: `0`, `90`,
  `180`, `270`.  Default `0.0`.
- `mirror`: if `true`, flip the glyph horizontally before rendering.

### Missing-value policy

- `on_missing`: how to handle data points for which no image is available.
  `:skip` (default) silently omits the glyph; `:error` throws;
  `:placeholder` draws a small gray placeholder glyph at the glyph position.
- `on_ambiguous`: how to handle a taxon query with multiple candidates.
  `:error` (default) throws; `:skip` treats the entry as unavailable.

## Returns

A [`PhyloPicGlyphs`](@ref) plot. Use the returned handle for reactive updates,
visibility, inspection, and deletion through Makie's normal plot lifecycle.

## Examples

```julia
using PhyloPicMakie, CairoMakie

fig = Figure()
ax  = Axis(fig[1, 1])

augment_phylopic!(
    ax,
    [1.0, 2.0],
    [1.0, 2.0];
    taxon            = ["Ursus arctos", "Ursus maritimus"],
    glyph_size      = 0.4,
    placement       = :center,
    image_rendering = :thumbnail,
)
```
"""
function augment_phylopic!(
        parent,
        x::AbstractVector{<:Real},
        y::AbstractVector{<:Real};
        node_uuid::Union{AbstractVector, Nothing} = nothing,
        taxon::Union{AbstractVector, Nothing} = nothing,
        glyph::Union{AbstractMatrix, Nothing} = nothing,
        taxon_resolver::PhyloPicDB.AbstractTaxonResolver = PhyloPicDB.PhyloPicResolver(),
        build::Union{Int, Nothing} = nothing,
        placement::Symbol = :center,
        xoffset::Real = 0.0,
        yoffset::Real = 0.0,
        glyph_size::Real = 0.4,
        aspect::Symbol = :preserve,
        rotation::Real = 0.0,
        mirror::Bool = false,
        image_rendering::Symbol = :thumbnail,
        on_missing::Symbol = :skip,
        on_ambiguous::Symbol = :error,
        request = PhyloPicDB.phylopic_get,
        taxonomy_request = nothing,
    )::PhyloPicGlyphs
    n = length(x)
    length(y) == n || throw(
        ArgumentError(
            "augment_phylopic!: `x` and `y` must have the same length."
        )
    )
    source_count = count(!isnothing, (node_uuid, taxon, glyph))
    source_count == 1 || throw(
        ArgumentError(
            "augment_phylopic!: exactly one of `node_uuid`, `taxon`, or `glyph` must be provided."
        )
    )

    images = if isnothing(taxon)
        _resolve_images_by_uuid(
            node_uuid,
            glyph,
            n;
            image_rendering,
            build,
            request,
        )
    else
        uuids, pinned_build = _resolve_taxon_node_uuids(
            taxon,
            taxon_resolver,
            n;
            build,
            on_ambiguous,
            request,
            taxonomy_request,
        )
        _resolve_images_by_uuid(
            uuids,
            nothing,
            n;
            image_rendering,
            build = pinned_build,
            request,
        )
    end
    return augment_phylopic!(
        parent, x, y, images;
        glyph_size = glyph_size,
        aspect = aspect,
        placement = placement,
        xoffset = xoffset,
        yoffset = yoffset,
        rotation = rotation,
        mirror = mirror,
        on_missing = on_missing,
    )
end

"""
    augment_phylopic(
        x::AbstractVector{<:Real},
        y::AbstractVector{<:Real};
        figure = (;),
        axis = (;),
        kwargs...,
    ) -> Makie.FigureAxisPlot

Create a new `Makie.Figure` and `Makie.Axis`, add one PhyloPic silhouette per
datum, and return Makie's conventional figure-axis-plot result.

Entries in the `figure` and `axis` named tuples or symbol-keyed dictionaries
are forwarded to the corresponding Makie constructors. Use
[`augment_phylopic!`](@ref) to add glyphs to an existing Makie parent.

See [`augment_phylopic!`](@ref) for the full keyword-argument documentation.
"""
function augment_phylopic(
        x::AbstractVector{<:Real},
        y::AbstractVector{<:Real};
        figure::_FigureOrAxisSettings = (;),
        axis::_FigureOrAxisSettings = (;),
        kwargs...,
    )::Makie.FigureAxisPlot
    result = _new_figure_axis(figure, axis)
    plot = augment_phylopic!(result.axis, x, y; kwargs...)
    return Makie.FigureAxisPlot(result.figure, result.axis, plot)
end

# ---------------------------------------------------------------------------
# Public: range vector API
# ---------------------------------------------------------------------------

"""
    augment_phylopic_ranges!(
        parent,
        xstart::AbstractVector{<:Real},
        xstop::AbstractVector{<:Real},
        y::AbstractVector{<:Real};
        node_uuid::Union{AbstractVector, Nothing} = nothing,
        glyph::Union{AbstractMatrix, Nothing} = nothing,
        at::Symbol = :start,
        kwargs...,
    ) -> PhyloPicGlyphs

Add one PhyloPic silhouette per datum to `parent`, anchored relative to a range
`(xstart[i], xstop[i])` at vertical position `y[i]`.

This is the **PhyloPic-native** range-based convenience wrapper for range
data (e.g. stratigraphic intervals).  It computes anchor x coordinates from
the range endpoints and then calls [`augment_phylopic!`](@ref).

## Arguments

- `xstart`, `xstop`: range endpoints in axis data units.
- `y`: vertical coordinate for each datum.
- `node_uuid`: per-datum PhyloPic node UUID strings (see
  [`augment_phylopic!`](@ref)).
- `glyph`: a single pre-loaded image matrix broadcast to all data points.
- `at`: where along the range to anchor the glyph.
  - `:start` (default) — anchor at `xstart[i]`.
  - `:stop` — anchor at `xstop[i]`.
  - `:midpoint` — anchor at `(xstart[i] + xstop[i]) / 2`.
- All remaining keyword arguments are forwarded to [`augment_phylopic!`](@ref).

## Returns

A [`PhyloPicGlyphs`](@ref) plot.

## Examples

```julia
using PhyloPicMakie, CairoMakie

node_uuids = ["3c4b8687-2401-4e5b-afb5-19aa3e7e8b26",
              "7fb20e1a-3a19-4e8c-beb9-3e7ffb59c0cf"]
first_app  = [68.0, 68.0]
last_app   = [66.0, 66.0]

fig = Figure()
ax  = Axis(fig[1, 1]; xreversed = true)
augment_phylopic_ranges!(
    ax, first_app, last_app, collect(1.0:2.0);
    node_uuid  = node_uuids,
    at         = :start,
    glyph_size = 0.4,
)
```
"""
function augment_phylopic_ranges!(
        parent,
        xstart::AbstractVector{<:Real},
        xstop::AbstractVector{<:Real},
        y::AbstractVector{<:Real};
        at::Symbol = :start,
        kwargs...,
    )::PhyloPicGlyphs
    n = length(xstart)
    length(xstop) == n || throw(
        ArgumentError(
            "augment_phylopic_ranges!: `xstart` and `xstop` must have the same length."
        )
    )
    length(y) == n || throw(
        ArgumentError(
            "augment_phylopic_ranges!: `y` must have the same length as `xstart`."
        )
    )
    xs = [_range_anchor(Float64(xstart[i]), Float64(xstop[i]), at) for i in 1:n]
    return augment_phylopic!(parent, xs, y; kwargs...)
end

"""
    augment_phylopic_ranges(
        xstart::AbstractVector{<:Real},
        xstop::AbstractVector{<:Real},
        y::AbstractVector{<:Real};
        figure = (;),
        axis = (;),
        kwargs...,
    ) -> Makie.FigureAxisPlot

Create a new `Makie.Figure` and `Makie.Axis`, add one PhyloPic silhouette per
range, and return Makie's conventional figure-axis-plot result.

See [`augment_phylopic_ranges!`](@ref) for full documentation.
"""
function augment_phylopic_ranges(
        xstart::AbstractVector{<:Real},
        xstop::AbstractVector{<:Real},
        y::AbstractVector{<:Real};
        figure::_FigureOrAxisSettings = (;),
        axis::_FigureOrAxisSettings = (;),
        kwargs...,
    )::Makie.FigureAxisPlot
    result = _new_figure_axis(figure, axis)
    plot = augment_phylopic_ranges!(result.axis, xstart, xstop, y; kwargs...)
    return Makie.FigureAxisPlot(result.figure, result.axis, plot)
end

# ---------------------------------------------------------------------------
# Public: table API
# ---------------------------------------------------------------------------

"""
    augment_phylopic!(
        parent,
        table;
        x,
        y,
        node_uuid = nothing,
        glyph = nothing,
        kwargs...,
    ) -> PhyloPicGlyphs

Table-oriented variant of [`augment_phylopic!`](@ref).

Extracts coordinate and image-source columns from a table-like source and
forwards to the vector API.

## Arguments

- `table`: any object supporting `propertynames` / `getproperty`.
- `x`: column selector for x coordinates (Symbol, String, or Integer).
- `y`: column selector for y coordinates.
- `node_uuid`: column selector for PhyloPic node UUID strings, or `nothing`
  if `glyph` is used instead.
- `taxon`: column selector for scientific-name queries, or `nothing` when
  another source is used.
- `glyph`: a single pre-loaded image matrix broadcast to all rows.
- All remaining keyword arguments are forwarded to the vector
  [`augment_phylopic!`](@ref).

## Returns

A [`PhyloPicGlyphs`](@ref) plot.

## Examples

```julia
using PhyloPicMakie, CairoMakie, DataFrames

df = DataFrame(
    x    = [1.0, 2.0],
    y    = [1.0, 2.0],
    uuid = ["3c4b8687-2401-4e5b-afb5-19aa3e7e8b26",
            "7fb20e1a-3a19-4e8c-beb9-3e7ffb59c0cf"],
)

fig = Figure()
ax  = Axis(fig[1, 1])
augment_phylopic!(ax, df; x = :x, y = :y, node_uuid = :uuid, glyph_size = 0.4)
```
"""
function augment_phylopic!(
        parent,
        table;
        x,
        y,
        node_uuid = nothing,
        taxon = nothing,
        glyph::Union{AbstractMatrix, Nothing} = nothing,
        kwargs...,
    )::PhyloPicGlyphs
    xs = _extract_column(table, x)
    ys = _extract_column(table, y)
    uuids = isnothing(node_uuid) ? nothing : _extract_column(table, node_uuid)
    taxa = isnothing(taxon) ? nothing : _extract_column(table, taxon)
    return augment_phylopic!(
        parent, xs::AbstractVector{<:Real}, ys::AbstractVector{<:Real};
        node_uuid = uuids, taxon = taxa, glyph = glyph, kwargs...,
    )
end

"""
    augment_phylopic(table; figure = (;), axis = (;), kwargs...)
        -> Makie.FigureAxisPlot

Create a new figure and axis from table columns and return Makie's
conventional figure-axis-plot result.

See [`augment_phylopic!`](@ref) for full documentation.
"""
function augment_phylopic(
        table;
        figure::_FigureOrAxisSettings = (;),
        axis::_FigureOrAxisSettings = (;),
        x,
        y,
        node_uuid = nothing,
        taxon = nothing,
        glyph::Union{AbstractMatrix, Nothing} = nothing,
        kwargs...,
    )::Makie.FigureAxisPlot
    xs = _extract_column(table, x)
    ys = _extract_column(table, y)
    uuids = isnothing(node_uuid) ? nothing : _extract_column(table, node_uuid)
    taxa = isnothing(taxon) ? nothing : _extract_column(table, taxon)
    return augment_phylopic(
        xs::AbstractVector{<:Real},
        ys::AbstractVector{<:Real};
        figure,
        axis,
        node_uuid = uuids,
        taxon = taxa,
        glyph,
        kwargs...,
    )
end

# ---------------------------------------------------------------------------
# Public: range table API
# ---------------------------------------------------------------------------

"""
    augment_phylopic_ranges!(
        parent,
        table;
        xstart,
        xstop,
        y,
        node_uuid = nothing,
        glyph = nothing,
        at::Symbol = :start,
        kwargs...,
    ) -> PhyloPicGlyphs

Table-oriented variant of [`augment_phylopic_ranges!`](@ref).

Extracts range and image-source columns from a table-like source and forwards
to the vector range API.

## Arguments

- `table`: any object supporting `propertynames` / `getproperty`.
- `xstart`, `xstop`: column selectors for the range endpoints.
- `y`: column selector for the vertical coordinate.
- `node_uuid`: column selector for PhyloPic node UUID strings, or `nothing`
  if `glyph` is used.
- `taxon`: column selector for scientific-name queries, or `nothing` when
  another source is used.
- `glyph`: a single pre-loaded image matrix broadcast to all rows.
- `at`: `:start` (default), `:stop`, or `:midpoint`.
- All remaining keyword arguments are forwarded to the vector API.

## Returns

A [`PhyloPicGlyphs`](@ref) plot.

## Examples

```julia
using PhyloPicMakie, CairoMakie, DataFrames

df = DataFrame(
    first_app = [68.0, 68.0],
    last_app  = [66.0, 66.0],
    row       = [1.0, 2.0],
    uuid      = ["3c4b8687-2401-4e5b-afb5-19aa3e7e8b26",
                 "7fb20e1a-3a19-4e8c-beb9-3e7ffb59c0cf"],
)

fig = Figure()
ax  = Axis(fig[1, 1]; xreversed = true)
augment_phylopic_ranges!(
    ax, df;
    xstart    = :first_app,
    xstop     = :last_app,
    y         = :row,
    node_uuid = :uuid,
    at        = :start,
    glyph_size = 0.4,
)
```
"""
function augment_phylopic_ranges!(
        parent,
        table;
        xstart,
        xstop,
        y,
        node_uuid = nothing,
        taxon = nothing,
        glyph::Union{AbstractMatrix, Nothing} = nothing,
        at::Symbol = :start,
        kwargs...,
    )::PhyloPicGlyphs
    xs = _extract_column(table, xstart)
    xe = _extract_column(table, xstop)
    ys = _extract_column(table, y)
    uuids = isnothing(node_uuid) ? nothing : _extract_column(table, node_uuid)
    taxa = isnothing(taxon) ? nothing : _extract_column(table, taxon)
    return augment_phylopic_ranges!(
        parent,
        xs::AbstractVector{<:Real},
        xe::AbstractVector{<:Real},
        ys::AbstractVector{<:Real};
        node_uuid = uuids, taxon = taxa, glyph = glyph, at = at, kwargs...,
    )
end

"""
    augment_phylopic_ranges(table; figure = (;), axis = (;), kwargs...)
        -> Makie.FigureAxisPlot

Create a new figure and axis from table range columns and return Makie's
conventional figure-axis-plot result.

See [`augment_phylopic_ranges!`](@ref) for full documentation.
"""
function augment_phylopic_ranges(
        table;
        figure::_FigureOrAxisSettings = (;),
        axis::_FigureOrAxisSettings = (;),
        xstart,
        xstop,
        y,
        node_uuid = nothing,
        taxon = nothing,
        glyph::Union{AbstractMatrix, Nothing} = nothing,
        at::Symbol = :start,
        kwargs...,
    )::Makie.FigureAxisPlot
    xs = _extract_column(table, xstart)
    xe = _extract_column(table, xstop)
    ys = _extract_column(table, y)
    uuids = isnothing(node_uuid) ? nothing : _extract_column(table, node_uuid)
    taxa = isnothing(taxon) ? nothing : _extract_column(table, taxon)
    return augment_phylopic_ranges(
        xs::AbstractVector{<:Real},
        xe::AbstractVector{<:Real},
        ys::AbstractVector{<:Real};
        figure,
        axis,
        node_uuid = uuids,
        taxon = taxa,
        glyph,
        at,
        kwargs...,
    )
end
