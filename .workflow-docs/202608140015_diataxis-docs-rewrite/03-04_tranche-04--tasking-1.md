---
date-created: 2026-08-16T22:30:52-07:00
workflow-instrument: Tasking plan
workflow-status: Superseded
workflow-agent-thread-id: codex/01a00e2f-82fc-7771-bed9-0d75dfc20914
workflow-location: /home/jeetsukumaran/site/storage/local/computing/research/20260414_PhyloPicMakie.jl/PhyloPicMakie.jl
workflow-production-id: diataxis-docs-primer
workflow-prd: .workflow-docs/202608140015_diataxis-docs-rewrite/01_prd.md
workflow-tranche: .workflow-docs/202608140015_diataxis-docs-rewrite/02_tranches.md
---

# Tasks for tranche 4: Write placement, PhyloPic source, and missing-image how-tos

## Blocked by remedial correction

This tasking is superseded archival context and is not approved for execution. It predates the project owner's 2026-08-16 correction that the documentation must not start from local image matrices or an offline-only fixture path.

All instructions below that require `docs/src/_offline_silhouette.jl`, `offline_silhouette()`, preloaded image matrices, an offline-capable core learning path, or a split where PhyloPic node UUID examples are merely non-executable side notes are superseded by `.workflow-docs/202608140015_diataxis-docs-rewrite/02_tranches.md` Tranche R1 and the revised PRD. Regenerate or rewrite this tasking after R1 has repaired the completed first-wave docs.

The future placement and source how-tos must start from PhyloPic-backed silhouettes. Local image matrices may appear only as a secondary "already have image data" path, and explicit DataCaches claims must name `PhyloPicDB.batch_primary_images`, `PhyloPicDB.batch_images`, the upstream DataCaches API being shown, or a separately approved source change.

This file also predates the repo-local `STYLE-agent-language.md` update. Any
instruction below that uses ownership, contract, boundary, layer, invariant,
compatibility, verification, source, or responsibility language is not
executable unless Tranche R1 or a regenerated tasking file expands it with the
exact file, function, module, public surface, or external contract; the
behavior; the consumer; the duplicate or bypass path that must not keep the
behavior; and the verification artifact that fails the vague statement.

## Settled user decisions and environment baseline

- This remains a documentation-only feature. No public API, exported name,
  plotting behavior, placement calculation, image-resolution behavior,
  missing-image behavior, network behavior, test source, example-script source,
  CI configuration, or dependency change is authorized.
- The documentation follows Diátaxis. These are goal-oriented how-to guides,
  not an API reference, a tutorial lesson, or an explanation of implementation
  details. Each page must state the reader's plotting task, give a concise
  runnable path, state the visible result, and link to reference material for
  exhaustive facts.
- `docs/make.jl` is the single authoritative implementation for the rendered
  Documenter sidebar. `docs/src/how-to/index.md` is the how-to route's list of
  completed guides. Add each completed page to both files; do not make a
  placeholder route or link to a later-tranche page.
- The existing Tranches 1 through 3 work is pre-existing worktree state. Keep
  `README.md`, `docs/Project.toml`, `docs/make.jl`, `docs/src/index.md`,
  `docs/src/primer.md`, `docs/src/tutorial.md`, `docs/src/_offline_silhouette.jl`,
  `docs/src/explanation/`, and the existing coordinate, range, and table
  guides intact except for the two explicitly authorized navigation files.
- Reuse the existing docs-private `offline_silhouette()` helper and the
  current `@setup` include pattern from `docs/src/how-to/points.md`. It is a
  small local image fixture, not a new public rendering surface and not a
  replacement for `examples/src/explicit_overlays.jl`.
- The core learning path must remain offline-capable. A preloaded image matrix
  passed through `glyph` does not fetch an image and causes `image_rendering`
  to be ignored. Any `node_uuid` plus `image_rendering` example is therefore
  non-executable, plainly labelled network-dependent, and excluded from the
  rendered PNG path.
- The API facts are fixed input for this tranche. `placement` controls which
  part of a silhouette meets the coordinate; `glyph_size` is the half-height
  in data units; `xoffset` and `yoffset` are data-unit nudges after placement;
  the guide demonstrates `rotation = 90` and `mirror = true`; and the public
  positive rotation values documented for users are `0`, `90`, `180`, and
  `270` degrees. Do not extend or redefine those semantics.
- The valid image-rendering choices are `:thumbnail` (default square PNG),
  `:raster` (full-resolution PNG), `:og_image` (Open Graph PNG preview),
  `:vector` (SVG requiring an SVG-capable FileIO plugin), and `:source_file`
  (the uploaded SVG or raster source, which can also require that plugin).
  The guide may give a compact choice table, but it must link to the rendering
  and PhyloPicDB references instead of duplicating their complete API details.
- Missing images are represented by `nothing` in the pre-resolved image-vector
  method. `on_missing = :skip` omits that glyph, `:placeholder` renders the
  gray placeholder, and `:error` throws at the missing datum. The missing-image
  guide demonstrates those existing behaviors with local image data; it does
  not introduce a live failure path.
- PNGs created by Documenter examples are ignored build products and
  verification artifacts. They must be created under `docs/build/how-to/` and
  must not be copied into `docs/src/` or committed. `docs/build/` and
  `docs/Manifest.toml` are currently ignored; the manifest remains untracked.
- No exact inference, typed-return, migration, schema, compatibility shim, or
  public API guarantee is part of this tranche.

## Governance

Before implementation, read each applicable authority below line by line and
comply with it throughout the work. This tasking uses responsibility,
contract, boundary, source, invariant, and verification language; therefore
the concrete-expansion rules in `STYLE-agent-language.md` are mandatory. In
particular, do not use those terms without naming the exact file, behavior,
consumer, prohibited duplicate or bypass, and verification artifact.

