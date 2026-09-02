# ---------------------------------------------------------------------------
# PhyloPicDB — high-level taxon resolvers
# ---------------------------------------------------------------------------

const GBIF_SPECIES_MATCH_URL = "https://api.gbif.org/v1/species/match"
const PBDB_TAXA_LIST_URL = "https://paleobiodb.org/data1.2/taxa/list.json"

function _resolution(
        query::AbstractString,
        normalized_query::AbstractString,
        resolver::R,
        status::TaxonResolutionStatus;
        match_basis::Union{TaxonMatchBasis, Nothing} = nothing,
        node::Union{PhyloPicNode, Nothing} = nothing,
        candidates::Vector{PhyloPicNode} = PhyloPicNode[],
        suggestions::Vector{String} = String[],
        external_identifiers::Vector{ExternalTaxonIdentifier} = ExternalTaxonIdentifier[],
        provider_taxon_name::Union{String, Nothing} = nothing,
        provider_taxon_rank::Union{String, Nothing} = nothing,
        provider_match_type::Union{String, Nothing} = nothing,
        provider_confidence::Union{Int, Nothing} = nothing,
    )::TaxonResolution{R} where {R <: AbstractTaxonResolver}
    return TaxonResolution(
        String(query),
        String(normalized_query),
        resolver,
        status,
        match_basis,
        node,
        candidates,
        suggestions,
        external_identifiers,
        provider_taxon_name,
        provider_taxon_rank,
        provider_match_type,
        provider_confidence,
    )
end

function _with_resolution_query(
        resolution::TaxonResolution{R},
        query::AbstractString,
    )::TaxonResolution{R} where {R <: AbstractTaxonResolver}
    return TaxonResolution(
        String(query),
        resolution.normalized_query,
        resolution.resolver,
        resolution.status,
        resolution.match_basis,
        resolution.node,
        resolution.candidates,
        resolution.suggestions,
        resolution.external_identifiers,
        resolution.provider_taxon_name,
        resolution.provider_taxon_rank,
        resolution.provider_match_type,
        resolution.provider_confidence,
    )
end

function _missing_suggestions(
        normalized_query::AbstractString,
        build::Int,
        request,
    )::Vector{String}
    return autocomplete_nodes(normalized_query; build, request)
end

function _canonical_taxon_name(name::AbstractString)::String
    value = lowercase(Base.Unicode.normalize(String(name); stripmark = true))
    return strip(replace(value, r"\s+" => " "))
end

"""
    resolve_taxon(query, resolver = PhyloPicResolver(); build = nothing, ...)
        -> TaxonResolution

Resolve one taxon-name query to a PhyloPic node without choosing arbitrary
matches. The default resolver searches PhyloPic directly. Pass `GBIFResolver()`
or `PBDBResolver()` to use an explicit external taxonomy provider.

Semantic outcomes are stored in the returned [`TaxonResolution`](@ref).
Transport and malformed-response errors are propagated.
"""
function resolve_taxon(
        query::AbstractString;
        kwargs...,
    )::TaxonResolution{PhyloPicResolver}
    return resolve_taxon(query, PhyloPicResolver(); kwargs...)
end

function resolve_taxon(
        query::AbstractString,
        resolver::PhyloPicResolver;
        build::Union{Int, Nothing} = nothing,
        request = phylopic_get,
        taxonomy_request = HTTP.get,
    )::TaxonResolution{PhyloPicResolver}
    _ = taxonomy_request
    normalized = _validated_taxon_query(query, "resolve_taxon")
    b = ensure_build(build; request)
    candidates = search_nodes(normalized; build = b, request)

    canonical_query = _canonical_taxon_name(query)
    canonical_matches = filter(candidates) do candidate
        _canonical_taxon_name(candidate.preferred_name) == canonical_query
    end
    preferred_matches = filter(candidates) do candidate
        normalize_taxon_query(candidate.preferred_name) == normalized
    end
    if length(canonical_matches) == 1
        return _resolution(
            query,
            normalized,
            resolver,
            TAXON_RESOLVED;
            match_basis = PREFERRED_NAME_MATCH,
            node = only(canonical_matches),
            candidates,
        )
    elseif length(preferred_matches) == 1
        return _resolution(
            query,
            normalized,
            resolver,
            TAXON_RESOLVED;
            match_basis = PREFERRED_NAME_MATCH,
            node = only(preferred_matches),
            candidates,
        )
    elseif length(candidates) == 1
        return _resolution(
            query,
            normalized,
            resolver,
            TAXON_RESOLVED;
            match_basis = UNIQUE_ALIAS_MATCH,
            node = only(candidates),
            candidates,
        )
    elseif !isempty(candidates)
        return _resolution(
            query,
            normalized,
            resolver,
            TAXON_AMBIGUOUS;
            candidates,
        )
    end

    suggestions = _missing_suggestions(normalized, b, request)
    return _resolution(
        query,
        normalized,
        resolver,
        TAXON_NOT_FOUND;
        suggestions,
    )
