const _RECIPE_FLOAT_GLYPH = reshape(Float32[0.0, 0.25, 0.75, 1.0], 2, 2)

@testset "PhyloPicMakie — PhyloPicGlyphs recipe contract" begin
    points = Point2f[Point2f(0, 0)]

    result = PhyloPicMakie.phylopicglyphs(
        points,
        [_RECIPE_FLOAT_GLYPH];
        glyph_size = 0.5,
    )
    @test result isa CairoMakie.Makie.FigureAxisPlot
    @test result.plot isa PhyloPicMakie.PhyloPicGlyphs

    fig, ax, plot = result
    _materialize!(fig)
    image_scatter = only(_image_scatter_children(plot))
    marker = only(image_scatter.marker[])
    @test marker isa Matrix{CairoMakie.Makie.RGBA{CairoMakie.Makie.N0f8}}
    @test marker[1, 1] == CairoMakie.Makie.RGBA{CairoMakie.Makie.N0f8}(0, 0, 0, 1)
    @test marker[2, 2] == CairoMakie.Makie.RGBA{CairoMakie.Makie.N0f8}(1, 1, 1, 1)

    updated_glyph = fill(
        CairoMakie.Makie.RGBA{CairoMakie.Makie.N0f8}(1, 0, 0, 0.5),
        3,
        5,
    )
    CairoMakie.Makie.update!(
        plot;
        arg1 = Point2f[Point2f(2, 3)],
        arg2 = [updated_glyph],
        glyph_size = 0.75,
    )
    _materialize!(fig)
    @test only(image_scatter.marker[]) == updated_glyph

    CairoMakie.Makie.update!(plot; visible = false)
    _materialize!(fig)
    @test all(!child.visible[] for child in plot.plots)

    delete!(ax, plot)
    _materialize!(fig)
    @test all(candidate !== plot for candidate in ax.scene.plots)

    fig2 = Figure()
    ax2 = Axis(fig2[1, 1])
    bang_plot = PhyloPicMakie.phylopicglyphs!(ax2, points, [_RECIPE_FLOAT_GLYPH])
    @test bang_plot isa PhyloPicMakie.PhyloPicGlyphs
    @test bang_plot in ax2.scene.plots

    parent_plot = scatter!(ax2, Point2f[Point2f(0, 0)])
    child_plot = PhyloPicMakie.phylopicglyphs!(
        parent_plot,
        points,
        [_RECIPE_FLOAT_GLYPH],
    )
    @test child_plot isa PhyloPicMakie.PhyloPicGlyphs
    @test child_plot in parent_plot.plots

    transformed_source = reshape(Float32.(0:5) ./ 5, 2, 3)
    multi_plot = PhyloPicMakie.phylopicglyphs!(
        ax2,
        Point2f[Point2f(0, 0), Point2f(1, 1)],
        [transformed_source, transformed_source];
        rotation = 90,
        mirror = true,
    )
    multi_scatter = only(_image_scatter_children(multi_plot))
    @test length(multi_scatter.marker[]) == 2
    @test all(image -> image isa Matrix{CairoMakie.Makie.RGBA{CairoMakie.Makie.N0f8}}, multi_scatter.marker[])
    @test all(image -> size(image) == (3, 2), multi_scatter.marker[])
end
