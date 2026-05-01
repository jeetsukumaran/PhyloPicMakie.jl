# test/test_render_core.jl
# Tests for PhyloPicMakie rendering entry points using pre-resolved image data
# (no taxon-name resolution, no PBDB dependency, no network access):
#
#   augment_phylopic!       — pre-resolved image matrix vector
#   augment_phylopic_ranges! — pre-resolved image matrix vector with range anchors
#   phylopic_thumbnail_grid! — pre-built cell arrays (images, labels, group_sizes)
#
# Also covers argument-validation errors raised by the rendering layer itself.
#
# CairoMakie and PhyloPicMakie are loaded in runtests.jl.

# ---------------------------------------------------------------------------
# Shared test fixtures
# ---------------------------------------------------------------------------

# Synthetic 4-row × 8-column grey Float32 image for offline render tests.
# augment_phylopic! accepts AbstractVector of images with no element-type constraint.
const _TEST_IMG = fill(0.5f0, 4, 8)

_materialize!(fig) = CairoMakie.Makie.update_state_before_display!(fig)

function _overlay_plots(ax)
    return filter(ax.scene.plots) do plot
        hasproperty(plot, :marker) || return false
        marker = plot.marker[]
        marker isa AbstractVector || return false
        isempty(marker) && return false
        return first(marker) isa AbstractMatrix
    end
end

_count_glyph_overlays(ax) = length(_overlay_plots(ax))

# Shared keyword args for the generic augment_phylopic! (no defaults).
const _AUGMENT_KW = (
    glyph_size = 1.0,
    aspect     = :preserve,
    placement  = :center,
    xoffset    = 0.0,
    yoffset    = 0.0,
    rotation   = 0.0,
    mirror     = false,
    on_missing = :skip,
)

# ---------------------------------------------------------------------------
# augment_phylopic! — pre-resolved images
# ---------------------------------------------------------------------------

@testset "PhyloPicMakie — augment_phylopic! (pre-resolved images)" begin

    @testset "nothing image, on_missing=:skip -> no glyph overlay added" begin
        fig = Figure(); ax = Axis(fig[1, 1])
        PhyloPicMakie.augment_phylopic!(ax, [0.0], [0.0], [nothing];
            _AUGMENT_KW..., on_missing = :skip)
        _materialize!(fig)
        @test _count_glyph_overlays(ax) == 0
    end

    @testset "nothing image, on_missing=:placeholder -> placeholder overlay added" begin
        fig = Figure(); ax = Axis(fig[1, 1])
        PhyloPicMakie.augment_phylopic!(ax, [0.0], [0.0], [nothing];
            _AUGMENT_KW..., on_missing = :placeholder)
        _materialize!(fig)
        @test _count_glyph_overlays(ax) == 1
    end

    @testset "pre-resolved image matrix rendered without taxon resolution" begin
        fig = Figure(); ax = Axis(fig[1, 1])
        PhyloPicMakie.augment_phylopic!(ax, [0.0], [0.0], [_TEST_IMG];
            _AUGMENT_KW...)
        _materialize!(fig)
        @test _count_glyph_overlays(ax) == 1
    end

    @testset "mismatched xs/ys/images length throws ArgumentError" begin
        fig = Figure(); ax = Axis(fig[1, 1])
        @test_throws ArgumentError PhyloPicMakie.augment_phylopic!(
            ax, [0.0, 1.0], [0.0], [_TEST_IMG, _TEST_IMG]; _AUGMENT_KW...)
    end

    @testset "on_missing=:error and nothing image throws ErrorException" begin
        fig = Figure(); ax = Axis(fig[1, 1])
        @test_throws ErrorException PhyloPicMakie.augment_phylopic!(
            ax, [0.0], [0.0], [nothing]; _AUGMENT_KW..., on_missing = :error)
    end

end  # augment_phylopic! pre-resolved

# ---------------------------------------------------------------------------
# augment_phylopic_ranges! — pre-resolved images
# ---------------------------------------------------------------------------

