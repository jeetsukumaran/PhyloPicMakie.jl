# ---------------------------------------------------------------------------
# PhyloPicMakie — rendering convenience API
#
# Discovery-free wrappers around the native PhyloPicGlyphs recipe.
# ---------------------------------------------------------------------------

const _FigureAxisResult = NamedTuple{
    (:figure, :axis),
    Tuple{Makie.Figure, Makie.Axis},
}

const _FigureOrAxisSettings = Union{NamedTuple, AbstractDict{Symbol}}

function _new_figure_axis(
        figure::_FigureOrAxisSettings,
        axis::_FigureOrAxisSettings,
    )::_FigureAxisResult
    fig = Makie.Figure(; figure...)
    ax = Makie.Axis(fig[1, 1]; axis...)
    return (; figure = fig, axis = ax)
end

function _xy_anchor_positions(
        xs::AbstractVector{<:Real},
        ys::AbstractVector{<:Real},
        images::AbstractVector,
    )::Vector{Makie.Point2f}
    length(xs) == length(ys) == length(images) || throw(
        ArgumentError(
            "augment_phylopic: xs, ys, and images must all have the same length."
        )
    )
    return Makie.Point2f[
        Makie.Point2f(Float32(xs[index]), Float32(ys[index])) for index in eachindex(xs)
    ]
end

"""
    _augment_resolved_phylopic_anchored!(parent, positions, images; kwargs...)
        -> PhyloPicGlyphs

Internal adapter for callers that already have decoded images and anchors in
either data or pixel space. The returned recipe owns every rendering primitive.
"""
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
    )::PhyloPicGlyphs
    return phylopicglyphs!(
        parent,
        anchor_positions,
        images;
        space = anchor_space,
        glyph_size_space,
        glyph_size,
        aspect,
        placement,
        xoffset,
        yoffset,
        rotation,
        mirror,
        on_missing,
    )
end

"""
    augment_phylopic!(parent, xs, ys, images; kwargs...) -> PhyloPicGlyphs

Render pre-resolved image matrices at explicit coordinates in an existing
Makie parent. This convenience function delegates to [`phylopicglyphs!`](@ref)
and returns the recipe plot.
"""
function augment_phylopic!(
        parent,
        xs::AbstractVector{<:Real},
        ys::AbstractVector{<:Real},
        images::AbstractVector;
        glyph_size::Real = 0.4,
        aspect::Symbol = :preserve,
        placement::Symbol = :center,
        xoffset::Real = 0.0,
        yoffset::Real = 0.0,
        rotation::Real = 0.0,
        mirror::Bool = false,
        on_missing::Symbol = :skip,
    )::PhyloPicGlyphs
    anchors = _xy_anchor_positions(xs, ys, images)
    return _augment_resolved_phylopic_anchored!(
        parent,
        anchors,
        images;
        anchor_space = :data,
        glyph_size_space = :data,
        glyph_size,
        aspect,
        placement,
        xoffset,
        yoffset,
        rotation,
        mirror,
        on_missing,
    )
end

"""
    augment_phylopic(xs, ys, images; kwargs...) -> Makie.FigureAxisPlot

Create a figure and axis and render pre-resolved image matrices through the
native [`PhyloPicGlyphs`](@ref) recipe.
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
    )::Makie.FigureAxisPlot
    anchors = _xy_anchor_positions(xs, ys, images)
    return phylopicglyphs(
        anchors,
        images;
        figure,
        axis,
        glyph_size,
        glyph_size_space = :data,
        aspect,
        placement,
        xoffset,
        yoffset,
        rotation,
        mirror,
        on_missing,
    )
end

"""
    augment_phylopic_ranges!(parent, xstart, xstop, y, images; at = :midpoint, kwargs...)
        -> PhyloPicGlyphs

Render pre-resolved glyphs at range-relative anchors in an existing Makie
parent and return the recipe plot.
"""
function augment_phylopic_ranges!(
        parent,
        xstart::AbstractVector{<:Real},
        xstop::AbstractVector{<:Real},
        y::AbstractVector{<:Real},
        images::AbstractVector;
        at::Symbol = :midpoint,
        kwargs...,
    )::PhyloPicGlyphs
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
    xs = [_range_anchor(Float64(xstart[index]), Float64(xstop[index]), at) for index in 1:n]
    return augment_phylopic!(parent, xs, y, images; kwargs...)
end

"""
    augment_phylopic_ranges(xstart, xstop, y, images; at = :midpoint, kwargs...)
        -> Makie.FigureAxisPlot

Create a figure and axis and render pre-resolved glyphs at range-relative
anchors.
"""
function augment_phylopic_ranges(
        xstart::AbstractVector{<:Real},
        xstop::AbstractVector{<:Real},
        y::AbstractVector{<:Real},
        images::AbstractVector;
        figure::_FigureOrAxisSettings = (;),
        axis::_FigureOrAxisSettings = (;),
        at::Symbol = :midpoint,
        kwargs...,
    )::Makie.FigureAxisPlot
    n = length(y)
    length(xstart) == n || throw(
        ArgumentError(
            "augment_phylopic_ranges: `xstart` and `y` must have the same length."
        )
    )
    length(xstop) == n || throw(
        ArgumentError(
            "augment_phylopic_ranges: `xstop` and `y` must have the same length."
        )
    )
    xs = [_range_anchor(Float64(xstart[index]), Float64(xstop[index]), at) for index in 1:n]
    return augment_phylopic(xs, y, images; figure, axis, kwargs...)
end
