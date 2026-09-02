@testset "PhyloPicDB — native name search" begin
    @test PhyloPicDB.normalize_taxon_query("  Úrsus   arctos!  ") == "ursus arctos"
    @test PhyloPicDB.normalize_taxon_query("A.-b") == "a -b"
    @test_throws ArgumentError PhyloPicDB.search_nodes("x"; build = 537)

    search_request = FakePhyloPicRequest(
        url -> begin
            if occursin("page=0", url)
                return _json_response(
                    _node_page_payload([_node_payload("node-1")]; next_page = 1)
                )
            elseif occursin("page=1", url)
                return _json_response(_node_page_payload([_node_payload("node-2")]))
            end
            error("unexpected URL: $url")
        end
    )
    nodes = PhyloPicDB.search_nodes("Ursus arctos"; build = 537, request = search_request)
    @test getproperty.(nodes, :uuid) == ["node-1", "node-2"]
    @test occursin("filter_name=ursus%20arctos", first(search_request.calls))
    @test occursin("embed_items=true", first(search_request.calls))

    autocomplete_request = FakePhyloPicRequest(
        url -> _json_response(Dict("build" => 537, "matches" => ["ursus", "ursus arctos"]))
    )
    @test PhyloPicDB.autocomplete_nodes(
        "Úrs";
        build = 537,
        request = autocomplete_request,
    ) == ["ursus", "ursus arctos"]
    @test occursin("query=urs", only(autocomplete_request.calls))

    namespace_request = FakePhyloPicRequest(
        url -> _json_response(
            Dict(
                "namespaces" => [
                    Dict("authority" => "gbif.org", "namespace" => "species"),
                    Dict("authority" => "paleobiodb.org", "namespace" => "txn"),
                ],
            )
        )
    )
    namespaces = PhyloPicDB.fetch_external_namespaces(
        build = 537,
        request = namespace_request,
    )
    @test getproperty.(namespaces, :authority) == ["gbif.org", "paleobiodb.org"]
    @test getproperty.(namespaces, :namespace) == ["species", "txn"]

    failing_request = FakePhyloPicRequest(url -> error("offline: $url"))
    @test_throws ErrorException PhyloPicDB.search_nodes(
        "Ursus";
        build = 537,
        request = failing_request,
    )
    @test_throws ErrorException PhyloPicDB.autocomplete_nodes(
        "Ursus";
        build = 537,
        request = failing_request,
    )
end