Repo-local authorities:

- `STYLE-workflow-docs.md`.
- `STYLE-makie.md`.
- `STYLE-git.md`.
- `STYLE-writing.md`.
- `STYLE-julia.md`.
- `STYLE-docs.md`.
- `STYLE-vocabulary.md`.
- `STYLE-architecture.md`.
- `STYLE-verification.md`.
- `STYLE-upstream-contracts.md`.

Expected governance files not found during tasking:

- Repo-local `CONTRIBUTING*.md`, `STYLE-python.md`, and
  `STYLE-domain-vocabulary.md`.

The local controlled vocabulary applies directly. In reader-facing prose, use
"PhyloPic silhouette" or "silhouette" and "PhyloPic node UUID"; use "local
image matrix" only for the secondary "already have image data" path; reserve
code font for exact syntax. Keep project
terms such as `glyph`, `placement`, `glyph_size`, `xoffset`, `yoffset`,
`rotation`, `mirror`, `image_rendering`, and `on_missing` as exact API spellings
only. Do not use proscribed generic node or graph terms in code examples.

Read-only git and shell commands may be used freely. Mutating git operations,
including commit, merge, push, branch, checkout, rebase, and reset, remain the
project owner's responsibility unless explicitly authorized.

## Upstream primary sources and local contract conclusions

Read these upstream primary sources in full before editing the page that relies
on them:

