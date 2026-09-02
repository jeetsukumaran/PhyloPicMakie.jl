# ---------------------------------------------------------------------------
# PhyloPicDB — build number management
#
# The PhyloPic API versions all responses by a discrete "build" index.
# Callers that pass `build=nothing` to any API function get the current build
# fetched automatically (with a 1-hour TTL cache, thread-safe).
#
# Public API:
#   fetch_current_build(; force) → Int
#   ensure_build(build; force)   → Int
# ---------------------------------------------------------------------------

"How long (in seconds) to reuse a cached build number before re-fetching."
const BUILD_TTL = 3600.0

# Thread-safe module-level build cache.
const _BUILD_LOCK = ReentrantLock()
const _BUILD_CACHE = Ref{Union{Nothing, Int}}(nothing)
const _BUILD_TIME = Ref{Float64}(0.0)
const _BUILD_REQUEST = Ref{Any}(nothing)

"""
    fetch_current_build(; force = false, request = phylopic_get) -> Int

Return the current PhyloPic build index.

The result is cached in memory with a TTL of [`BUILD_TTL`](@ref) seconds
(default one hour). Concurrent callers using the same `request` callable
share the cached value. Changing the callable invalidates the cache so custom
transports cannot receive a build fetched through a different transport.

# Arguments

- `force`: if `true`, bypass the cache and unconditionally re-fetch the build
  number from the API.  Default `false`.
- `request`: callable that accepts a URL and returns an `HTTP.Response`.
  Defaults to [`phylopic_get`](@ref).

# Returns

The current build index as an `Int`.

# Throws

Propagates any network error raised by the underlying `phylopic_get` call.

# Examples

```julia
build = fetch_current_build()   # fetches from API on first call
build2 = fetch_current_build()  # returns cached value
build3 = fetch_current_build(; force = true)  # forces a new request
```
"""
function fetch_current_build(;
        force::Bool = false,
        request = phylopic_get,
    )::Int
    return lock(_BUILD_LOCK) do
        cached = _BUILD_CACHE[]
        expired = (time() - _BUILD_TIME[]) > BUILD_TTL
        changed_request = _BUILD_REQUEST[] !== request
        if isnothing(cached) || expired || force || changed_request
            resp = request(PHYLOPIC_BASE_URL)
            obj = JSON3.read(resp.body)
            b_raw = obj.build
            b_raw isa Integer || error("fetch_current_build: unexpected build type $(typeof(b_raw))")
            b = Int(b_raw)
            _BUILD_CACHE[] = b
            _BUILD_TIME[] = time()
            _BUILD_REQUEST[] = request
            return b
        end
        return cached::Int
    end
end

"""
    ensure_build(build; force = false, request = phylopic_get) -> Int

Return `build` if it is not `nothing`; otherwise call
[`fetch_current_build`](@ref).

This is the canonical entry point used by all API functions that accept an
optional `build` parameter.  It lets callers avoid redundant build fetches
by passing a previously obtained build index, while defaulting to automatic
fetching when `nothing` is passed.

# Arguments

- `build`: an explicit build index, or `nothing` to fetch automatically.
- `force`: forwarded to [`fetch_current_build`](@ref) when `build` is
  `nothing`.  Default `false`.
- `request`: forwarded to [`fetch_current_build`](@ref) when `build` is
  `nothing`.

# Returns

An `Int` build index.

# Examples

```julia
ensure_build(537)      # → 537  (no network call)
ensure_build(nothing)  # → fetch_current_build()
```
"""
function ensure_build(
        build::Union{Int, Nothing};
        force::Bool = false,
        request = phylopic_get,
    )::Int
    return isnothing(build) ? fetch_current_build(; force, request) : build
end
