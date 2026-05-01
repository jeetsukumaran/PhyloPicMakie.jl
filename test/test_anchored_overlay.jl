# test/test_anchored_overlay.jl
# Focused coverage for the internal anchored-overlay substrate.

const _ANCHOR_TEST_IMG = fill(0.5f0, 4, 8)

@testset "PhyloPicMakie - anchor/glyph internal specs" begin

    @testset "data anchors and pixel anchors normalize to explicit spec types" begin
        data_spec = PhyloPicMakie._anchor_positions_spec([Point2f(0, 0)]; anchor_space = :data)
        pixel_spec = PhyloPicMakie._anchor_positions_spec([Point2f(0, 0)]; anchor_space = :pixel)
        @test data_spec isa PhyloPicMakie._DataAnchors
        @test pixel_spec isa PhyloPicMakie._PixelAnchors
    end

    @testset "invalid anchor space throws ArgumentError" begin
        @test_throws ArgumentError PhyloPicMakie._anchor_positions_spec(
            [Point2f(0, 0)]; anchor_space = :clip)
    end

    @testset "data and pixel glyph-size specs normalize to explicit spec types" begin
        data_spec = PhyloPicMakie._glyph_size_spec(1.0; glyph_size_space = :data)
        pixel_spec = PhyloPicMakie._glyph_size_spec(12.0; glyph_size_space = :pixel)
        @test data_spec isa PhyloPicMakie._DataGlyphSize
        @test pixel_spec isa PhyloPicMakie._PixelGlyphSize
    end

    @testset "invalid glyph-size space throws ArgumentError" begin
        @test_throws ArgumentError PhyloPicMakie._glyph_size_spec(
            1.0; glyph_size_space = :relative)
    end

    @testset "pixel marker size preserves image aspect" begin
        size_px = PhyloPicMakie._compute_pixel_marker_size(8, 4, 10.0; aspect = :preserve)
        @test size_px[1] ≈ 40.0f0
        @test size_px[2] ≈ 20.0f0
    end

    @testset "unsupported mixed anchor/glyph spaces throw deterministically" begin
        fig = Figure()
        ax = Axis(fig[1, 1])
        @test_throws ArgumentError PhyloPicMakie._augment_phylopic_anchored!(
            ax,
            [Point2f(0, 0)],
            [_ANCHOR_TEST_IMG];
            anchor_space = :pixel,
            glyph_size_space = :data,
            glyph_size = 1.0,
            aspect = :preserve,
            placement = :center,
            xoffset = 0.0,
            yoffset = 0.0,
        )
    end

end
