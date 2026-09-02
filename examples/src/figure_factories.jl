using CairoMakie: display, save
using ColorTypes: RGBA
using FixedPointNumbers: N0f8
using PhyloPicMakie: augment_phylopic, augment_phylopic_ranges

function example_glyph(;
        width::Integer = 180,
        height::Integer = 100,
    )::Matrix{RGBA{N0f8}}
    transparent = RGBA{N0f8}(0.0, 0.0, 0.0, 0.0)
    foreground = RGBA{N0f8}(0.08, 0.15, 0.24, 1.0)
    return [
        let
                x = 2.0 * ((Float64(col) - 0.5) / Float64(width)) - 1.0
                y = 1.0 - 2.0 * ((Float64(row) - 0.5) / Float64(height))
                body = (x / 0.68)^2 + (y / 0.32)^2 <= 1.0
                tail = x < -0.48 && abs(y) <= 0.75 * (x + 1.0)
                body || tail ? foreground : transparent
        end
            for row in 1:Int(height), col in 1:Int(width)
    ]
end

glyph = example_glyph()

coordinate_result = augment_phylopic(
    [1.0, 2.0, 3.0],
    [1.0, 2.0, 1.5];
    glyph,
    glyph_size = 0.3,
    figure = (; size = (720, 420)),
    axis = (;
        title = "Figure-creating coordinate overlay",
        limits = ((0.5, 3.5), (0.5, 2.5)),
    ),
)

range_result = augment_phylopic_ranges(
    [0.5, 1.0, 2.0],
    [2.0, 3.0, 4.0],
    [1.0, 2.0, 3.0];
    glyph,
    at = :midpoint,
    glyph_size = 0.25,
    figure = (; size = (720, 420)),
    axis = (;
        title = "Figure-creating range overlay",
        limits = ((0.5, 4.5), (0.5, 3.5)),
    ),
)

if isempty(ARGS) && isinteractive()
    display(coordinate_result.figure)
    display(range_result.figure)
    println("Displayed figure factory examples.")
    println("Pass an output prefix as the first argument to save PNG files instead.")
else
    output_prefix = abspath(get(ARGS, 1, "figure_factories"))
    coordinate_path = "$(output_prefix)_coordinates.png"
    range_path = "$(output_prefix)_ranges.png"
    save(coordinate_path, coordinate_result.figure)
    save(range_path, range_result.figure)
    println("Saved figure factory examples to $coordinate_path and $range_path")
end
