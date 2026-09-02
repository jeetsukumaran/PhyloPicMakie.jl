struct FakePhyloPicRequest{F}
    responder::F
    calls::Vector{String}
end

FakePhyloPicRequest(responder) = FakePhyloPicRequest(responder, String[])

function (request::FakePhyloPicRequest)(url::AbstractString)::HTTP.Response
    push!(request.calls, String(url))
    return request.responder(String(url))
end

function _json_response(payload)::HTTP.Response
    return HTTP.Response(200, JSON3.write(payload))
end

function _node_payload(
        uuid::AbstractString = "node-1";
        name::AbstractString = "Canis lupus",
        parent_uuid::Union{AbstractString, Nothing} = "parent-1",
        primary_image_uuid::Union{AbstractString, Nothing} = "image-1",
    )::Dict{String, Any}
    parent_link = isnothing(parent_uuid) ? nothing :
        Dict("href" => "/nodes/$parent_uuid?build=537")
    image_link = isnothing(primary_image_uuid) ? nothing :
        Dict("href" => "/images/$primary_image_uuid?build=537")
    return Dict{String, Any}(
        "uuid" => String(uuid),
        "names" => [[Dict("class" => "scientific", "text" => String(name))]],
        "_links" => Dict(
            "self" => Dict("href" => "/nodes/$uuid", "title" => String(name)),
            "parentNode" => parent_link,
            "primaryImage" => image_link,
            "cladeImages" => Dict("href" => "/images?filter_clade=$uuid"),
            "images" => Dict("href" => "/images?filter_node=$uuid"),
        ),
    )
end

function _image_payload(
        uuid::AbstractString = "image-1";
        specific_node_uuid::Union{AbstractString, Nothing} = "node-1",
        general_node_uuid::Union{AbstractString, Nothing} = "clade-1",
    )::Dict{String, Any}
    specific_link = isnothing(specific_node_uuid) ? nothing :
        Dict("href" => "/nodes/$specific_node_uuid?build=537")
    general_link = isnothing(general_node_uuid) ? nothing :
        Dict("href" => "/nodes/$general_node_uuid?build=537")
    return Dict{String, Any}(
        "uuid" => String(uuid),
        "attribution" => "Example artist",
        "_links" => Dict(
            "thumbnailFiles" => [
                Dict("href" => "https://example.test/$uuid-64.png", "sizes" => "64x64"),
                Dict("href" => "https://example.test/$uuid-256.png", "sizes" => "256x192"),
            ],
            "rasterFiles" => [
                Dict("href" => "https://example.test/$uuid-512.png", "sizes" => "512x384"),
            ],
            "vectorFile" => Dict("href" => "https://example.test/$uuid.svg"),
            "sourceFile" => Dict("href" => "https://example.test/$uuid-source.svg"),
            "http://ogp.me/ns#image" => Dict("href" => "https://example.test/$uuid-og.png"),
            "license" => Dict("href" => "https://creativecommons.org/licenses/by/4.0/"),
            "contributor" => Dict("href" => "https://example.test/contributors/1"),
            "specificNode" => specific_link,
            "generalNode" => general_link,
        ),
    )
end

function _node_with_primary_payload(
        node_uuid::AbstractString = "node-1";
        image_uuid::Union{AbstractString, Nothing} = "image-1",
    )::Dict{String, Any}
    payload = _node_payload(
        node_uuid;
        primary_image_uuid = image_uuid,
    )
    payload["_embedded"] = Dict(
        "primaryImage" => isnothing(image_uuid) ? nothing :
            _image_payload(image_uuid; specific_node_uuid = node_uuid),
    )
    return payload
end

function _image_page_payload(
        images::AbstractVector;
        total_pages::Integer = 1,
    )::Dict{String, Any}
    return Dict{String, Any}(
        "totalPages" => Int(total_pages),
        "_embedded" => Dict("items" => images),
    )
end