@testset "PhyloPicMakie — augment_phylopic_ranges! (pre-resolved images)" begin

    @testset "at=:midpoint, pre-resolved image -> one overlay" begin
        fig = Figure(); ax = Axis(fig[1, 1])
        PhyloPicMakie.augment_phylopic_ranges!(
            ax, [10.0], [20.0], [1.0], [_TEST_IMG];
            glyph_size = 1.0, aspect = :preserve, placement = :center,
            xoffset = 0.0, yoffset = 0.0, rotation = 0.0, mirror = false,
            on_missing = :skip, at = :midpoint)
        _materialize!(fig)
        @test _count_glyph_overlays(ax) == 1
    end

    @testset "at=:start, pre-resolved image -> one overlay" begin
        fig = Figure(); ax = Axis(fig[1, 1])
        PhyloPicMakie.augment_phylopic_ranges!(
            ax, [10.0], [20.0], [1.0], [_TEST_IMG];
            glyph_size = 1.0, aspect = :preserve, placement = :center,
            xoffset = 0.0, yoffset = 0.0, rotation = 0.0, mirror = false,
            on_missing = :skip, at = :start)
        _materialize!(fig)
        @test _count_glyph_overlays(ax) == 1
    end

    @testset "mismatched xstart/xstop throws ArgumentError" begin
        fig = Figure(); ax = Axis(fig[1, 1])
        @test_throws ArgumentError PhyloPicMakie.augment_phylopic_ranges!(
            ax, [10.0, 11.0], [20.0], [1.0], [_TEST_IMG, _TEST_IMG];
            glyph_size = 1.0, aspect = :preserve, placement = :center,
            xoffset = 0.0, yoffset = 0.0, rotation = 0.0, mirror = false,
            on_missing = :skip)
    end

end  # augment_phylopic_ranges! pre-resolved

# ---------------------------------------------------------------------------
# phylopic_thumbnail_grid! — pre-built cell data
# ---------------------------------------------------------------------------

@testset "PhyloPicMakie — phylopic_thumbnail_grid! (pre-built cells)" begin

    @testset "empty cell list renders without error" begin
        fig = Figure(); ax = Axis(fig[1, 1])
        @test_nowarn PhyloPicMakie.phylopic_thumbnail_grid!(
            ax, [], String[], Int[])
    end

    @testset "single nothing cell with on_missing=:placeholder → no crash" begin
        fig = Figure(); ax = Axis(fig[1, 1])
        @test_nowarn PhyloPicMakie.phylopic_thumbnail_grid!(
            ax, [nothing], ["label"], [1]; on_missing = :placeholder)
    end

    @testset "single pre-resolved image cell renders" begin
        fig = Figure(); ax = Axis(fig[1, 1])
        n0 = length(ax.scene.plots)
        PhyloPicMakie.phylopic_thumbnail_grid!(
            ax, [_TEST_IMG], ["test label"], [1])
        @test length(ax.scene.plots) > n0
    end

    @testset "factory (non-bang) returns a Figure" begin
        fig = PhyloPicMakie.phylopic_thumbnail_grid(
            [_TEST_IMG], ["test label"], [1])
        @test fig isa Figure
    end

end  # phylopic_thumbnail_grid! pre-built cells

# ---------------------------------------------------------------------------
# Argument validation — tested directly on the rendering-layer API
# ---------------------------------------------------------------------------
#
# These ArgumentErrors are raised by PhyloPicMakie itself before any network
# call or image resolution takes place.

@testset "PhyloPicMakie — argument validation" begin

    @testset "glyph_fraction = 1.0 → ArgumentError (must be strictly < 1)" begin
        fig = Figure(); ax = Axis(fig[1, 1])
        @test_throws ArgumentError PhyloPicMakie.phylopic_thumbnail_grid!(
            ax, [], String[], Int[]; glyph_fraction = 1.0)
    end

    @testset "glyph_fraction = 0.0 → ArgumentError (must be strictly > 0)" begin
        fig = Figure(); ax = Axis(fig[1, 1])
        @test_throws ArgumentError PhyloPicMakie.phylopic_thumbnail_grid!(
            ax, [], String[], Int[]; glyph_fraction = 0.0)
    end

    @testset "image_layout = :diagonal → ArgumentError (not in VALID_IMAGE_LAYOUTS)" begin
        fig = Figure(); ax = Axis(fig[1, 1])
        @test_throws ArgumentError PhyloPicMakie.phylopic_thumbnail_grid!(
            ax, [], String[], Int[]; image_layout = :diagonal)
    end

    @testset "image_layout = :grouped → ArgumentError (renamed to :blocks)" begin
        fig = Figure(); ax = Axis(fig[1, 1])
        @test_throws ArgumentError PhyloPicMakie.phylopic_thumbnail_grid!(
            ax, [], String[], Int[]; image_layout = :grouped)
    end

    @testset "image_filter = :universe → ArgumentError (UUID-API validation)" begin
        # image_filter is validated in the UUID-based phylopic_thumbnail_grid!
        # before any network call when the UUID list is empty.
        fig = Figure(); ax = Axis(fig[1, 1])
        @test_throws ArgumentError PhyloPicMakie.phylopic_thumbnail_grid!(
            ax, String[]; image_filter = :universe)
    end

end  # argument validation
