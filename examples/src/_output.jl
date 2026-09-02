using CairoMakie: Figure, display, save

function display_or_save(
        figure::Figure,
        default_filename::AbstractString,
    )::Nothing
    if isempty(ARGS) && isinteractive()
        display(figure)
    else
        output_path = abspath(get(ARGS, 1, default_filename))
        save(output_path, figure)
        println("Saved example to $(output_path)")
    end
    return nothing
end
