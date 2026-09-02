@testset "PhyloPicDB — build resolution and caching" begin
    PhyloPicDB._BUILD_CACHE[] = nothing
    PhyloPicDB._BUILD_TIME[] = 0.0
    request = FakePhyloPicRequest(
        url -> begin
            @test url == PhyloPicDB.PHYLOPIC_BASE_URL
            return _json_response(Dict("build" => 537))
        end
    )

    @test PhyloPicDB.fetch_current_build(; request) == 537
    @test PhyloPicDB.fetch_current_build(; request) == 537
    @test length(request.calls) == 1
    @test PhyloPicDB.ensure_build(612; request) == 612
    @test length(request.calls) == 1

    @test PhyloPicDB.fetch_current_build(; force = true, request) == 537
    @test length(request.calls) == 2

    other_request = FakePhyloPicRequest(
        url -> begin
            @test url == PhyloPicDB.PHYLOPIC_BASE_URL
            return _json_response(Dict("build" => 612))
        end
    )
    @test PhyloPicDB.fetch_current_build(; request = other_request) == 612
    @test PhyloPicDB.fetch_current_build(; request = other_request) == 612
    @test length(other_request.calls) == 1
end
