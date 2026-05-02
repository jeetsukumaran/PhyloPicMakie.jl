# ---------------------------------------------------------------------------
# PhyloPicMakie - generic anchored-overlay foundation
#
# Provides the internal substrate shared by explicit data-coordinate overlays
# and projected/screen-anchor overlays.  The visible glyphs are rendered as
# pixel-space scatter markers, while data-anchor variants retain reactive data
# limits and projected positions through transparent source plots.
# ---------------------------------------------------------------------------

"""
Valid internal anchor spaces for `_augment_phylopic_anchored!`.
"""
const VALID_ANCHOR_SPACES = (:data, :pixel)

"""
Valid internal glyph-size spaces for `_augment_phylopic_anchored!`.
"""
const VALID_GLYPH_SIZE_SPACES = (:data, :pixel)

abstract type _AbstractAnchorSpec end

struct _DataAnchors{P} <: _AbstractAnchorSpec
    positions::P
end

struct _PixelAnchors{P} <: _AbstractAnchorSpec
    positions::P
end

abstract type _AbstractGlyphSizeSpec end

struct _DataGlyphSize <: _AbstractGlyphSizeSpec
    half_height::Float64
end

struct _PixelGlyphSize <: _AbstractGlyphSizeSpec
    half_height::Float64
end

struct _AnchoredOverlay{P, Ps}
    visible_plot::P
    probe_plots::Ps
end

function Base.getproperty(overlay::_AnchoredOverlay, name::Symbol)
    if name === :visible_plot || name === :probe_plots
        return getfield(overlay, name)
    end
    return getproperty(getfield(overlay, :visible_plot), name)
end

function Base.propertynames(overlay::_AnchoredOverlay, private::Bool = false)
    return (
        :visible_plot,
        :probe_plots,
        propertynames(getfield(overlay, :visible_plot), private)...,
    )
end

_owned_plots(overlay::_AnchoredOverlay) = (overlay.visible_plot, overlay.probe_plots...)

function _delete_owned_overlay_plot!(plot)
    plot_parent = parent(plot)
    parent_owns_plot = plot_parent isa Makie.Plot && any(child -> child === plot, plot_parent.plots)
    if parent_owns_plot
        filter!(child -> child !== plot, plot_parent.plots)
    end

    scene = Makie.parent_scene(plot)
    (parent_owns_plot || any(p -> p === plot, scene.plots)) || return nothing
    delete!(scene, plot)
    return nothing
end

function Base.delete!(scene::Makie.Scene, overlay::_AnchoredOverlay)
    for plot in reverse(_owned_plots(overlay))
        _delete_owned_overlay_plot!(plot)
    end
    return overlay
end

_as_node(x::Makie.Observable) = x
_as_node(x::AbstractVector) = Makie.Observable(x)
_as_node(x) = x

_to_point2f(p) = Makie.Point2f(Float32(p[1]), Float32(p[2]))

function _to_point3f(p)
    z = length(p) >= 3 ? Float32(p[3]) : 0.0f0
    return Makie.Point3f(Float32(p[1]), Float32(p[2]), z)
end

_normalize_point2f_positions(positions::AbstractVector) =
    Makie.Point2f[_to_point2f(p) for p in positions]

_normalize_point3f_positions(positions::AbstractVector) =
    Makie.Point3f[_to_point3f(p) for p in positions]

function _anchor_positions_spec(positions; anchor_space::Symbol)::_AbstractAnchorSpec
    anchor_space === :data && return _DataAnchors(positions)
    anchor_space === :pixel && return _PixelAnchors(positions)
    throw(
        ArgumentError(
            "augment_phylopic: unsupported `anchor_space` value `$anchor_space`. " *
                "Valid values: $(join(VALID_ANCHOR_SPACES, ", "))."
        )
    )
end

function _glyph_size_spec(glyph_size::Real; glyph_size_space::Symbol)::_AbstractGlyphSizeSpec
    glyph_size_space === :data && return _DataGlyphSize(Float64(glyph_size))
    glyph_size_space === :pixel && return _PixelGlyphSize(Float64(glyph_size))
    throw(
        ArgumentError(
            "augment_phylopic: unsupported `glyph_size_space` value `$glyph_size_space`. " *
                "Valid values: $(join(VALID_GLYPH_SIZE_SPACES, ", "))."
        )
    )
end

function _transparent_probe_scatter!(parent, positions; visible = true)
    return Makie.scatter!(
        parent,
        positions;
        color = Makie.RGBAf(0, 0, 0, 0),
        markersize = 0,
        strokewidth = 0,
        visible = visible,
        inspectable = false,
    )
