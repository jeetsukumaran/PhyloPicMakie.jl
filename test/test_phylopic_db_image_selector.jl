@testset "PhyloPicDB — image selection and enrichment" begin
    images = PhyloPicDB.PhyloPicImage[
        PhyloPicDB._parse_image_json(
            JSON3.read(JSON3.write(_image_payload("image-1"))),
            537,
        ),
        PhyloPicDB._parse_image_json(
            JSON3.read(JSON3.write(_image_payload("image-2"))),
            537,
        ),
    ]

    @test PhyloPicDB.select_image(images, :first) === images[1]
    @test PhyloPicDB.select_image(images, 2) === images[2]
    @test isnothing(PhyloPicDB.select_image(images, 0))
    @test isnothing(PhyloPicDB.select_image(images, 3))
    @test PhyloPicDB.select_image(images, last) === images[2]
    @test_throws ArgumentError PhyloPicDB.select_image(images, :last)

    request = FakePhyloPicRequest(url -> _json_response(_node_payload()))
    enriched = PhyloPicDB.with_node_names(images; build = 537, request)
    @test getproperty.(enriched, :node_name) == ["Canis lupus", "Canis lupus"]
    @test length(request.calls) == 1

    primary_request = FakePhyloPicRequest(
        url -> _json_response(_node_with_primary_payload())
    )
    primary = PhyloPicDB.primary_image("node-1"; build = 537, request = primary_request)
    @test primary isa PhyloPicDB.PhyloPicImage

    page_request = FakePhyloPicRequest(
        url -> _json_response(
            _image_page_payload([_image_payload("image-1")]; total_pages = 1)
        )
    )
    @test length(PhyloPicDB.clade_images("node-1"; build = 537, request = page_request)) == 1
    @test occursin("filter_clade", page_request.calls[end])
    @test length(PhyloPicDB.node_images("node-1"; build = 537, request = page_request)) == 1
    @test occursin("filter_node", page_request.calls[end])
end
