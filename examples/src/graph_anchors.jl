import CairoMakie
import GraphMakie
using CairoMakie: Point2f, display, hidedecorations!, hidespines!, save
using ColorTypes: RGBA
using FixedPointNumbers: N0f8
using Graphs: SimpleGraph, add_edge!, add_vertex!, nv
using MetaGraphsNext: MetaGraph, label_for
using PhyloPicMakie: augment_phylopic!

const NodeData = NamedTuple{
    (:display_name, :glyph),
    Tuple{String, Matrix{RGBA{N0f8}}},
}

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

function point_components(points::AbstractVector)::Tuple{Vector{Float32}, Vector{Float32}}
    xs = Float32[Float32(point[1]) for point in points]
    ys = Float32[Float32(point[2]) for point in points]
    return (xs, ys)
end

function build_metagraph()::MetaGraph
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

meta_graph = build_metagraph()
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

CairoMakie.Makie.update_state_before_display!(fig)
# This example intentionally snapshots GraphMakie's documented node-position
# observable and then hands those explicit coordinates to the public overlay
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
ax.title = "GraphMakie node-position hand-off"

if isempty(ARGS) && isinteractive()
    display(fig)
    println("Displayed graph anchor example.")
    println("Pass a path as the first argument to save a PNG instead.")
else
    output_path = abspath(get(ARGS, 1, "graph_anchors.png"))
    save(output_path, fig)
    println("Saved graph anchor example to $(output_path)")
end
