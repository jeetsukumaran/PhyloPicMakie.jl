@testset "PhyloPicDB — HTTP transport" begin
    calls = Ref(0)
    function transport(url::AbstractString; readtimeout::Int)::HTTP.Response
        calls[] += 1
        @test url == "https://example.test/ping"
        @test readtimeout == 7
        calls[] == 1 && error("transient failure")
        return HTTP.Response(204)
    end

    response = PhyloPicDB.phylopic_get(
        "https://example.test/ping";
        retries = 2,
        readtimeout = 7,
        transport,
        retry_delay = 0.0,
    )
    @test response.status == 204
    @test calls[] == 2

    @test_throws ArgumentError PhyloPicDB.phylopic_get(
        "https://example.test";
        retries = 0,
        transport,
    )
    @test_throws ArgumentError PhyloPicDB.phylopic_get(
        "https://example.test";
        retry_delay = -1,
        transport,
    )
end
