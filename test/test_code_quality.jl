# test/test_code_quality.jl
# Code-quality checks for PhyloPicMakie:
#   Aqua — package API consistency, ambiguities, stale deps, etc.
#   JET  — type inference / static analysis

@testset "PhyloPicMakie — Aqua" begin
    Aqua.test_all(PhyloPicMakie)
end

@testset "PhyloPicMakie — JET" begin
    JET.test_package(PhyloPicMakie; target_modules = (PhyloPicMakie,))
end
