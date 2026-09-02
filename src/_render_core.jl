# ---------------------------------------------------------------------------
# PhyloPicMakie — core rendering loop
#
# Provides the generic augment_phylopic! and augment_phylopic_ranges! entry
# points that render pre-resolved image matrices onto a Makie axis.
#
# Taxon-name resolution belongs outside this package. Integrations can call
# this function after resolving image matrices without adding their data-source
# dependencies to PhyloPicMakie.
#
# The visible glyphs now render through the shared anchored-overlay substrate
# in `_anchored_overlay.jl`.  Explicit data-coordinate wrappers still enter
# here, but this layer now owns only image preparation, missing-image policy,
# and routing to the common data-anchor owner.
#
# Public:
#   augment_phylopic!(ax, xs, ys, images; ...)  → Nothing
#   augment_phylopic(xs, ys, images; ...)       → (; figure, axis)
#   augment_phylopic_ranges!(ax, xstarts, xstops, ys, images; ...) → Nothing
#   augment_phylopic_ranges(xstarts, xstops, ys, images; ...)      → (; figure, axis)
#
# Internal:
#   _augment_resolved_phylopic_anchored!(parent, anchors, images; ...) → overlay/nothing
# ---------------------------------------------------------------------------

import Makie

const _FigureAxisResult = NamedTuple{
    (:figure, :axis),
    Tuple{Makie.Figure, Makie.Axis},
}

const _FigureOrAxisSettings = Union{NamedTuple, AbstractDict{Symbol}}

function _new_figure_axis(
        figure::Union{NamedTuple, AbstractDict{Symbol}},
        axis::Union{NamedTuple, AbstractDict{Symbol}},
    )::_FigureAxisResult
    fig = Makie.Figure(; figure...)
    ax = Makie.Axis(fig[1, 1]; axis...)
    return (; figure = fig, axis = ax)
end

"""
    augment_phylopic!(
        ax::Makie.Axis,
        xs::AbstractVector{<:Real},
        ys::AbstractVector{<:Real},
        images::AbstractVector;
        glyph_size::Real,
        aspect::Symbol,
        placement::Symbol,
        xoffset::Real,
        yoffset::Real,
        rotation::Real,
        mirror::Bool,
        on_missing::Symbol,
    ) -> Nothing

Add one PhyloPic overlay glyph per data point to `ax` using pre-resolved
image matrices.

`images` is a `Vector{Union{Matrix{RGBA{N0f8}}, Nothing}}` — `nothing`
entries are handled according to `on_missing`.

This is the generic rendering entry point. Callers are responsible for
supplying pre-resolved images.

For `aspect = :preserve`, rendered glyphs maintain their correct pixel-space
aspect ratio on anisotropic axes and stay reactive under relimit and resize
through the shared anchored-overlay substrate.
"""

function _placeholder_glyph()::Matrix{RGBA{N0f8}}
    glyph = fill(RGBA{N0f8}(0.83, 0.83, 0.83, 0.5), 8, 8)
    glyph[1, :] .= RGBA{N0f8}(0.5, 0.5, 0.5, 1.0)
    glyph[end, :] .= RGBA{N0f8}(0.5, 0.5, 0.5, 1.0)
    glyph[:, 1] .= RGBA{N0f8}(0.5, 0.5, 0.5, 1.0)
    glyph[:, end] .= RGBA{N0f8}(0.5, 0.5, 0.5, 1.0)
    return glyph
end

