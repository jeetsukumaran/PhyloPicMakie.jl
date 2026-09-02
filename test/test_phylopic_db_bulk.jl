@testset "PhyloPicDB — batch request deduplication" begin
    suffix = string(getpid())
    node1 = "batch-node-1-$suffix"
    node2 = "batch-node-2-$suffix"

    primary_request = FakePhyloPicRequest(
        url -> begin
            uuid = occursin(node1, url) ? node1 : node2
            return _json_response(_node_with_primary_payload(uuid; image_uuid = "image-$uuid"))
        end
    )
    primary = PhyloPicDB.batch_primary_images(
        [node1, node1, node2];
        build = 537,
        request = primary_request,
    )
    @test sort(collect(keys(primary))) == sort([node1, node2])
    @test length(primary_request.calls) == 2

    replacement_request = FakePhyloPicRequest(
        url -> begin
            uuid = occursin(node1, url) ? node1 : node2
            return _json_response(
                _node_with_primary_payload(uuid; image_uuid = "replacement-$uuid")
            )
        end
    )
    replacement = PhyloPicDB.batch_primary_images(
        [node1]; build = 537, request = replacement_request
    )
    @test only(values(replacement)).uuid == "replacement-$node1"
    @test length(replacement_request.calls) == 1

    node3 = "batch-node-3-$suffix"
    images_request = FakePhyloPicRequest(
        url -> _json_response(
            _image_page_payload([_image_payload("image-$node3")])
        )
    )
    batch = PhyloPicDB.batch_images(
        [node3, node3];
        build = 537,
        max_pages = 1,
        request = images_request,
    )
    @test collect(keys(batch)) == [node3]
    @test only(batch[node3]).uuid == "image-$node3"
    @test length(images_request.calls) == 1
end
