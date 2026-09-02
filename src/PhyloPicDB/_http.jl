# ---------------------------------------------------------------------------
# PhyloPicDB — HTTP primitive
#
# Single effectful entry point for all PhyloPic API requests.
# ---------------------------------------------------------------------------

"""
Base URL for the PhyloPic REST API.
"""
const PHYLOPIC_BASE_URL = "https://api.phylopic.org"

"""
    phylopic_get(
        url;
        retries = 3,
        readtimeout = 30,
        transport = HTTP.get,
        retry_delay = 0.5,
    ) -> HTTP.Response

Perform an HTTP GET against the PhyloPic API at `url`.

Retries up to `retries` times with exponential back-off on transient failures
(non-4xx errors).  4xx client errors (400, 404, 410) are never retried — they
are re-raised immediately.

# Arguments

- `url`: The full request URL, including any query parameters.
- `retries`: Maximum number of attempts before re-raising the last error.
  Default `3`.
- `readtimeout`: Socket read timeout in seconds.  Default `30`.
- `transport`: HTTP GET callable. It must accept `url; readtimeout` and return
  an `HTTP.Response`. Defaults to `HTTP.get`.
- `retry_delay`: base delay in seconds between attempts. The delay is
  multiplied by the attempt number. Defaults to `0.5`.

# Returns

An `HTTP.Response` on success.

# Throws

Re-raises the last `HTTP.Exceptions.StatusError` (or any other exception) after
all retry attempts are exhausted.

# Examples

```julia
resp = phylopic_get("https://api.phylopic.org/ping")
resp.status  # 204
```
"""
function phylopic_get(
        url::AbstractString;
        retries::Int = 3,
        readtimeout::Int = 30,
        transport = HTTP.get,
        retry_delay::Real = 0.5,
    )::HTTP.Response
    retries > 0 || throw(ArgumentError("phylopic_get: `retries` must be positive."))
    retry_delay >= 0 || throw(
        ArgumentError("phylopic_get: `retry_delay` must be non-negative.")
    )
    for attempt in 1:retries
        try
            return transport(url; readtimeout)
        catch err
            # Client errors are definitive — retrying won't help.
            if err isa HTTP.Exceptions.StatusError && err.status in (400, 404, 410)
                rethrow(err)
            end
            attempt == retries && rethrow(err)
            sleep(Float64(retry_delay) * attempt)
        end
    end
    error("phylopic_get: unreachable (retries = $retries)")
end
