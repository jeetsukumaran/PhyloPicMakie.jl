# ---------------------------------------------------------------------------
# PhyloPicDB — external identifier resolution API
#
# Public:
#   resolve_node(authority, namespace, object_ids; build)  → Union{String, Nothing}
#   resolve_pbdb_node(pbdb_ids; build)                     → Union{String, Nothing}
# ---------------------------------------------------------------------------

"""
    resolve_node(
        authority,
        namespace,
        object_ids;
        build = nothing,
        request = phylopic_get,
    )
        -> Union{String, Nothing}

Resolve a list of external identifiers to the closest matching PhyloPic node
UUID.

Sends a request to `/resolve/{authority}/{namespace}?objectIDs={ids}`.
Identifiers earlier in `object_ids` take priority: PhyloPic returns the node
matching the first identifier for which a match exists.

# Arguments

- `authority`: external database authority string (e.g. `"paleobiodb.org"`,
  `"gbif.org"`).
- `namespace`: namespace within the authority (e.g. `"txn"`, `"species"`).
- `object_ids`: ordered vector of identifier strings to try.  The first
  element has the highest priority.
- `build`: PhyloPic build index.  `nothing` fetches the current build.
- `request`: callable that accepts a URL and returns an `HTTP.Response`.

# Returns

The matched PhyloPic node UUID as a `String`, or `nothing` if no match is
found or any error occurs.

# Examples

```julia
# Resolve GBIF species keys (most specific first)
uuid = resolve_node(
    "gbif.org", "species",
    ["5421410", "3191248", "5399"];
)
```
"""
function resolve_node(
        authority::AbstractString,
        namespace::AbstractString,
        object_ids::AbstractVector{<:AbstractString};
        build::Union{Int, Nothing} = nothing,
        request = phylopic_get,
    )::Union{String, Nothing}
    isempty(object_ids) && return nothing

    try
        b = ensure_build(build; request)
        return _resolve_node_strict(authority, namespace, object_ids, b; request)
    catch
        return nothing
    end
end

function _resolve_node_strict(
        authority::AbstractString,
        namespace::AbstractString,
        object_ids::AbstractVector{<:AbstractString},
        build::Int;
        request = phylopic_get,
    )::Union{String, Nothing}
    isempty(object_ids) && return nothing

    ids_str = join(object_ids, ",")
    url = "$PHYLOPIC_BASE_URL/resolve/$authority/$namespace" *
        "?build=$build&objectIDs=$ids_str"
    return try
        response = request(url)
        obj = JSON3.read(response.body)

        hasproperty(obj, :uuid) && return string(obj.uuid)
        if hasproperty(obj, :href)
            path = first(split(string(obj.href), '?'))
            uuid = last(split(path, '/'))
            isempty(uuid) || return uuid
        end
        error("_resolve_node_strict: response did not contain a node UUID or href.")
    catch err
        err isa HTTP.Exceptions.StatusError && err.status == 404 && return nothing
        rethrow(err)
    end
end

"""
    resolve_pbdb_node(pbdb_ids; build = nothing, request = phylopic_get)
        -> Union{String, Nothing}

Convenience wrapper for [`resolve_node`](@ref) using the Paleobiology Database
(`paleobiodb.org / txn`) as the authority.

`pbdb_ids` should be in priority order (most specific taxon first, then
progressively more inclusive ancestors), matching the ordering expected by the
PhyloPic `/resolve` endpoint.

# Arguments

- `pbdb_ids`: ordered vector of PBDB `orig_no` integer values, most-specific
  first.
- `build`: PhyloPic build index.  `nothing` fetches the current build.
- `request`: callable that accepts a URL and returns an `HTTP.Response`.

# Returns

The matched PhyloPic node UUID as a `String`, or `nothing` if no match is
found.

# Examples

```julia
# Tyrannosaurus rex lineage: taxon first, ancestors after
uuid = resolve_pbdb_node([133360, 133359, 39168, 37177])
```
"""
function resolve_pbdb_node(
        pbdb_ids::AbstractVector{<:Integer};
        build::Union{Int, Nothing} = nothing,
        request = phylopic_get,
    )::Union{String, Nothing}
    isempty(pbdb_ids) && return nothing
    return resolve_node(
        "paleobiodb.org",
        "txn",
        string.(pbdb_ids);
        build,
        request,
    )
end
