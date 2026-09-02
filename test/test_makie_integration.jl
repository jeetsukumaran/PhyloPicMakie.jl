# Makie-level reactive integration checks for the PhyloPicGlyphs recipe.

_materialize_integration!(fig) = CairoMakie.Makie.update_state_before_display!(fig)

@testset "PhyloPicMakie - _axis_scale_correction_obs" begin
    fig = Figure()
    ax = Axis(fig[1, 1])
    obs = PhyloPicMakie._axis_scale_correction_obs(ax.scene)
    @test obs isa Observable
    _materialize_integration!(fig)
    sc = obs[]
    @test sc isa Float64
    @test sc > 0.0
end

@testset "PhyloPicMakie - data-space recipe reacts to resize and relimit" begin
    fig = Figure(size = (400, 400))
    ax = Axis(fig[1, 1])
    xlims!(ax, -4, 4)
    ylims!(ax, -2, 2)

    recipe = PhyloPicMakie.augment_phylopic!(
        ax,
        [0.0],
        [0.0],
        [_TEST_IMG];
        glyph_size = 1.0,
    )
    _materialize_integration!(fig)
    glyph_scatter = only(_image_scatter_children(recipe))
    @test glyph_scatter.space[] === :data
    @test glyph_scatter.markerspace[] === :pixel

    size_1 = only(glyph_scatter.markersize[])
    @test size_1[1] / size_1[2] ≈ 2.0f0 atol = 0.05f0
    @test size_1[2] > 0.0f0

    resize!(fig.scene, 800, 800)
    _materialize_integration!(fig)
    size_2 = only(glyph_scatter.markersize[])
    @test size_2[2] > size_1[2]
    @test size_2[1] / size_2[2] ≈ 2.0f0 atol = 0.05f0

    ylims!(ax, -4, 4)
    _materialize_integration!(fig)
    size_3 = only(glyph_scatter.markersize[])
    @test size_3[2] < size_2[2]
    @test size_3[1] / size_3[2] ≈ 2.0f0 atol = 0.05f0
end

@testset "PhyloPicMakie - recipe visibility and teardown control autolimits" begin
    fig = Figure(size = (400, 400))
    ax = Axis(fig[1, 1])
    scatter!(ax, [Point2f(0, 0)])

    recipe = PhyloPicMakie.augment_phylopic!(
        ax,
        [10.0],
        [0.0],
        [_TEST_IMG];
        glyph_size = 1.0,
    )
    _materialize_integration!(fig)

    recipe_limits = CairoMakie.Makie.data_limits(recipe)
    @test recipe_limits.origin[1] ≈ 10.0
    @test recipe_limits.origin[2] ≈ 0.0
    @test recipe_limits.widths[1] ≈ 0.0
    @test recipe_limits.widths[2] ≈ 0.0

    @test length(recipe.plots) == 1
    @test length(ax.scene.plots) == 2

    CairoMakie.Makie.autolimits!(ax)
    _materialize_integration!(fig)
    visible_limits = ax.finallimits[]
    @test visible_limits.widths[1] < 15.0

    CairoMakie.Makie.update!(recipe; visible = false)
    _materialize_integration!(fig)
    @test all(!plot.visible[] for plot in recipe.plots)
    CairoMakie.Makie.autolimits!(ax)
    _materialize_integration!(fig)
    hidden_limits = ax.finallimits[]
    @test hidden_limits.widths[1] < visible_limits.widths[1] / 4

    CairoMakie.Makie.update!(recipe; visible = true)
    CairoMakie.Makie.autolimits!(ax)
    _materialize_integration!(fig)
    restored_limits = ax.finallimits[]
    @test restored_limits ≈ visible_limits

    delete!(ax, recipe)
    _materialize_integration!(fig)
    @test length(ax.scene.plots) == 1
    CairoMakie.Makie.autolimits!(ax)
    _materialize_integration!(fig)
    final_limits = ax.finallimits[]
    @test final_limits ≈ hidden_limits
end

@testset "PhyloPicMakie - recipe composes under and deletes with a parent plot" begin
    fig = Figure(size = (400, 400))
    ax = Axis(fig[1, 1])
    parent_plot = scatter!(ax, [Point2f(0, 0)])

    recipe = PhyloPicMakie.augment_phylopic!(
        parent_plot,
        [10.0],
        [0.0],
        [_TEST_IMG];
        glyph_size = 1.0,
    )
    _materialize_integration!(fig)

    @test recipe in parent_plot.plots
    @test length(recipe.plots) == 1

    delete!(ax, parent_plot)
    _materialize_integration!(fig)
    @test isempty(ax.scene.plots)
end

@testset "PhyloPicMakie - projected pixel anchors stay tied to rendered markers" begin
    fig = Figure(size = (500, 400))
    ax = Axis(fig[1, 1])
    xlims!(ax, -2, 2)
    ylims!(ax, -2, 2)

    base_plot = scatter!(ax, [Point2f(0.5, 0.5)]; markersize = 16)
    base_pixels = CairoMakie.Makie.register_projected_positions!(
        base_plot;
        output_name = :phylopic_test_base_pixels,
    )
    pixel_anchor_positions = lift(base_pixels) do positions
        Point2f[Point2f(p[1], p[2]) for p in positions]
    end

    recipe = PhyloPicMakie.phylopicglyphs!(
        ax,
        pixel_anchor_positions,
        [_TEST_IMG];
        space = :pixel,
        glyph_size_space = :pixel,
        glyph_size = 18.0,
        placement = :bottomleft,
        xoffset = 6.0,
        yoffset = -4.0,
    )
    _materialize_integration!(fig)
    glyph_scatter = only(_image_scatter_children(recipe))
    @test glyph_scatter.space[] === :pixel
    @test glyph_scatter.markerspace[] === :pixel

    anchor_1 = only(pixel_anchor_positions[])
    pos_1 = only(glyph_scatter.positions[])
    size_1 = only(glyph_scatter.markersize[])
    @test pos_1[1] ≈ anchor_1[1] + 6.0f0 atol = 1.0f-3
    @test pos_1[2] ≈ anchor_1[2] - 4.0f0 atol = 1.0f-3

    xlims!(ax, -1, 3)
    ylims!(ax, -1, 3)
    _materialize_integration!(fig)
    anchor_2 = only(pixel_anchor_positions[])
    pos_2 = only(glyph_scatter.positions[])
    size_2 = only(glyph_scatter.markersize[])
    @test pos_2[1] ≈ anchor_2[1] + 6.0f0 atol = 1.0f-3
    @test pos_2[2] ≈ anchor_2[2] - 4.0f0 atol = 1.0f-3
    @test size_2[1] ≈ size_1[1] atol = 1.0f-3
    @test size_2[2] ≈ size_1[2] atol = 1.0f-3

    resize!(fig.scene, 700, 500)
    _materialize_integration!(fig)
    anchor_3 = only(pixel_anchor_positions[])
    pos_3 = only(glyph_scatter.positions[])
    size_3 = only(glyph_scatter.markersize[])
    @test pos_3[1] ≈ anchor_3[1] + 6.0f0 atol = 1.0f-3
    @test pos_3[2] ≈ anchor_3[2] - 4.0f0 atol = 1.0f-3
    @test size_3[1] ≈ size_1[1] atol = 1.0f-3
    @test size_3[2] ≈ size_1[2] atol = 1.0f-3
end
