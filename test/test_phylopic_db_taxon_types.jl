@testset "PhyloPicDB — taxon resolution types" begin
    node = PhyloPicDB._parse_node_json(JSON3.read(JSON3.write(_node_payload())), 537)
    resolution = PhyloPicDB._resolution(
        "Canis lupus",
        "canis lupus",
        PhyloPicDB.PhyloPicResolver(),
        PhyloPicDB.TAXON_RESOLVED;
        match_basis = PhyloPicDB.PREFERRED_NAME_MATCH,
        node,
        candidates = [node],
    )
    @test PhyloPicDB.isresolved(resolution)
    @test PhyloPicDB.node_uuid(resolution) == "node-1"
    @test PhyloPicDB.require_node(resolution) === node
    @test occursin("Canis lupus", sprint(show, resolution))
    @test occursin("Taxon resolution", sprint(show, MIME("text/plain"), resolution))

    missing_resolution = PhyloPicDB._resolution(
        "Missing taxon",
        "missing taxon",
        PhyloPicDB.PhyloPicResolver(),
        PhyloPicDB.TAXON_NOT_FOUND;
        suggestions = ["missingia"],
    )
    @test !PhyloPicDB.isresolved(missing_resolution)
    @test isnothing(PhyloPicDB.node_uuid(missing_resolution))
    @test_throws ArgumentError PhyloPicDB.require_node(missing_resolution)

    identifier = PhyloPicDB.ExternalTaxonIdentifier("gbif.org", "species", "1")
    namespace = PhyloPicDB.ExternalTaxonNamespace("gbif.org", "species")
    @test identifier.object_id == "1"
    @test namespace.authority == "gbif.org"
end
