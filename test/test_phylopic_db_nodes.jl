@testset "PhyloPicDB — node requests" begin
    request = FakePhyloPicRequest(
        url -> begin
            if occursin("embed_primaryImage=true", url)
                return _json_response(_node_with_primary_payload())
            end
            return _json_response(_node_payload())
        end
    )

    node = PhyloPicDB.fetch_node("node-1"; build = 537, request)
    @test node isa PhyloPicDB.PhyloPicNode
    @test node.preferred_name == "Canis lupus"
    @test request.calls[1] ==
        "$(PhyloPicDB.PHYLOPIC_BASE_URL)/nodes/node-1?build=537"

    embedded_node, image = PhyloPicDB.fetch_node_with_primary_image(
        "node-1";
        build = 537,
        request,
    )
    @test embedded_node isa PhyloPicDB.PhyloPicNode
    @test image isa PhyloPicDB.PhyloPicImage
    @test image.uuid == "image-1"

    failing_request = FakePhyloPicRequest(url -> error("offline: $url"))
    @test_throws ErrorException PhyloPicDB.fetch_node(
        "missing";
        build = 537,
        request = failing_request,
    )
    @test_throws ErrorException PhyloPicDB.fetch_node_with_primary_image(
        "missing";
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
        PhyloPicDB.fetch_node("missing"; build = 537, request = not_found_request)
    )
    @test PhyloPicDB.fetch_node_with_primary_image(
        "missing";
        build = 537,
        request = not_found_request,
    ) == (nothing, nothing)

    malformed_request = FakePhyloPicRequest(url -> _json_response(Dict("names" => Any[])))
    @test_throws ErrorException PhyloPicDB.fetch_node(
        "malformed";
        build = 537,
        request = malformed_request,
    )
end
