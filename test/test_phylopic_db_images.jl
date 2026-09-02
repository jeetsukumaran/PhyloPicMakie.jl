@testset "PhyloPicDB — image requests and pagination" begin
    image_request = FakePhyloPicRequest(
        url -> begin
            if occursin("/images/image-1", url)
                return _json_response(_image_payload())
            elseif occursin("/nodes/node-1", url)
                return _json_response(_node_payload())
            end
            error("unexpected URL: $url")
        end
    )

    image = PhyloPicDB.fetch_image(
        "image-1";
        build = 537,
        add_node_name = true,
        request = image_request,
    )
    @test image isa PhyloPicDB.PhyloPicImage
    @test image.node_name == "Canis lupus"
    @test length(image_request.calls) == 2

    page_request = FakePhyloPicRequest(
        url -> begin
            if occursin("page=0", url)
                return _json_response(
                    _image_page_payload([_image_payload("image-1")]; total_pages = 2)
                )
            elseif occursin("page=1", url)
                return _json_response(
                    _image_page_payload([_image_payload("image-2")]; total_pages = 2)
                )
            end
            error("unexpected URL: $url")
        end
    )

    images = PhyloPicDB.fetch_images(
        "node-1";
        build = 537,
        filter = :clade,
        request = page_request,
    )
    @test getproperty.(images, :uuid) == ["image-1", "image-2"]
    @test length(page_request.calls) == 2
    @test all(occursin("filter_clade=node-1", url) for url in page_request.calls)

    limited_request = FakePhyloPicRequest(
        url -> _json_response(
            _image_page_payload([_image_payload("image-1")]; total_pages = 3)
        )
    )
    limited = PhyloPicDB.fetch_images(
        "node-1";
        build = 537,
        filter = :node,
        max_pages = 1,
        request = limited_request,
    )
    @test getproperty.(limited, :uuid) == ["image-1"]
    @test length(limited_request.calls) == 1
    @test occursin("filter_node=node-1", only(limited_request.calls))

    @test_throws ArgumentError PhyloPicDB.fetch_images(
        "node-1";
        build = 537,
        filter = :invalid,
        request = limited_request,
    )
    @test_throws ArgumentError PhyloPicDB.fetch_images(
        "node-1";
        build = 537,
        max_pages = 0,
        request = limited_request,
    )

    failing_request = FakePhyloPicRequest(url -> error("offline: $url"))
    @test isnothing(
        PhyloPicDB.fetch_image("missing"; build = 537, request = failing_request)
    )
    @test isempty(
        PhyloPicDB.fetch_images("missing"; build = 537, request = failing_request)
    )
end
