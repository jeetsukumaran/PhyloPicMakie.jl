module ExplicitOverlaysExample

include("_common.jl")

using CairoMakie: Axis, Figure, Point2f, hidedecorations!, hidespines!, lines!, scatter!, text!, xlims!, ylims!
using PhyloPicMakie: augment_phylopic!, augment_phylopic_ranges!

function _configure_axis!(ax::Axis)::Nothing
    hidedecorations!(ax; grid = false)
    hidespines!(ax)
    return nothing
end

function _explicit_anchor_panel!(ax::Axis)::Nothing
    xs = Float64[0.8, 2.0, 3.2, 4.4]
    ys = Float64[1.2, 2.3, 1.8, 2.8]
    labels = ["Marine node", "Avian node", "Fern node", "Mirrored node"]
    images = Matrix{RGBA{N0f8}}[
        fish_glyph(),
        bird_glyph(),
        fern_glyph(),
        mirrored_image(bird_glyph(; color = RGBA{N0f8}(0.18, 0.22, 0.28, 1.0))),
    ]

    lines!(ax, xs, ys; color = (:gray45, 0.45), linewidth = 2.0)
    scatter!(
        ax,
        xs,
        ys;
        color = :white,
        markersize = 18,
        strokecolor = :gray25,
        strokewidth = 2.0,
    )
    text!(
        ax,
        labels;
        position = Point2f.(xs, ys .- 0.34),
        align = (:center, :top),
        fontsize = 16,
        color = :gray25,
    )
    augment_phylopic!(
        ax,
        xs,
        ys,
        images;
        glyph_size = 0.34,
        aspect = :preserve,
        placement = :bottom,
        xoffset = 0.0,
        yoffset = 0.18,
        rotation = 0.0,
        mirror = false,
        on_missing = :skip,
    )
    xlims!(ax, 0.2, 5.0)
    ylims!(ax, 0.4, 3.6)
    ax.title = "Explicit data anchors"
    return nothing
end

function _range_anchor_panel!(ax::Axis)::Nothing
    xstart = Float64[0.6, 1.1, 1.7]
    xstop = Float64[3.2, 4.0, 4.8]
    ys = Float64[3.0, 2.0, 1.0]
    labels = ["Shelf interval", "Lagoon interval", "Floodplain interval"]
    images = Matrix{RGBA{N0f8}}[
        mirrored_image(fish_glyph(; color = RGBA{N0f8}(0.12, 0.30, 0.37, 1.0))),
        bird_glyph(; color = RGBA{N0f8}(0.47, 0.24, 0.16, 1.0)),
        fern_glyph(; color = RGBA{N0f8}(0.13, 0.31, 0.15, 1.0)),
    ]

    for index in eachindex(xstart)
        lines!(
            ax,
            [xstart[index], xstop[index]],
            [ys[index], ys[index]];
            color = (:gray40, 0.55),
            linewidth = 8.0,
        )
        scatter!(
            ax,
            [xstart[index], xstop[index]],
            [ys[index], ys[index]];
            color = :white,
            markersize = 10,
            strokecolor = :gray25,
            strokewidth = 1.5,
        )
        text!(
            ax,
            labels[index];
            position = Point2f(6.35f0, ys[index] - 0.18f0),
            align = (:right, :center),
            fontsize = 15,
            color = :gray25,
        )
    end

    augment_phylopic_ranges!(
        ax,
        xstart,
        xstop,
        ys,
        images;
        at = :midpoint,
        glyph_size = 0.28,
        aspect = :preserve,
        placement = :bottom,
        xoffset = 0.0,
        yoffset = 0.20,
        rotation = 0.0,
        mirror = false,
        on_missing = :skip,
    )
    xlims!(ax, 0.2, 6.6)
    ylims!(ax, 0.4, 3.8)
    ax.title = "Range midpoint anchors"
    return nothing
end

function main(; output_dir::Union{Nothing, AbstractString} = nothing)::String
    fig = Figure(size = (1180, 560))
    left_axis = Axis(fig[1, 1])
    right_axis = Axis(fig[1, 2])

    _configure_axis!(left_axis)
    _configure_axis!(right_axis)
    _explicit_anchor_panel!(left_axis)
    _range_anchor_panel!(right_axis)

    return save_example(fig, "explicit_overlays"; output_dir)
end

if abspath(PROGRAM_FILE) == @__FILE__
    println(main())
end

end # module ExplicitOverlaysExample
