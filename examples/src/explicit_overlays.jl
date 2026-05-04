using CairoMakie: Axis, Figure, Point2f, display, hidedecorations!, hidespines!, lines!, save, scatter!, text!, xlims!, ylims!
using ColorTypes: RGBA
using FixedPointNumbers: N0f8
using PhyloPicMakie: augment_phylopic!, augment_phylopic_ranges!

function silhouette_image(
        predicate;
        width::Integer = 240,
        height::Integer = 160,
        color::RGBA{N0f8} = RGBA{N0f8}(0.08, 0.10, 0.12, 1.0),
    )::Matrix{RGBA{N0f8}}
    image = fill(
        RGBA{N0f8}(0.0, 0.0, 0.0, 0.0),
        Int(height),
        Int(width),
    )
    for row in 1:Int(height), col in 1:Int(width)
        x = 2.0 * ((Float64(col) - 0.5) / Float64(width)) - 1.0
        y = 1.0 - 2.0 * ((Float64(row) - 0.5) / Float64(height))
        if predicate(x, y)
            image[row, col] = color
        end
    end
    return image
end

function fish_glyph(;
        color::RGBA{N0f8} = RGBA{N0f8}(0.10, 0.18, 0.32, 1.0),
    )::Matrix{RGBA{N0f8}}
    return silhouette_image(; width = 260, height = 150, color) do x, y
        body = ((x + 0.04) / 0.56)^2 + (y / 0.25)^2 <= 1.0
        tail = x < -0.34 && abs(y) <= 0.70 * (x + 0.96)
        dorsal = -0.06 <= x <= 0.18 && 0.08 <= y <= 0.34 - 0.55 * abs(x + 0.02)
        ventral = -0.12 <= x <= 0.16 && -0.30 + 0.48 * abs(x + 0.02) <= y <= -0.04
        snout = 0.46 <= x <= 0.78 && abs(y) <= 0.18 * (0.78 - x) + 0.04
        return body || tail || dorsal || ventral || snout
    end
end

function bird_glyph(;
        color::RGBA{N0f8} = RGBA{N0f8}(0.36, 0.16, 0.12, 1.0),
    )::Matrix{RGBA{N0f8}}
    return silhouette_image(; width = 240, height = 180, color) do x, y
        body = ((x + 0.02) / 0.44)^2 + ((y + 0.04) / 0.28)^2 <= 1.0
        head = ((x - 0.30) / 0.13)^2 + ((y - 0.12) / 0.13)^2 <= 1.0
        beak = 0.42 <= x <= 0.72 && abs(y - 0.12) <= 0.18 * (0.72 - x) + 0.01
        tail = x < -0.30 && abs(y + 0.02) <= 0.46 * (x + 0.92) + 0.03
        wing = ((x + 0.04) / 0.28)^2 + ((y + 0.01) / 0.16)^2 <= 1.0 && y >= -0.02
        leg = abs(x - 0.01) <= 0.03 && -0.58 <= y <= -0.18
        return body || head || beak || tail || wing || leg
    end
end

function fern_glyph(;
        color::RGBA{N0f8} = RGBA{N0f8}(0.11, 0.28, 0.17, 1.0),
    )::Matrix{RGBA{N0f8}}
    return silhouette_image(; width = 220, height = 220, color) do x, y
        stem = abs(x + 0.04 * y) <= 0.03 && -0.78 <= y <= 0.78
        leaflets = false
        for anchor in (-0.56, -0.36, -0.16, 0.04, 0.24, 0.44)
            left = ((x + 0.24) / 0.24)^2 + ((y - anchor) / 0.11)^2 <= 1.0 &&
                x <= 0.02 &&
                y <= anchor + 0.14
            right = ((x - 0.22) / 0.24)^2 + ((y - anchor - 0.08) / 0.11)^2 <= 1.0 &&
                x >= -0.02 &&
                y >= anchor - 0.18
            leaflets = leaflets || left || right
        end
        tip = (x / 0.12)^2 + ((y - 0.84) / 0.16)^2 <= 1.0
        return stem || leaflets || tip
    end
end

function mirrored_image(
        image::Matrix{RGBA{N0f8}},
    )::Matrix{RGBA{N0f8}}
    return image[:, end:-1:1]
