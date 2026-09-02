@testset "PhyloPicDB — types and parsing" begin
    @test PhyloPicDB._cc_license_label(
        "https://creativecommons.org/licenses/by-nc-sa/4.0/"
    ) == "CC BY NC SA 4.0"
    @test PhyloPicDB._cc_license_label(
        "https://creativecommons.org/publicdomain/zero/1.0/"
    ) == "CC0 1.0"
    @test PhyloPicDB._parse_img_width("256x192") == 256
    @test PhyloPicDB._parse_img_width("invalid") == 0

    files = JSON3.read(
        JSON3.write(
            [
                Dict("href" => "small.png", "sizes" => "64x64"),
                Dict("href" => "large.png", "sizes" => "512x256"),
            ]
        )
    )
    @test PhyloPicDB._largest_file_href(files) == "large.png"
    @test ismissing(PhyloPicDB._largest_file_href([]))

    node = PhyloPicDB._parse_node_json(
        JSON3.read(JSON3.write(_node_payload())),
        537,
    )
    @test node.uuid == "node-1"
    @test node.preferred_name == "Canis lupus"
    @test node.all_names == ["Canis lupus"]
    @test node.parent_node_uuid == "parent-1"
    @test node.primary_image_uuid == "image-1"

    image = PhyloPicDB._parse_image_json(
        JSON3.read(JSON3.write(_image_payload())),
        537,
    )
    @test image.uuid == "image-1"
    @test image.thumbnail_url == "https://example.test/image-1-256.png"
    @test image.raster_url == "https://example.test/image-1-512.png"
    @test image.license == "CC BY 4.0"
    @test image.attribution == "Example artist"
    @test image.specific_node_uuid == "node-1"

    null_attribution_payload = _image_payload()
    null_attribution_payload["attribution"] = nothing
    image_without_attribution = PhyloPicDB._parse_image_json(
        JSON3.read(JSON3.write(null_attribution_payload)),
        537,
    )
    @test ismissing(image_without_attribution.attribution)

    named = PhyloPicDB._with_node_name(image, "Canis lupus")
    @test named.node_name == "Canis lupus"
    @test named.uuid == image.uuid

    null_image = PhyloPicDB._null_image(537)
    @test null_image.uuid == ""
    @test ismissing(null_image.thumbnail_url)
    @test isnothing(null_image.node_name)
end
