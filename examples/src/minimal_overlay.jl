include("_output.jl")

using PhyloPicMakie: augment_phylopic

result = augment_phylopic(
    [0.0],
    [0.0];
    taxon = ["Ursus arctos"],
    glyph_size = 0.45,
    figure = (; size = (520, 400)),
    axis = (;
        title = "A PhyloPic silhouette",
        limits = ((-1.0, 1.0), (-0.8, 0.8)),
    ),
)

# The non-bang function returns Makie's figure-axis-plot container.
figure, axis, plot = result
display_or_save(figure, "minimal_overlay.png")
