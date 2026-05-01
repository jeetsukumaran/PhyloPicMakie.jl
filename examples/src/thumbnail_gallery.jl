module ThumbnailGalleryExample

include("_common.jl")

using PhyloPicMakie: phylopic_thumbnail_grid

function main(; output_dir::Union{Nothing, AbstractString} = nothing)::String
    cell_images = Any[
        fish_glyph(; color = PhyloPicMakie.RGBA{PhyloPicMakie.N0f8}(0.10, 0.22, 0.34, 1.0)),
        mirrored_image(fish_glyph(; color = PhyloPicMakie.RGBA{PhyloPicMakie.N0f8}(0.15, 0.32, 0.41, 1.0))),
        bird_glyph(; color = PhyloPicMakie.RGBA{PhyloPicMakie.N0f8}(0.40, 0.20, 0.13, 1.0)),
        mirrored_image(bird_glyph(; color = PhyloPicMakie.RGBA{PhyloPicMakie.N0f8}(0.49, 0.27, 0.18, 1.0))),
        fern_glyph(; color = PhyloPicMakie.RGBA{PhyloPicMakie.N0f8}(0.11, 0.27, 0.15, 1.0)),
        fern_glyph(; color = PhyloPicMakie.RGBA{PhyloPicMakie.N0f8}(0.18, 0.39, 0.20, 1.0)),
    ]
    labels = String[
        "Marine set\nShelf fish",
        "Marine set\nLagoon fish",
        "Avian set\nDryland bird",
        "Avian set\nCoastal bird",
        "Botanical set\nFern crown",
        "Botanical set\nWetland frond",
    ]
    group_sizes = Int[2, 2, 2]

    fig = phylopic_thumbnail_grid(
        cell_images,
        labels,
        group_sizes;
        title = "Deterministic public API gallery",
        image_layout = :blocks,
        ncols = 3,
        label_lines = 2,
        cell_width = 1.15,
        cell_height = 1.85,
        glyph_fraction = 0.58,
        label_gap = 0.12,
        label_fontsize = 16.0,
    )
    return save_example(fig, "thumbnail_gallery"; output_dir)
end

if abspath(PROGRAM_FILE) == @__FILE__
    println(main())
end

end # module ThumbnailGalleryExample
