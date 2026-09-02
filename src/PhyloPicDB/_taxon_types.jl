# ---------------------------------------------------------------------------
# PhyloPicDB — taxon discovery value types
# ---------------------------------------------------------------------------

"""
    AbstractTaxonResolver

Supertype for explicit taxonomic-name resolution strategies.
"""
abstract type AbstractTaxonResolver end

"""
    PhyloPicResolver()

Resolve normalized taxon names directly against PhyloPic. This is the default
resolver and requires no third-party taxonomy service.
"""
struct PhyloPicResolver <: AbstractTaxonResolver end

"""
    GBIFResolver(; kingdom = nothing)

Resolve names with the GBIF species-match service, then map the returned GBIF
lineage identifiers through PhyloPic's `gbif.org/species` namespace.

Set `kingdom` (for example, `"Animalia"`) to constrain GBIF matching.
Only GBIF matches reported as exact are accepted automatically.
"""
struct GBIFResolver <: AbstractTaxonResolver
    kingdom::Union{String, Nothing}
end

function GBIFResolver(; kingdom::Union{AbstractString, Nothing} = nothing)::GBIFResolver
    value = isnothing(kingdom) ? nothing : String(kingdom)
    return GBIFResolver(value)
end

"""
    PBDBResolver()

Resolve names and ancestor lineages with the Paleobiology Database, then map
the ordered `orig_no` identifiers through PhyloPic's
`paleobiodb.org/txn` namespace.
"""
struct PBDBResolver <: AbstractTaxonResolver end

"""
    TaxonResolutionStatus

Semantic outcome of a taxon-name lookup: `TAXON_RESOLVED`,
`TAXON_AMBIGUOUS`, or `TAXON_NOT_FOUND`.
"""
@enum TaxonResolutionStatus begin
    TAXON_RESOLVED
    TAXON_AMBIGUOUS
    TAXON_NOT_FOUND
end

"""
    TaxonMatchBasis

Evidence used to select a resolved PhyloPic node.
"""
@enum TaxonMatchBasis begin
    PREFERRED_NAME_MATCH
    UNIQUE_ALIAS_MATCH
    EXTERNAL_IDENTIFIER_MATCH
end

"""
    ExternalTaxonIdentifier

One external taxonomic identifier considered during provider-backed
resolution. Identifiers are stored in priority order on [`TaxonResolution`](@ref).
"""
struct ExternalTaxonIdentifier
    authority::String
    namespace::String
    object_id::String
end

"""
    ExternalTaxonNamespace

An authority and namespace pair supported by PhyloPic's external identifier
resolver.
"""
struct ExternalTaxonNamespace
    authority::String
    namespace::String
end

function _validate_taxon_resolution(
        status::TaxonResolutionStatus,
        match_basis::Union{TaxonMatchBasis, Nothing},
        node::Union{PhyloPicNode, Nothing},
    )::Nothing
    if status === TAXON_RESOLVED
        isnothing(node) && throw(
            ArgumentError("TaxonResolution: TAXON_RESOLVED requires a selected node.")
        )
        isnothing(match_basis) && throw(
            ArgumentError("TaxonResolution: TAXON_RESOLVED requires a match basis.")
        )
    else
        !isnothing(node) && throw(
            ArgumentError(
                "TaxonResolution: $status cannot contain a selected node."
            )
        )
        !isnothing(match_basis) && throw(
            ArgumentError(
                "TaxonResolution: $status cannot contain a match basis."
            )
        )
    end
    return nothing
end

