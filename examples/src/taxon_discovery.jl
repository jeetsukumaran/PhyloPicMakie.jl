using CairoMakie: Axis, Figure, display, hidedecorations!, hidespines!, save, text!, xlims!, ylims!
using PhyloPicMakie: PhyloPicDB, augment_phylopic!

const BEAR_TAXA = [
    "Ailuropoda melanoleuca",
    "Tremarctos ornatus",
    "Melursus ursinus",
    "Helarctos malayanus",
    "Ursus thibetanus",
    "Ursus americanus",
    "Ursus arctos",
    "Ursus maritimus",
]

# The batch result is useful at the REPL: each element shows its semantic
# status, selected node, selection basis, candidates, and suggestions.
resolutions = PhyloPicDB.resolve_taxa(BEAR_TAXA)
display(resolutions)

# Programmatic callers can require successful nodes or inspect each status.
nodes = PhyloPicDB.require_node.(resolutions)
node_uuids = getproperty.(nodes, :uuid)

figure = Figure(size = (900, 560))
axis = Axis(figure[1, 1])
y = collect(reverse(eachindex(BEAR_TAXA)))
x = fill(0.0, length(BEAR_TAXA))

text!(
    axis,
    BEAR_TAXA;
    position = [(-0.45, row) for row in y],
    align = (:right, :center),
    fontsize = 17,
)
augment_phylopic!(
    axis,
    x,
    y;
    node_uuid = node_uuids,
    build = only(unique(getproperty.(nodes, :build))),
    glyph_size = 0.38,
    on_missing = :error,
)

xlims!(axis, -4.0, 1.5)
ylims!(axis, 0.3, length(BEAR_TAXA) + 0.7)
hidedecorations!(axis)
hidespines!(axis)

if isempty(ARGS) && isinteractive()
    display(figure)
else
    output_path = abspath(get(ARGS, 1, "taxon_discovery.png"))
    save(output_path, figure)
    println("Saved taxon discovery example to $(output_path)")
end
