# ---------------------------------------------------------------------------
# PhyloPicDB — image API
#
# Public:
#   fetch_image(uuid; build)                              → Union{PhyloPicImage, Nothing}
#   fetch_images(node_uuid; build, filter, max_pages)     → Vector{PhyloPicImage}
# ---------------------------------------------------------------------------

# Number of images returned per page by the PhyloPic /images list endpoint.
const _IMAGES_PER_PAGE = 30

"""
    fetch_image(
        uuid;
        build = nothing,
        add_node_name::Bool = false,
        request = phylopic_get,
    ) -> Union{PhyloPicImage, Nothing}

Fetch a single [`PhyloPicImage`](@ref) by its UUID from the PhyloPic API.

# Arguments

- `uuid`: The PhyloPic image UUID string.
- `build`: PhyloPic build index.  `nothing` fetches the current build.
- `add_node_name`: if `true` and the image has a `specific_node_uuid`, fetch
  the corresponding node and populate `img.node_name` with its
  `preferred_name`.  Requires one additional HTTP round trip.  Default `false`.
- `request`: callable that accepts a URL and returns an `HTTP.Response`.

# Returns

A [`PhyloPicImage`](@ref), or `nothing` if the image is not found or any
error occurs.

# Examples

```julia
img = fetch_image("045279d5-24e5-4838-bec9-0bea86812e35")
isnothing(img) || println(img.thumbnail_url)

img2 = fetch_image("045279d5-24e5-4838-bec9-0bea86812e35"; add_node_name = true)
isnothing(img2) || println(img2.node_name)
```
"""
function fetch_image(
        uuid::AbstractString;
        build::Union{Int, Nothing} = nothing,
        add_node_name::Bool = false,
        request = phylopic_get,
    )::Union{PhyloPicImage, Nothing}
    b = ensure_build(build; request)
    url = "$PHYLOPIC_BASE_URL/images/$uuid?build=$b"
    try
        resp = request(url)
        img = _parse_image_json(JSON3.read(resp.body), b)
        isempty(img.uuid) && return nothing
        if add_node_name && !isnothing(img.specific_node_uuid)
            node = fetch_node(img.specific_node_uuid; build = b, request)
            isnothing(node) || (img = _with_node_name(img, node.preferred_name))
        end
        return img
    catch
        return nothing
    end
end

# ---------------------------------------------------------------------------
# Internal: single-page fetch
# ---------------------------------------------------------------------------

# Fetch one page (zero-indexed) of the /images list for a node.
# filter_param is "filter_clade" or "filter_node".
# Returns a (possibly empty) Vector{PhyloPicImage} and the total page count,
# or (empty, 0) on any error.
function _fetch_images_page(
        node_uuid::AbstractString,
        build::Int,
        page::Int,
        filter_param::AbstractString;
        request = phylopic_get,
    )::Tuple{Vector{PhyloPicImage}, Int}
    url = "$PHYLOPIC_BASE_URL/images?build=$build" *
        "&$filter_param=$node_uuid&embed_items=true&page=$page"
    try
        resp = request(url)
        obj = JSON3.read(resp.body)
        n_pages = try
            tp = obj.totalPages
            tp isa Integer ? Int(tp) : 1
        catch
            1
        end
        items = try
            obj._embedded.items
        catch
            return (PhyloPicImage[], n_pages)
        end
        images = [_parse_image_json(item, build) for item in items]
        # Discard entries that failed to parse (empty uuid).
        filter!(img -> !isempty(img.uuid), images)
        return (images, n_pages)
    catch
        return (PhyloPicImage[], 0)
    end
end

"""
    fetch_images(
        node_uuid;
        build = nothing,
        filter = :clade,
        max_pages = nothing,
        add_node_name::Bool = false,
        request = phylopic_get,
    ) -> Vector{PhyloPicImage}

Return all [`PhyloPicImage`](@ref)s associated with a PhyloPic node,
paging through the `/images` list endpoint.

# Arguments

- `node_uuid`: PhyloPic node UUID string.
- `build`: PhyloPic build index.  `nothing` fetches the current build.
- `filter`: image scope.
  - `:clade` (default): images for the node and all its descendants, ordered
    from most-basal to most-nested.
  - `:node`: only images tagged to exactly this node.
- `max_pages`: if provided, fetch at most this many pages (each page contains
  up to $(repr(_IMAGES_PER_PAGE)) images).  `nothing` (default) fetches all
  pages.
- `add_node_name`: if `true`, populate `node_name` on each returned image via
  deduplicated [`fetch_node`](@ref) calls (one call per unique
  `specific_node_uuid`).  Default `false`.
- `request`: callable that accepts a URL and returns an `HTTP.Response`.

# Returns

A `Vector{PhyloPicImage}`.  An empty vector is returned when the node has no
images or cannot be resolved.

# Throws

`ArgumentError` if `filter` is not `:clade` or `:node`.

# Examples

```julia
# All clade images for the Carnivora node
imgs = fetch_images("36c04f2f-b7d2-4891-a4a9-138d79592bf2"; max_pages = 2)
length(imgs)  # up to 60

# Only images directly tagging this node
imgs_node = fetch_images("36c04f2f-b7d2-4891-a4a9-138d79592bf2"; filter = :node)

# With node names enriched
imgs2 = fetch_images("36c04f2f-b7d2-4891-a4a9-138d79592bf2"; add_node_name = true)
imgs2[1].node_name   # → e.g. "Carnivora"
```
"""
function fetch_images(
        node_uuid::AbstractString;
        build::Union{Int, Nothing} = nothing,
        filter::Symbol = :clade,
        max_pages::Union{Int, Nothing} = nothing,
        add_node_name::Bool = false,
        request = phylopic_get,
    )::Vector{PhyloPicImage}
    filter in (:clade, :node) ||
        throw(
        ArgumentError(
            "fetch_images: `filter` must be :clade or :node, got :$filter"
        )
    )
    (!isnothing(max_pages) && max_pages < 1) && throw(
        ArgumentError(
            "fetch_images: `max_pages` must be positive or `nothing`, got $max_pages"
        )
    )

    b = ensure_build(build; request)
    filter_param = filter === :clade ? "filter_clade" : "filter_node"

    # Fetch page 0 to learn totalPages.
    first_page, n_pages = _fetch_images_page(node_uuid, b, 0, filter_param; request)
    n_pages == 0 && return PhyloPicImage[]

    limit = isnothing(max_pages) ? n_pages : min(n_pages, max_pages)

    results = copy(first_page)
    sizehint!(results, limit * _IMAGES_PER_PAGE)

    for page in 1:(limit - 1)
        page_imgs, _ = _fetch_images_page(node_uuid, b, page, filter_param; request)
        append!(results, page_imgs)
    end

    # Enrich with node names after all pages are collected so that node
    # fetches are deduplicated across the full result set.
    add_node_name && (results = with_node_names(results; build = b, request))

    return results
end