"""
    TaxonResolution

Typed, inspectable result of [`resolve_taxon`](@ref). Semantic misses and
ambiguities are represented by `status`; transport and malformed-response
errors are thrown by the discovery API.

The `candidates` field preserves every direct PhyloPic name match. The
`suggestions` field contains normalized autocomplete suggestions when no
direct match exists. Provider-backed resolvers additionally preserve ordered
`external_identifiers` and provider metadata.
"""
struct TaxonResolution{R <: AbstractTaxonResolver}
    query::String
    normalized_query::String
    resolver::R
    status::TaxonResolutionStatus
    match_basis::Union{TaxonMatchBasis, Nothing}
    node::Union{PhyloPicNode, Nothing}
    candidates::Vector{PhyloPicNode}
    suggestions::Vector{String}
    external_identifiers::Vector{ExternalTaxonIdentifier}
    provider_taxon_name::Union{String, Nothing}
    provider_taxon_rank::Union{String, Nothing}
    provider_match_type::Union{String, Nothing}
    provider_confidence::Union{Int, Nothing}

    function TaxonResolution{R}(
            query::String,
            normalized_query::String,
            resolver::R,
            status::TaxonResolutionStatus,
            match_basis::Union{TaxonMatchBasis, Nothing},
            node::Union{PhyloPicNode, Nothing},
            candidates::Vector{PhyloPicNode},
            suggestions::Vector{String},
            external_identifiers::Vector{ExternalTaxonIdentifier},
            provider_taxon_name::Union{String, Nothing},
            provider_taxon_rank::Union{String, Nothing},
            provider_match_type::Union{String, Nothing},
            provider_confidence::Union{Int, Nothing},
        ) where {R <: AbstractTaxonResolver}
        _validate_taxon_resolution(status, match_basis, node)
        return new{R}(
            query,
            normalized_query,
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
end

function TaxonResolution(
        query::String,
        normalized_query::String,
        resolver::R,
        status::TaxonResolutionStatus,
        match_basis::Union{TaxonMatchBasis, Nothing},
        node::Union{PhyloPicNode, Nothing},
        candidates::Vector{PhyloPicNode},
        suggestions::Vector{String},
        external_identifiers::Vector{ExternalTaxonIdentifier},
        provider_taxon_name::Union{String, Nothing},
        provider_taxon_rank::Union{String, Nothing},
        provider_match_type::Union{String, Nothing},
        provider_confidence::Union{Int, Nothing},
    )::TaxonResolution{R} where {R <: AbstractTaxonResolver}
    return TaxonResolution{R}(
        query,
        normalized_query,
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

"""
    isresolved(resolution) -> Bool

Return `true` exactly when `resolution` contains a selected PhyloPic node.
"""
function isresolved(resolution::TaxonResolution)::Bool
    return resolution.status === TAXON_RESOLVED && !isnothing(resolution.node)
end

"""
    node_uuid(resolution) -> Union{String, Nothing}

Return the selected PhyloPic node UUID, or `nothing` for an ambiguous or
unresolved result.
"""
function node_uuid(resolution::TaxonResolution)::Union{String, Nothing}
    return isresolved(resolution) ? (resolution.node::PhyloPicNode).uuid : nothing
end

"""
    require_node(resolution) -> PhyloPicNode

Return the selected node or throw an `ArgumentError` describing the semantic
resolution failure.
"""
function require_node(resolution::TaxonResolution)::PhyloPicNode
    isresolved(resolution) && return resolution.node::PhyloPicNode
    throw(
        ArgumentError(
            "taxon query $(repr(resolution.query)) was " *
                lowercase(replace(string(resolution.status), "TAXON_" => ""))
        )
    )
end

function Base.show(io::IO, resolution::TaxonResolution)::Nothing
    print(io, "TaxonResolution(", repr(resolution.query), ", ", resolution.status)
    if isresolved(resolution)
        node = resolution.node::PhyloPicNode
        print(io, ", ", repr(node.preferred_name), ", uuid=", repr(node.uuid))
    elseif resolution.status === TAXON_AMBIGUOUS
        print(io, ", candidates=", length(resolution.candidates))
    elseif !isempty(resolution.suggestions)
        print(io, ", suggestions=", length(resolution.suggestions))
    end
    print(io, ")")
    return nothing
end

function Base.show(
        io::IO,
        ::MIME"text/plain",
        resolution::TaxonResolution,
    )::Nothing
    println(io, "Taxon resolution")
    println(io, "  query:      ", resolution.query)
    println(io, "  normalized: ", resolution.normalized_query)
    println(io, "  resolver:   ", nameof(typeof(resolution.resolver)))
    println(io, "  status:     ", resolution.status)
    if isresolved(resolution)
        node = resolution.node::PhyloPicNode
        println(io, "  node:       ", node.preferred_name)
        println(io, "  UUID:       ", node.uuid)
        println(io, "  basis:      ", resolution.match_basis)
    end
    isempty(resolution.candidates) || println(
        io,
        "  candidates: ",
        join(getproperty.(resolution.candidates, :preferred_name), ", "),
    )
    isempty(resolution.suggestions) || println(
        io,
        "  suggestions: ",
        join(resolution.suggestions, ", "),
    )
    isempty(resolution.external_identifiers) || println(
        io,
        "  external IDs: ",
        join(getproperty.(resolution.external_identifiers, :object_id), ", "),
    )
    return nothing
end
