# ---------------------------------------------------------------------------
# PhyloPicMakie — native Makie glyph recipe
# ---------------------------------------------------------------------------

"""
    phylopicglyphs(positions, images; kwargs...) -> Makie.FigureAxisPlot
    phylopicglyphs!(parent, positions, images; kwargs...) -> PhyloPicGlyphs

Render decoded PhyloPic silhouette images at two-dimensional anchor positions.
The recipe owns image normalization, missing-image policy, projected marker
geometry, child plots, and lifecycle. It performs no network discovery.

`space` and `glyph_size_space` must both be `:data` or both be `:pixel`.
Numeric image matrices are normalized to `Matrix{RGBA{N0f8}}` so Makie treats
them as images rather than signed-distance-field markers.

In data space, glyph anchors participate in axis autolimits while the
pixel-rendered marker extents do not, matching ordinary Makie scatter markers
whose marker space is pixel space.
"""
Makie.@recipe PhyloPicGlyphs (
    positions::AbstractVector,
    images::AbstractVector,
) begin
    "Half-height of each rendered glyph in `glyph_size_space`."
    glyph_size = 0.4
    "Coordinate space used to interpret `glyph_size`."
    glyph_size_space = :data
    "Preserve source aspect ratio or stretch glyphs to squares."
    aspect = :preserve
    "Anchor placement on each glyph."
    placement = :center
    "Horizontal anchor offset in the recipe's `space`."
    xoffset = 0.0
    "Vertical anchor offset in the recipe's `space`."
    yoffset = 0.0
    "Clockwise glyph rotation in multiples of 90 degrees."
    rotation = 0.0
    "Mirror glyphs horizontally after rotation."
    mirror = false
    "Missing-image policy: `:skip`, `:error`, or `:placeholder`."
    on_missing = :skip
    Makie.mixin_generic_plot_attributes()...
end

function Makie.convert_arguments(
        ::Type{<:PhyloPicGlyphs},
        positions::AbstractVector,
        images::AbstractVector,
    )::Tuple{Vector{Makie.Point2f}, Vector{Any}}
    converted_positions = Makie.Point2f[_to_point2f(position) for position in positions]
    return (converted_positions, Any[images...])
end

function _placeholder_glyph()::Matrix{RGBA{N0f8}}
    glyph = fill(RGBA{N0f8}(0.83, 0.83, 0.83, 0.5), 8, 8)
    glyph[1, :] .= RGBA{N0f8}(0.5, 0.5, 0.5, 1.0)
    glyph[end, :] .= RGBA{N0f8}(0.5, 0.5, 0.5, 1.0)
    glyph[:, 1] .= RGBA{N0f8}(0.5, 0.5, 0.5, 1.0)
    glyph[:, end] .= RGBA{N0f8}(0.5, 0.5, 0.5, 1.0)
    return glyph
end

function _normalize_glyph_image(
        image::AbstractMatrix{<:Colorant},
    )::Matrix{RGBA{N0f8}}
    return RGBA{N0f8}.(image)
end

function _normalize_glyph_image(
        image::AbstractMatrix{<:Real},
    )::Matrix{RGBA{N0f8}}
    return map(image) do value
        channel = clamp(Float64(value), 0.0, 1.0)
        RGBA{N0f8}(channel, channel, channel, 1.0)
    end
end

function _normalize_glyph_image(image::AbstractMatrix)::Matrix{RGBA{N0f8}}
    throw(
        ArgumentError(
            "phylopicglyphs: image matrices must contain colors or real-valued pixels; " *
                "received $(eltype(image))."
        )
    )
end

function _prepare_glyph_data(
        positions::AbstractVector,
        images::AbstractVector,
        on_missing::Symbol,
        rotation::Real,
        mirror::Bool,
    )::Tuple{
        Vector{Makie.Point2f},
        Vector{Matrix{RGBA{N0f8}}},
        Vector{Tuple{Int, Int}},
    }
    length(positions) == length(images) || throw(
        ArgumentError(
            "phylopicglyphs: positions and images must have the same length."
        )
    )
    on_missing in VALID_ON_MISSING || throw(
        ArgumentError(
            "phylopicglyphs: unknown `on_missing` value `$on_missing`. " *
                "Valid values: $(join(VALID_ON_MISSING, ", "))."
        )
    )

    rendered_positions = Makie.Point2f[]
    rendered_images = Matrix{RGBA{N0f8}}[]
    sizehint!(rendered_positions, length(positions))
    sizehint!(rendered_images, length(images))

    for index in eachindex(images)
        image = images[index]
        if isnothing(image)
            if on_missing === :error
                error(
                    "phylopicglyphs: missing image for data point $index " *
                        "(on_missing = :error)."
                )
            elseif on_missing === :skip
                continue
            end
            image = _placeholder_glyph()
        end
        image isa AbstractMatrix || throw(
            ArgumentError(
                "phylopicglyphs: image $index must be an AbstractMatrix or nothing."
            )
        )

        normalized = _normalize_glyph_image(image)
        transformed = _apply_rotation(normalized, rotation)
        mirror && (transformed = transformed[:, end:-1:1])
        final_image = Matrix{RGBA{N0f8}}(transformed)

        push!(rendered_positions, _to_point2f(positions[index]))
        push!(rendered_images, final_image)
    end

    image_sizes = Tuple{Int, Int}[
        (size(image, 2), size(image, 1)) for image in rendered_images
    ]
    return (rendered_positions, rendered_images, image_sizes)
