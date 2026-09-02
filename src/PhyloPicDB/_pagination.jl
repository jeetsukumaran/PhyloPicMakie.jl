# ---------------------------------------------------------------------------
# PhyloPicDB — shared HAL page traversal
# ---------------------------------------------------------------------------

function _absolute_phylopic_url(href::AbstractString)::String
    value = String(href)
    (startswith(value, "https://") || startswith(value, "http://")) && return value
    startswith(value, "/") && return PHYLOPIC_BASE_URL * value
    return "$PHYLOPIC_BASE_URL/$value"
end

function _next_page_url(obj)::Union{String, Nothing}
    next_link = try
        obj._links.next
    catch
        error("_fetch_hal_pages: response did not contain `_links.next`.")
    end
    isnothing(next_link) && return nothing
    hasproperty(next_link, :href) || error(
        "_fetch_hal_pages: non-empty `_links.next` did not contain `href`."
    )
    href = string(next_link.href)
    isempty(href) && error("_fetch_hal_pages: `_links.next.href` was empty.")
    return _absolute_phylopic_url(href)
end

function _embedded_items(obj)::AbstractVector
    items = try
        obj._embedded.items
    catch
        error("_fetch_hal_pages: response did not contain `_embedded.items`.")
    end
    items isa AbstractVector || error(
        "_fetch_hal_pages: `_embedded.items` was not an array."
    )
    return items
end

"""
    _fetch_hal_pages(T, first_url, parse_item; max_pages = nothing, request)

Follow PhyloPic HAL `_links.next` relations and parse embedded page items.
This strict internal primitive propagates transport and parsing failures.
"""
function _fetch_hal_pages(
        ::Type{T},
        first_url::AbstractString,
        parse_item;
        max_pages::Union{Int, Nothing} = nothing,
        request = phylopic_get,
    )::Vector{T} where {T}
    (!isnothing(max_pages) && max_pages < 1) && throw(
        ArgumentError("_fetch_hal_pages: `max_pages` must be positive or `nothing`.")
    )

    results = T[]
    seen_urls = Set{String}()
    next_url = String(first_url)
    pages_fetched = 0

    while true
        next_url in seen_urls && error(
            "_fetch_hal_pages: cyclic `_links.next` relation at $(repr(next_url))."
        )
        push!(seen_urls, next_url)

        response = request(next_url)
        obj = JSON3.read(response.body)
        for item in _embedded_items(obj)
            parsed = parse_item(item)
            isnothing(parsed) || push!(results, parsed::T)
        end

        pages_fetched += 1
        pages_fetched == max_pages && break
        following = _next_page_url(obj)
        isnothing(following) && break
        next_url = following
    end

    return results
end
