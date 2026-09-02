include("_output.jl")

using CairoMakie: DataAspect, Point2f, hidedecorations!, hidespines!, xlims!, ylims!
using GraphMakie: graphplot
using Graphs: SimpleDiGraph, add_edge!
using PhyloPicMakie: augment_phylopic!

graph = SimpleDiGraph(7)
for (source, destination) in [(1, 2), (1, 3), (3, 4), (3, 5), (5, 6), (5, 7)]
    add_edge!(graph, source, destination)
end

layout = Point2f[
    (0.0, 1.5),
    (1.0, 3.0),
    (1.0, 1.0),
    (2.0, 2.0),
    (2.0, 0.5),
    (3.0, 1.0),
    (3.0, 0.0),
]
labels = ["", "Giant panda", "", "American black bear", "", "Brown bear", "Polar bear"]

figure, axis, graph_plot = graphplot(
    graph;
    layout,
    arrow_show = false,
    node_color = :white,
    node_size = 13,
    node_attr = (; strokecolor = :gray35, strokewidth = 1.5),
    edge_color = :gray45,
    edge_width = 2.5,
    nlabels = labels,
    nlabels_align = (:center, :top),
    nlabels_offset = Point2f(0.0, -0.28),
    nlabels_fontsize = 14,
)

# GraphMakie exposes node positions through `graph_plot[:node_pos]`. This
# example takes a snapshot and passes explicit tip coordinates to PhyloPicMakie.
tip_indices = [2, 4, 6, 7]
tip_positions = graph_plot[:node_pos][][tip_indices]
plot = augment_phylopic!(
    axis,
    first.(tip_positions),
    last.(tip_positions);
    taxon = [
        "Ailuropoda melanoleuca",
        "Ursus americanus",
        "Ursus arctos",
        "Ursus maritimus",
    ],
    glyph_size = 0.18,
    placement = :left,
    xoffset = 0.12,
    on_missing = :error,
)

axis.aspect = DataAspect()
axis.title = "Silhouettes at phylogeny tips"
xlims!(axis, -0.25, 4.1)
ylims!(axis, -0.45, 3.5)
hidedecorations!(axis)
hidespines!(axis)
display_or_save(figure, "graph_anchors.png")
