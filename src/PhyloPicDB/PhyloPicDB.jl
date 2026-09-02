"""
    PhyloPicDB

A Julia client for the [PhyloPic](https://www.phylopic.org/) API (v2).

PhyloPic is an open database of freely reusable silhouette images of
organisms, searchable by phylogeny.  This package provides typed structs
([`PhyloPicNode`](@ref), [`PhyloPicImage`](@ref)), low-level API wrappers,
a high-level taxon-discovery and image-selection layer, and batch-fetch
utilities with built-in deduplication and DataCaches-based caching.

## Quick start

```julia
using PhyloPicMakie

const PhyloPicDB = PhyloPicMakie.PhyloPicDB

# Resolve a scientific name directly through PhyloPic
resolution = PhyloPicDB.resolve_taxon("Ursus arctos")

# Require the selected node in programmatic code
node = PhyloPicDB.require_node(resolution)
println(node.preferred_name)

# Get the primary image (one request)
img = PhyloPicDB.primary_image(resolution)
println(img.thumbnail_url)

# Get all clade images (paginated)
imgs = PhyloPicDB.clade_images(node; max_pages = 2)
length(imgs)

# Select the third image (or nothing if fewer than 3 exist)
chosen = PhyloPicDB.select_image(imgs, 3)

# Batch fetch for multiple nodes
result = PhyloPicDB.batch_primary_images([node.uuid, node.uuid])
```

## Build management

All API functions accept an optional `build` keyword argument.  Pass
`nothing` (the default) to fetch the current build automatically.  Pass an
explicit `Int` to pin the build and avoid redundant network requests when
making many calls in a tight loop:

```julia
b = PhyloPicDB.fetch_current_build()
node = PhyloPicDB.fetch_node(uuid; build = b)
imgs = PhyloPicDB.clade_images(uuid; build = b)
```

## Image ordering stability

Within a single PhyloPic build, image ordering for a given node is
deterministic.  Integer-index selection via [`select_image`](@ref) therefore
returns the same image on every call within a session (assuming the build
does not change).
"""
module PhyloPicDB

import HTTP
import JSON3
import DataCaches: autocache

include("_types.jl")
include("_taxon_types.jl")
include("_http.jl")
include("_build.jl")
include("_pagination.jl")
include("_api_nodes.jl")
include("_api_images.jl")
include("_api_resolve.jl")
include("_api_search.jl")
include("_taxon_resolvers.jl")
include("_image_selector.jl")
include("_bulk.jl")

export PhyloPicNode
export PhyloPicImage
export AbstractTaxonResolver
export PhyloPicResolver
export GBIFResolver
export PBDBResolver
export TaxonResolution
export TaxonResolutionStatus
export TaxonMatchBasis
export ExternalTaxonIdentifier
export ExternalTaxonNamespace

export TAXON_RESOLVED
export TAXON_AMBIGUOUS
export TAXON_NOT_FOUND
export PREFERRED_NAME_MATCH
export UNIQUE_ALIAS_MATCH
export EXTERNAL_IDENTIFIER_MATCH

export PHYLOPIC_BASE_URL
export BUILD_TTL
export phylopic_get

export fetch_current_build
export ensure_build

export fetch_node
export fetch_node_with_primary_image
export autocomplete_nodes
export search_nodes
export fetch_external_namespaces
export normalize_taxon_query

export resolve_taxon
export resolve_taxa
export isresolved
export require_node
export node_uuid

export fetch_image
export fetch_images

export resolve_node
export resolve_pbdb_node

export primary_image
export clade_images
export node_images
export select_image
export with_node_names

export batch_primary_images
export batch_images

export PHYLOPIC_IMAGE_RENDERINGS
export PHYLOPIC_IMAGE_ALL_LABEL_FIELDS
export PHYLOPIC_IMAGE_BASIC_LABEL_FIELDS

end # module PhyloPicDB
