# test/test_makie_integration.jl
# Makie-level smoke test for PhyloPicMakie axis integration:
#   _axis_scale_correction_obs
#
# Requires CairoMakie (loaded in runtests.jl) to materialise the Figure/Axis.

@testset "PhyloPicMakie — _axis_scale_correction_obs" begin
    # CairoMakie loaded in runtests.jl; Figure + Axis are available.
    # Before the figure is displayed the projectionview may be degenerate,
    # in which case _axis_scale_correction_obs returns the safe default 1.0.
    fig = Figure()
    ax  = Axis(fig[1, 1])
    obs = PhyloPicMakie._axis_scale_correction_obs(ax.scene)
    @test obs isa Observable
    sc = obs[]
    @test sc isa Float64
    @test sc > 0.0
end