end

function _offset_point2f_positions(positions::AbstractVector, xoffset::Real, yoffset::Real)
    dx = Float32(xoffset)
    dy = Float32(yoffset)
    return [Makie.Point2f(p[1] + dx, p[2] + dy) for p in positions]
end

function _offset_point3f_positions(positions::AbstractVector, xoffset::Real, yoffset::Real)
    dx = Float32(xoffset)
    dy = Float32(yoffset)
    return [Makie.Point3f(p[1] + dx, p[2] + dy, p[3]) for p in positions]
end

function _vertical_probe_positions(positions::AbstractVector, delta::Real)
    dy = Float32(delta)
    return [Makie.Point2f(p[1], p[2] + dy) for p in positions]
end

function _bbox_corner_positions(
        positions::AbstractVector,
        image_sizes::AbstractVector{<:Tuple{<:Integer, <:Integer}};
        glyph_size::Real,
        aspect::Symbol,
        placement::Symbol,
        axis_scale_correction::Real,
    )::Vector{Makie.Point2f}
    corners = Makie.Point2f[]
    sizehint!(corners, 4 * length(positions))

    for (p, (img_width, img_height)) in zip(positions, image_sizes)
        x_lo, x_hi, y_lo, y_hi = _compute_image_bbox(
            p[1], p[2], img_width, img_height;
            glyph_size = glyph_size,
            aspect = aspect,
            placement = placement,
            xoffset = 0.0,
            yoffset = 0.0,
            axis_scale_correction = axis_scale_correction,
        )
        push!(corners, Makie.Point2f(x_lo, y_lo))
        push!(corners, Makie.Point2f(x_lo, y_hi))
        push!(corners, Makie.Point2f(x_hi, y_lo))
        push!(corners, Makie.Point2f(x_hi, y_hi))
    end
    return corners
end

function _pixel_marker_sizes(
        image_sizes::AbstractVector{<:Tuple{<:Integer, <:Integer}},
        half_heights_px::AbstractVector{<:Real};
        aspect::Symbol,
    )::Vector{Makie.Vec2f}
    length(image_sizes) == length(half_heights_px) || throw(
        ArgumentError(
            "augment_phylopic: image and marker-size vectors must have the same length."
        )
    )
    return [
        _compute_pixel_marker_size(img_width, img_height, half_height_px; aspect)
        for ((img_width, img_height), half_height_px) in zip(image_sizes, half_heights_px)
    ]
end

function _pixel_marker_offsets(
        marker_sizes::AbstractVector{<:Makie.VecTypes};
        placement::Symbol,
    )::Vector{Makie.Vec3f}
    (pfx, pfy) = _placement_offsets(placement)
    dx_scale = Float32(pfx)
    dy_scale = Float32(pfy)
    return [
        Makie.Vec3f(dx_scale * ms[1], dy_scale * ms[2], 0.0f0)
        for ms in marker_sizes
    ]
end

function _projected_anchor_positions!(
        parent,
        anchor_spec::_DataAnchors,
        image_sizes::AbstractVector{<:Tuple{<:Integer, <:Integer}};
        glyph_size::Real,
        aspect::Symbol,
        placement::Symbol,
        xoffset::Real,
        yoffset::Real,
        visible,
    )
    positions = Makie.lift(
        pos -> _offset_point2f_positions(_normalize_point2f_positions(pos), xoffset, yoffset),
        _as_node(anchor_spec.positions),
    )

    anchor_source = _transparent_probe_scatter!(parent, positions; visible = visible)
    anchor_pixels = Makie.register_projected_positions!(
        anchor_source;
        input_name = :positions,
        output_name = :phylopic_anchor_pixel_positions,
        output_space = :pixel,
    )

    upper_source = _transparent_probe_scatter!(
        parent,
        Makie.lift(pos -> _vertical_probe_positions(pos, glyph_size), positions);
        visible = visible,
    )
    lower_source = _transparent_probe_scatter!(
        parent,
        Makie.lift(pos -> _vertical_probe_positions(pos, -glyph_size), positions);
        visible = visible,
    )
    upper_pixels = Makie.register_projected_positions!(
        upper_source;
        input_name = :positions,
        output_name = :phylopic_upper_pixel_positions,
        output_space = :pixel,
    )
    lower_pixels = Makie.register_projected_positions!(
        lower_source;
        input_name = :positions,
        output_name = :phylopic_lower_pixel_positions,
        output_space = :pixel,
    )

    pixel_half_heights = Makie.lift(upper_pixels, lower_pixels) do upper, lower
        Float32[
            hypot(up[1] - lo[1], up[2] - lo[2]) / 2.0f0
            for (up, lo) in zip(upper, lower)
        ]
    end

    scale_corr_obs = _axis_scale_correction_obs(Makie.get_scene(parent))
    extent_positions = Makie.lift(positions, scale_corr_obs) do pos, scale_corr
        _bbox_corner_positions(
            pos,
            image_sizes;
            glyph_size = glyph_size,
            aspect = aspect,
            placement = placement,
            axis_scale_correction = scale_corr,
        )
    end
    extent_source = _transparent_probe_scatter!(parent, extent_positions; visible = visible)

    pixel_positions = Makie.lift(anchor_pixels) do pos
        _normalize_point3f_positions(pos)
    end

    return (
        pixel_positions = pixel_positions,
        pixel_half_heights = pixel_half_heights,
        source_plots = (anchor_source, upper_source, lower_source, extent_source),
    )
