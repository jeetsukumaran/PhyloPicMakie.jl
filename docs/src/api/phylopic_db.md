```@meta
CurrentModule = PhyloPicMakie
```

# PhyloPicDB

This reference lists the public PhyloPic API client types, constants, lookup,
image-selection, and batch-query APIs.

For task guidance, see the [tutorial](../tutorial.md), [choose PhyloPic
images](../how-to/choose-phylopic-images.md), [build a thumbnail
gallery](../how-to/thumbnail-gallery.md), and [cache repeated PhyloPic
queries](../how-to/repeated-queries.md).

```@autodocs
Modules = [PhyloPicMakie.PhyloPicDB]
Private = false
Order = [:constant, :type, :function]
Pages = ["_http.jl", "_build.jl", "_types.jl", "_api_nodes.jl", "_api_images.jl", "_api_resolve.jl", "_image_selector.jl", "_bulk.jl"]
```
