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
    @test isnothing(PhyloPicDB.fetch_node("missing"; build = 537, request = failing_request))
    @test PhyloPicDB.fetch_node_with_primary_image(
        "missing";
        build = 537,
        request = failing_request,
    ) == (nothing, nothing)
end
