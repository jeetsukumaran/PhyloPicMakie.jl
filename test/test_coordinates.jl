# test/test_coordinates.jl
# Offline unit tests for PhyloPicMakie coordinate and geometry helpers:
#   _compute_image_bbox, _apply_rotation, _range_anchor
#
# All tests are pure-function (no Makie backend needed).
# Symbols are accessed via the PhyloPicMakie module loaded in runtests.jl.

@testset "PhyloPicMakie — _compute_image_bbox" begin

    @testset ":center placement" begin
        x_lo, x_hi, y_lo, y_hi = PhyloPicMakie._compute_image_bbox(
            0.0, 0.0, 8, 4;
            glyph_size = 1.0, aspect = :preserve,
            placement = :center, xoffset = 0.0, yoffset = 0.0,
        )
        # aspect ratio = 8/4 = 2 → half_w = 2*1.0 = 2.0, half_h = 1.0
        @test x_lo ≈ -2.0
        @test x_hi ≈  2.0
        @test y_lo ≈ -1.0
        @test y_hi ≈  1.0
    end

    @testset ":left placement anchors at left edge" begin
        x_lo, x_hi, _, _ = PhyloPicMakie._compute_image_bbox(
            0.0, 0.0, 8, 4;
            glyph_size = 1.0, aspect = :preserve,
            placement = :left, xoffset = 0.0, yoffset = 0.0,
        )
        @test x_lo ≈ 0.0    # left edge at anchor
        @test x_hi ≈ 4.0
    end

    @testset ":right placement anchors at right edge" begin
        x_lo, x_hi, _, _ = PhyloPicMakie._compute_image_bbox(
            0.0, 0.0, 8, 4;
            glyph_size = 1.0, aspect = :preserve,
            placement = :right, xoffset = 0.0, yoffset = 0.0,
        )
        @test x_hi ≈ 0.0    # right edge at anchor
        @test x_lo ≈ -4.0
    end

    @testset ":stretch aspect makes square" begin
        x_lo, x_hi, y_lo, y_hi = PhyloPicMakie._compute_image_bbox(
            0.0, 0.0, 8, 4;
            glyph_size = 1.0, aspect = :stretch,
            placement = :center, xoffset = 0.0, yoffset = 0.0,
        )
        @test (x_hi - x_lo) ≈ (y_hi - y_lo)
        @test x_lo ≈ -1.0
        @test x_hi ≈  1.0
    end

    @testset "xoffset/yoffset applied after anchoring" begin
        x_lo, x_hi, y_lo, y_hi = PhyloPicMakie._compute_image_bbox(
            0.0, 0.0, 4, 4;
            glyph_size = 1.0, aspect = :preserve,
            placement = :center, xoffset = 5.0, yoffset = 3.0,
        )
        @test x_lo ≈ 4.0
        @test y_lo ≈ 2.0
    end

    @testset "unknown aspect throws ArgumentError" begin
        @test_throws ArgumentError PhyloPicMakie._compute_image_bbox(
            0.0, 0.0, 4, 4;
            glyph_size = 1.0, aspect = :bad,
            placement = :center, xoffset = 0.0, yoffset = 0.0,
        )
    end

    @testset "unknown placement throws ArgumentError" begin
        @test_throws ArgumentError PhyloPicMakie._compute_image_bbox(
            0.0, 0.0, 4, 4;
            glyph_size = 1.0, aspect = :preserve,
            placement = :diagonal, xoffset = 0.0, yoffset = 0.0,
        )
    end

    @testset "axis_scale_correction scales half_w for :preserve" begin
        x_lo1, x_hi1, y_lo1, y_hi1 = PhyloPicMakie._compute_image_bbox(
            0.0, 0.0, 8, 4;
            glyph_size = 1.0, aspect = :preserve,
            placement = :center, xoffset = 0.0, yoffset = 0.0,
            axis_scale_correction = 1.0,
        )
        x_lo2, x_hi2, y_lo2, y_hi2 = PhyloPicMakie._compute_image_bbox(
            0.0, 0.0, 8, 4;
            glyph_size = 1.0, aspect = :preserve,
            placement = :center, xoffset = 0.0, yoffset = 0.0,
            axis_scale_correction = 2.0,
        )
        @test (x_hi2 - x_lo2) ≈ 2 * (x_hi1 - x_lo1)
        @test y_lo2 ≈ y_lo1
        @test y_hi2 ≈ y_hi1
    end

    @testset "axis_scale_correction ignored for :stretch" begin
        x_lo1, x_hi1, _, _ = PhyloPicMakie._compute_image_bbox(
            0.0, 0.0, 8, 4;
            glyph_size = 1.0, aspect = :stretch,
            placement = :center, xoffset = 0.0, yoffset = 0.0,
            axis_scale_correction = 1.0,
        )
        x_lo2, x_hi2, _, _ = PhyloPicMakie._compute_image_bbox(
            0.0, 0.0, 8, 4;
            glyph_size = 1.0, aspect = :stretch,
            placement = :center, xoffset = 0.0, yoffset = 0.0,
            axis_scale_correction = 3.0,
        )
        @test x_lo1 ≈ x_lo2
        @test x_hi1 ≈ x_hi2
    end

end  # _compute_image_bbox

@testset "PhyloPicMakie — _apply_rotation" begin
    img = collect(reshape(1:8, 2, 4))   # 2 rows × 4 cols

    @testset "0° is identity" begin
        @test PhyloPicMakie._apply_rotation(img, 0.0) === img
    end

    @testset "90° changes dimensions" begin
        @test size(PhyloPicMakie._apply_rotation(img, 90.0)) == (4, 2)
    end

    @testset "180° same dimensions" begin
        @test size(PhyloPicMakie._apply_rotation(img, 180.0)) == (2, 4)
    end

    @testset "270° equals -90°" begin
        @test PhyloPicMakie._apply_rotation(img, 270.0) == PhyloPicMakie._apply_rotation(img, -90.0)
    end

    @testset "non-multiple-of-90 throws ArgumentError" begin
        @test_throws ArgumentError PhyloPicMakie._apply_rotation(img, 45.0)
        @test_throws ArgumentError PhyloPicMakie._apply_rotation(img, 1.0)
    end
end  # _apply_rotation

@testset "PhyloPicMakie — _range_anchor" begin
    @test PhyloPicMakie._range_anchor(10.0, 20.0, :start)    ≈ 10.0
    @test PhyloPicMakie._range_anchor(10.0, 20.0, :stop)     ≈ 20.0
    @test PhyloPicMakie._range_anchor(10.0, 20.0, :midpoint) ≈ 15.0
    @test_throws ArgumentError PhyloPicMakie._range_anchor(10.0, 20.0, :unknown)
end
