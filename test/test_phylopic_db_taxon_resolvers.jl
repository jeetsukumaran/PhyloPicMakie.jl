@testset "PhyloPicDB — taxon resolvers" begin
    exact_request = FakePhyloPicRequest(
        url -> _json_response(
            _node_page_payload(
                [
                    _node_payload("parenthetical-bear"; name = "Ursus (arctos)"),
                    _node_payload("brown-bear"; name = "Ursus arctos"),
                    _node_payload("other-bear"; name = "Ursus arctos middendorffi"),
                ]
            )
        )
    )
    exact = PhyloPicDB.resolve_taxon(
        "Ursus arctos";
        build = 537,
        request = exact_request,
    )
    @test exact.status === PhyloPicDB.TAXON_RESOLVED
    @test exact.match_basis === PhyloPicDB.PREFERRED_NAME_MATCH
    @test PhyloPicDB.node_uuid(exact) == "brown-bear"
    @test length(exact.candidates) == 3

    alias_request = FakePhyloPicRequest(
        url -> _json_response(
            _node_page_payload(
                [
                    _node_payload(
                        "asiatic-bear";
                        name = "Selenarctos thibetanus",
                        aliases = ["Ursus thibetanus"],
                    ),
                ]
            )
        )
    )
    alias = PhyloPicDB.resolve_taxon(
        "Ursus thibetanus";
        build = 537,
        request = alias_request,
    )
    @test alias.status === PhyloPicDB.TAXON_RESOLVED
    @test alias.match_basis === PhyloPicDB.UNIQUE_ALIAS_MATCH
    @test alias.node.preferred_name == "Selenarctos thibetanus"

    ambiguous_request = FakePhyloPicRequest(
        url -> _json_response(
            _node_page_payload(
                [
                    _node_payload("node-1"; name = "Alias one"),
                    _node_payload("node-2"; name = "Alias two"),
                ]
            )
        )
    )
    ambiguous = PhyloPicDB.resolve_taxon(
        "Shared alias";
        build = 537,
        request = ambiguous_request,
    )
    @test ambiguous.status === PhyloPicDB.TAXON_AMBIGUOUS
    @test length(ambiguous.candidates) == 2

    missing_request = FakePhyloPicRequest(
        url -> begin
            occursin("/autocomplete", url) && return _json_response(
                Dict("matches" => ["ursus arctos"])
            )
            return _json_response(_node_page_payload(Any[]))
        end
    )
    missing = PhyloPicDB.resolve_taxon(
        "Ursus absentus";
        build = 537,
        request = missing_request,
    )
    @test missing.status === PhyloPicDB.TAXON_NOT_FOUND
    @test missing.suggestions == ["ursus arctos"]

    batch_request = FakePhyloPicRequest(
        url -> begin
            url == PhyloPicDB.PHYLOPIC_BASE_URL && return _json_response(Dict("build" => 537))
            return _json_response(
                _node_page_payload([_node_payload("brown-bear"; name = "Ursus arctos")])
            )
        end
    )
    batch = PhyloPicDB.resolve_taxa(
        ["Ursus arctos", "  Úrsus arctos  "];
        request = batch_request,
    )
    @test length(batch) == 2
    @test getproperty.(batch, :query) == ["Ursus arctos", "  Úrsus arctos  "]
    @test PhyloPicDB.node_uuid.(batch) == ["brown-bear", "brown-bear"]
    @test count(==(PhyloPicDB.PHYLOPIC_BASE_URL), batch_request.calls) == 1
    @test count(url -> occursin("/nodes?", url), batch_request.calls) == 1

    gbif_taxonomy = FakePhyloPicRequest(
        url -> _json_response(
            Dict(
                "usageKey" => 2435099,
                "speciesKey" => 2435099,
                "genusKey" => 2435098,
                "familyKey" => 9703,
                "matchType" => "EXACT",
                "confidence" => 100,
                "scientificName" => "Ursus arctos Linnaeus, 1758",
                "rank" => "SPECIES",
            )
        )
    )
    gbif_phylopic = FakePhyloPicRequest(
        url -> begin
            occursin("/resolve/", url) && return _json_response(Dict("uuid" => "brown-bear"))
            occursin("/nodes/brown-bear", url) && return _json_response(
                _node_payload("brown-bear"; name = "Ursus arctos")
            )
            error("unexpected URL: $url")
        end
    )
    gbif = PhyloPicDB.resolve_taxon(
        "Ursus arctos",
        PhyloPicDB.GBIFResolver(kingdom = "Animalia");
        build = 537,
        request = gbif_phylopic,
        taxonomy_request = gbif_taxonomy,
    )
    @test gbif.status === PhyloPicDB.TAXON_RESOLVED
    @test gbif.match_basis === PhyloPicDB.EXTERNAL_IDENTIFIER_MATCH
    @test getproperty.(gbif.external_identifiers, :object_id) == ["2435099", "2435098", "9703"]
    @test occursin("objectIDs=2435099,2435098,9703", first(gbif_phylopic.calls))
    @test occursin("kingdom=Animalia", only(gbif_taxonomy.calls))

    fuzzy_taxonomy = FakePhyloPicRequest(
        url -> _json_response(Dict("matchType" => "FUZZY", "confidence" => 80))
    )
    fuzzy_phylopic = FakePhyloPicRequest(
        url -> _json_response(Dict("matches" => String[]))
    )
    fuzzy = PhyloPicDB.resolve_taxon(
        "Ursus arctosx",
        PhyloPicDB.GBIFResolver();
        build = 537,
        request = fuzzy_phylopic,
        taxonomy_request = fuzzy_taxonomy,
    )
    @test fuzzy.status === PhyloPicDB.TAXON_AMBIGUOUS
    @test fuzzy.provider_match_type == "FUZZY"
    @test all(!occursin("/resolve/", url) for url in fuzzy_phylopic.calls)

    pbdb_taxonomy = FakePhyloPicRequest(
        url -> _json_response(
            Dict(
                "records" => [
                    Dict("orig_no" => "txn:10", "taxon_name" => "Carnivora", "taxon_rank" => "order"),
                    Dict("orig_no" => "txn:20", "taxon_name" => "Ursus", "taxon_rank" => "genus"),
                    Dict("orig_no" => "txn:30", "taxon_name" => "Ursus arctos", "taxon_rank" => "species"),
                ],
            )
        )
    )
    pbdb_phylopic = FakePhyloPicRequest(
        url -> begin
            occursin("/resolve/", url) && return _json_response(Dict("uuid" => "brown-bear"))
            occursin("/nodes/brown-bear", url) && return _json_response(
                _node_payload("brown-bear"; name = "Ursus arctos")
            )
            error("unexpected URL: $url")
        end
    )
    pbdb = PhyloPicDB.resolve_taxon(
        "Ursus arctos",
        PhyloPicDB.PBDBResolver();
        build = 537,
        request = pbdb_phylopic,
        taxonomy_request = pbdb_taxonomy,
    )
    @test pbdb.status === PhyloPicDB.TAXON_RESOLVED
    @test getproperty.(pbdb.external_identifiers, :object_id) == ["30", "20", "10"]
    @test occursin("objectIDs=30,20,10", first(pbdb_phylopic.calls))
    @test occursin("rel=all_parents", only(pbdb_taxonomy.calls))

    failing_request = FakePhyloPicRequest(url -> error("offline: $url"))
    @test_throws ErrorException PhyloPicDB.resolve_taxon(
        "Ursus arctos";
        build = 537,
        request = failing_request,
    )
end
