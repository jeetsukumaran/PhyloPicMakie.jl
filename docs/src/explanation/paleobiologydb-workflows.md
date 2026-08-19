```@meta
CurrentModule = PhyloPicMakie
```

# About PaleobiologyDB workflows

PhyloPicMakie serves figures that already have PhyloPic node UUIDs or decoded
images. A PaleobiologyDB taxon-name starting point belongs to
`PaleobiologyDB.PBDBMakie`.

## Two starting points

The two packages meet at a reader's input data. Use PhyloPicMakie when a
workflow already supplies a node UUID or decoded image and the next task is to
place a silhouette in a Makie figure. Use the
[PaleobiologyDB PhyloPic rendering reference](https://jeetsukumaran.github.io/PaleobiologyDB.jl/dev/api/phylopic_makie/)
when a workflow begins with PBDB taxon names. Its
`PaleobiologyDB.PBDBMakie` surface resolves that taxon-name workflow before
rendering silhouettes or building a gallery.

This division keeps the two reader paths clear. PhyloPicMakie does not accept
PBDB taxon names as direct silhouette inputs, while PaleobiologyDB provides the
taxon-name path that can lead to PhyloPic images.

## Related local pages

Read the [rendering reference](../api/rendering.md) for PhyloPicMakie API
facts, [build a thumbnail gallery](../how-to/thumbnail-gallery.md) for a
UUID-backed gallery, and [place silhouettes on GraphMakie node-position
snapshots](../how-to/graphmakie-node-positions.md) for a graph layout snapshot.
