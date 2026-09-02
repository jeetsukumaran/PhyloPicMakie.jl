# Focused coverage for recipe space validation and pixel marker geometry.

const _ANCHOR_TEST_IMG = fill(0.5f0, 4, 8)

@testset "PhyloPicMakie - glyph spaces and marker geometry" begin
    @testset "matching data and pixel spaces are supported" begin
        @test isnothing(PhyloPicMakie._validate_glyph_spaces(:data, :data))
        @test isnothing(PhyloPicMakie._validate_glyph_spaces(:pixel, :pixel))
    end

    @testset "invalid and mixed spaces throw ArgumentError" begin
        @test_throws ArgumentError PhyloPicMakie._validate_glyph_spaces(:clip, :clip)
        @test_throws ArgumentError PhyloPicMakie._validate_glyph_spaces(:data, :relative)
        @test_throws ArgumentError PhyloPicMakie._validate_glyph_spaces(:pixel, :data)

        fig = Figure()
        ax = Axis(fig[1, 1])
        @test_throws ArgumentError PhyloPicMakie.phylopicglyphs!(
            ax,
            [Point2f(0, 0)],
            [_ANCHOR_TEST_IMG];
            space = :pixel,
            glyph_size_space = :data,
        )
    end

    @testset "pixel marker size preserves image aspect" begin
        size_px = only(
            PhyloPicMakie._pixel_marker_sizes(
                [(8, 4)],
                Float32[10];
                aspect = :preserve,
            )
        )
        @test size_px[1] ≈ 40.0f0
        @test size_px[2] ≈ 20.0f0
    end
end
