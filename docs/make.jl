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
        "Start here" => "index.md",
        "Primer and tutorial" => [
            "Primer" => "primer.md",
            "Tutorial" => "tutorial.md",
        ],
        "How-to guides" => [
            "Overview" => "how-to/index.md",
            "Place silhouettes on points" => "how-to/points.md",
            "Place silhouettes on ranges" => "how-to/ranges.md",
            "Use table columns" => "how-to/table-columns.md",
            "Cache repeated PhyloPic queries" => "how-to/repeated-queries.md",
        ],
        "Explanation" => [
            "Concepts" => "explanation/index.md",
        ],
        "API reference" => [
            "Rendering"  => "api/rendering.md",
            "PhyloPicDB" => "api/phylopic_db.md",
        ],
        "Examples" => "examples.md",
    ],
)

deploydocs(;
    repo="github.com/jeetsukumaran/PhyloPicMakie.jl",
    devbranch="main",
)
