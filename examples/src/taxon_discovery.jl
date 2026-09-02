include("_output.jl")

using PhyloPicMakie: PhyloPicDB, phylopic_thumbnail_grid

const BEAR_TAXA = [
    "Ailuropoda melanoleuca",
    "Ursus americanus",
    "Ursus arctos",
    "Ursus maritimus",
]

# Each result preserves its status, selected node, candidates, and suggestions.
resolutions = PhyloPicDB.resolve_taxa(BEAR_TAXA)
foreach(display, resolutions)

figure = phylopic_thumbnail_grid(
    resolutions;
    figure_size = (760, 620),
    ncols = 2,
    image_layout = :flat,
    image_label = [:taxon_name, :license],
    label_lines = 2,
    title = "Resolved bear silhouettes and image licenses",
    on_missing = :error,
)

display_or_save(figure, "taxon_discovery.png")
