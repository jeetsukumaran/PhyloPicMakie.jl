# test/test_makie_integration.jl
# Makie-level reactive integration checks for the anchored-overlay substrate.

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

@testset "PhyloPicMakie - data-anchor overlays react to resize and relimit" begin
    fig = Figure(size = (400, 400))
    ax = Axis(fig[1, 1])
    xlims!(ax, -4, 4)
    ylims!(ax, -2, 2)

    overlay = PhyloPicMakie._augment_phylopic_anchored!(
        ax,
        [Point2f(0, 0)],
        [_TEST_IMG];
        anchor_space = :data,
        glyph_size_space = :data,
        glyph_size = 1.0,
        aspect = :preserve,
        placement = :center,
        xoffset = 0.0,
        yoffset = 0.0,
    )
    _materialize_integration!(fig)

    size_1 = only(overlay.markersize[])
    @test size_1[1] / size_1[2] ≈ 2.0f0 atol = 0.05f0
    @test size_1[2] > 0.0f0

    resize!(fig.scene, 800, 800)
    _materialize_integration!(fig)
    size_2 = only(overlay.markersize[])
    @test size_2[2] > size_1[2]
    @test size_2[1] / size_2[2] ≈ 2.0f0 atol = 0.05f0

    ylims!(ax, -4, 4)
    _materialize_integration!(fig)
    size_3 = only(overlay.markersize[])
    @test size_3[2] < size_2[2]
    @test size_3[1] / size_3[2] ≈ 2.0f0 atol = 0.05f0
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

    overlay = PhyloPicMakie._augment_phylopic_anchored!(
        ax,
        pixel_anchor_positions,
        [_TEST_IMG];
        anchor_space = :pixel,
        glyph_size_space = :pixel,
        glyph_size = 18.0,
        aspect = :preserve,
        placement = :bottomleft,
        xoffset = 6.0,
        yoffset = -4.0,
    )
    _materialize_integration!(fig)

    anchor_1 = only(pixel_anchor_positions[])
    pos_1 = only(overlay.positions[])
    size_1 = only(overlay.markersize[])
    @test pos_1[1] ≈ anchor_1[1] + 6.0f0 atol = 1.0f-3
    @test pos_1[2] ≈ anchor_1[2] - 4.0f0 atol = 1.0f-3

    xlims!(ax, -1, 3)
    ylims!(ax, -1, 3)
    _materialize_integration!(fig)
    anchor_2 = only(pixel_anchor_positions[])
    pos_2 = only(overlay.positions[])
    size_2 = only(overlay.markersize[])
    @test pos_2[1] ≈ anchor_2[1] + 6.0f0 atol = 1.0f-3
    @test pos_2[2] ≈ anchor_2[2] - 4.0f0 atol = 1.0f-3
    @test size_2[1] ≈ size_1[1] atol = 1.0f-3
    @test size_2[2] ≈ size_1[2] atol = 1.0f-3

    resize!(fig.scene, 700, 500)
    _materialize_integration!(fig)
    anchor_3 = only(pixel_anchor_positions[])
    pos_3 = only(overlay.positions[])
    size_3 = only(overlay.markersize[])
    @test pos_3[1] ≈ anchor_3[1] + 6.0f0 atol = 1.0f-3
    @test pos_3[2] ≈ anchor_3[2] - 4.0f0 atol = 1.0f-3
    @test size_3[1] ≈ size_1[1] atol = 1.0f-3
    @test size_3[2] ≈ size_1[2] atol = 1.0f-3
end
