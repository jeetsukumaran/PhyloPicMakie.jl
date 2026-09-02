---
date-created: 2026-09-01
status: ratified
---

# Controlled vocabulary

This file defines domain terms for PhyloPicMakie.jl. Code, documentation,
tests, workflow documents, issue reports, and pull requests use these terms
consistently. Upstream API names retain their upstream spelling.

Agents and contributors must pass applicable terms into downstream workflow
documents and delegated tasks. Proposed additions or changes require project
owner approval.

## Reader-facing prose and API names

Reader-facing prose uses conventional spaced English. Code font identifies an
exact Julia name, keyword, symbol, or field.

Examples:

- Write "node UUID" in prose and `node_uuid` for the exact keyword.
- Write "image rendering" in prose and `image_rendering` for the exact
  keyword.
- Write "thumbnail gallery" in prose and `phylopic_thumbnail_grid` for the
  exact function.

## Terms

### PhyloPic

`PhyloPic` is the proper name of the external silhouette database and API at
<https://www.phylopic.org/>. Preserve the internal capital `P`.

Proscribed forms: `Phylopic` when referring to the service; `Phylo Pic`.

The separately registered Julia package named `Phylopic` retains that spelling
because it is an exact package name.

### PhyloPic node

A PhyloPic node is a taxonomic or phylogenetic node returned by the PhyloPic
API. `PhyloPicNode` is the corresponding Julia type.

Use "node UUID" for the node identifier in prose and `node_uuid` for the
rendering keyword. Do not call a node UUID an image UUID.

### PhyloPic image

A PhyloPic image is an image record returned by the PhyloPic API.
`PhyloPicImage` is the corresponding Julia type. The record includes image
URLs, node associations, license data, and attribution data.

Use "image UUID" for the image record identifier. Do not call an image UUID a
node UUID.

### Silhouette

A silhouette is the organism image represented by a PhyloPic image record.
Use this term in user-facing descriptions of visible content.

### Glyph

A glyph is a decoded image matrix or a rendered silhouette instance placed in
a Makie scene. The `glyph` keyword accepts one preloaded image matrix, and
`glyph_size` controls its rendered half-height.

Use "PhyloPic image" for API metadata and "glyph" for the decoded or rendered
visual object.

### Overlay

An overlay is one or more silhouette glyphs added at explicit Makie
coordinates. `augment_phylopic!` adds an overlay to an existing axis.
`augment_phylopic` creates a new figure and axis before adding the overlay.

### Range overlay

A range overlay anchors each silhouette relative to a numeric range. The `at`
keyword accepts `:start`, `:stop`, or `:midpoint`.

Use "range overlay" in prose. Use `augment_phylopic_ranges` or
`augment_phylopic_ranges!` for the exact Julia function.

### Thumbnail gallery

A thumbnail gallery arranges silhouette images and labels in cells.
`phylopic_thumbnail_grid` creates a figure; `phylopic_thumbnail_grid!` adds the
gallery to an existing axis.

Use "thumbnail gallery" in prose. "Thumbnail grid" is acceptable when
describing the geometric layout or naming the exact API.

### Image rendering

An image rendering is a particular file representation exposed by a
`PhyloPicImage`. The supported `image_rendering` values are `:thumbnail`,
`:raster`, `:og_image`, `:vector`, and `:source_file`.

Do not use "format" when the distinction is which PhyloPic URL field to
select; several renderings can share one file format.

### Figure-creating function

A figure-creating function does not accept an existing axis. It creates a new
`Makie.Figure` and `Makie.Axis`. `augment_phylopic` and
`augment_phylopic_ranges` return `(; figure, axis)`.

### Axis-mutating function

An axis-mutating function accepts an existing `Makie.Axis` and adds content to
it. These function names end in `!`.

Do not describe an axis-mutating function as non-mutating merely because it
returns `nothing`.

### Nested API namespace

`PhyloPicMakie.PhyloPicDB` is the supported nested namespace for the typed
PhyloPic v2 API client. Use the fully qualified name on first mention. The
short local alias `PhyloPicDB` is acceptable after code explicitly binds it.

Do not describe `PhyloPicDB` as a separate package in this repository.

### Image license

An image license is the license attached to one PhyloPic image record. The
fields `license`, `license_url`, `attribution`, and `contributor_href` describe
the relevant terms and credit information.

Do not imply that the PhyloPicMakie package license governs downloaded
silhouette images.
