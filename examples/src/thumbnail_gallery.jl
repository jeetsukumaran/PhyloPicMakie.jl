using CairoMakie: display, save
using ColorTypes: RGBA
using FixedPointNumbers: N0f8
using PhyloPicMakie: phylopic_thumbnail_grid

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

cell_images = Matrix{RGBA{N0f8}}[
    fish_glyph(; color = RGBA{N0f8}(0.10, 0.22, 0.34, 1.0)),
    mirrored_image(fish_glyph(; color = RGBA{N0f8}(0.15, 0.32, 0.41, 1.0))),
    bird_glyph(; color = RGBA{N0f8}(0.40, 0.20, 0.13, 1.0)),
    mirrored_image(bird_glyph(; color = RGBA{N0f8}(0.49, 0.27, 0.18, 1.0))),
    fern_glyph(; color = RGBA{N0f8}(0.11, 0.27, 0.15, 1.0)),
    fern_glyph(; color = RGBA{N0f8}(0.18, 0.39, 0.20, 1.0)),
]
labels = String[
    "Marine set
Shelf fish",
    "Marine set
Lagoon fish",
    "Avian set
Dryland bird",
    "Avian set
Coastal bird",
    "Botanical set
Fern crown",
    "Botanical set
Wetland frond",
]
group_sizes = Int[2, 2, 2]

fig = phylopic_thumbnail_grid(
    cell_images,
    labels,
    group_sizes;
    title = "Grouped PhyloPic thumbnail gallery",
    image_layout = :blocks,
    ncols = 3,
    label_lines = 2,
    cell_width = 1.15,
    cell_height = 1.85,
    glyph_fraction = 0.58,
    label_gap = 0.12,
    label_fontsize = 16.0,
)

if isempty(ARGS) && isinteractive()
    display(fig)
    println("Displayed thumbnail gallery example.")
    println("Pass a path as the first argument to save a PNG instead.")
else
    output_path = abspath(get(ARGS, 1, "thumbnail_gallery.png"))
    save(output_path, fig)
    println("Saved thumbnail gallery example to $(output_path)")
end
