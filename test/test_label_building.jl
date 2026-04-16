# test/test_label_building.jl
# Offline unit tests for PhyloPicMakie label-building helpers:
#   _extract_image_field, _join_fields, _build_label
#
# All tests are pure-function (no Makie backend needed).
# Uses PhyloPicDB._null_image to construct a minimal PhyloPicImage offline.
# Symbols are accessed via the PhyloPicMakie / PhyloPicDB modules loaded in runtests.jl.

@testset "PhyloPicMakie — _extract_image_field" begin
    null_img = PhyloPicDB._null_image(1)

    @testset "virtual field :taxon_name" begin
        @test PhyloPicMakie._extract_image_field(:taxon_name, "Felidae", 3, null_img) == "Felidae"
    end

    @testset "virtual field :index" begin
        @test PhyloPicMakie._extract_image_field(:index, "Felidae", 3, null_img) == "3"
    end

    @testset ":node_name nothing on null image" begin
        @test isnothing(PhyloPicMakie._extract_image_field(:node_name, "Felidae", 1, null_img))
    end

    @testset ":uuid always returns a String (empty for null image)" begin
        val = PhyloPicMakie._extract_image_field(:uuid, "Felidae", 1, null_img)
        @test val isa String
    end

    @testset ":attribution missing on null image" begin
        @test ismissing(PhyloPicMakie._extract_image_field(:attribution, "Felidae", 1, null_img))
    end

    @testset ":license missing on null image" begin
        @test ismissing(PhyloPicMakie._extract_image_field(:license, "Felidae", 1, null_img))
    end

    @testset ":specific_node_uuid nothing on null image" begin
        @test isnothing(PhyloPicMakie._extract_image_field(:specific_node_uuid, "Felidae", 1, null_img))
    end

    @testset "unknown symbol throws ArgumentError" begin
        @test_throws ArgumentError PhyloPicMakie._extract_image_field(:notafield, "Felidae", 1, null_img)
    end
end  # _extract_image_field

@testset "PhyloPicMakie — _join_fields" begin
    null_img = PhyloPicDB._null_image(1)

    @testset "virtual-only fields always present" begin
        result = PhyloPicMakie._join_fields([:taxon_name, :index], "Felidae", 2, null_img, " | ")
        @test result == "Felidae | 2"
    end

    @testset "missing structural field skipped" begin
        # :attribution is missing on null_img → only :taxon_name survives
        result = PhyloPicMakie._join_fields([:taxon_name, :attribution], "Felidae", 1, null_img, "\n")
        @test result == "Felidae"
    end

    @testset "nothing structural field skipped" begin
        # :node_name is nothing on null_img → only :taxon_name survives
        result = PhyloPicMakie._join_fields([:taxon_name, :node_name], "Felidae", 1, null_img, "\n")
        @test result == "Felidae"
    end

    @testset "empty uuid skipped" begin
        # null_img.uuid == "" → skipped
        result = PhyloPicMakie._join_fields([:taxon_name, :uuid], "Felidae", 1, null_img, "\n")
        @test result == "Felidae"
    end

    @testset "empty field list → empty string" begin
        @test PhyloPicMakie._join_fields(Symbol[], "Felidae", 1, null_img, "\n") == ""
    end

    @testset "custom separator respected" begin
        result = PhyloPicMakie._join_fields([:taxon_name, :index], "Carnivora", 5, null_img, " :: ")
        @test result == "Carnivora :: 5"
    end
end  # _join_fields

@testset "PhyloPicMakie — _build_label" begin
    null_img = PhyloPicDB._null_image(1)

    @testset "nothing, single-image group → name only" begin
        @test PhyloPicMakie._build_label("Felidae", 1, false, null_img, nothing, "\n") == "Felidae"
    end

    @testset "nothing, multi-image group → name [k]" begin
        @test PhyloPicMakie._build_label("Felidae", 3, true, null_img, nothing, "\n") == "Felidae [3]"
    end

    @testset ":BASICFIELDS is [:index, :node_name, :taxon_name]; node_name absent on null" begin
        # null_img: node_name=nothing → skipped; index and taxon_name survive
        result = PhyloPicMakie._build_label("Felidae", 2, true, null_img, :BASICFIELDS, " | ")
        @test result == "2 | Felidae"
    end

    @testset "Vector{Symbol}: missing/nothing fields dropped, labeljoin used" begin
        # :attribution missing → only :taxon_name
        @test PhyloPicMakie._build_label("Felidae", 1, false, null_img, [:taxon_name, :attribution], "\n") == "Felidae"
        # :taxon_name + :index with custom sep
        @test PhyloPicMakie._build_label("Carnivora", 3, true, null_img, [:taxon_name, :index], " — ") == "Carnivora — 3"
    end

    @testset "single known symbol missing/nothing → falls back to default" begin
        @test PhyloPicMakie._build_label("Felidae", 1, false, null_img, :attribution, "\n") == "Felidae"
        @test PhyloPicMakie._build_label("Felidae", 2, true,  null_img, :attribution, "\n") == "Felidae [2]"
        # :node_name is nothing on null_img → falls back to default
        @test PhyloPicMakie._build_label("Felidae", 1, false, null_img, :node_name, "\n") == "Felidae"
        @test PhyloPicMakie._build_label("Felidae", 3, true,  null_img, :node_name, "\n") == "Felidae [3]"
    end

    @testset "callable receives name, k, img" begin
        f = (name, k, img) -> "$(name):$(k)"
        @test PhyloPicMakie._build_label("Felidae", 7, true, null_img, f, "\n") == "Felidae:7"
    end

    @testset "unknown Symbol throws ArgumentError" begin
        @test_throws ArgumentError PhyloPicMakie._build_label("Felidae", 1, false, null_img, :notafield, "\n")
    end
end  # _build_label
