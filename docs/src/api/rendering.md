```@meta
CurrentModule = PhyloPicMakie
```

# Rendering API

Primitives for overlaying pre-resolved PhyloPic silhouettes on Makie axes.
These functions accept image matrices directly — no taxon-name resolution or network access.
For PBDB-integrated taxon-name resolution, see [`PaleobiologyDB.PhyloPicPBDB`](https://jeetsukumaran.github.io/PaleobiologyDB.jl/dev/api/phylopic_makie/).

The public explicit-coordinate API is implemented on top of the package's
generic anchored-overlay substrate. Internally, `PhyloPicMakie` now owns both
data-anchor and projected pixel-anchor placement mechanics, along with aspect
preservation, placement offsets, and reactive resize or relimit behavior.

```@autodocs
Modules = [PhyloPicMakie]
```
