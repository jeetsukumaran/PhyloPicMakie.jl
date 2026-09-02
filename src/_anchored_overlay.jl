# ---------------------------------------------------------------------------
# PhyloPicMakie — anchored glyph geometry
#
# Pure geometry helpers used by the PhyloPicGlyphs recipe. Plot ownership and
# lifecycle belong to the recipe and Makie's native plot tree.
# ---------------------------------------------------------------------------

const VALID_GLYPH_SIZE_SPACES = (:data, :pixel)

_to_point2f(p) = Makie.Point2f(Float32(p[1]), Float32(p[2]))

function _to_point3f(p)::Makie.Point3f
    z = length(p) >= 3 ? Float32(p[3]) : 0.0f0
    return Makie.Point3f(Float32(p[1]), Float32(p[2]), z)
end

_normalize_point2f_positions(positions::AbstractVector)::Vector{Makie.Point2f} =
    Makie.Point2f[_to_point2f(p) for p in positions]

_normalize_point3f_positions(positions::AbstractVector)::Vector{Makie.Point3f} =
    Makie.Point3f[_to_point3f(p) for p in positions]

function _offset_point2f_positions(
        positions::AbstractVector,
        xoffset::Real,
        yoffset::Real,
    )::Vector{Makie.Point2f}
    dx = Float32(xoffset)
    dy = Float32(yoffset)
    return Makie.Point2f[
        Makie.Point2f(p[1] + dx, p[2] + dy) for p in positions
    ]
end

function _offset_point3f_positions(
        positions::AbstractVector,
        xoffset::Real,
        yoffset::Real,
    )::Vector{Makie.Point3f}
    dx = Float32(xoffset)
    dy = Float32(yoffset)
    return Makie.Point3f[
        Makie.Point3f(p[1] + dx, p[2] + dy, p[3]) for p in positions
    ]
end

function _vertical_probe_positions(
        positions::AbstractVector,
        delta::Real,
    )::Vector{Makie.Point2f}
    dy = Float32(delta)
    return Makie.Point2f[Makie.Point2f(p[1], p[2] + dy) for p in positions]
end

function _bbox_corner_positions(
        positions::AbstractVector,
        image_sizes::AbstractVector{<:Tuple{<:Integer, <:Integer}};
        glyph_size::Real,
        aspect::Symbol,
        placement::Symbol,
        axis_scale_correction::Real,
    )::Vector{Makie.Point2f}
    length(positions) == length(image_sizes) || throw(
        ArgumentError(
            "phylopicglyphs: position and image-size vectors must have the same length."
        )
    )
    corners = Makie.Point2f[]
    sizehint!(corners, 4 * length(positions))

    for (p, (img_width, img_height)) in zip(positions, image_sizes)
        x_lo, x_hi, y_lo, y_hi = _compute_image_bbox(
            p[1], p[2], img_width, img_height;
            glyph_size,
            aspect,
            placement,
            xoffset = 0.0,
            yoffset = 0.0,
            axis_scale_correction,
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
            "phylopicglyphs: image and marker-size vectors must have the same length."
        )
    )
    return Makie.Vec2f[
        _compute_pixel_marker_size(img_width, img_height, half_height_px; aspect)
            for ((img_width, img_height), half_height_px) in zip(
                image_sizes,
                half_heights_px,
            )
    ]
end

function _pixel_marker_offsets(
        marker_sizes::AbstractVector{<:Makie.VecTypes};
        placement::Symbol,
    )::Vector{Makie.Vec3f}
    (pfx, pfy) = _placement_offsets(placement)
    dx_scale = Float32(pfx)
    dy_scale = Float32(pfy)
    return Makie.Vec3f[
        Makie.Vec3f(dx_scale * size[1], dy_scale * size[2], 0.0f0)
            for size in marker_sizes
    ]
end
