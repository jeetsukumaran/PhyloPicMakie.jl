# test/test_grid_helpers.jl
# Offline unit tests for PhyloPicMakie grid-geometry helpers:
#   _infer_thumbnail_grid_shape, _rows_grid_positions
#
# All tests are pure-function (no Makie backend needed).
# Symbols are accessed via the PhyloPicMakie module loaded in runtests.jl.

@testset "PhyloPicMakie — _infer_thumbnail_grid_shape" begin
    @test PhyloPicMakie._infer_thumbnail_grid_shape(0) == (1, 1)
    @test PhyloPicMakie._infer_thumbnail_grid_shape(1) == (1, 1)
    @test PhyloPicMakie._infer_thumbnail_grid_shape(6) == (3, 2)
    @test PhyloPicMakie._infer_thumbnail_grid_shape(17) == (4, 5)
    @test PhyloPicMakie._infer_thumbnail_grid_shape(6; ncols = 2) == (2, 3)
    @test PhyloPicMakie._infer_thumbnail_grid_shape(6; nrows = 2) == (3, 2)
    @test_throws ArgumentError PhyloPicMakie._infer_thumbnail_grid_shape(6; ncols = 0)
    @test_throws ArgumentError PhyloPicMakie._infer_thumbnail_grid_shape(6; ncols = 2, nrows = 2)
end  # _infer_thumbnail_grid_shape

@testset "PhyloPicMakie — _rows_grid_positions" begin

    @testset "empty groups → no positions, 1×1 grid" begin
        pos, r, c = PhyloPicMakie._rows_grid_positions(
            Int[]; cell_width = 1.0, cell_height = 1.6)
        @test isempty(pos)
        @test r == 1
        @test c == 1
    end

    @testset "two groups of sizes [2, 3]" begin
        pos, r, c = PhyloPicMakie._rows_grid_positions(
            [2, 3]; cell_width = 1.0, cell_height = 1.6)
        @test length(pos) == 5   # 2 + 3 cells total
        @test r == 2             # two non-empty groups → two rows
        @test c == 3             # widest group has 3 cells
    end

end  # _rows_grid_positions
