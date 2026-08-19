```@meta
CurrentModule = PhyloPicMakie
```

# PhyloPicMakie

PhyloPicMakie places [PhyloPic](https://www.phylopic.org/) silhouettes in Makie
figures. Start with PhyloPic node UUIDs, taxon-derived node UUIDs from another
package, or image matrices you have already prepared. Then choose the points,
ranges, table rows, or gallery cells where the silhouettes should appear.

## What you can make

Add silhouettes to a figure at point coordinates or across ranges. Build a
thumbnail gallery from PhyloPic node UUIDs and labels. Use the runnable
gallery scripts to save figures while you explore the available plotting
options.

## What data you need

Most plots need coordinates plus a `node_uuid` vector or table column. Range
plots also need start and stop coordinates. If you already have decoded image
matrices, pass them with `glyph`; that path is for local image data, not the
main learning path.

Repeated PhyloPic queries can use `PhyloPicDB.batch_primary_images` or
`PhyloPicDB.batch_images`, which call DataCaches-backed cache helpers in this
package. Cache setup belongs in later task pages, so the primer and tutorial
stay focused on making the first figure.

## Where to go next

Read the [primer](primer.md) for the first conceptual pass, then follow the
[tutorial](tutorial.md) for a guided first figure. Choose
[how-to guides](how-to/index.md) for a plotting task, including
[build a thumbnail gallery](how-to/thumbnail-gallery.md) and [place silhouettes
on GraphMakie node-position snapshots](how-to/graphmakie-node-positions.md),
read [concepts](explanation/index.md) and [about PaleobiologyDB
workflows](explanation/paleobiologydb-workflows.md) for context, consult the
[API reference](api/rendering.md) for exact facts, or run an [example](examples.md)
when you want working scripts.

## Documentation map

- [Start here](index.md): choose a path through the documentation.
- [Primer and tutorial](primer.md): learn what silhouettes can add to a Makie
  figure, then build a first figure step by step.
- [How-to guides](how-to/index.md): solve a focused plotting, query, or gallery
  task, including [place silhouettes on GraphMakie node-position
  snapshots](how-to/graphmakie-node-positions.md).
- [Explanation](explanation/index.md): connect the concepts behind the
  reader-visible behavior, including [about PaleobiologyDB
  workflows](explanation/paleobiologydb-workflows.md).
- [API reference](api/rendering.md): look up [rendering](api/rendering.md) and
  [PhyloPicDB](api/phylopic_db.md) facts.
- [Examples](examples.md): run the repository's gallery scripts.