- [Diátaxis how-to guides](https://diataxis.fr/how-to-guides/).
- [Diátaxis explanation](https://diataxis.fr/explanation/), to keep explanation
  from leaking into the placement guide.
- [Documenter syntax](https://documenter.juliadocs.org/stable/man/syntax/),
  specifically `@meta`, `@setup`, `@example`, relative Markdown links, and
  generated-file handling.
- [Documenter guide](https://documenter.juliadocs.org/stable/man/guide/),
  specifically the `makedocs` page tree and rendered sidebar behavior.

Read these local primary sources in full before implementation:

- `docs/make.jl`, `docs/src/how-to/index.md`,
  `docs/src/how-to/points.md`, `docs/src/how-to/ranges.md`,
  `docs/src/how-to/table-columns.md`, `docs/src/primer.md`,
  `docs/src/tutorial.md`, and `docs/src/_offline_silhouette.jl`.
- `src/_augment_api.jl` for the documented point, range, and table method
  signatures; direct-glyph precedence; the public keyword facts; and the
  guarantee that `image_rendering` is ignored when `glyph` is supplied.
- `src/_coordinates.jl` for valid `placement` symbols, data-unit offsets,
  `glyph_size` interpretation, aspect behavior, and supported right-angle
  rotation behavior.
- `src/_glyph_resolution.jl` for local-glyph broadcasting, node-UUID image
  resolution, URL selection, and the point at which `nothing` values reach the
  renderer.
- `src/_render_core.jl` for the exact effects of `:skip`, `:placeholder`, and
  `:error` on a pre-resolved image vector.
- `src/PhyloPicDB/_types.jl` for the exact `PHYLOPIC_IMAGE_RENDERINGS` choices
  and source formats.
- `src/_thumbnail_grid.jl` and `examples/src/thumbnail_gallery.jl` to confirm
  that gallery behavior belongs to Tranche 5, not these point-overlay guides.
- `examples/src/explicit_overlays.jl` for the existing offline point-overlay
  visual pattern, without copying the script into documentation.
- `test/test_coordinates.jl`, `test/test_render_core.jl`,
  `test/test_makie_integration.jl`, `test/test_grid_helpers.jl`, and
  `test/test_anchored_overlay.jl` for verified placement, rotation,
  missing-image, and thumbnail boundaries.

Conclusions already resolved during tasking:

- Diátaxis how-to guides are goal-oriented, action-focused, and use titles
  that say exactly what the reader wants to accomplish. The pages below keep
  their reader task in the opening and link to reference instead of providing
  an exhaustive parameter catalogue.
- Documenter's named `@setup` and `@example` blocks are the established,
  working local pattern for an executable example that writes a page-relative
  image under `docs/build/`. The guide pages must follow the existing
  `points.md` helper-include form rather than invent another path strategy.
- `_compute_image_bbox` applies `xoffset` and `yoffset` after placement. The
  placement guide must therefore show an anchor marker and a visibly displaced
  silhouette rather than falsely describing offsets as a different anchor.
- `_apply_rotation` accepts right-angle rotations only. The placement guide
  demonstrates `rotation = 90`, not an unsupported arbitrary angle.
- `_resolve_images_by_uuid` broadcasts a supplied `glyph` and does not use
  `image_rendering`; UUID resolution performs the fetch. The image-source
  guide must keep its rendered example on the glyph path and isolate the UUID
  example as network-dependent prose.
- `_augment_resolved_phylopic_anchored!` filters `nothing` for `:skip`,
  substitutes the package placeholder for `:placeholder`, and throws for
  `:error`. The missing-image guide must use the four-argument
  `augment_phylopic!(axis, x, y, images; ...)` form with a vector containing
  one `nothing`, so all three policies are deterministic and offline.
- `PHYLOPIC_IMAGE_RENDERINGS` has five choices, including `:og_image`; the
  image-source guide must not silently describe the required four choices as
  the whole set. SVG choices carry the FileIO-plugin limitation, which is an
  existing API fact rather than permission to add FileIO or a plugin.
- `phylopic_thumbnail_grid!` is the gallery-specific rendering surface.
  Tranche 4 must not document or edit it; thumbnail-gallery content remains
  Tranche 5.

## Current-state diagnosis

The working tree contains the completed documentation map, offline primer and
tutorial, and coordinate/range/table guides from earlier tranches. The docs
build currently succeeds, creates three ignored how-to PNGs, and leaves no
tracked `docs/src` PNG. `docs/make.jl` currently routes only the overview plus
`points.md`, `ranges.md`, and `table-columns.md` under `How-to guides`.

No page currently gives a reader a task-oriented, rendered path for adjusting
silhouette placement and appearance, selecting an offline image or a
network-dependent rendering format, or choosing among `:skip`, `:error`, and
`:placeholder`. `docs/src/api/rendering.md` lists these API facts beside
`@autodocs` and currently contains implementation-first prose, but it is the
reference surface and outside this tranche. The new pages must link to it
without duplicating or editing it.

`docs/src/_offline_silhouette.jl` already provides one local image matrix and
the docs project already declares CairoMakie. Consequently, all three required
rendered examples can use the existing docs environment without a dependency,
network, source, test, or example-script change. A request for a live UUID
fetch, an additional image loader, an SVG plugin, or changed missing-image
behavior is a stop condition rather than an implementation choice.

## Primary-goal lock

### Lock 1: Adjust a plotted silhouette visually

- The work is not complete if a reader still finds `placement`, `glyph_size`,
  `xoffset`, `yoffset`, `rotation`, and `mirror` only in API facts, or cannot
  see their effect in a concrete offline figure.
- Direct red-state repro: `docs/src/how-to/` contains point, range, and table
  pages only. `docs/src/api/rendering.md` documents the keywords, but no
  reader-facing guide renders their visual effects.
- Task that closes it: task 1.
- Failing verification artifact: the task-1 source audit for all six exact
  keyword spellings and the rendered
  `docs/build/how-to/adjust-placement/adjust-placement.png` both fail the
  current repository and any page that merely links to reference.

### Lock 2: Choose an offline image or a live rendering format accurately

- The work is not complete if a reader is told that a local `glyph` fetches an
  image, if the `image_rendering` choices are incomplete or inaccurate, or if
  a live UUID example becomes part of the required executable learning path.
- Direct red-state repro: current first-contact material uses a preloaded
  image, while the API reference is the only page that lists
  `image_rendering`; no task page explains the offline-versus-network choice
  or the SVG limitation.
- Task that closes it: task 2.
- Failing verification artifact: the task-2 source audit requires the local
  `glyph` example, all five valid symbols, the exact statement that
  `image_rendering` is ignored for a direct glyph, and a network-dependent
  label. It fails a page that uses a UUID in an executable Documenter block or
  omits a supported choice.

### Lock 3: Make every missing-image policy observable

- The work is not complete if `:skip`, `:placeholder`, or `:error` remains an
  unexplained symbol, or if the guide simulates a policy instead of using the
  public image-vector method that implements it.
- Direct red-state repro: `test/test_render_core.jl` proves the three
  behaviors, but current reader-facing pages do not show any of them.
- Task that closes it: task 3.
- Failing verification artifact: the task-3 source audit requires a
  `nothing` image entry and all three exact `on_missing` values; the rendered
  `missing-images.png` must visibly distinguish skip from placeholder, and
  the caught executable `:error` example must print the public error message.
  This fails a page with only a prose table or a made-up placeholder.

### Lock 4: Preserve the how-to/reference role boundary

- The work is not complete if any new page becomes an `@autodocs`, `@docs`, or
  `@index` API dump, copies a broad keyword catalogue, or opens with internal
  implementation prose instead of the reader's task and visual result.
- Direct red-state repro: `docs/src/api/rendering.md` is the current facts
  surface and opens with implementation-first text. It is not a suitable
  model for a how-to opening.
- Tasks that close it: tasks 1 through 3, verified together by task 4.
- Failing verification artifact: task 4's forbidden-form audit and rendered
  review fail a page that builds while retaining `@autodocs`, `@docs`,
  `@index`, "generic anchored-overlay", "owner layer", "data-anchor",
  "projected pixel-anchor", "placement mechanics", or a copied API catalogue.

### Lock 5: Keep runnable examples genuinely offline and rendered

- The work is not complete if an executable guide is merely a static code
  fence, lacks a build-generated output, imports a network client, or changes
  the existing docs environment to make an example run.
- Direct red-state repro: before this tranche the three new page files and
  their PNG artifacts do not exist. A green build of the existing pages cannot
  prove that the new learning paths work.
- Tasks that close it: tasks 1 through 3, verified together by task 4.
- Failing verification artifact: each task's `julia --project=docs docs/make.jl`
  run, its exact PNG file-type check, and its rendered-HTML image-reference
  check fail a static, missing, or network-dependent implementation.

### Lock 6: Preserve the documentation-only and build-artifact boundary

- The work is not complete if it changes public behavior or any source,
  test, example, CI, environment, API-reference, primer, tutorial, home, or
  explanation file; if it erases pre-existing tranche work; or if it tracks a
  PNG or a docs manifest.
- Direct red-state repro: the PRD rejects source changes made to simplify
  documentation, and the worktree already contains uncommitted earlier-tranche
  work that must survive this tranche.
- Tasks that close it: tasks 1 through 3 stay within named files; task 4
  performs the scope audit.
- Failing verification artifact: task 4 compares the pre-edit out-of-scope
  hash, inspects the complete worktree status, verifies ignored build outputs,
  and confirms that `git ls-files docs/src` returns no PNG. Those checks fail a
  source change, tracked asset, or overwritten earlier page.

### Lock 7: Preserve style and controlled vocabulary

- The work is not complete if headings lose sentence case, prose uses a
  proscribed project term, ordinary prose incorrectly uses code font, or a
  reader-facing opening contains the implementation-first vocabulary rejected
  by the PRD.
- Direct red-state repro: the old reference opening uses phrases such as
  "generic anchored-overlay substrate" and "projected pixel-anchor placement
  mechanics", which the PRD reserves away from first-contact pages.
- Tasks that close it: tasks 1 through 3, verified together by task 4.
- Failing verification artifact: task 4's source audit and rendered reading
  review fail any forbidden phrase, non-goal title, or missing plain-language
  explanation of placement, preloaded images, or missing-image behavior.

## Forbidden passing implementation table

| Lock item | Required behavior | Current code state | Resolved implementation instruction | Forbidden passing implementation | Failing verification artifact |
| --- | --- | --- | --- | --- | --- |
| Lock 1: Adjust a plotted silhouette visually | The adjustment page visibly demonstrates placement, size, offsets, a right-angle rotation, and mirroring with local image data. | `docs/src/how-to/` has no adjustment page; `src/_augment_api.jl` holds the keyword facts. | Task 1 adds `docs/src/how-to/adjust-placement.md`, routes it through `docs/make.jl` and the overview, and saves its three-panel offline image. | List the six keywords in prose, use an arbitrary rotation, or show only a pre-existing point recipe. | The exact-keyword audit and `adjust-placement.png` visual review fail the list-only, unsupported-angle, or single-feature page. |
| Lock 2: Choose an offline image or a live rendering format accurately | The source guide distinguishes direct local glyphs from optional UUID fetching and names every valid rendering symbol with its real format or limitation. | `src/_glyph_resolution.jl` broadcasts `glyph` and ignores `image_rendering`; format facts appear only in API source and `PhyloPicDB` types. | Task 2 adds `docs/src/how-to/image-sources.md` with a runnable glyph example, a compact five-choice decision table, and one plain fenced UUID snippet labelled network-dependent. | Make a network call in `@example`, imply `image_rendering` changes a supplied glyph, omit `:og_image`, or add FileIO. | The source audit, no-network-import audit, and `image-sources.png` check fail the network, inaccurate, incomplete, or dependency-expanding page. |
| Lock 3: Make every missing-image policy observable | The missing-image guide shows a real `nothing` image handled by skip, placeholder, and error. | `src/_render_core.jl` implements the three policies; `test/test_render_core.jl` covers them; docs have no reader guide. | Task 3 adds `docs/src/how-to/missing-images.md` using the image-vector overload, two rendered policy panels, and a caught `:error` Documenter example. | Use a decorative gray rectangle, explain only two policies, or claim a `nothing` glyph has no effect. | The three-symbol and `nothing` audit, rendered policy PNG, and captured error-message check fail the fake or incomplete form. |
| Lock 4: Preserve the how-to/reference role boundary | Each page gives action for a reader goal and links to reference for broader facts. | `docs/src/api/rendering.md` has `@autodocs`; goal pages do not yet cover these tasks. | Tasks 1 through 3 write concise goal-titled pages with reference links and no generated API blocks. | Copy the rendering docstring table or make a green docs build the only proof of a how-to. | Task 4's forbidden-form audit and rendered reading review fail the copied-reference page. |
| Lock 5: Keep runnable examples genuinely offline and rendered | Every guide has a successful Documenter example, a page-relative PNG, and no network dependency. | The docs environment and `offline_silhouette()` already support local rendering, but these three artifacts do not exist. | Tasks 1 through 3 use the existing named setup pattern and save one PNG per page under the matching `docs/build/how-to/` directory. | Add static fences only, reuse another page's PNG, or replace the offline code with live fetching. | Three distinct PNG file checks, HTML-reference checks, and image review fail the static, reused, or live-only page. |
| Lock 6: Preserve the documentation-only and build-artifact boundary | Only the named how-to Markdown files and navigation files change; PNGs and the docs manifest remain untracked. | Earlier documentation work is already modified or untracked; `docs/build/` and `docs/Manifest.toml` are ignored. | Task 1 records the out-of-scope hash; tasks 1 through 3 modify only their named Markdown/navigation files; task 4 compares the hash and status. | Change `src/` or an example to make prose easier, modify an API page, overwrite earlier work, or add a PNG to `docs/src/`. | The hash/status audit, ignore checks, and `git ls-files docs/src` PNG check fail the expanded scope. |
| Lock 7: Preserve style and controlled vocabulary | The guide titles and openings are direct, reader-facing, and use canonical project wording. | The API reference retains internal implementation phrases that cannot enter how-to openings. | Tasks 1 through 3 use the settled reader-facing terms and task 4 audits the exact forbidden phrases. | Describe implementation mechanisms, call ordinary prose `glyph` everywhere, or write a generic page title such as "Placement options". | The phrase/title audit and rendered page review fail style or vocabulary drift. |

## Handoff packet

- **Active authorities**: This tasking file; the approved PRD; the parent
  tranche plan; all repo-local governance documents named in
  Governance; and the local controlled vocabulary.
- **Parent documents**: `.workflow-docs/202608140015_diataxis-docs-rewrite/01_prd.md`
  and `.workflow-docs/202608140015_diataxis-docs-rewrite/02_tranches.md`.
- **Settled decisions and non-negotiables**: Diátaxis structure; goal-oriented
  offline how-tos; explicit Documenter navigation; existing public API facts;
  no network in executable examples; no implementation or dependency change;
  ignored build PNGs; and retention of prior uncommitted tranche work.
- **Authorization boundary**: Repository changes are limited to `docs/make.jl`,
  `docs/src/how-to/index.md`, and the three new Markdown files named in the
  tasks. Ignored outputs may be created in the corresponding `docs/build/how-to/`
  directories. Temporary evidence may be written under `/tmp` only.
- **Current-state diagnosis**: The coordinate, range, and table guides build
  and render successfully. The three Tranche 4 routes and rendered artifacts
  are absent. API source holds accurate facts, but is outside the scope of the
  new task pages.
- **Primary-goal lock**: Verify locks 1 through 7 separately. A successful
  docs build alone closes none of the prose-role, policy-accuracy, offline, or
  scope locks.
- **Direct red-state repros**: absent routes and pages; absent rendered images;
  API-only placement/image/missing facts; no task-level policy demonstration;
  and a dirty worktree containing previous work that could be accidentally
  changed.
- **Responsible files and behaviors**: `docs/make.jl` orders the sidebar;
  `docs/src/how-to/index.md` lists only completed guides;
  `adjust-placement.md` demonstrates visual adjustment;
  `image-sources.md` explains the local-versus-optional-live source decision;
  `missing-images.md` demonstrates the three policies;
  `src/_augment_api.jl`, `src/_coordinates.jl`, `src/_glyph_resolution.jl`,
  `src/_render_core.jl`, and `src/PhyloPicDB/_types.jl` remain the API-fact
  sources; and `docs/src/_offline_silhouette.jl` remains the small local docs
  fixture. The new Markdown files must not duplicate source implementation or
  make a second example-script implementation.
- **Exact files in scope**: `docs/make.jl`, `docs/src/how-to/index.md`,
  `docs/src/how-to/adjust-placement.md`, `docs/src/how-to/image-sources.md`,
  `docs/src/how-to/missing-images.md`, ignored build artifacts under the three
  matching `docs/build/how-to/` directories, and the exact `/tmp` files named
  in task 1 or task 4.
- **Exact files and surfaces out of scope**: `README.md`; `Project.toml`;
  `docs/Project.toml`; `docs/Manifest.toml`; `docs/src/index.md`;
  `docs/src/primer.md`; `docs/src/tutorial.md`; `docs/src/_offline_silhouette.jl`;
  `docs/src/examples.md`; `docs/src/api/`; `docs/src/explanation/`; existing
  coordinate/range/table how-to pages; `src/`; `test/`; `examples/`;
  `.github/`; public API signatures; rendering semantics; missing-image
  semantics; image-download semantics; network behavior; source-controlled
  assets; and package/docs/example environments.
- **Required upstream primary sources**: the two Diátaxis pages, the two
  Documenter pages, and local primary sources named above.
- **Green-state gates**: a fresh docs build after every write task; three
  separately generated PNGs with HTML references and valid file types; exact
  source audits; visual reviews; ignore and scope checks; and no tracked PNG
  or manifest.
- **Stop conditions**: Stop and raise the issue before editing if the baseline
  docs build fails; the existing helper include pattern fails; a required
  example needs a public API, dependency, source, test, example-script, or
  network change; an image-rendering fact is unsupported by the named source;
  an SVG rendering requires a plugin; the UUID snippet would execute; or a
  new guide would require changing an earlier-tranche file outside the named
  authorization boundary.

## Required revalidation before implementation

- Read the parent PRD, tranche plan, and this tasking file in full.
- Read every governance document named in Governance line by line, including
  the repo-local `STYLE-agent-language.md` authority.
- Read every upstream and local primary source named above in full before
  editing the page it constrains.
- Re-run `julia --project=docs docs/make.jl` before editing. Stop if the
  existing build is not green.
- Confirm that `docs/Project.toml` still declares CairoMakie; that
  `docs/src/_offline_silhouette.jl` still returns the local image matrix; that
  the how-to helper include pattern in `points.md` still works; and that
  `docs/build/` plus `docs/Manifest.toml` remain ignored.
- Read the existing coordinate, range, and table guide pages in full to avoid
  copying a previous recipe or overwriting their current content.
- Re-check `src/_augment_api.jl`, `src/_coordinates.jl`,
  `src/_glyph_resolution.jl`, `src/_render_core.jl`, and
  `src/PhyloPicDB/_types.jl` against every API statement below. Stop if the
  current code contradicts this tasking.
- Stop and report any mismatch between this handoff, current source, output,
  environment, primary source, governance, or authorization boundary.

## Tranche execution rule

This tranche extends the established how-to route with three independently
buildable pages. Each WRITE task must end with the complete docs build green
and its own new build-tree PNG present. The pages adapt only the small local
docs fixture and must not replace or duplicate `examples/src/explicit_overlays.jl`.

The guide pages are the narrative locations responsible for their reader task;
the package source files remain responsible for public behavior and API facts;
and Documenter remains responsible for rendering the page-local PNGs. No
guide may introduce alternative placement, image-resolution, missing-image, or
gallery logic in Markdown or test code.

## Non-negotiable execution rules

- Do not edit any source, test, example, CI, environment, README, API,
  primer, tutorial, home, explanation, or earlier how-to content outside the
  two authorized navigation files.
- Do not change `augment_phylopic!`, `_compute_image_bbox`, `_apply_rotation`,
  `_resolve_images_by_uuid`, `_augment_resolved_phylopic_anchored!`,
  `PHYLOPIC_IMAGE_RENDERINGS`, `phylopic_thumbnail_grid!`, or their tests to
  make an example shorter.
- Do not add HTTP, Downloads, FileIO, an SVG plugin, DataFrames, Tables, a
  remote image file, a live UUID request, or a live PNG to an executable docs
  example.
- Do not show `image_rendering` as effective when a direct `glyph` is supplied.
  Do not call a thumbnail, raster, vector, source file, or Open Graph preview
  an offline image source.
- Do not show arbitrary rotation values. The executable adjustment example
  uses `rotation = 90` only.
- Do not represent `:placeholder` by drawing a custom rectangle, or represent
  `:error` by inventing a warning. Use the public pre-resolved image-vector
  entry point and let it perform the existing behavior.
- Do not add `@autodocs`, `@docs`, `@index`, a copied signature catalogue, a
  full keyword table, or internal overlay language to any new guide.
- Do not add source-text policing to package tests or CI. Text searches in
  this tasking are one-time failure-oriented verification of the new reader
  surface only.
- Do not create a source-controlled PNG, commit a manifest, or discard the
  current uncommitted Tranches 1 through 3 work.

## Concrete anti-patterns or removal targets

- Prevent `docs/src/api/rendering.md` from remaining the only task-level path
  for visual adjustment, image-selection, or missing-image decisions. Do not
  edit that reference page in this tranche.
- Prevent the three new page names from becoming navigation-only stubs, copied
  versions of `points.md`, or copies of `examples/src/explicit_overlays.jl`.
- Prevent a direct-glyph recipe from being presented as a UUID-fetch example,
  and prevent a real UUID fetch from being called offline.
- Prevent an image-source choice table from becoming a second API reference or
  silently omitting `:og_image`.
- Prevent a hand-drawn placeholder, static fence, or prose-only promise from
  standing in for the renderer's missing-image policy.
- Prevent gallery layout, labels, grouping, or thumbnail-grid semantics from
  leaking into these overlay guides; that reader task belongs to Tranche 5.

## Failure-oriented verification

- Before work, the three new page-file existence checks, sidebar-route checks,
  three generated-PNG checks, and corresponding rendered-HTML checks fail.
- The placement guide audit must fail if any of `placement`, `glyph_size`,
  `xoffset`, `yoffset`, `rotation = 90`, or `mirror = true` is absent. Its
  visual review must fail an example where an offset does not visibly move a
  silhouette from its plotted marker.
- The image-source guide audit must fail if a direct-glyph example claims that
  `image_rendering` affects it, if any of the five valid symbols is absent, if
  SVG plugin limitations are omitted, or if a UUID is executed in an
  `@example` block.
- The missing-image guide audit must fail if `nothing`, `:skip`, `:placeholder`,
  or `:error` is absent. Its rendered review must fail if the skip and
  placeholder panels look the same, and its executable error block must fail
  if the package does not throw for the second datum.
- A docs build is necessary but insufficient. Visual review, PNG/HTML checks,
  exact reader-facing title/opening checks, no-network and no-API-block audits,
  and the scope-plus-ignored-assets audit are all required.

## Tasks

### 1. Add the placement and appearance guide

**Type**: WRITE
**Output**: `docs/src/how-to/adjust-placement.md` is routed in the sidebar and
the how-to overview, and its offline Documenter example writes
`docs/build/how-to/adjust-placement/adjust-placement.png`.
**Depends on**: none.
**Positive contract**: The page is titled `Adjust silhouette placement and
appearance`, opens with the task of making a silhouette sit and face correctly
on an existing figure, and gives one offline, three-panel visual recipe. The
recipe uses `offline_silhouette()` and the public point method to show: a
`:center` versus `:bottom` placement at visibly marked coordinates; smaller
and larger `glyph_size` values; a positive `xoffset` and `yoffset` that moves
the silhouette away from a marked coordinate; and side-by-side `rotation = 90`
and `mirror = true` results. It saves and embeds `adjust-placement.png`, states
the visible result in plain language, and links to `../api/rendering.md` for
the complete option list.
**Negative contract**: Do not use a network request, a UUID, `image_rendering`,
  FileIO, an arbitrary rotation, a gallery API, a copied parameter catalogue,
  a static-only fence, a source-controlled image, or internal placement prose.
  Do not modify an existing coordinate, range, table, primer, tutorial, API,
  example, source, test, project, or explanation file.
**Files**: Repository files: `docs/make.jl`, `docs/src/how-to/index.md`, and
new `docs/src/how-to/adjust-placement.md`. Generated artifacts: ignored
`docs/build/how-to/adjust-placement/adjust-placement.png` and its rendered
HTML. Temporary baseline artifact:
`/tmp/phylopicmakie-tranche4-out-of-scope.sha256`.
**Out of scope**: `README.md`; `Project.toml`; `docs/Project.toml`;
`docs/Manifest.toml`; `docs/src/index.md`; `docs/src/primer.md`;
`docs/src/tutorial.md`; `docs/src/_offline_silhouette.jl`; `docs/src/examples.md`;
`docs/src/api/`; `docs/src/explanation/`; existing how-to pages; `src/`;
`test/`; `examples/`; `.github/`; package behavior; network behavior; and
tracked PNG files.
**Verification**: Before editing, record the current `git status --short` in
`/tmp/phylopicmakie-tranche4-status-before.txt` and hash every out-of-scope
path listed above that exists, plus all tracked paths under `src/`, `test/`,
`examples/`, and `.github/`, into
`/tmp/phylopicmakie-tranche4-out-of-scope.sha256`. Run
`julia --project=docs docs/make.jl`; require the new PNG to exist and `file`
to identify it as PNG image data; require the rendered
`docs/build/how-to/adjust-placement/index.html` to reference
`adjust-placement.png`; search the page for `placement`, `glyph_size`,
`xoffset`, `yoffset`, `rotation = 90`, and `mirror = true`; and open the
rendered PNG. The pre-work state fails the page, route, PNG, HTML, and
keyword checks.

Add `"Adjust placement and appearance" => "how-to/adjust-placement.md"`
immediately after the existing table-columns route in the `How-to guides`
vector in `docs/make.jl`. Append an `Adjust silhouette placement and
appearance` link to `docs/src/how-to/index.md` after the existing table-column
link; do not alter any existing bullet.

Create the page with the current `@meta` form and the exact named `@setup`
helper-include pattern from `points.md`. Its named `@example` creates one
three-column CairoMakie figure: the first axis contrasts `:center` and
`:bottom` at two outlined point markers; the second contrasts `glyph_size =
0.18` and `glyph_size = 0.42` and includes a third outlined marker with
`xoffset = 0.35` and `yoffset = 0.25`; the third contrasts an unrotated image,
an image with `rotation = 90`, and an image with `mirror = true`. Use
`glyph = offline_silhouette()` for every call; provide short labels directly
on the axes; save the file through `mkpath("adjust-placement")` and the exact
filename; return `nothing`; and embed the generated image. Explain placement
once as "which part of the silhouette touches the coordinate" and explain
offsets once as data-unit nudges. Link to the rendering reference rather than
listing every placement symbol or aspect option.

### 2. Add the image-source and quality guide

**Type**: WRITE
**Output**: `docs/src/how-to/image-sources.md` is routed in the sidebar and
the how-to overview, contains a correct offline-versus-network decision path,
and its local Documenter example writes
`docs/build/how-to/image-sources/image-sources.png`.
**Depends on**: task 1.
**Positive contract**: The page is titled `Choose image sources and quality`,
opens with choosing a usable silhouette source for a figure, and begins with
an executable offline example using `glyph = offline_silhouette()`. It states
that a preloaded image matrix is the offline choice and that
`image_rendering` is ignored on that direct-glyph path. A compact user-level
choice table then names `:thumbnail`, `:raster`, `:og_image`, `:vector`, and
`:source_file`, their actual supplied format/purpose, and the SVG plugin
limitation. A separate ordinary Julia fence shows `node_uuid` with one
`image_rendering` choice, calls that route network-dependent, and is not
executed. The page embeds its local PNG and links to both
`../api/rendering.md` and `../api/phylopic_db.md` for exact reference facts.
**Negative contract**: Do not run or fetch a UUID, show a live image, import
HTTP, Downloads, FileIO, or an SVG plugin, add a dependency, say that a local
glyph obeys `image_rendering`, omit `:og_image`, call the original source an
invariably SVG file, or turn the compact choice table into a copied API
reference. Do not modify task-1 files other than the two navigation files or
touch source, API, environment, test, example, or existing documentation
surfaces.
**Files**: Repository files: `docs/make.jl`, `docs/src/how-to/index.md`, and
new `docs/src/how-to/image-sources.md`. Generated artifacts: ignored
`docs/build/how-to/image-sources/image-sources.png` and its rendered HTML.
**Out of scope**: `docs/src/how-to/adjust-placement.md`; every existing page
other than the how-to overview; `docs/Project.toml`; `docs/Manifest.toml`;
`src/`; `test/`; `examples/`; `.github/`; external network calls; FileIO or
SVG-plugin configuration; public API behavior; and tracked image assets.
**Verification**: Run `julia --project=docs docs/make.jl`; require the new
PNG and its HTML reference; inspect the PNG for a local silhouette figure;
search the source for `glyph = offline_silhouette()`, the statement that
`image_rendering` is ignored, all five exact symbols, `node_uuid`, and
`network-dependent`; and verify that neither `Downloads`, `HTTP`, `using FileIO`,
nor `import FileIO` occurs. Inspect the UUID code fence and confirm that it is
ordinary `julia`, not `@example`. The pre-work state fails the page, route,
PNG, HTML, choice, and offline/network distinction checks.

Append `"Choose image sources and quality" => "how-to/image-sources.md"`
immediately after the task-1 route in `docs/make.jl`, and append the matching
Markdown link after the task-1 bullet in `docs/src/how-to/index.md`.

Create the page with the settled `@meta` and named `@setup` helper pattern.
Its only named `@example` imports CairoMakie and PhyloPicMakie, creates a
small local-coordinate figure with the preloaded helper image, saves
`image-sources/image-sources.png`, returns `nothing`, and embeds that image.
Use the exact five-source decision table specified by the positive contract;
describe `:thumbnail` as the default square PNG, `:raster` as the full-
resolution PNG, `:og_image` as the Open Graph PNG preview, `:vector` as the
SVG silhouette, and `:source_file` as the original uploaded SVG-or-raster
file. State that the latter two can need an SVG-capable FileIO plugin. The
non-executable UUID fence uses the vector point method, a one-element UUID
vector, and `image_rendering = :thumbnail`; it must be preceded by the
network-dependent statement and followed by a reference link, not a claim of
offline reproducibility.

### 3. Add the missing-image policy guide

**Type**: WRITE
**Output**: `docs/src/how-to/missing-images.md` is routed in the sidebar and
the how-to overview, demonstrates the three existing policies with local data,
and writes `docs/build/how-to/missing-images/missing-images.png`.
**Depends on**: tasks 1 and 2.
**Positive contract**: The page is titled `Handle missing images`, opens with
the task of deciding what a figure does when one silhouette is absent, and
uses the public pre-resolved image-vector point method with three coordinates
and the exact image vector `[offline_silhouette(), nothing,
offline_silhouette()]`. One named Documenter example produces a two-panel
figure: the `on_missing = :skip` panel leaves the middle marker without a
silhouette, while the `on_missing = :placeholder` panel shows the package's
gray placeholder at that same middle marker. A separate caught named
Documenter example invokes `on_missing = :error` with the same missing second
image, prints its public error message, and confirms that the failure is at
data point 2. The page embeds its PNG, describes the three user-visible
outcomes, and links to `../api/rendering.md` for full behavior.
**Negative contract**: Do not use a UUID, network request, custom placeholder
drawing, a manually skipped data vector, a fake warning for `:error`, a static
code fence as the only policy proof, a gallery API, an API catalogue, or
internal renderer prose. Do not modify source, tests, examples, environments,
the API reference, any existing how-to page other than the overview, or task-1
and task-2 page content.
**Files**: Repository files: `docs/make.jl`, `docs/src/how-to/index.md`, and
new `docs/src/how-to/missing-images.md`. Generated artifacts: ignored
`docs/build/how-to/missing-images/missing-images.png` and its rendered HTML.
**Out of scope**: `docs/src/how-to/adjust-placement.md`;
`docs/src/how-to/image-sources.md`; every existing documentation page except
the how-to overview; `src/_render_core.jl`; all other `src/`; `test/`;
`examples/`; `.github/`; project environments; public API and missing-image
semantics; network behavior; and source-controlled image assets.
**Verification**: Run `julia --project=docs docs/make.jl`; require the new
PNG and its HTML reference; inspect the image for a blank middle marker in the
skip panel and a gray placeholder in the placeholder panel; search the source
for `nothing`, `on_missing = :skip`, `on_missing = :placeholder`, and
`on_missing = :error`; confirm that the caught error example prints the
substring `missing image for data point 2`; and verify that the page contains
no `node_uuid`, `Downloads`, HTTP, `@autodocs`, `@docs`, or `@index`. The
pre-work state fails the page, route, three-policy, PNG, HTML, and visible-
distinction checks.

Append `"Handle missing images" => "how-to/missing-images.md"` immediately
after the task-2 route in `docs/make.jl`, and append the matching Markdown link
after the task-2 bullet in `docs/src/how-to/index.md`.

Create the page with the established `@meta` and named `@setup` helper include.
The image-producing named example shares one explicit coordinate array and the
three-entry image vector across its two axes, draws the same outlined markers
on both, calls the four-argument public method once per panel with the exact
skip and placeholder values, saves the named PNG, and embeds it. The separate
caught example must allocate a fresh local CairoMakie figure and axis, call
the same four-argument method with `on_missing = :error`, catch the resulting
`ErrorException`, assert that its rendered message includes `missing image for
data point 2`, print that message, and return `nothing`. The prose must call
the gray glyph the package placeholder and explain that `:error` stops the
plotting call; it must not define a new fallback policy.

### 4. Verify the completed how-to surface and its scope

**Type**: TEST
**Output**: A recorded green verification result proves the three pages render,
remain task-oriented and offline, use accurate public terms, and do not expand
the authorized worktree scope.
**Depends on**: tasks 1, 2, and 3.
**Positive contract**: Run the full docs build, inspect all three rendered HTML
pages and PNGs, complete every lock-item audit, and record concise results in
the implementation report. Confirm that each page starts from a distinct
reader task, exposes its corresponding sidebar and overview link, has one
build-generated image, links to the rendering reference, and keeps the docs
environment and source tree unchanged.
**Negative contract**: Do not edit any repository file, weaken a check because
the worktree was already dirty, accept a static fence or a green build as the
only proof, add source-text policing to CI or tests, regenerate or track an
asset outside ignored build output, or claim completion while any lock item
survives.
**Files**: No repository file may be changed. Temporary evidence only:
`/tmp/phylopicmakie-tranche4-status-before.txt`,
`/tmp/phylopicmakie-tranche4-out-of-scope.sha256`,
`/tmp/phylopicmakie-tranche4-out-of-scope-after.sha256`, and
`/tmp/phylopicmakie-tranche4-verification.txt`.
**Out of scope**: Every repository file, public surface, dependency, build
configuration, source-controlled asset, CI rule, and document content.
**Verification**: Run `julia --project=docs docs/make.jl`. Require all of
`docs/build/how-to/adjust-placement/adjust-placement.png`,
`docs/build/how-to/image-sources/image-sources.png`, and
`docs/build/how-to/missing-images/missing-images.png`; use `file` on all
three; and require each matching rendered `index.html` to reference its image.
Inspect all three images and rendered HTML pages manually. Confirm the six
placement controls, all five image-rendering symbols plus the local-glyph and
network-dependent statements, and the three missing-image policies plus the
caught error text. Confirm the exact three routes in `docs/make.jl` and three
links in the how-to overview.

Run a failure-oriented source audit over only the three new pages. It must
reject `@autodocs`, `@docs`, `@index`, `generic anchored-overlay`, `shared
internal anchored-overlay substrate`, `owner layer`, `data-anchor`, `projected
pixel-anchor`, `placement mechanics`, `projection mechanics`, and `internal
owner`; reject `Downloads`, HTTP imports, FileIO imports, and an executable
UUID example; and confirm that the UUID code in `image-sources.md` is a plain
Julia fence. Confirm that only the image-source guide contains `node_uuid`,
and that the placement and missing-image guides do not.

Re-hash the exact out-of-scope paths from task 1 into
`/tmp/phylopicmakie-tranche4-out-of-scope-after.sha256` and compare it with
the original hash. Inspect `git status --short` against the saved baseline and
confirm that the only intentional repository edits are `docs/make.jl`,
`docs/src/how-to/index.md`, and the three named new pages; pre-existing status
must remain present rather than be erased. Confirm `git check-ignore -q
docs/build`, `git check-ignore -q docs/Manifest.toml`, and that `git ls-files
docs/src` reports no PNG. These checks must fail a source change, unexpected
environment change, tracked image, or lost earlier-tranche work.
