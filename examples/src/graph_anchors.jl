module GraphAnchorsExample

include("_common.jl")

import GraphMakie
using CairoMakie: Point2f, hidedecorations!, hidespines!
using Graphs: SimpleGraph, add_edge!, add_vertex!, nv
using MetaGraphsNext: MetaGraph, label_for
using PhyloPicMakie: augment_phylopic!

const NodeData = NamedTuple{
    (:display_name, :glyph),
    Tuple{String, Matrix{RGBA{N0f8}}},
}

function _build_metagraph()::MetaGraph
    meta_graph = MetaGraph(SimpleGraph(), Symbol, NodeData)
    add_vertex!(meta_graph, :lagoon, (; display_name = "Lagoon", glyph = fish_glyph()))
    add_vertex!(
        meta_graph,
        :coast,
        (; display_name = "Coast", glyph = mirrored_image(bird_glyph())),
    )
    add_vertex!(
        meta_graph,
        :marsh,
        (; display_name = "Marsh", glyph = fern_glyph()),
    )
    add_vertex!(
        meta_graph,
        :delta,
        (;
            display_name = "Delta",
            glyph = mirrored_image(
                fish_glyph(; color = RGBA{N0f8}(0.12, 0.30, 0.40, 1.0)),
            ),
        ),
    )
    add_vertex!(
        meta_graph,
        :upland,
        (;
            display_name = "Upland",
            glyph = bird_glyph(; color = RGBA{N0f8}(0.44, 0.23, 0.15, 1.0)),
        ),
    )

    add_edge!(meta_graph, :lagoon, :coast)
    add_edge!(meta_graph, :lagoon, :marsh)
    add_edge!(meta_graph, :coast, :delta)
    add_edge!(meta_graph, :marsh, :delta)
    add_edge!(meta_graph, :delta, :upland)

    return meta_graph
end

function main(; output_dir::Union{Nothing, AbstractString} = nothing)::String
    meta_graph = _build_metagraph()
    graph = meta_graph.graph
    fixed_layout = Point2f[
        Point2f(0.0, 0.0),
        Point2f(1.2, 0.8),
        Point2f(1.2, -0.8),
        Point2f(2.5, 0.0),
        Point2f(3.7, 0.7),
    ]
    labels = [label_for(meta_graph, code) for code in 1:nv(graph)]
    display_names = String[meta_graph[label].display_name for label in labels]
    images = Matrix{RGBA{N0f8}}[meta_graph[label].glyph for label in labels]

    fig, ax, graph_plot = GraphMakie.graphplot(
        graph;
        layout = fixed_layout,
        node_color = :gray97,
        node_size = 28,
        node_attr = (; strokecolor = :gray25, strokewidth = 2.0),
        edge_color = (:gray35, 0.85),
        edge_width = 2.5,
        nlabels = display_names,
        nlabels_align = (:center, :top),
        nlabels_distance = 0.0,
        nlabels_offset = fill(Point2f(0.0, -0.34), nv(graph)),
        nlabels_fontsize = 16,
    )

    materialize!(fig)
    # This example intentionally snapshots GraphMakie's documented node
    # positions and then hands those explicit coordinates to the public overlay
    # API. It does not claim live reactive overlay tracking.
    node_positions = graph_plot[:node_pos][]
    xs, ys = point_components(node_positions)
    augment_phylopic!(
        ax,
        xs,
        ys,
        images;
        glyph_size = 0.16,
        aspect = :preserve,
        placement = :bottomleft,
        xoffset = 0.18,
        yoffset = 0.14,
        rotation = 0.0,
        mirror = false,
        on_missing = :skip,
    )

    hidedecorations!(ax; grid = false)
    hidespines!(ax)
    ax.title = "GraphMakie node-position snapshot hand-off"

    return save_example(fig, "graph_anchors"; output_dir)
end

if abspath(PROGRAM_FILE) == @__FILE__
    println(main())
end

end # module GraphAnchorsExample
