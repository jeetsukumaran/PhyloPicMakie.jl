```@meta
CurrentModule = PhyloPicMakie
```

# Place silhouettes on GraphMakie node-position snapshots

Place PhyloPic silhouettes at a GraphMakie layout's node positions by capturing
the positions from a materialized graph plot and passing their coordinates to
`augment_phylopic!`.

```julia
using CairoMakie
using GraphMakie
using Graphs: path_graph
using PhyloPicMakie

graph = path_graph(3)
figure, axis, graph_plot = GraphMakie.graphplot(graph)
CairoMakie.Makie.update_state_before_display!(figure)

node_positions = graph_plot[:node_pos][]
xs = [point[1] for point in node_positions]
ys = [point[2] for point in node_positions]
node_uuid = [
    "8f901db5-84c1-4dc0-93ba-2300eeddf4ab",
    "36c04f2f-b7d2-4891-a4a9-138d79592bf2",
    "8f901db5-84c1-4dc0-93ba-2300eeddf4ab",
]

augment_phylopic!(axis, xs, ys; node_uuid)
```

The silhouettes use the positions captured by this run. After changing the
graph layout, rerun the capture and placement sequence.

## Expected result

The graph remains visible, with one PhyloPic silhouette placed at each captured
node position.

Use the [GraphMakie example script](../examples.md) for a local rendering
check. See the [rendering reference](../api/rendering.md) for the full
`augment_phylopic!` option list, [how-to guides](index.md) for related tasks,
and [about PaleobiologyDB workflows](../explanation/paleobiologydb-workflows.md)
when taxon names are your starting point.