end

function _validate_glyph_spaces(space::Symbol, glyph_size_space::Symbol)::Nothing
    space in (:data, :pixel) || throw(
        ArgumentError(
            "phylopicglyphs: `space` must be :data or :pixel, got :$space."
        )
    )
    glyph_size_space in VALID_GLYPH_SIZE_SPACES || throw(
        ArgumentError(
            "phylopicglyphs: `glyph_size_space` must be :data or :pixel, " *
                "got :$glyph_size_space."
        )
    )
    space === glyph_size_space || throw(
        ArgumentError(
            "phylopicglyphs: `space` and `glyph_size_space` must match; " *
                "received :$space and :$glyph_size_space."
        )
    )
    return nothing
end

function _register_glyph_inputs!(plot::PhyloPicGlyphs)::Nothing
    Makie.map!(
        plot,
        [:positions, :images, :on_missing, :rotation, :mirror],
        [:glyph_positions, :glyph_images, :glyph_image_sizes],
    ) do positions, images, on_missing, rotation, mirror
        return _prepare_glyph_data(positions, images, on_missing, rotation, mirror)
    end

    Makie.map!(
        plot,
        [:glyph_positions, :xoffset, :yoffset],
        :glyph_anchor_positions,
    ) do positions, xoffset, yoffset
        return _offset_point2f_positions(positions, xoffset, yoffset)
    end
    return nothing
end

function _register_data_space_geometry!(plot::PhyloPicGlyphs)::Nothing
    Makie.map!(
        plot,
        [:glyph_anchor_positions, :glyph_size],
        [:glyph_upper_positions, :glyph_lower_positions],
    ) do positions, glyph_size
        return (
            _vertical_probe_positions(positions, glyph_size),
            _vertical_probe_positions(positions, -glyph_size),
        )
    end

    Makie.register_projected_positions!(
        plot,
        Makie.Point3f;
        input_name = :glyph_upper_positions,
        output_name = :glyph_upper_pixel_positions,
        output_space = :pixel,
    )
    Makie.register_projected_positions!(
        plot,
        Makie.Point3f;
        input_name = :glyph_lower_positions,
        output_name = :glyph_lower_pixel_positions,
        output_space = :pixel,
    )
    Makie.map!(
        plot,
        [:glyph_upper_pixel_positions, :glyph_lower_pixel_positions],
        :glyph_pixel_half_heights,
    ) do upper, lower
        return Float32[
            hypot(up[1] - lo[1], up[2] - lo[2]) / 2.0f0
                for (up, lo) in zip(upper, lower)
        ]
    end
    return nothing
end

function _register_pixel_space_geometry!(plot::PhyloPicGlyphs)::Nothing
    Makie.map!(plot, :glyph_anchor_positions, :glyph_pixel_positions) do positions
        return _normalize_point3f_positions(positions)
    end
    Makie.map!(
        plot,
        [:glyph_image_sizes, :glyph_size],
        :glyph_pixel_half_heights,
    ) do image_sizes, glyph_size
        return fill(Float32(glyph_size), length(image_sizes))
    end
    return nothing
end

function _create_glyph_scatter!(
        plot::PhyloPicGlyphs,
        space::Symbol,
    )::Makie.Plot
    Makie.map!(
        plot,
        [:glyph_image_sizes, :glyph_pixel_half_heights, :aspect],
        :glyph_marker_sizes,
    ) do image_sizes, half_heights, aspect
        return _pixel_marker_sizes(image_sizes, half_heights; aspect)
    end
    Makie.map!(
        plot,
        [:glyph_marker_sizes, :placement],
        :glyph_marker_offsets,
    ) do marker_sizes, placement
        return _pixel_marker_offsets(marker_sizes; placement)
    end

    glyph_attributes = (
        marker = plot[:glyph_images],
        markersize = plot[:glyph_marker_sizes],
        marker_offset = plot[:glyph_marker_offsets],
        markerspace = :pixel,
        visible = plot[:visible],
        inspectable = plot[:inspectable],
    )
    if space === :data
        # Keep data anchors in data space and only the rendered marker geometry
        # in pixel space. Makie then derives axis limits from the anchors, as it
        # does for ordinary pixel-sized scatter markers, without a projected
        # limits proxy feeding the current axis limits back into autolimits.
        return Makie.scatter!(
            plot,
            plot[:glyph_anchor_positions];
            glyph_attributes...,
            space = :data,
        )
    end
    return Makie.scatter!(
        plot,
        plot[:glyph_pixel_positions];
        glyph_attributes...,
        space = :pixel,
        transformation = :nothing,
    )
end

function Makie.plot!(plot::PhyloPicGlyphs)
    space = plot.attributes[:space][]::Symbol
    glyph_size_space = plot.attributes[:glyph_size_space][]::Symbol
    _validate_glyph_spaces(space, glyph_size_space)
    _register_glyph_inputs!(plot)
    if space === :data
        _register_data_space_geometry!(plot)
    else
        _register_pixel_space_geometry!(plot)
    end
    _create_glyph_scatter!(plot, space)
    return plot
end