end

function _projected_anchor_positions!(
        parent,
        anchor_spec::_PixelAnchors,
        image_sizes::AbstractVector{<:Tuple{<:Integer, <:Integer}};
        glyph_size::Real,
        aspect::Symbol,
        placement::Symbol,
        xoffset::Real,
        yoffset::Real,
        visible,
    )
    positions = Makie.lift(
        pos -> _offset_point3f_positions(_normalize_point3f_positions(pos), xoffset, yoffset),
        _as_node(anchor_spec.positions),
    )
    half_heights = Makie.Observable(fill(Float32(glyph_size), length(image_sizes)))
    return (
        pixel_positions = positions,
        pixel_half_heights = half_heights,
        source_plots = (),
    )
end

"""
    _augment_phylopic_anchored!(
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
    ) -> Union{Nothing, _AnchoredOverlay}

Render pre-resolved image matrices through the internal anchored-overlay
substrate shared by the public `augment_phylopic!` wrappers and future
projected-anchor clients.

Supported combinations are:

- `anchor_space = :data`, `glyph_size_space = :data`
- `anchor_space = :pixel`, `glyph_size_space = :pixel`

Mixed data/pixel combinations currently throw `ArgumentError` so callers do not
silently mix incompatible contracts.
"""
function _augment_phylopic_anchored!(
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
    )::Union{Nothing, _AnchoredOverlay}
    isempty(images) && return nothing

    anchor_spec = _anchor_positions_spec(anchor_positions; anchor_space)
    size_spec = _glyph_size_spec(glyph_size; glyph_size_space)
    (anchor_spec isa _DataAnchors) == (size_spec isa _DataGlyphSize) || throw(
        ArgumentError(
            "augment_phylopic: unsupported mixed anchor/glyph space combination " *
                "(`anchor_space = :$anchor_space`, `glyph_size_space = :$glyph_size_space`). " *
                "Supported combinations are `(:data, :data)` and `(:pixel, :pixel)`."
        )
    )

    visible = Makie.Observable(true)
    image_sizes = [(size(img, 2), size(img, 1)) for img in images]
    geometry = _projected_anchor_positions!(
        parent,
        anchor_spec,
        image_sizes;
        glyph_size = size_spec.half_height,
        aspect = aspect,
        placement = placement,
        xoffset = xoffset,
        yoffset = yoffset,
        visible = visible,
    )
    length(geometry.pixel_positions[]) == length(images) || throw(
        ArgumentError(
            "augment_phylopic: anchor and image vectors must have the same length."
        )
    )

    marker_sizes = Makie.lift(geometry.pixel_half_heights) do half_heights
        _pixel_marker_sizes(image_sizes, half_heights; aspect)
    end
    marker_offsets = Makie.lift(marker_sizes) do sizes
        _pixel_marker_offsets(sizes; placement)
    end

    visible_plot = Makie.scatter!(
        parent,
        geometry.pixel_positions;
        marker = images,
        markersize = marker_sizes,
        marker_offset = marker_offsets,
        markerspace = :pixel,
        space = :pixel,
        visible = visible,
        inspectable = false,
        transformation = :nothing,
    )
    for probe_plot in geometry.source_plots
        Makie.on(probe_plot, visible_plot.visible, update = true) do is_visible
            probe_plot[:visible] = is_visible
            return Makie.Consume(false)
        end
    end
    return _AnchoredOverlay(visible_plot, geometry.source_plots)
end
