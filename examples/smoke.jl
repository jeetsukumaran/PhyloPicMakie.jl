include(joinpath(@__DIR__, "src", "explicit_overlays.jl"))
include(joinpath(@__DIR__, "src", "thumbnail_gallery.jl"))
include(joinpath(@__DIR__, "src", "graph_anchors.jl"))

const EXAMPLE_RUNNERS = (
    ExplicitOverlaysExample.main,
    ThumbnailGalleryExample.main,
    GraphAnchorsExample.main,
)

function _normalize_paths(result)::Vector{String}
    if result isa AbstractString
        return [String(result)]
    elseif result isa AbstractVector
        return [String(path) for path in result]
    else
        throw(
            ArgumentError(
                "Example runner must return a path or vector of paths. Got $(typeof(result))."
            )
        )
    end
end

function main()::Vector{String}
    output_paths = String[]
    for runner in EXAMPLE_RUNNERS
        append!(output_paths, _normalize_paths(runner()))
    end

    missing_paths = filter(path -> !isfile(path), output_paths)
    isempty(missing_paths) || error(
        "Example smoke run did not create expected artifacts: $(join(missing_paths, ", "))."
    )
    return output_paths
end

if abspath(PROGRAM_FILE) == @__FILE__
    for output_path in main()
        println(output_path)
    end
end
