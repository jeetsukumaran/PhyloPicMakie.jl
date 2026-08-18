---
date-created: 2026-08-16T00:43:09-07:00
workflow-instrument: Tasking plan
workflow-status: Superseded
workflow-agent-thread-id: codex/01a00962-4fcc-7f22-8ca4-1cb895eb90a5
workflow-agent-implementing-id:
  - codex/01a009a0-d213-71d0-a283-a044050c0fa7
workflow-location: /home/jeetsukumaran/site/storage/local/computing/research/20260414_PhyloPicMakie.jl/PhyloPicMakie.jl
workflow-production-id: diataxis-docs-primer
workflow-prd: .workflow-docs/202608140015_diataxis-docs-rewrite/01_prd.md
workflow-tranche: .workflow-docs/202608140015_diataxis-docs-rewrite/02_tranches.md
---

# Tasks for tranche 3: Write coordinate, range, and table how-tos

## Remedial correction required: 2026-08-16 owner correction

This implemented tasking file is superseded archival context. It predates the project owner's 2026-08-16 correction that point, range, and table how-tos must teach the normal user trajectory: start from PhyloPic identifiers, taxon-derived identifiers, tables that carry those identifiers, or package-supported lookup, then place silhouettes.

All instructions in this file that require `docs/src/_offline_silhouette.jl`, `offline_silhouette()`, preloaded image matrices, an offline-only executable path, or local-image-first examples as the main how-to path are superseded by `.workflow-docs/202608140015_diataxis-docs-rewrite/02_tranches.md` Tranche R1 and the revised PRD. The table `node_uuid` selector is no longer optional side material by product decision; it must be placed in the PhyloPic-backed learning path while staying honest about network and caching behavior.

DataCaches guidance must follow the revised boundary: later how-to or explanation content may discuss repeated-query performance, but explicit DataCaches claims must name `PhyloPicDB.batch_primary_images`, `PhyloPicDB.batch_images`, the upstream DataCaches API being shown, or a separately approved source change.

This file also predates the repo-local `STYLE-agent-language.md` update. Any
instruction below that uses ownership, contract, boundary, layer, invariant,
compatibility, verification, source, or responsibility language is not
executable unless Tranche R1 or a regenerated tasking file expands it with the
exact file, function, module, public surface, or external contract; the
behavior; the consumer; the duplicate or bypass path that must not keep the
behavior; and the verification artifact that fails the vague statement.

## Settled user decisions and environment baseline

- This is documentation work. It must not change public API behavior, exported
  names, plotting behavior, range-anchor behavior, table extraction behavior,
  network behavior, package dependencies, CI behavior, or example-script
  behavior.
- `docs/make.jl` is the sole file that declares the Documenter sidebar. The
  existing `How-to guides` group contains `Overview => how-to/index.md`; this
  tranche appends three pages to that group in the order specified by tasks 1
  through 3.
- `docs/src/how-to/index.md` is the sole route page for the how-to collection.
  It must list only guides that already exist at the end of each task. It must
  not use placeholder links or claim that unwritten guides are available.
- The current fresh baseline is green. On 2026-08-16,
  `julia --project=docs docs/make.jl` exited 0, and
  `docs/build/primer/primer-silhouettes.png` plus
  `docs/build/tutorial/tutorial-first-figure.png` were valid PNG files.
  Preserve the working Tranche 1 navigation and Tranche 2 primer/tutorial
  content while adding this tranche's pages.
- `docs/Project.toml` already declares `CairoMakie`, `Documenter`, and
  `PhyloPicMakie`. `docs/Manifest.toml` and `docs/build/` are ignored build
  products. This tranche must not add a dependency or edit either project
  environment.
- Use the current, working docs-private helper
  `docs/src/_offline_silhouette.jl`. Each new page's hidden named `@setup`
  block must use the same include form that currently works in
  `docs/src/primer.md` and `docs/src/tutorial.md`:
  `include(joinpath(pwd(), "..", "src", "_offline_silhouette.jl"))`.
  The setup block must import CairoMakie before that include. The generated
  figures belong only under the corresponding `docs/build/how-to/.../`
  directory.
- The required learning path remains offline. All executable examples in this
  tranche use `offline_silhouette()` and make no remote request.
- The table overload of `augment_phylopic!` selects only `x`, `y`, and,
  optionally, `node_uuid` columns. It broadcasts one `glyph` matrix to every
  row. It has no image-column or label-column selector. The table guide must
  state that limitation and use the public vector-with-images overload plus
  `CairoMakie.text!` for offline image and label columns.
- A table-held `node_uuid` selector is a network-dependent path. The table
  guide may contain one clearly marked, non-executable code fence that shows
  the supported selector spelling and links to the rendering reference. It
  must not make a request, generate a live image, claim offline behavior, or
  create a live-data guide. Tranche 7 retains responsibility for the placement
  and full content of live UUID documentation.
