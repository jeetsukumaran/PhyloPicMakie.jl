include("_output.jl")

using CairoMakie: Axis, Figure, rangebars!, xlims!, ylims!
using PhyloPicMakie: augment_phylopic_ranges!

# These illustrative values stand in for a table loaded by an analysis.
bears = (
    taxon = [
        "Ailuropoda melanoleuca",
        "Ursus americanus",
        "Ursus arctos",
        "Ursus maritimus",
    ],
    common_name = ["Giant panda", "American black bear", "Brown bear", "Polar bear"],
    minimum_mass = [70.0, 40.0, 80.0, 150.0],
    maximum_mass = [120.0, 300.0, 600.0, 700.0],
    row = [4.0, 3.0, 2.0, 1.0],
)

figure = Figure(size = (820, 480))
axis = Axis(
    figure[1, 1];
    title = "Illustrative adult body-mass intervals",
    xlabel = "Body mass (kg)",
    yticks = (bears.row, bears.common_name),
)

rangebars!(
    axis,
    bears.row,
    bears.minimum_mass,
    bears.maximum_mass;
    direction = :x,
    color = :gray65,
    linewidth = 7,
    whiskerwidth = 12,
)

plot = augment_phylopic_ranges!(
    axis,
    bears.minimum_mass,
    bears.maximum_mass,
    bears.row;
    taxon = bears.taxon,
    at = :midpoint,
    glyph_size = 0.3,
    placement = :bottom,
    yoffset = 0.08,
    on_missing = :error,
)

xlims!(axis, 0.0, 800.0)
ylims!(axis, 0.5, 4.8)
display_or_save(figure, "range_overlay.png")
