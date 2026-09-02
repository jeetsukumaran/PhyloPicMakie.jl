@testset "PhyloPicDB — identifier resolution" begin
    resolved_request = FakePhyloPicRequest(url -> _json_response(Dict("uuid" => "node-1")))
    @test PhyloPicDB.resolve_node(
        "gbif.org",
        "species",
        ["1", "2"];
        build = 537,
        request = resolved_request,
    ) == "node-1"
    @test only(resolved_request.calls) ==
        "$(PhyloPicDB.PHYLOPIC_BASE_URL)/resolve/gbif.org/species?build=537&objectIDs=1,2"

    href_request = FakePhyloPicRequest(
        url -> _json_response(Dict("href" => "/nodes/node-2?build=537"))
    )
    @test PhyloPicDB.resolve_node(
        "gbif.org",
        "species",
        ["3"];
        build = 537,
        request = href_request,
    ) == "node-2"

    pbdb_request = FakePhyloPicRequest(url -> _json_response(Dict("uuid" => "node-3")))
    @test PhyloPicDB.resolve_pbdb_node(
        [10, 20];
        build = 537,
        request = pbdb_request,
    ) == "node-3"
    @test occursin("/resolve/paleobiodb.org/txn", only(pbdb_request.calls))
    @test occursin("objectIDs=10,20", only(pbdb_request.calls))

    @test isnothing(PhyloPicDB.resolve_node("gbif.org", "species", String[]))
    @test isnothing(PhyloPicDB.resolve_pbdb_node(Int[]))

    failing_request = FakePhyloPicRequest(url -> error("offline: $url"))
    @test_throws ErrorException PhyloPicDB.resolve_node(
        "gbif.org",
        "species",
        ["1"];
        build = 537,
        request = failing_request,
    )

    not_found_request = FakePhyloPicRequest(
        url -> throw(
            HTTP.Exceptions.StatusError(
                404,
                "GET",
                String(url),
                HTTP.Response(404),
            )
        )
    )
    @test isnothing(
        PhyloPicDB.resolve_node(
            "gbif.org",
            "species",
            ["1"];
            build = 537,
            request = not_found_request,
        )
    )
end