- Generated PNGs are verification artifacts, not source documentation assets.
  Do not copy an image into `docs/src/`, add a PNG to version control, or add a
  source-text test to CI.
- This tranche has no migration, compatibility shim, exact-inference, or
  returned-type guarantee.

## Governance

Before implementation, read each applicable authority line by line and comply
with it throughout the work:

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
- `STYLE-agent-language.md`.
- `STYLE-agent-handoffs.md`.
- `STYLE-workflow-vocabulary.md`.

`STYLE-agent-language.md` applies wherever this tasking uses responsibility,
contract, boundary, invariant, compatibility, verification, source, or
similar architecture language. The implementing agent must name the exact file
or public function, its behavior, the consuming pages or callers, prohibited
duplicate behavior, and the failing verification artifact.

Expected authorities not found during tasking are repo-local `CONTRIBUTING*.md`,
`STYLE-python.md`, and `STYLE-domain-vocabulary.md`. Their absence does not
relax the listed authorities.

Read-only shell and Git commands are allowed. Commit, merge, push, branch,
checkout, rebase, and reset operations remain the project owner's
responsibility.

## Upstream primary sources and settled constraints

- [Diátaxis how-to guides](https://diataxis.fr/how-to-guides/) requires a
  guide to address a concrete user goal, use an action sequence, omit teaching
  and reference catalog material, and link elsewhere for full options. The
  three page titles and focused scopes below implement that constraint.
- [Documenter syntax](https://documenter.juliadocs.org/stable/man/syntax/)
  specifies that named `@setup` and `@example` blocks on one page share an
  evaluation context; `@example` runs code; and saved media may be referenced
  from the rendered page. The three new pages therefore use a separate named
  setup/example context and save one page-local PNG each.
- [Documenter guide](https://documenter.juliadocs.org/stable/man/guide/) and
  [Documenter public API](https://documenter.juliadocs.org/stable/lib/public/)
  establish `docs/src/`, `docs/make.jl`, `makedocs`, and the build directory as
  the documentation surfaces. Do not use filename ordering as navigation.
- `src/_augment_api.jl` defines the high-level point, range, and table forms:
  the point table method extracts `x`, `y`, and optional `node_uuid`; the
  range table method extracts `xstart`, `xstop`, `y`, and optional
  `node_uuid`; direct `glyph` input is one image matrix broadcast to all data.
- `src/_render_core.jl` defines the public low-level point and range methods
  that accept an `AbstractVector` of pre-resolved images. The table guide uses
  that point method for its per-row offline image column and supplies its
  required `glyph_size`, `aspect`, `placement`, `xoffset`, `yoffset`,
  `rotation`, `mirror`, and `on_missing` keywords explicitly.
- `examples/src/explicit_overlays.jl` is the project-owned executable evidence
  for point and range overlays. The new pages may link to `examples.md`, but
  must not copy that script or edit it.

## Primary-goal lock

### Lock 1: Place silhouettes on points

- The work is not complete if a reader with x and y coordinates still has no
  goal-titled page that produces a visible offline point-overlay figure.
- Direct red-state repro: `docs/src/how-to/` contains only `index.md`; the
  rendered sidebar contains only `Overview` under `How-to guides`.
- Tasks that close it: task 1 and task 4.
- Failing verification artifact: the old state fails the `test -f
  docs/src/how-to/points.md` check, the `docs/make.jl` route-label check, and
  the PNG/type/HTML checks for
  `docs/build/how-to/points/points-silhouettes.png`.

### Lock 2: Place silhouettes on ranges

- The work is not complete if a reader with interval endpoints cannot see an
  offline guide that demonstrates `:start`, `:midpoint`, and `:stop` as the
  three `at` values.
- Direct red-state repro: there is no `docs/src/how-to/ranges.md`, and the
  existing example script is the only local point-and-range presentation.
- Tasks that close it: task 2 and task 4.
- Failing verification artifact: the old state fails the range-page and route
  checks and has no valid
  `docs/build/how-to/ranges/ranges-silhouettes.png` linked from the rendered
  range page.

### Lock 3: Use table columns without inventing unsupported selectors

- The work is not complete if a reader cannot follow an offline table recipe
  for coordinate, image, and label columns, or if the page claims that the
  `augment_phylopic!` table overload accepts image or label selectors that
  `src/_augment_api.jl` does not define.
- Direct red-state repro: no table guide exists. The current table overload
  accepts `x`, `y`, optional `node_uuid`, and one broadcast `glyph`; it does
  not accept `image = :image` or `label = :label`.
- Tasks that close it: task 3 and task 4.
- Failing verification artifact: the direct docs-environment API probe in task
  4 proves both supported forms — table-plus-broadcast-glyph and
  vector-plus-per-row-images — and the generated table PNG plus rendered-page
  review fails an absent or non-executable offline recipe.

### Lock 4: Keep optional node UUID use accurate and non-core

- The work is not complete if the table guide omits the supported
  `node_uuid = :node_uuid` selector entirely, presents its network request as
  offline, or becomes a live-data how-to before Tranche 7's project-owner
  decision.
- Direct red-state repro: no documentation page presently explains the table
  UUID selector, while `src/_augment_api.jl` accepts it and resolves images
  through the network path.
- Tasks that close it: task 3 and task 4.
- Failing verification artifact: task 4's page audit requires the exact
  `node_uuid = :node_uuid` spelling, an explicit network-dependent label, a
  non-`@example` code fence, and no generated live image or network import.

### Lock 5: Preserve the how-to/reference boundary

- The work is not complete if any new page is a keyword catalog, copies an
  `@autodocs` block, or explains the internal anchored-overlay implementation
  instead of giving a practical task sequence and one reference link.
- Direct red-state repro: the existing `docs/src/api/rendering.md` is the only
  rendering help and begins with implementation-mechanics prose; there are no
  task pages to take the practical teaching role.
- Tasks that close it: tasks 1 through 4.
- Failing verification artifact: the audit in task 4 rejects `@autodocs`,
  `@docs`, `@index`, the forbidden implementation-first phrases, and missing
  links to `../api/rendering.md` in any new how-to page.

### Lock 6: Keep the documentation-only, offline boundary

- The work is not complete if implementation, API, CI, dependency, existing
  example-script, or source-asset changes are used to make the pages pass.
- Direct red-state repro: the PRD explicitly excludes API and implementation
  changes, and generated PNGs are build products rather than source assets.
- Tasks that close it: tasks 1 through 4.
- Failing verification artifact: task 1 records hashes of all out-of-scope
  source surfaces before editing; task 4 compares the final hashes, confirms
  ignored build products, and confirms that no PNG is tracked below
  `docs/src/`.

## Forbidden passing implementation table

| Lock item | Required behavior | Current code state | Resolved implementation instruction | Forbidden passing implementation | Failing verification artifact |
| --- | --- | --- | --- | --- | --- |
| Lock 1: Place silhouettes on points | A page titled `Place silhouettes on points` gives an executable, offline point recipe and renders one visible PNG. | `docs/src/how-to/` has only `index.md`; `docs/make.jl` lists only `Overview` in the how-to group. | In task 1, create `docs/src/how-to/points.md`, save `points-silhouettes.png` from a named Documenter example, add the exact sidebar label, and add one overview link. | Add a prose-only overview bullet or a static code fence while leaving no routed page or generated image. | The page-existence, sidebar-route, PNG-file-type, HTML-image-link, and rendered-image checks in task 1 and task 4 fail. |
| Lock 2: Place silhouettes on ranges | A page titled `Place silhouettes on ranges` visibly distinguishes `at = :start`, `:midpoint`, and `:stop`. | `examples/src/explicit_overlays.jl` has a range panel, but no documentation page exposes the three anchor choices as a reader task. | In task 2, create `docs/src/how-to/ranges.md` with one offline named example that renders all three anchors and saves `ranges-silhouettes.png`. | Mention only `:midpoint`, or copy the point recipe and call it a range guide. | The page audit for all three exact `at` values and the rendered range PNG fail. |
| Lock 3: Use table columns without inventing unsupported selectors | The table page demonstrates offline coordinate, per-row image, and label columns while stating the actual selector limitation. | `augment_phylopic!(ax, table; ...)` extracts only x, y, and optional node UUID columns; `glyph` is one broadcast matrix. | In task 3, use a `NamedTuple` with `x`, `y`, `image`, and `label`; pass x/y/image vectors to the public vector-with-images method; place labels with `CairoMakie.text!`; state that no image or label selector exists on the table overload. | Document `glyph = :image`, `image = :image`, or `label = :label` as accepted table keywords. | The direct API probe and the rendered offline table example in task 4 fail the claimed selector behavior. |
| Lock 4: Keep optional node UUID use accurate and non-core | The table page names the supported UUID selector and labels it as network-dependent without running it. | `src/_augment_api.jl` accepts `node_uuid` selectors, but docs contain no table UUID guidance. | In task 3, add one ordinary Julia fence containing `node_uuid = :node_uuid`, label it network-dependent, and link to the rendering reference; do not use `@example` for it. | Add an executable live request, call the result offline, or defer all mention of the selector despite the stated table requirement. | The task 4 audit checks the exact selector, network label, absence of an `@example` UUID block, absence of `Downloads`/HTTP imports, and absence of a live PNG. |
| Lock 5: Preserve the how-to/reference boundary | Each guide starts from a user goal, has a concise action sequence and expected result, and links to the rendering reference for details. | `docs/src/api/rendering.md` carries the public reference and internal mechanics prose; there are no focused task pages. | Tasks 1 through 3 write goal-titled pages and link to `../api/rendering.md`; task 4 audits role drift. | Put a copied signature/keyword catalog or `@autodocs` block in the how-to pages and call a green docs build sufficient. | The forbidden-form and required-reference-link audit in task 4 fails. |
| Lock 6: Keep the documentation-only, offline boundary | The final diff modifies only the three new how-to pages, their existing route/index files, and ignored build outputs. | Current workspace has pre-existing Tranches 1 and 2 documentation changes; docs build products and manifest are ignored. | Task 1 records out-of-scope hashes before changes; tasks 1 through 3 limit edits to the exact listed Markdown/navigation files; task 4 compares hashes and tracked assets. | Edit `src/`, `test/`, examples, CI, docs environments, or add a tracked PNG to make a prose example work. | The baseline-hash comparison, `git check-ignore` checks, and `git ls-files docs/src` PNG check in task 4 fail. |

## Handoff packet

- **Active authorities**: This tasking file; the approved PRD and tranche plan;
  all repo-local governance documents named above.
- **Parent documents**: `.workflow-docs/202608140015_diataxis-docs-rewrite/01_prd.md`
  and `.workflow-docs/202608140015_diataxis-docs-rewrite/02_tranches.md`.
- **Settled decisions and non-negotiables**: The docs follow Diátaxis; first
  learning remains offline; Documenter navigation is explicit; API facts stay
  in source docstrings/reference; generated PNGs are ignored build products;
  live UUID documentation remains a Tranche 7 decision; public behavior is
  not authorized to change.
- **Authorization boundary**: The implementation may edit
  `docs/make.jl`, `docs/src/how-to/index.md`, and exactly
  `docs/src/how-to/points.md`, `docs/src/how-to/ranges.md`, and
  `docs/src/how-to/table-columns.md`. It may create ignored output only under
  `docs/build/how-to/` and `/tmp`. Every other repository surface is out of
  scope.
- **Current-state diagnosis**: Tranches 1 and 2 have installed a working
  sidebar, primer, tutorial, offline helper, CairoMakie docs dependency, and
  docs-build images. The docs build currently passes. The how-to route remains
  a single overview page without point, range, or table guides.
- **Primary-goal lock**: Locks 1 through 6 above. Verify each separately; a
  green docs build alone does not close them.
- **Direct red-state repros**: absent page files and sidebar routes; no range
  page showing all `at` values; no table guide; no UUID-selector explanation;
  API-reference-only practical help; and the possibility of changing code or
  committing generated images.
- **Responsible files and behaviors**: `docs/make.jl` orders the rendered
  sidebar; `docs/src/how-to/index.md` links to completed how-to pages;
  `points.md`, `ranges.md`, and `table-columns.md` each contain one practical
  reader recipe; `src/_augment_api.jl` and `src/_render_core.jl` remain the
  API-fact sources; `examples/src/explicit_overlays.jl` remains executable
  point/range evidence. The new Markdown pages must not duplicate API
  implementation or replace the example script.
- **Exact scope**: The five repository files named in the authorization
  boundary and ignored build artifacts from their Documenter examples.
- **Required upstream primary sources**: the Diátaxis how-to page, Documenter
  syntax/guide/public-API pages listed above, `src/_augment_api.jl`,
  `src/_render_core.jl`, `examples/src/explicit_overlays.jl`, and the current
  successful `docs/src/primer.md`/`docs/src/tutorial.md` setup pattern.
- **Green-state gates**: docs build; CI-style doctests; three new how-to PNGs
  with HTML references; direct table-API probe; explicit-overlay PNG; prose
  and route audits; visual review; scope/ignored-asset audit.
- **Stop conditions**: Stop before an edit if the baseline docs build becomes
  red, the current setup/include pattern stops working, a required example
  needs a dependency or public API change, a live UUID request is needed for
  an executable example, an API fact is not supported by the listed source, or
  the work would overwrite a pre-existing Tranche 1 or Tranche 2 change.

## Required revalidation before implementation

- Read the parent PRD, tranche plan, and this tasking file in full.
- Read all governance documents named above line by line.
- Re-run `julia --project=docs docs/make.jl`; stop if it exits nonzero before
  editing a Tranche 3 file.
- Read `docs/make.jl`, `docs/src/how-to/index.md`, `docs/src/primer.md`,
  `docs/src/tutorial.md`, `docs/src/_offline_silhouette.jl`,
  `docs/src/api/rendering.md`, `src/_augment_api.jl`, `src/_render_core.jl`,
  and `examples/src/explicit_overlays.jl` in full.
- Read the Diátaxis and Documenter primary sources listed above in full before
  editing a guide or Documenter example.
- Confirm that `docs/Project.toml` still declares CairoMakie and that
  `docs/build/` plus `docs/Manifest.toml` remain ignored.
- Stop and raise any mismatch between this handoff and the current code,
  environment, rendered artifacts, or authorization boundary.

## Tranche execution rule

This tranche extends the existing documentation map with three independently
buildable how-to pages. At the end of every write task, the full docs build and
that task's new render artifact must be green. The completed pages may rely on
the existing docs-private helper, but that helper remains Tranche 2's small
in-memory image definition and must not gain new plotting, range, table,
network, or label behavior.

## Non-negotiable execution rules

- Do not change `src/`, `test/`, `examples/`, `.github/`, a project file, an
  API page, the README, the docs home page, the primer, tutorial, explanation,
  or the offline helper.
- Do not alter `augment_phylopic!`, `augment_phylopic_ranges!`,
  `_extract_column`, range anchoring, missing-image behavior, or the table
  method to make a documentation example shorter.
- Do not introduce `DataFrames`, `Tables`, HTTP, Downloads, `node_uuid` data
  fetching, external image files, or source-controlled PNGs to the executable
  learning path.
- Do not call a `NamedTuple`-field recipe the package's table overload. Name
  the actual public overload used in the prose and preserve the table
  overload's current selector limitation.
- Do not add `@autodocs`, `@docs`, `@index`, a copied signature catalog, or
  internal anchored-overlay mechanics to a how-to page.
- Do not add source-text policing to test files or CI. The text searches in
  this tasking are local, failure-oriented session verification only.
- Do not erase, reformat, or fold in the pre-existing uncommitted Tranche 1 or
  Tranche 2 work.

## Concrete anti-patterns or removal targets

- Remove the forward-looking paragraph in `docs/src/how-to/index.md` beginning
  "This route will collect". Replace it incrementally with links only to
  pages completed by the current task.
- Prevent the old `examples.md` command list and `api/rendering.md` reference
  page from remaining the only practical path for points, ranges, or table
  data.
- Prevent the table guide from describing nonexistent `image` or `label`
  selector keywords, or from moving a network-dependent UUID demonstration
  into the offline learning path.
- Prevent a static code fence, a docs build with no image, or a checked-in
  asset from being accepted in place of a rendered how-to artifact.
- Prevent point/range code from becoming a second copy of
  `examples/src/explicit_overlays.jl`; each guide must retain one concise
  recipe and link to the fuller example.

## Failure-oriented verification

- The pre-work repository fails the three source-page existence checks, the
  three `docs/make.jl` route-label checks, and all three rendered-PNG checks.
- The range page audit must fail when any of `:start`, `:midpoint`, or `:stop`
  is absent from the documented executable example.
- The table-API probe must fail a page that claims unsupported image/label
  selectors because the public table overload only accepts its documented
  selectors. The probe must separately succeed for the table-plus-broadcast
  glyph method and the vector-plus-per-row-images method.
- The optional UUID section audit must fail an executable `@example`, a live
  PNG, a network import, or missing network-dependent label.
- The docs build is necessary but insufficient. The new image file checks,
  rendered HTML checks, visual review, exact route checks, prose-role audit,
  direct API probe, explicit-overlay artifact, and scope/asset audit are all
  required.

## Tasks

### 1. Add the offline point-coordinate guide

**Type**: WRITE
**Output**: `docs/src/how-to/points.md` is routed in the sidebar and contains
an executable offline point recipe that renders
`docs/build/how-to/points/points-silhouettes.png`.
**Depends on**: none.
**Positive contract**: The page is titled `Place silhouettes on points`, opens
with the reader's coordinate-annotation goal, gives one concise action
sequence using the public `augment_phylopic!` point form and
`offline_silhouette()`, states the visible expected result, links to
`../api/rendering.md` for option facts, and saves/embeds a PNG built by
Documenter. The sidebar and how-to overview expose only the completed point
guide after this task.
**Negative contract**: The page must not use a network request, a UUID, an API
catalog, internal implementation prose, a copied explicit-overlay script, a
source-controlled image, or a placeholder link to range/table pages. Do not
modify existing Tranche 1 or Tranche 2 pages.
**Files**: Repository files: `docs/make.jl`, `docs/src/how-to/index.md`, and
new `docs/src/how-to/points.md`. Generated artifacts: ignored
`docs/build/how-to/points/points-silhouettes.png` and its rendered HTML.
Temporary baseline artifact: `/tmp/phylopicmakie-tranche3-out-of-scope.sha256`.
**Out of scope**: `README.md`; `docs/Project.toml`; `docs/src/index.md`;
`docs/src/primer.md`; `docs/src/tutorial.md`; `docs/src/_offline_silhouette.jl`;
`docs/src/examples.md`; `docs/src/explanation/`; `docs/src/api/`; `src/`;
`test/`; `examples/`; `.github/`; tracked image files; public API behavior;
network behavior.
**Verification**: Before editing, create
`/tmp/phylopicmakie-tranche3-out-of-scope.sha256` by hashing the paths returned
by `rg --files src test examples .github` together with `Project.toml`,
`docs/Project.toml`, `examples/Project.toml`, `README.md`,
`docs/src/index.md`, `docs/src/primer.md`, `docs/src/tutorial.md`,
`docs/src/_offline_silhouette.jl`, `docs/src/examples.md`,
`docs/src/api/rendering.md`, `docs/src/api/phylopic_db.md`, and
`docs/src/explanation/index.md`. Then run `julia --project=docs docs/make.jl`;
`test -f docs/build/how-to/points/points-silhouettes.png`; `file
docs/build/how-to/points/points-silhouettes.png`; `rg -n
"points-silhouettes\\.png" docs/build/how-to/points/index.html`; and checks
for the exact page/route title. The pre-work state fails the page, route, PNG,
and HTML checks.

Replace the stale future-tense route paragraph with an `Available guides`
list containing only `[Place silhouettes on points](points.md)`. Append
`"Place silhouettes on points" => "how-to/points.md"` immediately after the
existing `Overview` entry in the `How-to guides` vector in `docs/make.jl`.

Create `points.md` with the existing `@meta CurrentModule = PhyloPicMakie`
form and one named `@setup point-silhouettes` block. Import CairoMakie and
PhyloPicMakie there, then use the settled helper include form from the
environment baseline. Its named `@example point-silhouettes` block must create
one CairoMakie axis, draw a small point context, call
`augment_phylopic!(axis, [1.0, 2.5, 4.0], [1.1, 2.3, 1.5]; glyph =
offline_silhouette(), glyph_size = 0.32, placement = :bottom, yoffset = 0.12)`,
save `points-silhouettes.png`, and return `nothing` so only the intended code
and image remain. Embed that image directly below the example. Use a short
expected-result note that says silhouettes appear at the plotted coordinates,
then link to the rendering reference and existing fuller example page.

### 2. Add the offline range-coordinate guide

**Type**: WRITE
**Output**: `docs/src/how-to/ranges.md` is routed in the sidebar and contains
an executable offline range recipe that renders
`docs/build/how-to/ranges/ranges-silhouettes.png` with start, midpoint, and
stop anchors.
**Depends on**: task 1.
**Positive contract**: The page is titled `Place silhouettes on ranges`, opens
with the interval-annotation goal, gives a concise practical sequence, visibly
uses `at = :start`, `at = :midpoint`, and `at = :stop` in one offline
Documenter example, states the expected result, and links to
`../api/rendering.md` for all remaining options. The overview and sidebar list
the completed range guide after the point guide.
**Negative contract**: Do not reduce the recipe to a point overlay, omit one
of the three anchor values, add network data, turn the page into a discussion
of range implementation, copy the full explicit example script, or add a
placeholder link to the table guide. Do not alter the range implementation or
the docs environment.
**Files**: Repository files: `docs/make.jl`, `docs/src/how-to/index.md`, and
new `docs/src/how-to/ranges.md`. Generated artifacts: ignored
`docs/build/how-to/ranges/ranges-silhouettes.png` and its rendered HTML.
**Out of scope**: `docs/src/how-to/points.md`; every existing documentation
page other than the how-to overview; `src/_augment_api.jl`;
`src/_render_core.jl`; `src/_coordinates.jl`; all other `src/`, `test/`,
`examples/`, `.github/`, project-environment, public API, and network surfaces.
**Verification**: Run `julia --project=docs docs/make.jl`; `test -f
docs/build/how-to/ranges/ranges-silhouettes.png`; `file
docs/build/how-to/ranges/ranges-silhouettes.png`; `rg -n
"ranges-silhouettes\\.png" docs/build/how-to/ranges/index.html`; three
separate `rg -n` checks for `at = :start`, `at = :midpoint`, and `at = :stop`
in `docs/src/how-to/ranges.md`; and inspect the
rendered image for three interval rows whose glyphs occupy the stated start,
midpoint, and stop positions. The old state fails every page, route, PNG, and
three-anchor check.

Append `[Place silhouettes on ranges](ranges.md)` to the existing `Available
guides` list without changing the point bullet. Append
`"Place silhouettes on ranges" => "how-to/ranges.md"` immediately after the
point route in `docs/make.jl`.

Create `ranges.md` with the same `@meta` form and a separate named
`@setup range-silhouettes` block that imports CairoMakie and PhyloPicMakie and
includes the settled helper. Its named example must draw intervals from
`xstart = [0.8, 0.8, 0.8]` to `xstop = [4.8, 4.8, 4.8]` at
`y = [3.0, 2.0, 1.0]`, set `xlims!(axis, 0.4, 5.2)` and
`ylims!(axis, 0.5, 3.5)`, then call the public `augment_phylopic_ranges!`
once for each row with the same preloaded glyph and the explicit `at` values `:start`,
`:midpoint`, and `:stop`; use `glyph_size = 0.24`, `placement = :bottom`, and
`yoffset = 0.16` so the visible glyphs do not hide the interval marks. Save
and embed `ranges-silhouettes.png`. State in ordinary prose that `at` selects
where along each interval the silhouette is placed, and link to the rendering
reference instead of enumerating the broader keyword surface.

### 3. Add the offline table-column guide

**Type**: WRITE
**Output**: `docs/src/how-to/table-columns.md` is routed in the sidebar and
contains an executable offline table recipe that renders
`docs/build/how-to/table-columns/table-columns-silhouettes.png`, accurately
explains image/label-column handling, and contains one non-executable
network-dependent UUID selector note.
**Depends on**: tasks 1 and 2.
**Positive contract**: The page is titled `Use table columns`, opens with the
goal of keeping coordinate, image, and label data together, uses a dependency-
free `NamedTuple` for its executable offline data, renders per-row images
through the public vector-with-images `augment_phylopic!` method, places the
matching labels with `CairoMakie.text!`, and links to
`../api/rendering.md`. It explicitly states that the table overload selects
only coordinate and optional UUID columns and broadcasts one glyph. A separate
short UUID section shows `node_uuid = :node_uuid` in one ordinary Julia fence,
labels that path network-dependent, and does not execute it.
**Negative contract**: Do not add DataFrames or Tables dependencies; claim that
`image = :image`, `glyph = :image`, or `label = :label` is an accepted table
selector; use an executable UUID fetch; generate a live image; link to an
unwritten live UUID guide; copy a full parameter catalog; or alter API source
to make the desired selectors exist.
**Files**: Repository files: `docs/make.jl`, `docs/src/how-to/index.md`, and
new `docs/src/how-to/table-columns.md`. Generated artifacts: ignored
`docs/build/how-to/table-columns/table-columns-silhouettes.png` and its
rendered HTML.
**Out of scope**: `docs/src/how-to/points.md`; `docs/src/how-to/ranges.md`;
all source/docstring files; `docs/Project.toml`; every test, example, CI,
network, public API, and source-controlled-image surface.
**Verification**: Run `julia --project=docs docs/make.jl`; `test -f
docs/build/how-to/table-columns/table-columns-silhouettes.png`; `file
docs/build/how-to/table-columns/table-columns-silhouettes.png`; `rg -n
"table-columns-silhouettes\\.png" docs/build/how-to/table-columns/index.html`;
and inspect the rendered image for one label per image. Audit the source for
the exact text `node_uuid = :node_uuid`, a network-dependent label, one plain
`julia` UUID fence rather than an `@example` UUID fence, and the limitation on
image/label selectors. The old state has no page, image, or accurate table
recipe and fails these checks.

Append `[Use table columns](table-columns.md)` after the point and range
bullets. Append `"Use table columns" => "how-to/table-columns.md"` immediately
after the range route in `docs/make.jl`.

Create `table-columns.md` with the established metadata and a named
`@setup table-columns` block that imports CairoMakie and PhyloPicMakie and
includes the existing helper. In the named executable example, construct a
`NamedTuple` with exactly `x`, `y`, `image`, and `label` fields: `x = [1.0,
2.7, 4.4]`, `y = [1.2, 2.4, 1.8]`, three `offline_silhouette()` matrices in
`image`, and labels `"Sample A"`, `"Sample B"`, and `"Sample C"`. Draw
coordinate context with `xlims!(axis, 0.4, 5.0)` and `ylims!(axis, 0.5, 3.0)`; call
the public vector-with-images method with `records.x`, `records.y`, and
`records.image`; and provide its required keywords exactly as follows:
`glyph_size = 0.28`, `aspect = :preserve`, `placement = :bottom`,
`xoffset = 0.0`, `yoffset = 0.14`, `rotation = 0.0`, `mirror = false`, and
`on_missing = :skip`. Call `CairoMakie.text!` with `records.label` at
`CairoMakie.Point2f.(records.x, records.y .- 0.30)` using
`align = (:center, :top)`, save `table-columns-silhouettes.png`, and
embed that image. Explain that the page uses fields from one table-like value,
but calls the vector image method because the table overload does not accept
per-row images or labels.

Add a short final `Use a node UUID column` section. It must contain only one
ordinary Julia fence showing a table named `network_records` with
`x = [1.0]`, `y = [1.0]`, and
`node_uuid = ["3c4b8687-2401-4e5b-afb5-19aa3e7e8b26"]` fields followed by
`augment_phylopic!(axis, network_records; x = :x, y = :y, node_uuid =
:node_uuid)`. State immediately before that fence that it requests remote
PhyloPic data and is outside the offline recipe. Link to
`../api/rendering.md` for exact behavior. Do not save an image, import a
network package, or describe the full live workflow in this section.

### 4. Verify the three rendered guides and their boundaries

**Type**: TEST
**Output**: A recorded green verification run demonstrates three routed,
rendered guides; true point/range example evidence; accurate table behavior;
offline/live separation; and an unchanged out-of-scope surface.
**Depends on**: tasks 1, 2, and 3.
**Positive contract**: The docs build and CI-style doctest gate pass. Each new
page has a sidebar route, rendered HTML, valid page-local PNG, user-goal title,
reference link, and visual result. The table API probe successfully exercises
the supported table-plus-broadcast-glyph and vector-plus-per-row-images forms.
The existing explicit-overlay script still produces a PNG. Out-of-scope source
hashes remain identical to the task-1 baseline.
**Negative contract**: Do not edit any file while verifying. Do not weaken a
check, respond to a failure by adding a source-text CI test, accept a docs build
without PNG/HTML evidence, accept an unrendered UUID example, check in a
generated asset, or repair an out-of-scope surface. Return a failure to the
task responsible for its allowed file; stop for a failure outside the tranche.
**Files**: No repository edits. Temporary artifacts only:
`/tmp/phylopicmakie-tranche3-out-of-scope.sha256`,
`/tmp/phylopicmakie-tranche3-out-of-scope-final.sha256`,
`/tmp/explicit_overlays.png`, and `/tmp/phylopicmakie-table-api.png`; ignored
`docs/build/` and `docs/Manifest.toml` outputs.
**Out of scope**: Every repository modification, including the five in-scope
documentation files; CI changes; test additions; source assets; public API;
dependencies; and network behavior.
**Verification**: Run all commands and inspections stated below. The old
implementation fails the source-page/route/PNG checks; the forbidden passing
implementations in the table fail their named audit or API probe.

Run:

1. `julia --project=docs docs/make.jl`.
2. `julia --project=docs -e 'using Documenter: DocMeta, doctest; using PhyloPicMakie; DocMeta.setdocmeta!(PhyloPicMakie, :DocTestSetup, :(using PhyloPicMakie); recursive=true); doctest(PhyloPicMakie)'`.
3. `file docs/build/how-to/points/points-silhouettes.png docs/build/how-to/ranges/ranges-silhouettes.png docs/build/how-to/table-columns/table-columns-silhouettes.png`.
4. One `rg -n` check per rendered HTML page for its corresponding image name.
5. `julia --project=examples examples/src/explicit_overlays.jl /tmp/explicit_overlays.png` followed by `file /tmp/explicit_overlays.png`.
6. `julia --project=docs -e 'using CairoMakie, PhyloPicMakie; glyph =
   fill(CairoMakie.RGBAf(0.2, 0.4, 0.6, 1.0), 8, 12); rows = (; x = [1.0,
   2.0], y = [1.0, 2.0]); figure = Figure(); axis = Axis(figure[1, 1]);
   augment_phylopic!(axis, rows; x = :x, y = :y, glyph = glyph,
   glyph_size = 0.2); augment_phylopic!(axis, rows.x, rows.y, [glyph, glyph];
   glyph_size = 0.2, aspect = :preserve, placement = :center, xoffset = 0.0,
   yoffset = 0.0, rotation = 0.0, mirror = false, on_missing = :skip);
   save("/tmp/phylopicmakie-table-api.png", figure)'` followed by
   `file /tmp/phylopicmakie-table-api.png`. This probe must not use
   `node_uuid`.
7. Source audits that require the three exact H1 titles and the three exact
   `docs/make.jl` route labels; require `at = :start`, `at = :midpoint`, and
   `at = :stop` in `ranges.md`; require the table-selector limitation, `node_uuid =
   :node_uuid`, and a network-dependent label in `table-columns.md`; and
   require a rendering-reference link in every new page.
8. Source audits that reject `TODO`, `TBD`, `coming soon`, `@autodocs`,
   `@docs`, `@index`, `generic anchored-overlay`, `shared internal
   anchored-overlay substrate`, `owner layer`, `data-anchor`, `projected
   pixel-anchor`, `placement mechanics`, and `projection mechanics` in all
   three new pages. Inspect the UUID section to confirm that its only code
   fence is ordinary `julia`, not `@example`.
9. Recreate the task-1 out-of-scope hash list as
   `/tmp/phylopicmakie-tranche3-out-of-scope-final.sha256` and compare it with
   `cmp`. Any changed or newly added out-of-scope path fails the boundary.
   Also confirm `git check-ignore -q docs/build`, `git check-ignore -q
   docs/Manifest.toml`, and that `git ls-files docs/src | rg '\\.png$'` has no
   output.
10. Open the three new PNGs and rendered pages. Confirm that point, range, and
    table tasks are visually distinguishable; the range page visibly uses all
    three anchors; the table page visibly pairs labels and per-row images; and
    no page promises an offline live-UUID result.
