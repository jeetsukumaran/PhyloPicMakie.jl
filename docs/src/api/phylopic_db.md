```@meta
CurrentModule = PhyloPicMakie.PhyloPicDB
```

# PhyloPicDB

`PhyloPicMakie.PhyloPicDB` is a supported nested namespace containing the
typed client for the [PhyloPic](https://www.phylopic.org/) v2 API. Its exported
types, constants, and functions are part of the package's public API.

## Import

```julia
using PhyloPicMakie

const PhyloPicDB = PhyloPicMakie.PhyloPicDB
```

The nested namespace avoids adding all client names to the top-level rendering
namespace.

## Quick start

```julia
using PhyloPicMakie

const PhyloPicDB = PhyloPicMakie.PhyloPicDB

uuid = PhyloPicDB.resolve_pbdb_node([133360, 133359, 39168, 37177])
node = isnothing(uuid) ? nothing : PhyloPicDB.fetch_node(uuid)
image = isnothing(uuid) ? nothing : PhyloPicDB.primary_image(uuid)
```

Use an explicit build number when several requests must use one PhyloPic data
snapshot:

```julia
build = PhyloPicDB.fetch_current_build()
images = PhyloPicDB.clade_images(uuid; build, max_pages = 2)
```

## Request injection

Networked functions accept a `request` keyword whose default is
`PhyloPicDB.phylopic_get`. A replacement callable must accept one URL string
and return an `HTTP.Response`. This seam supports deterministic tests and
controlled transports without modifying module state.

```julia
using HTTP

response = HTTP.Response(200, "{\"build\": 537}")
request = url -> response
build = PhyloPicDB.fetch_current_build(; force = true, request)
```

## Image licensing and attribution

`PhyloPicImage` records include `license`, `license_url`, `attribution`, and
`contributor_href`. These values describe the individual image. The
PhyloPicMakie package license does not replace the image's license. Preserve
the applicable attribution and follow the terms attached to each image.

## Types and constants

```@docs
PhyloPicNode
PhyloPicImage
PHYLOPIC_BASE_URL
BUILD_TTL
PHYLOPIC_IMAGE_RENDERINGS
PHYLOPIC_IMAGE_ALL_LABEL_FIELDS
PHYLOPIC_IMAGE_BASIC_LABEL_FIELDS
phylopic_get
```

## Build and node requests

```@docs
fetch_current_build
ensure_build
fetch_node
fetch_node_with_primary_image
resolve_node
resolve_pbdb_node
```

## Image requests and selection

```@docs
fetch_image
fetch_images
primary_image
clade_images
node_images
select_image
with_node_names
```

## Batch requests

```@docs
batch_primary_images
batch_images
```
