# ---------------------------------------------------------------------------
# PhyloPicDB — node API
#
# Public:
#   fetch_node(uuid; build)                   → Union{PhyloPicNode, Nothing}
#   fetch_node_with_primary_image(uuid; build) → Tuple{Union{PhyloPicNode,Nothing},
#                                                      Union{PhyloPicImage,Nothing}}
# ---------------------------------------------------------------------------

"""
    fetch_node(uuid; build = nothing, request = phylopic_get)
        -> Union{PhyloPicNode, Nothing}

Fetch a single [`PhyloPicNode`](@ref) by its UUID from the PhyloPic API.

# Arguments

- `uuid`: The PhyloPic node UUID string.
- `build`: PhyloPic build index.  `nothing` (default) fetches the current
  build automatically via [`ensure_build`](@ref).
- `request`: callable that accepts a URL and returns an `HTTP.Response`.

# Returns

    A [`PhyloPicNode`](@ref), or `nothing` if the node is not found (404).
    Operational and malformed-response errors are propagated.

# Examples

```julia
node = fetch_node("8f901db5-84c1-4dc0-93ba-2300eeddf4ab")
isnothing(node) || println(node.preferred_name)
```
"""
function fetch_node(
        uuid::AbstractString;
        build::Union{Int, Nothing} = nothing,
        request = phylopic_get,
    )::Union{PhyloPicNode, Nothing}
    b = ensure_build(build; request)
    return _fetch_node_strict(uuid, b; request)
end

function _fetch_node_strict(
        uuid::AbstractString,
        build::Int;
        request = phylopic_get,
    )::Union{PhyloPicNode, Nothing}
    url = "$PHYLOPIC_BASE_URL/nodes/$uuid?build=$build"
    try
        response = request(url)
        node = _parse_node_json(JSON3.read(response.body), build)
        isempty(node.uuid) && error("_fetch_node_strict: response did not contain a node UUID.")
        return node
    catch err
        _is_not_found_error(err) && return nothing
        rethrow(err)
    end
end

"""
    fetch_node_with_primary_image(uuid; build = nothing, request = phylopic_get)
        -> Tuple{Union{PhyloPicNode, Nothing}, Union{PhyloPicImage, Nothing}}

Fetch a node and its embedded primary image in a single API request.

Uses `?embed_primaryImage=true` to retrieve both records in one round trip.
The second element of the returned tuple is `nothing` when the node has no
primary image. Malformed embedded image data throws.

# Arguments

- `uuid`: The PhyloPic node UUID string.
- `build`: PhyloPic build index.  `nothing` fetches the current build.
- `request`: callable that accepts a URL and returns an `HTTP.Response`.

# Returns

A two-element tuple `(node, image)`:
    - `node`: a [`PhyloPicNode`](@ref), or `nothing` when the node is not found.
    - `image`: a [`PhyloPicImage`](@ref), or `nothing` when no primary image exists.

Operational and malformed-response errors are propagated.

# Examples

```julia
node, img = fetch_node_with_primary_image("8f901db5-84c1-4dc0-93ba-2300eeddf4ab")
if !isnothing(img)
    println(img.thumbnail_url)
end
```
"""
function fetch_node_with_primary_image(
        uuid::AbstractString;
        build::Union{Int, Nothing} = nothing,
        request = phylopic_get,
    )::Tuple{Union{PhyloPicNode, Nothing}, Union{PhyloPicImage, Nothing}}
    b = ensure_build(build; request)
    url = "$PHYLOPIC_BASE_URL/nodes/$uuid?build=$b&embed_primaryImage=true"
    try
        resp = request(url)
        obj = JSON3.read(resp.body)
        node = _parse_node_json(obj, b)
        isempty(node.uuid) && error(
            "fetch_node_with_primary_image: response did not contain a node UUID."
        )

        embedded = hasproperty(obj, :_embedded) ? obj._embedded : nothing
        img_obj = !isnothing(embedded) && hasproperty(embedded, :primaryImage) ?
            embedded.primaryImage : nothing
        isnothing(img_obj) && return (node, nothing)

        img = _parse_image_json(img_obj, b)
        isempty(img.uuid) && error(
            "fetch_node_with_primary_image: embedded primary image did not contain an image UUID."
        )
        return (node, img)
    catch err
        _is_not_found_error(err) && return (nothing, nothing)
        rethrow(err)
    end
end