end

function _optional_string(obj, property::Symbol)::Union{String, Nothing}
    hasproperty(obj, property) || return nothing
    value = getproperty(obj, property)
    (isnothing(value) || ismissing(value)) && return nothing
    return string(value)
end

function _optional_int(obj, property::Symbol)::Union{Int, Nothing}
    hasproperty(obj, property) || return nothing
    value = getproperty(obj, property)
    (isnothing(value) || ismissing(value)) && return nothing
    return value isa Integer ? Int(value) : parse(Int, string(value))
end

function _gbif_identifiers(obj)::Vector{ExternalTaxonIdentifier}
    properties = (
        :usageKey,
        :speciesKey,
        :genusKey,
        :familyKey,
        :orderKey,
        :classKey,
        :phylumKey,
        :kingdomKey,
    )
    identifiers = ExternalTaxonIdentifier[]
    seen = Set{String}()
    for property in properties
        value = _optional_string(obj, property)
        isnothing(value) && continue
        value in seen && continue
        push!(seen, value)
        push!(identifiers, ExternalTaxonIdentifier("gbif.org", "species", value))
    end
    return identifiers
end

function _provider_resolution(
        query::AbstractString,
        normalized::AbstractString,
        resolver::R,
        build::Int,
        identifiers::Vector{ExternalTaxonIdentifier};
        request,
        provider_taxon_name::Union{String, Nothing},
        provider_taxon_rank::Union{String, Nothing},
        provider_match_type::Union{String, Nothing},
        provider_confidence::Union{Int, Nothing},
    )::TaxonResolution{R} where {R <: AbstractTaxonResolver}
    if isempty(identifiers)
        suggestions = _missing_suggestions(normalized, build, request)
        return _resolution(
            query,
            normalized,
            resolver,
            TAXON_NOT_FOUND;
            suggestions,
            provider_taxon_name,
            provider_taxon_rank,
            provider_match_type,
            provider_confidence,
        )
    end

    first_identifier = first(identifiers)
    object_ids = getproperty.(identifiers, :object_id)
    uuid = _resolve_node_strict(
        first_identifier.authority,
        first_identifier.namespace,
        object_ids,
        build;
        request,
    )
    if isnothing(uuid)
        suggestions = _missing_suggestions(normalized, build, request)
        return _resolution(
            query,
            normalized,
            resolver,
            TAXON_NOT_FOUND;
            suggestions,
            external_identifiers = identifiers,
            provider_taxon_name,
            provider_taxon_rank,
            provider_match_type,
            provider_confidence,
        )
    end

    node = _fetch_node_strict(uuid, build; request)
    isnothing(node) && error(
        "resolve_taxon: PhyloPic resolved an external identifier to a missing node."
    )
    return _resolution(
        query,
        normalized,
        resolver,
        TAXON_RESOLVED;
        match_basis = EXTERNAL_IDENTIFIER_MATCH,
        node,
        external_identifiers = identifiers,
        provider_taxon_name,
        provider_taxon_rank,
        provider_match_type,
        provider_confidence,
    )
end