end

function configure_axis!(ax::Axis)::Nothing
    hidedecorations!(ax; grid = false)
    hidespines!(ax)
    return nothing
end

function explicit_anchor_panel!(ax::Axis)::Nothing
    xs = Float64[0.8, 2.0, 3.2, 4.4]
    ys = Float64[1.2, 2.3, 1.8, 2.8]
    labels = ["Marine node", "Avian node", "Fern node", "Mirrored node"]
    images = Matrix{RGBA{N0f8}}[
        fish_glyph(),
        bird_glyph(),
        fern_glyph(),
        mirrored_image(bird_glyph(; color = RGBA{N0f8}(0.18, 0.22, 0.28, 1.0))),
    ]

    lines!(ax, xs, ys; color = (:gray45, 0.45), linewidth = 2.0)
    scatter!(
        ax,
        xs,
        ys;
        color = :white,
        markersize = 18,
        strokecolor = :gray25,
        strokewidth = 2.0,
    )
    text!(
        ax,
        labels;
        position = Point2f.(xs, ys .- 0.34),
        align = (:center, :top),
        fontsize = 16,
        color = :gray25,
    )
    augment_phylopic!(
        ax,
        xs,
        ys,
        images;
        glyph_size = 0.34,
        aspect = :preserve,
        placement = :bottom,
        xoffset = 0.0,
        yoffset = 0.18,
        rotation = 0.0,
        mirror = false,
        on_missing = :skip,
    )
    xlims!(ax, 0.2, 5.0)
    ylims!(ax, 0.4, 3.6)
    ax.title = "Explicit data anchors"
    return nothing
end

function range_anchor_panel!(ax::Axis)::Nothing
    xstart = Float64[0.6, 1.1, 1.7]
    xstop = Float64[3.2, 4.0, 4.8]
    ys = Float64[3.0, 2.0, 1.0]
    labels = ["Shelf interval", "Lagoon interval", "Floodplain interval"]
    images = Matrix{RGBA{N0f8}}[
        mirrored_image(fish_glyph(; color = RGBA{N0f8}(0.12, 0.30, 0.37, 1.0))),
        bird_glyph(; color = RGBA{N0f8}(0.47, 0.24, 0.16, 1.0)),
        fern_glyph(; color = RGBA{N0f8}(0.13, 0.31, 0.15, 1.0)),
    ]

    for index in eachindex(xstart)
        lines!(
            ax,
            [xstart[index], xstop[index]],
            [ys[index], ys[index]];
            color = (:gray40, 0.55),
            linewidth = 8.0,
        )
        scatter!(
            ax,
            [xstart[index], xstop[index]],
            [ys[index], ys[index]];
            color = :white,
            markersize = 10,
            strokecolor = :gray25,
            strokewidth = 1.5,
        )
        text!(
            ax,
            labels[index];
            position = Point2f(6.35f0, ys[index] - 0.18f0),
            align = (:right, :center),
            fontsize = 15,
            color = :gray25,
        )
    end

    augment_phylopic_ranges!(
        ax,
        xstart,
        xstop,
        ys,
        images;
        at = :midpoint,
        glyph_size = 0.28,
        aspect = :preserve,
        placement = :bottom,
        xoffset = 0.0,
        yoffset = 0.20,
        rotation = 0.0,
        mirror = false,
        on_missing = :skip,
    )
    xlims!(ax, 0.2, 6.6)
    ylims!(ax, 0.4, 3.8)
    ax.title = "Range midpoint anchors"
    return nothing
end

fig = Figure(size = (1180, 560))
left_axis = Axis(fig[1, 1])
right_axis = Axis(fig[1, 2])

configure_axis!(left_axis)
configure_axis!(right_axis)
explicit_anchor_panel!(left_axis)
range_anchor_panel!(right_axis)

if isempty(ARGS) && isinteractive()
    display(fig)
    println("Displayed explicit overlay example.")
    println("Pass a path as the first argument to save a PNG instead.")
else
    output_path = abspath(get(ARGS, 1, "explicit_overlays.png"))
    save(output_path, fig)
    println("Saved explicit overlay example to $(output_path)")
end
