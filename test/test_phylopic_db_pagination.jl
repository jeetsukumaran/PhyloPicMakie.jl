@testset "PhyloPicDB — HAL pagination" begin
    request = FakePhyloPicRequest(
        url -> begin
            if occursin("page=0", url)
                return _json_response(_node_page_payload([_node_payload("node-1")]; next_page = 1))
            elseif occursin("page=1", url)
                return _json_response(_node_page_payload([_node_payload("node-2")]))
            end
            error("unexpected URL: $url")
        end
    )
    nodes = PhyloPicDB._fetch_hal_pages(
        PhyloPicDB.PhyloPicNode,
        "$(PhyloPicDB.PHYLOPIC_BASE_URL)/nodes?build=537&page=0",
        item -> PhyloPicDB._parse_node_json(item, 537);
        request,
    )
    @test getproperty.(nodes, :uuid) == ["node-1", "node-2"]
    @test length(request.calls) == 2
    @test startswith(request.calls[2], PhyloPicDB.PHYLOPIC_BASE_URL)

    limited_request = FakePhyloPicRequest(
        url -> _json_response(_node_page_payload([_node_payload()]; next_page = 1))
    )
    limited = PhyloPicDB._fetch_hal_pages(
        PhyloPicDB.PhyloPicNode,
        "$(PhyloPicDB.PHYLOPIC_BASE_URL)/nodes?page=0",
        item -> PhyloPicDB._parse_node_json(item, 537);
        max_pages = 1,
        request = limited_request,
    )
    @test length(limited) == 1
    @test length(limited_request.calls) == 1
    @test_throws ArgumentError PhyloPicDB._fetch_hal_pages(
        PhyloPicDB.PhyloPicNode,
        "$(PhyloPicDB.PHYLOPIC_BASE_URL)/nodes?page=0",
        item -> PhyloPicDB._parse_node_json(item, 537);
        max_pages = 0,
        request = limited_request,
    )

    cyclic_request = FakePhyloPicRequest(
        url -> _json_response(
            Dict(
                "_links" => Dict("next" => Dict("href" => url)),
                "_embedded" => Dict("items" => Any[]),
            )
        )
    )
    @test_throws ErrorException PhyloPicDB._fetch_hal_pages(
        PhyloPicDB.PhyloPicNode,
        "$(PhyloPicDB.PHYLOPIC_BASE_URL)/nodes?page=0",
        item -> PhyloPicDB._parse_node_json(item, 537);
        request = cyclic_request,
    )

    malformed_request = FakePhyloPicRequest(
        url -> _json_response(Dict("_links" => Dict("next" => nothing)))
    )
    @test_throws ErrorException PhyloPicDB._fetch_hal_pages(
        PhyloPicDB.PhyloPicNode,
        "$(PhyloPicDB.PHYLOPIC_BASE_URL)/nodes?page=0",
        item -> PhyloPicDB._parse_node_json(item, 537);
        request = malformed_request,
    )
end
