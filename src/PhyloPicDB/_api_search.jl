# ---------------------------------------------------------------------------
# PhyloPicDB — native name-search API
# ---------------------------------------------------------------------------

"""
    normalize_taxon_query(query) -> String

Normalize a taxon-name query using PhyloPic's search contract: remove
diacritics, lowercase, retain only ASCII letters, spaces, and hyphens, then
collapse and trim whitespace.
"""
function normalize_taxon_query(query::AbstractString)::String
    value = lowercase(Base.Unicode.normalize(String(query); stripmark = true))
    value = replace(value, r"\s+" => " ")
    value = replace(value, r"[^a-z -]+" => " ")
    return strip(replace(value, r"\s+" => " "))
end

function _validated_taxon_query(query::AbstractString, caller::AbstractString)::String
    normalized = normalize_taxon_query(query)
    length(normalized) >= 2 || throw(
        ArgumentError("$caller: normalized query must contain at least two characters.")
    )
    return normalized
end

"""
    autocomplete_nodes(query; build = nothing, request = phylopic_get)
        -> Vector{String}

Return up to 16 normalized PhyloPic name suggestions for `query`.
Operational and malformed-response errors are propagated.
"""
function autocomplete_nodes(
        query::AbstractString;
        build::Union{Int, Nothing} = nothing,
        request = phylopic_get,
    )::Vector{String}
    normalized = _validated_taxon_query(query, "autocomplete_nodes")
    b = ensure_build(build; request)
    encoded = HTTP.escapeuri(normalized)
    url = "$PHYLOPIC_BASE_URL/autocomplete?build=$b&query=$encoded"
    response = request(url)
    obj = JSON3.read(response.body)
    hasproperty(obj, :matches) || error(
        "autocomplete_nodes: response did not contain `matches`."
    )
    matches = obj.matches
    matches isa AbstractVector || error(
        "autocomplete_nodes: `matches` was not an array."
    )
    return String[string(match) for match in matches]
end

"""
    search_nodes(query; build = nothing, max_pages = nothing, request = phylopic_get)
        -> Vector{PhyloPicNode}

Return every PhyloPic node associated with the normalized name `query`,
following HAL `_links.next` relations until exhausted. Results are returned in
the API's phylogenetic order. Operational and malformed-response errors are
propagated.
"""
function search_nodes(
        query::AbstractString;
        build::Union{Int, Nothing} = nothing,
        max_pages::Union{Int, Nothing} = nothing,
        request = phylopic_get,
    )::Vector{PhyloPicNode}
    normalized = _validated_taxon_query(query, "search_nodes")
    b = ensure_build(build; request)
    encoded = HTTP.escapeuri(normalized)
    first_url = "$PHYLOPIC_BASE_URL/nodes?build=$b&filter_name=$encoded" *
        "&embed_items=true&page=0"
    return _fetch_hal_pages(
        PhyloPicNode,
        first_url,
        item -> begin
            node = _parse_node_json(item, b)
            isempty(node.uuid) && error(
                "search_nodes: response contained a node without a UUID."
            )
            node
        end;
        max_pages,
        request,
    )
end

"""
    fetch_external_namespaces(; build = nothing, request = phylopic_get)
        -> Vector{ExternalTaxonNamespace}

Return the external authority/namespace pairs supported by the active
PhyloPic build.
"""
function fetch_external_namespaces(;
        build::Union{Int, Nothing} = nothing,
        request = phylopic_get,
    )::Vector{ExternalTaxonNamespace}
    b = ensure_build(build; request)
    response = request("$PHYLOPIC_BASE_URL/namespaces?build=$b")
    obj = JSON3.read(response.body)
    hasproperty(obj, :namespaces) || error(
        "fetch_external_namespaces: response did not contain `namespaces`."
    )
    namespaces = obj.namespaces
    namespaces isa AbstractVector || error(
        "fetch_external_namespaces: `namespaces` was not an array."
    )
    return ExternalTaxonNamespace[
        ExternalTaxonNamespace(string(item.authority), string(item.namespace))
            for item in namespaces
    ]
end