"""
    augment_phylopic(
        xs::AbstractVector{<:Real},
        ys::AbstractVector{<:Real},
        images::AbstractVector;
        figure = (;),
        axis = (;),
        kwargs...,
    ) -> NamedTuple{(:figure, :axis)}

Create a new `Makie.Figure` and `Makie.Axis`, render pre-resolved PhyloPic
image matrices at `(xs[i], ys[i])`, and return `(; figure, axis)`.

The `figure` and `axis` keyword arguments accept named tuples or symbol-keyed
dictionaries whose entries are forwarded to the corresponding Makie
constructors. The result supports field access and destructuring:

```julia
result = augment_phylopic(xs, ys, images; glyph_size = 0.4)
result.figure
result.axis

fig, ax = augment_phylopic(xs, ys, images; glyph_size = 0.4)
```

See [`augment_phylopic!`](@ref) for rendering keyword documentation.
"""
function augment_phylopic(
        xs::AbstractVector{<:Real},
        ys::AbstractVector{<:Real},
        images::AbstractVector;
        figure::_FigureOrAxisSettings = (;),
        axis::_FigureOrAxisSettings = (;),
        glyph_size::Real = 0.4,
        aspect::Symbol = :preserve,
        placement::Symbol = :center,
        xoffset::Real = 0.0,
        yoffset::Real = 0.0,
        rotation::Real = 0.0,
        mirror::Bool = false,
        on_missing::Symbol = :skip,
    )::_FigureAxisResult
    result = _new_figure_axis(figure, axis)
    augment_phylopic!(
        result.axis,
        xs,
        ys,
        images;
        glyph_size,
        aspect,
        placement,
        xoffset,
        yoffset,
        rotation,
        mirror,
        on_missing,
    )
    return result
end

function _prepared_anchor_positions(anchor_positions, kept_indices::AbstractVector{<:Integer})
    anchor_positions isa AbstractVector && return anchor_positions[kept_indices]
    return Makie.lift(pos -> pos[kept_indices], anchor_positions)
end

function _augment_resolved_phylopic_anchored!(
        parent,
        anchor_positions,
        images::AbstractVector;
        anchor_space::Symbol,
        glyph_size_space::Symbol,
        glyph_size::Real,
        aspect::Symbol,
        placement::Symbol,
        xoffset::Real,
        yoffset::Real,
        rotation::Real,
        mirror::Bool,
        on_missing::Symbol,
    )::Union{Nothing, _AnchoredOverlay}
    on_missing ∈ VALID_ON_MISSING || throw(
        ArgumentError(
            "augment_phylopic: unknown `on_missing` value `$on_missing`. " *
                "Valid values: $(join(VALID_ON_MISSING, ", "))."
        )
    )

    kept_indices = Int[]
    rendered_images = AbstractMatrix[]
    sizehint!(kept_indices, length(images))
    sizehint!(rendered_images, length(images))

    for i in eachindex(images)
        img = images[i]

        if isnothing(img)
            if on_missing === :error
                throw(
                    ErrorException(
                        "augment_phylopic: missing image for data point $i " *
                            "(on_missing = :error)."
                    )
                )
            elseif on_missing === :placeholder
                push!(kept_indices, i)
                push!(rendered_images, _placeholder_glyph())
            end
            continue
        end

        rendered = _apply_rotation(img, rotation)
        if mirror
            rendered = rendered[:, end:-1:1]
        end

        push!(kept_indices, i)
        push!(rendered_images, rendered)
    end

    isempty(rendered_images) && return nothing
    prepared_positions = _prepared_anchor_positions(anchor_positions, kept_indices)
    return _augment_phylopic_anchored!(
        parent,
        prepared_positions,
        rendered_images;
        anchor_space = anchor_space,
        glyph_size_space = glyph_size_space,
        glyph_size = glyph_size,
        aspect = aspect,
        placement = placement,
        xoffset = xoffset,
        yoffset = yoffset,
    )
end

function augment_phylopic!(
        ax::Makie.Axis,
        xs::AbstractVector{<:Real},
        ys::AbstractVector{<:Real},
        images::AbstractVector;
        glyph_size::Real,
        aspect::Symbol,
        placement::Symbol,
        xoffset::Real,
        yoffset::Real,
        rotation::Real,
        mirror::Bool,
        on_missing::Symbol,
    )::Nothing
    n = length(xs)
    n == length(ys) == length(images) || throw(
        ArgumentError(
            "augment_phylopic: xs, ys, and images must all have the same length."
        )
    )

    anchors = Makie.Point2f[
        Makie.Point2f(Float32(xs[i]), Float32(ys[i])) for i in eachindex(xs)
    ]
    _augment_resolved_phylopic_anchored!(
        ax,
        anchors,
        images;
        anchor_space = :data,
        glyph_size_space = :data,
        glyph_size = glyph_size,
        aspect = aspect,
        placement = placement,
        xoffset = xoffset,
        yoffset = yoffset,
        rotation = rotation,
        mirror = mirror,
        on_missing = on_missing,
    )
    return nothing
