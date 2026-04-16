using PhyloPicMakie
using Documenter

DocMeta.setdocmeta!(PhyloPicMakie, :DocTestSetup, :(using PhyloPicMakie); recursive=true)

makedocs(;
    modules=[PhyloPicMakie, PhyloPicMakie.PhyloPicDB],
    authors="Jeet Sukumaran <jeetsukumaran@gmail.com>",
    sitename="PhyloPicMakie.jl",
    format=Documenter.HTML(;
        canonical="https://jeetsukumaran.github.io/PhyloPicMakie.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
        "API Reference" => [
            "Rendering"  => "api/rendering.md",
            "PhyloPicDB" => "api/phylopic_db.md",
        ],
    ],
)

deploydocs(;
    repo="github.com/jeetsukumaran/PhyloPicMakie.jl",
    devbranch="main",
)
