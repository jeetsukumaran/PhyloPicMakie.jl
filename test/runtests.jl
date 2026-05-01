# test/runtests.jl — PhyloPicMakie test suite entry point
#
# Structure:
#   test_coordinates.jl      — _compute_image_bbox, _apply_rotation, _range_anchor
#   test_anchored_overlay.jl — internal anchored-overlay specs and contract checks
#   test_label_building.jl   — _extract_image_field, _join_fields, _build_label
#   test_grid_helpers.jl     — _infer_thumbnail_grid_shape, _rows_grid_positions
#   test_render_core.jl      — pre-resolved augment_phylopic!, augment_phylopic_ranges!,
#                              phylopic_thumbnail_grid! + argument validation
#   test_makie_integration.jl — reactive resize/relimit integration checks
#   test_code_quality.jl     — Aqua + JET

using Test
using CairoMakie
using PhyloPicMakie
using Aqua
using JET

# PhyloPicDB is a nested module of PhyloPicMakie and is accessible here.
const PhyloPicDB = PhyloPicMakie.PhyloPicDB

include("test_coordinates.jl")
include("test_anchored_overlay.jl")
include("test_label_building.jl")
include("test_grid_helpers.jl")
include("test_render_core.jl")
include("test_makie_integration.jl")
include("test_code_quality.jl")