end

"""
    augment_phylopic_ranges!(
        ax::Makie.Axis,
        xstart::AbstractVector{<:Real},
        xstop::AbstractVector{<:Real},
        y::AbstractVector{<:Real},
        images::AbstractVector;
        at::Symbol = :midpoint,
        kwargs...,
    ) -> Nothing

Add one PhyloPic glyph per datum to `ax` using pre-resolved image matrices,
where each glyph is anchored relative to a range `(xstart[i], xstop[i])`.

Computes anchor x coordinates from the range endpoints via `_range_anchor` and
then calls [`augment_phylopic!`](@ref).

## Arguments

- `xstart`, `xstop`: range endpoints in axis data units.
- `y`: vertical coordinate for each datum.
- `images`: pre-resolved image matrices (`nothing` entries handled by
  `on_missing`).
- `at`: where along the range to anchor the glyph.  One of:
  - `:start` — anchor at `xstart[i]`.
  - `:stop` — anchor at `xstop[i]`.
  - `:midpoint` (default) — anchor at the midpoint.
- All remaining keyword arguments are forwarded to [`augment_phylopic!`](@ref).

## Returns

`Nothing`.
"""
function augment_phylopic_ranges!(
        ax::Makie.Axis,
        xstart::AbstractVector{<:Real},
        xstop::AbstractVector{<:Real},
        y::AbstractVector{<:Real},
        images::AbstractVector;
        at::Symbol = :midpoint,
        kwargs...,
    )::Nothing
    n = length(y)
    length(xstart) == n || throw(
        ArgumentError(
            "augment_phylopic_ranges!: `xstart` and `y` must have the same length."
        )
    )
    length(xstop) == n || throw(
        ArgumentError(
            "augment_phylopic_ranges!: `xstop` and `y` must have the same length."
        )
    )
    xs = [_range_anchor(Float64(xstart[i]), Float64(xstop[i]), at) for i in 1:n]
    augment_phylopic!(ax, xs, y, images; kwargs...)
    return nothing
end

"""
    augment_phylopic_ranges(
        xstart::AbstractVector{<:Real},
        xstop::AbstractVector{<:Real},
        y::AbstractVector{<:Real},
        images::AbstractVector;
        figure = (;),
        axis = (;),
        at::Symbol = :midpoint,
        kwargs...,
    ) -> NamedTuple{(:figure, :axis)}

Create a new `Makie.Figure` and `Makie.Axis`, render pre-resolved PhyloPic
images at range-relative anchors, and return `(; figure, axis)`.

See [`augment_phylopic_ranges!`](@ref) for rendering keyword documentation.
"""
function augment_phylopic_ranges(
        xstart::AbstractVector{<:Real},
        xstop::AbstractVector{<:Real},
        y::AbstractVector{<:Real},
        images::AbstractVector;
        figure::_FigureOrAxisSettings = (;),
        axis::_FigureOrAxisSettings = (;),
        at::Symbol = :midpoint,
        glyph_size::Real = 0.4,
        aspect::Symbol = :preserve,
        placement::Symbol = :center,
        xoffset::Real = 0.0,
        yoffset::Real = 0.0,
        rotation::Real = 0.0,
        mirror::Bool = false,
        on_missing::Symbol = :skip,
    )::_FigureAxisResult
    result = _new_figure_axis(figure, axis)
    augment_phylopic_ranges!(
        result.axis,
        xstart,
        xstop,
        y,
        images;
        at,
        glyph_size,
        aspect,
        placement,
        xoffset,
        yoffset,
        rotation,
        mirror,
        on_missing,
    )
    return result
end
