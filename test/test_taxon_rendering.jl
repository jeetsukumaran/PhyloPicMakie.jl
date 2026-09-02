@testset "PhyloPicMakie — taxon-name rendering sources" begin
    resolved_request = FakePhyloPicRequest(
        url -> begin
            if occursin("/nodes?", url)
                return _json_response(
                    _node_page_payload(
                        [_node_payload("brown-bear"; name = "Ursus arctos")]
                    )
                )
            elseif occursin("/nodes/brown-bear", url)
                return _json_response(
                    _node_with_primary_payload("brown-bear"; image_uuid = nothing)
                )
            end
            error("unexpected URL: $url")
        end
    )
    uuids, build = PhyloPicMakie._resolve_taxon_node_uuids(
        ["Ursus arctos", "  Úrsus arctos  "],
        PhyloPicDB.PhyloPicResolver(),
        2;
        build = 537,
        request = resolved_request,
    )
    @test uuids == ["brown-bear", "brown-bear"]
    @test build == 537
    @test count(url -> occursin("/nodes?", url), resolved_request.calls) == 1

    fig = Figure()
    ax = Axis(fig[1, 1])
    taxon_plot = augment_phylopic!(
        ax,
        [1.0, 2.0],
        [1.0, 2.0];
        taxon = ["Ursus arctos", "Ursus arctos"],
        build = 537,
        request = resolved_request,
        on_missing = :skip,
    )
    @test taxon_plot isa PhyloPicMakie.PhyloPicGlyphs
    @test count(url -> occursin("embed_primaryImage=true", url), resolved_request.calls) == 1

    image_failure_request = FakePhyloPicRequest(
        url -> _json_response(_node_with_primary_payload("brown-bear"))
    )
    @test_throws ErrorException PhyloPicMakie._resolve_images_by_uuid(
        ["brown-bear"],
        nothing,
        1;
        build = 537,
        request = image_failure_request,
        loader = _ -> error("offline decode failure"),
    )
    thumbnail_image = PhyloPicDB._parse_image_json(
        JSON3.read(JSON3.write(_image_payload("brown-bear-image"))),
        537,
    )
    @test_throws ErrorException PhyloPicMakie._download_image(
        thumbnail_image,
        "brown bear";
        loader = _ -> error("offline gallery decode failure"),
    )

    table = (
        x = [1.0],
        y = [1.0],
        start = [0.5],
        stop = [1.5],
        scientific_name = ["Ursus arctos"],
    )
    table_plot = augment_phylopic!(
        ax,
        table;
        x = :x,
        y = :y,
        taxon = :scientific_name,
        build = 537,
        request = resolved_request,
    )
    @test table_plot isa PhyloPicMakie.PhyloPicGlyphs
    range_plot = augment_phylopic_ranges!(
        ax,
        table;
        xstart = :start,
        xstop = :stop,
        y = :y,
        taxon = :scientific_name,
        build = 537,
        request = resolved_request,
    )
    @test range_plot isa PhyloPicMakie.PhyloPicGlyphs

    ambiguous_request = FakePhyloPicRequest(
        url -> _json_response(
            _node_page_payload(
                [
                    _node_payload("one"; name = "Alias one"),
                    _node_payload("two"; name = "Alias two"),
                ]
            )
        )
    )
    @test_throws ArgumentError PhyloPicMakie._resolve_taxon_node_uuids(
        ["Shared alias"],
        PhyloPicDB.PhyloPicResolver(),
        1;
        build = 537,
        request = ambiguous_request,
    )
    skipped, _ = PhyloPicMakie._resolve_taxon_node_uuids(
        ["Shared alias"],
        PhyloPicDB.PhyloPicResolver(),
        1;
        build = 537,
        on_ambiguous = :skip,
        request = ambiguous_request,
    )
    @test skipped == [nothing]
    @test_throws ArgumentError augment_phylopic!(
        ax,
        [1.0],
        [1.0];
        taxon = ["Ursus arctos"],
        glyph = fill(0.0, 2, 2),
    )
    @test_throws ArgumentError augment_phylopic!(ax, [1.0], [1.0])

    node = PhyloPicDB._parse_node_json(
        JSON3.read(JSON3.write(_node_payload("brown-bear"; name = "Ursus arctos"))),
        537,
    )
    typed_uuids, typed_labels, typed_build = PhyloPicMakie._typed_gallery_sources(
        [node],
        nothing,
        nothing,
    )
    @test typed_uuids == ["brown-bear"]
    @test typed_labels == ["Ursus arctos"]
    @test typed_build == 537
    @test hasmethod(phylopic_thumbnail_grid, Tuple{Vector{PhyloPicDB.PhyloPicNode}})
    @test hasmethod(phylopic_thumbnail_grid!, Tuple{Axis, PhyloPicDB.PhyloPicNode})

    resolution = PhyloPicDB._resolution(
        "Ursus arctos",
        "ursus arctos",
        PhyloPicDB.PhyloPicResolver(),
        PhyloPicDB.TAXON_RESOLVED;
        match_basis = PhyloPicDB.PREFERRED_NAME_MATCH,
        node,
        candidates = [node],
    )
    result_uuids, result_labels, result_build = PhyloPicMakie._typed_gallery_sources(
        [resolution],
        nothing,
        nothing,
        :error,
    )
    @test result_uuids == ["brown-bear"]
    @test result_labels == ["Ursus arctos"]
    @test result_build == 537
    @test hasmethod(
        phylopic_thumbnail_grid,
        Tuple{Vector{typeof(resolution)}},
    )
end
