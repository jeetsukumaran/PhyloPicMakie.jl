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

resolution = PhyloPicDB.resolve_taxon("Ursus arctos")
node = PhyloPicDB.require_node(resolution)
image = PhyloPicDB.primary_image(resolution)
```

Use an explicit build number when several requests must use one PhyloPic data
snapshot:

```julia
build = PhyloPicDB.fetch_current_build()
images = PhyloPicDB.clade_images(node; build, max_pages = 2)
```

## Native name discovery

`resolve_taxon` normalizes a scientific-name query and searches PhyloPic. It
first uses an exact canonical preferred-name match, then an exact normalized
preferred-name match, and finally a single unique alias candidate. It never
selects the first ambiguous candidate.

```julia
resolution = PhyloPicDB.resolve_taxon("Ursus thibetanus")

resolution.status
resolution.match_basis
resolution.node
resolution.candidates
resolution.suggestions
```

The compact REPL display shows the status and selected node. Use
`search_nodes` to inspect all candidates and `autocomplete_nodes` for
normalized suggestions. `resolve_taxa` preserves input order, deduplicates
normalized queries, and pins one PhyloPic build for the batch.

```julia
resolutions = PhyloPicDB.resolve_taxa([
    "Ailuropoda melanoleuca",
    "Ursus arctos",
    "Ursus arctos",
])

uuids = PhyloPicDB.node_uuid.(resolutions)
```

Semantic outcomes use `TAXON_RESOLVED`, `TAXON_AMBIGUOUS`, and
`TAXON_NOT_FOUND`. Network and malformed-response failures throw instead of
being represented as taxonomic misses.

## External taxonomy providers

Provider selection is explicit. `GBIFResolver` uses exact GBIF matches and
passes the ordered GBIF lineage to PhyloPic. `PBDBResolver` obtains a PBDB
`orig_no` lineage and passes it in most-specific-first order. PhyloPic remains
the source of the selected node in both cases.

```julia
gbif_result = PhyloPicDB.resolve_taxon(
    "Ursus arctos",
    PhyloPicDB.GBIFResolver(kingdom = "Animalia"),
)

pbdb_result = PhyloPicDB.resolve_taxon(
    "Ursus arctos",
    PhyloPicDB.PBDBResolver(),
)
```

The result preserves the ordered external identifiers and provider metadata.
PhyloPicMakie does not run an automatic multi-provider cascade.

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
AbstractTaxonResolver
PhyloPicResolver
GBIFResolver
PBDBResolver
TaxonResolution
TaxonResolutionStatus
TaxonMatchBasis
ExternalTaxonIdentifier
ExternalTaxonNamespace
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
normalize_taxon_query
autocomplete_nodes
search_nodes
fetch_external_namespaces
resolve_taxon
resolve_taxa
isresolved
require_node
node_uuid
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