function resolve_taxon(
        query::AbstractString,
        resolver::GBIFResolver;
        build::Union{Int, Nothing} = nothing,
        request = phylopic_get,
        taxonomy_request = HTTP.get,
    )::TaxonResolution{GBIFResolver}
    normalized = _validated_taxon_query(query, "resolve_taxon")
    b = ensure_build(build; request)
    query_parts = String["name=$(HTTP.escapeuri(String(query)))"]
    isnothing(resolver.kingdom) || push!(
        query_parts,
        "kingdom=$(HTTP.escapeuri(resolver.kingdom::String))",
    )
    response = taxonomy_request(GBIF_SPECIES_MATCH_URL * "?" * join(query_parts, "&"))
    obj = JSON3.read(response.body)
    match_type = _optional_string(obj, :matchType)
    confidence = _optional_int(obj, :confidence)
    taxon_name = _optional_string(obj, :scientificName)
    rank = _optional_string(obj, :rank)

    isnothing(match_type) && error(
        "resolve_taxon: GBIF response did not contain `matchType`."
    )
    if uppercase(match_type) != "EXACT"
        suggestions = _missing_suggestions(normalized, b, request)
        return _resolution(
            query,
            normalized,
            resolver,
            uppercase(match_type) == "NONE" ? TAXON_NOT_FOUND : TAXON_AMBIGUOUS;
            suggestions,
            provider_taxon_name = taxon_name,
            provider_taxon_rank = rank,
            provider_match_type = match_type,
            provider_confidence = confidence,
        )
    end

    identifiers = _gbif_identifiers(obj)
    return _provider_resolution(
        query,
        normalized,
        resolver,
        b,
        identifiers;
        request,
        provider_taxon_name = taxon_name,
        provider_taxon_rank = rank,
        provider_match_type = match_type,
        provider_confidence = confidence,
    )
end

function _pbdb_identifier(value)::String
    parts = split(string(value), ':')
    return String(last(parts))
end

function _pbdb_identifiers(records)::Vector{ExternalTaxonIdentifier}
    identifiers = ExternalTaxonIdentifier[]
    seen = Set{String}()
    for record in Iterators.reverse(records)
        hasproperty(record, :orig_no) || continue
        value = _pbdb_identifier(record.orig_no)
        value in seen && continue
        push!(seen, value)
        push!(
            identifiers,
            ExternalTaxonIdentifier("paleobiodb.org", "txn", value),
        )
    end
    return identifiers
end

function resolve_taxon(
        query::AbstractString,
        resolver::PBDBResolver;
        build::Union{Int, Nothing} = nothing,
        request = phylopic_get,
        taxonomy_request = HTTP.get,
    )::TaxonResolution{PBDBResolver}
    normalized = _validated_taxon_query(query, "resolve_taxon")
    b = ensure_build(build; request)
    url = PBDB_TAXA_LIST_URL * "?name=$(HTTP.escapeuri(String(query)))" *
        "&rel=all_parents&show=attr&vocab=pbdb"
    response = taxonomy_request(url)
    obj = JSON3.read(response.body)
    hasproperty(obj, :records) || error(
        "resolve_taxon: PBDB response did not contain `records`."
    )
    records = obj.records
    identifiers = _pbdb_identifiers(records)
    query_record = isempty(records) ? nothing : last(records)
    taxon_name = isnothing(query_record) ? nothing :
        _optional_string(query_record, :taxon_name)
    rank = isnothing(query_record) ? nothing : _optional_string(query_record, :taxon_rank)
    return _provider_resolution(
        query,
        normalized,
        resolver,
        b,
        identifiers;
        request,
        provider_taxon_name = taxon_name,
        provider_taxon_rank = rank,
        provider_match_type = nothing,
        provider_confidence = nothing,
    )
end

"""
    resolve_taxa(queries, resolver = PhyloPicResolver(); build = nothing, ...)
        -> Vector{TaxonResolution}

Resolve taxon names in input order. Normalized duplicate queries are resolved
once, and one PhyloPic build is pinned for the entire batch.
"""
function resolve_taxa(
        queries::AbstractVector{<:AbstractString};
        kwargs...,
    )::Vector{TaxonResolution{PhyloPicResolver}}
    return resolve_taxa(queries, PhyloPicResolver(); kwargs...)
end

function resolve_taxa(
        queries::AbstractVector{<:AbstractString},
        resolver::R;
        build::Union{Int, Nothing} = nothing,
        request = phylopic_get,
        taxonomy_request = HTTP.get,
    )::Vector{TaxonResolution{R}} where {R <: AbstractTaxonResolver}
    isempty(queries) && return TaxonResolution{R}[]
    b = ensure_build(build; request)
    cache = Dict{String, TaxonResolution{R}}()
    results = TaxonResolution{R}[]
    sizehint!(results, length(queries))
    for query in queries
        normalized = _validated_taxon_query(query, "resolve_taxa")
        resolution = get!(cache, normalized) do
            resolve_taxon(query, resolver; build = b, request, taxonomy_request)
        end
        push!(results, _with_resolution_query(resolution, query))
    end
    return results
end
