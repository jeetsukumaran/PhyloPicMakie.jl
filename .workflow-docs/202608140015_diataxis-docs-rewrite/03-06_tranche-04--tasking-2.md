---
date-created: 2026-08-17T18:33:14-07:00
workflow-instrument: Tasking plan
workflow-status: Completed
date-completed: 2026-08-17T19:14:01-07:00
workflow-agent-thread-id: codex/019ff9d2-ef36-7e31-92dd-bea4892ee11e
workflow-agent-implementing-id:
  - codex/01a01289-3340-7192-834c-685a0fb39570
workflow-location: /home/jeetsukumaran/site/storage/local/computing/research/20260414_PhyloPicMakie.jl/PhyloPicMakie.jl
workflow-production-id: diataxis-docs-primer
workflow-prd: .workflow-docs/202608140015_diataxis-docs-rewrite/01_prd.md
workflow-tranche: .workflow-docs/202608140015_diataxis-docs-rewrite/02_tranches.md
supersedes: .workflow-docs/202608140015_diataxis-docs-rewrite/03-04_tranche-04--tasking-1.md
---

# Tasks for tranche 4: Write placement, PhyloPic source, and missing-image how-tos

## Settled user decisions and environment baseline

- R1 is complete. The first documentation trajectory starts from PhyloPic node
  UUIDs, taxon-derived identifiers from another package, PhyloPic image
  records, coordinates, ranges, tables, or package-supported lookup. It does
  not start from a local image matrix.
- The superseded tasking file
  `.workflow-docs/202608140015_diataxis-docs-rewrite/03-04_tranche-04--tasking-1.md`
  must not be executed.
- This tranche writes how-to pages. It may update docs navigation, route pages,
  cross-links, and reference-page introductions. It must not change public API
  behavior, plotting behavior, PhyloPicDB behavior, DataCaches behavior, package
  dependencies, CI behavior, or example-script behavior.
- Generated PNGs are build products and verification artifacts. They must live
  under `docs/build/` or `/tmp` and must not be tracked as docs source files.
- Execution correction, 2026-08-17: Documenter evaluates an `@example` from
  the rendered page's build directory. The placement and missing-image pages
  must therefore save to their page-local `adjust-placement/` and
  `handle-missing-images/` directories, respectively, so the required outputs
  are `docs/build/how-to/adjust-placement/placement-adjustments.png` and
  `docs/build/how-to/handle-missing-images/missing-image-policies.png`.
- Network-sensitive examples must be honest. Plotting examples may use live
  PhyloPic node UUIDs with `on_missing = :placeholder` so the docs build can
  still show the layout when a request fails. PhyloPicDB image-record examples
  that would make live API calls must use plain `julia` code fences unless the
  task explicitly verifies them under the docs build.
- The existing repeated-query page is
  `docs/src/how-to/repeated-queries.md`. Do not create the stale R1 filename
  `docs/src/how-to/reuse-phylopic-queries.md`.

## Governance

Before implementation, read each authority line by line and comply with it:

- `.workflow-docs/202608140015_diataxis-docs-rewrite/01_prd.md`.
- `.workflow-docs/202608140015_diataxis-docs-rewrite/02_tranches.md`.
- `.workflow-docs/202608140015_diataxis-docs-rewrite/03-05_tranche-r1--tasking-1.md`.
- `STYLE-workflow-docs.md`.
- `STYLE-agent-language.md`.
- `STYLE-agent-handoffs.md`.
- `STYLE-workflow-vocabulary.md`.
- `STYLE-docs.md`.
- `STYLE-writing.md`.
- `STYLE-vocabulary.md`.
- `STYLE-makie.md`.
- `STYLE-julia.md`.
- `STYLE-git.md`.
- `STYLE-architecture.md`.
- `STYLE-verification.md`.
- `STYLE-upstream-contracts.md`.

`STYLE-agent-language.md` applies to every responsibility, contract, boundary,
invariant, source, and verification statement. Each such statement must name
the exact file, function, module, public surface, or external contract; the
behavior; the consuming page or caller; the duplicate or bypass path that must
not keep that behavior; and the verification artifact that fails vague prose.

Read-only git and shell commands may be used freely. Mutating git operations,
including commit, merge, push, branch, checkout, rebase, and reset, remain the
human project owner's responsibility unless the user explicitly instructs
otherwise.

## Upstream primary sources and local contract conclusions

Read these upstream primary sources before implementation:

- Diataxis how-to guide page: https://diataxis.fr/how-to-guides/.
- Diataxis explanation page: https://diataxis.fr/explanation/.
- Documenter syntax for `@setup`, named `@example`, hidden lines, generated
  images, and build-directory paths:
  https://documenter.juliadocs.org/stable/man/syntax/.
- DataCaches upstream repository and README: https://github.com/JuliaData/DataCaches.jl.

Read these local files before implementation:

- `docs/make.jl`.
- `docs/src/index.md`.
- `docs/src/how-to/index.md`.
- `docs/src/how-to/points.md`.
- `docs/src/how-to/ranges.md`.
- `docs/src/how-to/table-columns.md`.
- `docs/src/how-to/repeated-queries.md`.
- `docs/src/api/rendering.md`.
- `docs/src/api/phylopic_db.md`.
- `src/_augment_api.jl`.
- `src/_coordinates.jl`.
- `src/_render_core.jl`.
- `src/_glyph_resolution.jl`.
- `src/_image_cache.jl`.
- `src/_thumbnail_grid.jl`.
- `src/PhyloPicDB/_types.jl`.
- `src/PhyloPicDB/_image_selector.jl`.
- `src/PhyloPicDB/_bulk.jl`.
- `test/test_coordinates.jl`.
- `test/test_render_core.jl`.

Contract conclusions already resolved for this tasking:

- Diataxis how-to guides must be goal-oriented and practical. The Tranche 4
  pages must open from user tasks such as adjusting an annotation, choosing an
  image representation, and choosing a missing-image policy.
- Documenter evaluates named `@example` blocks in the rendered page's build
  directory, and named `@setup` blocks share context with named examples on the
  same page. Image-producing examples must save PNG files under page-relative
  directories such as `adjust-placement/`.
- `src/_augment_api.jl` defines the public plotting keyword surface consumed by
  these pages: `node_uuid`, `glyph`, `placement`, `xoffset`, `yoffset`,
  `glyph_size`, `aspect`, `rotation`, `mirror`, `image_rendering`, and
  `on_missing`.
- `src/_coordinates.jl` defines valid placement values, range `at` values,
  missing-image symbols, and valid rotation multiples. The placement how-to
  must teach those values through visible recipes rather than duplicating the
  full reference catalog.
- `src/_render_core.jl` implements `on_missing = :skip`, `:error`, and
  `:placeholder` for pre-resolved images and public calls after UUID resolution.
  The missing-image how-to must not claim any behavior beyond those branches.
- `src/PhyloPicDB/_types.jl` defines image-rendering fields and valid
  `image_rendering` symbols: `:thumbnail`, `:raster`, `:og_image`,
  `:vector`, and `:source_file`.
- `src/PhyloPicDB/_image_selector.jl` defines `primary_image`, `clade_images`,
  `node_images`, `select_image`, and `with_node_names`. The PhyloPic source
  how-to may cite those public functions for image-record selection.
- `src/PhyloPicDB/_bulk.jl` shows that `PhyloPicDB.batch_primary_images` and
  `PhyloPicDB.batch_images` call `DataCaches.autocache`.
- `src/_image_cache.jl` shows that `_load_phylopic_image(url)` calls
  `DataCaches.autocache` for decoded image matrices keyed by URL.
- `src/_glyph_resolution.jl` deduplicates repeated UUID strings within one
  plotting call before it calls `PhyloPicDB.primary_image`. It then calls
  `_load_phylopic_image(url)` for the selected image URL.

## Current-state diagnosis

The R1-clean docs have first-wave how-tos for points, ranges, table columns,
and repeated queries. They do not yet have task pages for visual adjustment,
PhyloPic image choice and rendering quality, or missing-image policy.

The file `docs/src/how-to/index.md` currently lists only:

- `points.md`.
- `ranges.md`.
- `table-columns.md`.
- `repeated-queries.md`.

The file `docs/src/api/rendering.md` gives reference facts through prose and
`@autodocs`, but it does not provide a goal-oriented page where a reader can
adjust `glyph_size`, `placement`, `xoffset`, `yoffset`, `rotation`, or `mirror`
through concrete examples.

The file `docs/src/api/phylopic_db.md` is a minimal API reference route. It
does not show the reader how to choose between `primary_image`,
`clade_images`, `node_images`, `select_image`, batch APIs, and
`image_rendering` values.

The file `docs/src/explanation/index.md` remains an explanation route page. It
is not a blocker for Tranche 4, but Tranche 4 pages should link to it only for
bounded context, not as a substitute for task steps.

## Primary-goal lock

### Lock 1: Adjust a plotted silhouette visually

- The work is not complete if a reader cannot change size, placement, offsets,
  rotation, and mirroring from a concrete how-to page.
- Direct red-state repro: `docs/src/how-to/` has no placement-adjustment page,
  and `docs/src/api/rendering.md` leaves those options as reference facts.
- Closer: task 1.
- Verification artifact: `julia --project=docs docs/make.jl`, file check for
  `docs/build/how-to/adjust-placement/placement-adjustments.png`, and rendered
  page review fail a missing or API-catalog-only page.

### Lock 2: Choose a PhyloPic image and rendering quality

- The work is not complete if a reader cannot tell when to use `node_uuid`,
  `PhyloPicDB.primary_image`, `PhyloPicDB.clade_images`,
  `PhyloPicDB.node_images`, `PhyloPicDB.select_image`,
  `PhyloPicDB.batch_primary_images`, `PhyloPicDB.batch_images`, or
  `image_rendering`.
- Direct red-state repro: `docs/src/api/phylopic_db.md` is reference-only and
  no how-to page connects image-record choice to plotting.
- Closer: task 2.
- Verification artifact: source-text audit of
  `docs/src/how-to/choose-phylopic-images.md` fails if it omits the named APIs
  or makes a DataCaches claim not tied to `src/_image_cache.jl` or
  `src/PhyloPicDB/_bulk.jl`.

### Lock 3: Explain missing-image policy through examples

- The work is not complete if `on_missing = :skip`, `:error`, and
  `:placeholder` appear only in reference text.
- Direct red-state repro: no page under `docs/src/how-to/` shows the three
  missing-image policies as a task.
- Closer: task 3.
- Verification artifact: `julia --project=docs docs/make.jl`, file check for
  `docs/build/how-to/handle-missing-images/missing-image-policies.png`, and
  source-text audit against `src/_render_core.jl` fail a page that invents
  another policy or omits one of the 3 existing policies.

### Lock 4: Preserve the how-to and reference roles

- The work is not complete if new how-to pages become full parameter catalogs,
  or if reference pages become tutorial replacements.
- Direct red-state repro: a page duplicates the full keyword tables from
  `src/_augment_api.jl` or `src/PhyloPicDB/_types.jl` instead of linking to
  `docs/src/api/rendering.md` or `docs/src/api/phylopic_db.md`.
- Closer: tasks 1, 2, 3, and 4.
- Verification artifact: rendered-page review and source-text audit fail if
  any new how-to page contains a complete reference table for plotting
  keywords or PhyloPic image fields.

### Lock 5: Preserve the R1 user-first trajectory

- The work is not complete if a new how-to starts from local image matrices,
  `offline_silhouette()`, `_offline_silhouette.jl`, hidden fixtures, or
  implementation-first placement prose.
- Direct red-state repro: the superseded Tranche 4 tasking taught from
  `offline_silhouette()` and preloaded image matrices.
- Closer: every task.
- Verification artifact: source-text audit fails forbidden offline-first and
  implementation-first phrases in `README.md`, `docs/src`, `src`, and
  `docs/build`.

### Lock 6: Preserve build-product and documentation-only boundaries

- The work is not complete if a generated PNG is tracked as a source asset, or
  if this tranche changes source behavior, exported names, public keyword
  behavior, package dependencies, CI behavior, or network behavior.
- Direct red-state repro: a passing docs build depends on a copied PNG under
  `docs/src/` or a source-code change that makes a docs example easier to
  explain.
- Closer: every task.
- Verification artifact: `git status --short`, `git ls-files docs/src examples docs README.md | rg '\\.png$'`, and diff review fail tracked generated PNGs or unapproved behavior changes.

## Forbidden passing implementation table

| Lock item | Required behavior | Current code state | Resolved implementation instruction | Forbidden passing implementation | Failing verification artifact |
| --- | --- | --- | --- | --- | --- |
| Lock 1: Adjust a plotted silhouette visually | `docs/src/how-to/adjust-placement.md` shows a user how to change `glyph_size`, `placement`, `xoffset`, `yoffset`, `rotation`, and `mirror` through a rendered example that starts from PhyloPic node UUIDs. | `docs/src/how-to/` has no placement-adjustment page; `src/_augment_api.jl` and `src/_coordinates.jl` define the options as API facts. | Create `docs/src/how-to/adjust-placement.md` with a named Documenter example that saves `how-to/adjust-placement/placement-adjustments.png`; use `node_uuid`, `on_missing = :placeholder`, and a small set of visual variants. | Add a page that only lists keywords or points back to `docs/src/api/rendering.md` without a rendered task example. | `file docs/build/how-to/adjust-placement/placement-adjustments.png` and rendered-page review fail. |
| Lock 2: Choose a PhyloPic image and rendering quality | `docs/src/how-to/choose-phylopic-images.md` explains primary image lookup, clade and node image lists, `select_image`, rendering values, and batch APIs without overstating caching. | `docs/src/api/phylopic_db.md` is a minimal reference route; `src/PhyloPicDB/_types.jl`, `src/PhyloPicDB/_image_selector.jl`, `src/PhyloPicDB/_bulk.jl`, `src/_glyph_resolution.jl`, and `src/_image_cache.jl` define the behavior. | Create `docs/src/how-to/choose-phylopic-images.md`; use plain `julia` fences for network-sensitive PhyloPicDB calls; state that `_load_phylopic_image(url)` caches decoded image matrices and that batch image-record APIs cache calls through `DataCaches.autocache`. | Claim all direct UUID plotting is the same as `PhyloPicDB.batch_images`, or omit batch APIs and leave repeated-query guidance disconnected. | Source-text audit of DataCaches prose against `src/_image_cache.jl` and `src/PhyloPicDB/_bulk.jl` fails. |
| Lock 3: Explain missing-image policy through examples | `docs/src/how-to/handle-missing-images.md` shows `:skip`, `:placeholder`, and `:error` with runnable code and a rendered policy figure. | `src/_render_core.jl` implements `:skip`, `:placeholder`, and `:error`; no how-to page shows all 3 policies. | Create `docs/src/how-to/handle-missing-images.md` with a named Documenter example that saves `how-to/handle-missing-images/missing-image-policies.png` and a separate caught-error example for `:error`. | Mention `on_missing` in prose only, or invent a fallback policy not present in `VALID_ON_MISSING`. | Docs build and source-text audit against `src/_render_core.jl` fail. |
| Lock 4: Preserve the how-to and reference roles | New how-to pages solve user tasks and link to reference for exhaustive facts. | `docs/src/api/rendering.md` and `docs/src/api/phylopic_db.md` provide reference routes. | Keep complete symbol and keyword catalogs in reference pages; add short links from how-to pages to reference; update reference intros only for navigation links. | Copy the entire public keyword table into each how-to page. | Source-text and rendered-page review fail duplicated catalogs. |
| Lock 5: Preserve the R1 user-first trajectory | New pages start from UUIDs, image records, or user plotting tasks, and they avoid internal-first and offline-first openings. | R1 live docs pass the forbidden-phrase audit; superseded Tranche 4 tasking does not. | Use PhyloPic node UUID examples and secondary local-image wording only where the user already has decoded image data. | Recreate a local fixture under a new name or explain placement through internal image-placement helpers first. | Forbidden-phrase audit over `README.md`, `docs/src`, `src`, and `docs/build` fails. |
| Lock 6: Preserve build-product and documentation-only boundaries | Generated images remain under `docs/build/` or `/tmp`, and source behavior is unchanged. | Current docs build generates PNGs under `docs/build`; no tracked docs PNGs exist. | Save new rendered images from Documenter examples into page-relative build directories; do not edit `src/` except separately approved docstrings. | Commit generated PNGs into `docs/src/` or alter source behavior to make examples easier. | `git ls-files docs/src examples docs README.md | rg '\\.png$'`, `git status --short`, and diff review fail. |

## Handoff packet

- **Active authorities**: `.workflow-docs/202608140015_diataxis-docs-rewrite/01_prd.md`; `.workflow-docs/202608140015_diataxis-docs-rewrite/02_tranches.md`; `.workflow-docs/202608140015_diataxis-docs-rewrite/03-05_tranche-r1--tasking-1.md`; this tasking file; repo-local `STYLE-workflow-docs.md`, `STYLE-agent-language.md`, `STYLE-agent-handoffs.md`, `STYLE-workflow-vocabulary.md`, `STYLE-docs.md`, `STYLE-writing.md`, `STYLE-vocabulary.md`, `STYLE-makie.md`, `STYLE-julia.md`, `STYLE-git.md`, `STYLE-architecture.md`, `STYLE-verification.md`, and `STYLE-upstream-contracts.md`.
- **Parent documents**: `.workflow-docs/202608140015_diataxis-docs-rewrite/01_prd.md`; `.workflow-docs/202608140015_diataxis-docs-rewrite/02_tranches.md`.
- **Settled decisions and non-negotiables**: The docs follow Diataxis. Tranche 4 writes how-to pages. The first path starts from PhyloPic node UUIDs, taxon-derived identifiers from another package, PhyloPic image records, or package-supported lookup. DataCaches details stay outside first-contact prose and appear in later how-to or reference material with exact local files named. Generated PNGs are build products. Public API and plotting behavior are unchanged.
- **Authorization boundary**: In scope: new how-to Markdown pages, docs navigation, route-page links, reference-page cross-links, Documenter examples, and generated PNGs under `docs/build`. Out of scope: public API changes, plotting implementation changes, PhyloPic API client behavior changes, DataCaches behavior changes, dependency changes, CI changes, generated PNGs as tracked source assets, and example-script behavior changes.
- **Current-state diagnosis**: R1-clean docs have first-wave point, range, table, and repeated-query how-tos. They lack placement-adjustment, PhyloPic image-source, image-rendering-quality, and missing-image-policy how-tos.
- **Primary-goal lock**: lock items 1 through 6 in this tasking file.
- **Direct red-state repros**: `test -f docs/src/how-to/adjust-placement.md` fails; `test -f docs/src/how-to/choose-phylopic-images.md` fails; `test -f docs/src/how-to/handle-missing-images.md` fails; `docs/src/how-to/index.md` lacks those links; the superseded 03-04 tasking starts from `offline_silhouette()`.
- **Named responsible entities and required behavior**: `docs/src/how-to/adjust-placement.md` must provide the user recipe for visual adjustment and save `docs/build/how-to/adjust-placement/placement-adjustments.png`; no source helper may duplicate placement behavior for this tranche, and file checks fail if the PNG is missing. `docs/src/how-to/choose-phylopic-images.md` must provide the user recipe for choosing image records and rendering values; `src/PhyloPicDB/_types.jl`, `src/PhyloPicDB/_image_selector.jl`, `src/PhyloPicDB/_bulk.jl`, `src/_glyph_resolution.jl`, and `src/_image_cache.jl` provide the API facts consumed by the page, and DataCaches prose audit fails if claims exceed those files. `docs/src/how-to/handle-missing-images.md` must provide examples for the 3 `on_missing` values implemented in `src/_render_core.jl`; the source-text audit against `VALID_ON_MISSING` fails invented policy claims. `docs/make.jl` must include the new pages in the rendered sidebar; rendered navigation review fails if the pages exist but are unreachable from the how-to route. `docs/src/api/rendering.md` and `docs/src/api/phylopic_db.md` must remain reference pages and may receive cross-links only; rendered-page review fails if they become tutorial replacements.
- **Exact files or surfaces in scope**: `docs/src/how-to/adjust-placement.md`; `docs/src/how-to/choose-phylopic-images.md`; `docs/src/how-to/handle-missing-images.md`; `docs/src/how-to/index.md`; `docs/src/index.md`; `docs/src/primer.md`; `docs/src/tutorial.md`; `docs/src/api/rendering.md`; `docs/src/api/phylopic_db.md`; `docs/src/explanation/index.md`; `docs/make.jl`; generated PNGs under `docs/build`.
- **Exact files or surfaces out of scope**: `src/` implementation; `test/`; `examples/src/`; `.github/`; `Project.toml`; `docs/Project.toml`; public API behavior; exported names; network behavior; DataCaches behavior; generated PNGs as tracked source files.
- **Required upstream primary sources**: Diataxis how-to and explanation pages; Documenter syntax page for named `@example`, `@setup`, hidden lines, generated images, and build-directory paths; DataCaches upstream repository and README.
- **Green-state gates**: `julia --project=docs docs/make.jl`; file checks for the 2 required PNGs; source-text audit for offline-first and implementation-first forbidden phrases; source-text audit for DataCaches overclaims; rendered-page review of the 3 new how-to pages; `git status --short`; tracked-PNG audit.
- **Stop conditions**: Stop if a page needs a public API keyword or behavior that does not exist. Stop if a DataCaches statement cannot be tied to `src/_image_cache.jl`, `src/PhyloPicDB/_bulk.jl`, or the upstream DataCaches docs. Stop if network behavior prevents an executable docs example from completing with `on_missing = :placeholder`. Stop if implementation would need source, dependency, CI, or example-script changes not authorized here.

## Required revalidation before implementation

- Read every file listed under Governance line by line.
- Read every local file listed under Upstream primary sources and local contract conclusions.
- Run `find docs/src -maxdepth 3 -type f | sort` and confirm the 3 Tranche 4 pages do not already exist.
- Run source-text audits for offline-first and implementation-first phrases over `README.md`, `docs/src`, `src`, and `docs/build`.
- Re-check `src/_coordinates.jl`, `src/_render_core.jl`, `src/_glyph_resolution.jl`, `src/_image_cache.jl`, `src/PhyloPicDB/_types.jl`, `src/PhyloPicDB/_image_selector.jl`, and `src/PhyloPicDB/_bulk.jl` before writing any option, rendering, missing-image, or DataCaches sentence.
- Stop and revise this tasking if current docs already provide any target page or if a source file no longer supports the contract conclusions above.

## Tranche execution rule

Complete the tasks in order. Each task must leave the docs buildable or record
that the full green state is deferred to task 5 because navigation links point
to pages created by later tasks. Do not mark the tranche complete until task 5
records every green-state gate.

The docs must adapt to the current public API. This tranche does not authorize
changing source behavior to match a desired docs story.

## Non-negotiable execution rules

- Do not execute or reuse the superseded 03-04 tasking instructions.
- Do not use `offline_silhouette()`, `_offline_silhouette.jl`, preloaded image
  matrices, hidden fixtures, or renamed fixture helpers as the main example
  path.
- Do not write first-contact prose about internal image placement helpers,
  data anchors, pixel anchors, substrates, or implementation ownership.
- Do not add new source behavior, new public keywords, new exports, new
  dependencies, new CI gates, or example-script changes.
- Do not claim that `:vector` or `:source_file` always decodes in every docs
  environment; state that those options may require an SVG-capable FileIO
  plugin.
- Do not make DataCaches claims without naming `src/_image_cache.jl`,
  `src/PhyloPicDB/_bulk.jl`, or the upstream DataCaches API.
- Do not commit generated PNGs as source assets.

## Concrete anti-patterns or removal targets

- The file `.workflow-docs/202608140015_diataxis-docs-rewrite/03-04_tranche-04--tasking-1.md` is archival and superseded.
- New pages must not include `offline_silhouette`, `_offline_silhouette`,
  "preloaded image matrix", "local fixture", "generic anchored-overlay
  substrate", "data-anchor", "projected pixel-anchor", or "owner layer".
- New how-to pages must not copy the complete keyword table from
  `src/_augment_api.jl` or the complete field table from
  `src/PhyloPicDB/_types.jl`; they must link to `docs/src/api/rendering.md` and
  `docs/src/api/phylopic_db.md` for complete reference facts.
- New examples must not use generated PNGs outside `docs/build/` or `/tmp`.

## Failure-oriented verification

- `rg -n "offline_silhouette|_offline_silhouette|preloaded image matrix|preloaded-image|generated in-memory image|offline-capable|required learning path remains offline|required tutorial remains offline|live UUID examples are optional|load an image matrix|secret offline image|local image fixture|local fixture" README.md docs/src src docs/build` must return no matches outside archival workflow files, which are not in this command.
- `rg -n "generic anchored-overlay substrate|shared internal anchored-overlay substrate|projected pixel-anchor placement mechanics|owner layer|data-anchor|pixel-anchor|anchored-overlay substrate|placement mechanics" README.md docs/src src docs/build` must return no matches.
- `rg -n "DataCaches|autocache|batch_primary_images|batch_images|_load_phylopic_image" docs/src/how-to/choose-phylopic-images.md docs/src/how-to/repeated-queries.md docs/src/api/rendering.md docs/src/index.md docs/src/primer.md` must show that every DataCaches claim names a local function or API listed in this tasking.
- `file docs/build/how-to/adjust-placement/placement-adjustments.png docs/build/how-to/handle-missing-images/missing-image-policies.png` must identify both outputs as PNG images.
- `git ls-files docs/src examples docs README.md | rg '\\.png$'` must return no matches.

## Tasks

### 1. Add the placement adjustment guide

**Type**: WRITE
**Output**: `docs/src/how-to/adjust-placement.md` exists and its Documenter example saves `docs/build/how-to/adjust-placement/placement-adjustments.png`.
**Depends on**: none.
**Positive contract**: The page shows how to adjust `glyph_size`, `placement`, `xoffset`, `yoffset`, `rotation`, and `mirror` through a concrete Makie figure using PhyloPic node UUIDs and `on_missing = :placeholder`.
**Negative contract**: The page must not teach from local image matrices, hidden fixtures, internal placement helper prose, or a full API parameter catalog.
**Files**: `docs/src/how-to/adjust-placement.md`.
**Out of scope**: `src/`; `test/`; `examples/src/`; `docs/make.jl`; existing docs pages.
**Verification**: Run `julia --project=docs docs/make.jl`; run `file docs/build/how-to/adjust-placement/placement-adjustments.png`; audit the new page for the forbidden offline-first and implementation-first phrases listed above.

Create `docs/src/how-to/adjust-placement.md`. Use sentence-case headings and a direct how-to opening: the reader has silhouettes on coordinates and wants to move or reorient them. Include one named `@setup adjust-placement` block that loads `CairoMakie` and `PhyloPicMakie`. Include one named `@example adjust-placement` block that builds a small figure, defines x/y coordinates, defines PhyloPic node UUIDs, calls `augment_phylopic!` more than once or across a compact panel to demonstrate the required visual options, saves `joinpath("adjust-placement", "placement-adjustments.png")`, and returns `nothing`. Use `on_missing = :placeholder` so failed image requests still produce a visible layout. End with links to `../api/rendering.md` for complete keyword facts and to `handle-missing-images.md` for missing-image policy.

### 2. Add the PhyloPic image choice and rendering guide

**Type**: WRITE
**Output**: `docs/src/how-to/choose-phylopic-images.md` exists and explains image-record choice, rendering values, and repeated-query boundaries.
**Depends on**: none.
**Positive contract**: The page shows when to use direct `node_uuid` plotting, `PhyloPicDB.primary_image`, `PhyloPicDB.clade_images`, `PhyloPicDB.node_images`, `PhyloPicDB.select_image`, `PhyloPicDB.batch_primary_images`, `PhyloPicDB.batch_images`, and `image_rendering`.
**Negative contract**: The page must not claim that every direct UUID plotting step is equivalent to the batch image-record APIs, must not promise that SVG rendering works without an SVG-capable FileIO plugin, and must not move cache setup into the primer or tutorial.
**Files**: `docs/src/how-to/choose-phylopic-images.md`.
**Out of scope**: `src/PhyloPicDB/`; `src/_glyph_resolution.jl`; `src/_image_cache.jl`; package dependencies; CI; generated PNG files.
**Verification**: Run `julia --project=docs docs/make.jl`; audit DataCaches claims in the new page against `src/_image_cache.jl` and `src/PhyloPicDB/_bulk.jl`; audit `image_rendering` claims against `src/PhyloPicDB/_types.jl` and `src/_thumbnail_grid.jl`.

Create `docs/src/how-to/choose-phylopic-images.md`. Start from the user's task: they have a PhyloPic node UUID or image records and need to choose which silhouette or quality to use. Use plain `julia` fences for network-sensitive PhyloPicDB examples. Explain that direct `augment_phylopic!` with `node_uuid` is the simplest path for one figure, that repeated UUIDs are deduplicated within a plotting call by `src/_glyph_resolution.jl`, and that selected image URL decoding uses `_load_phylopic_image(url)` from `src/_image_cache.jl`. Explain that `PhyloPicDB.batch_primary_images` and `PhyloPicDB.batch_images` cache image-record queries through `DataCaches.autocache` in `src/PhyloPicDB/_bulk.jl`. Explain `image_rendering` values at task level and link to `../api/rendering.md` and `../api/phylopic_db.md` for complete reference facts.

### 3. Add the missing-image policy guide

**Type**: WRITE
**Output**: `docs/src/how-to/handle-missing-images.md` exists and its Documenter example saves `docs/build/how-to/handle-missing-images/missing-image-policies.png`.
**Depends on**: none.
**Positive contract**: The page demonstrates `on_missing = :skip`, `on_missing = :placeholder`, and `on_missing = :error` using examples that match `src/_render_core.jl`.
**Negative contract**: The page must not invent a fourth policy, must not imply `:skip` creates a placeholder, and must not hide errors that the user explicitly requested with `:error`.
**Files**: `docs/src/how-to/handle-missing-images.md`.
**Out of scope**: `src/_render_core.jl`; tests; package dependencies; example scripts.
**Verification**: Run `julia --project=docs docs/make.jl`; run `file docs/build/how-to/handle-missing-images/missing-image-policies.png`; audit the page against `VALID_ON_MISSING` and `_augment_resolved_phylopic_anchored!` in `src/_render_core.jl`.

Create `docs/src/how-to/handle-missing-images.md`. Use a named setup block with `CairoMakie` and `PhyloPicMakie`. Use `node_uuid = [nothing, nothing]` or a mix of valid UUID and `nothing` to produce a deterministic missing-image demonstration. The rendered example must save `joinpath("handle-missing-images", "missing-image-policies.png")` and visibly compare `:skip` with `:placeholder`. Add a separate `@example` block that catches the `:error` exception and shows the reader that `:error` is for fail-fast workflows. Link to `../api/rendering.md` for exact error behavior.

### 4. Update navigation and cross-links

**Type**: WRITE
**Output**: `docs/make.jl`, route pages, and reference introductions link to the 3 new how-to pages.
**Depends on**: tasks 1, 2, and 3.
**Positive contract**: The rendered sidebar and how-to overview expose `adjust-placement.md`, `choose-phylopic-images.md`, and `handle-missing-images.md`. Existing first-wave how-tos link to the new pages where they naturally answer the next task.
**Negative contract**: Navigation must not link to missing files, and reference pages must not become how-to pages.
**Files**: `docs/make.jl`; `docs/src/how-to/index.md`; `docs/src/index.md`; `docs/src/primer.md`; `docs/src/tutorial.md`; `docs/src/how-to/points.md`; `docs/src/how-to/ranges.md`; `docs/src/how-to/table-columns.md`; `docs/src/how-to/repeated-queries.md`; `docs/src/api/rendering.md`; `docs/src/api/phylopic_db.md`; `docs/src/explanation/index.md`.
**Out of scope**: `src/`; `test/`; `examples/src/`; `.github/`; dependency files.
**Verification**: Run `julia --project=docs docs/make.jl`; run `rg -n "adjust-placement|choose-phylopic-images|handle-missing-images" docs/make.jl docs/src`; rendered navigation review must find the pages under the how-to section.

Update `docs/make.jl` so the how-to section includes the 3 new pages in this order after the existing first-wave plotting pages and before repeated-query guidance: adjust placement, choose PhyloPic images, handle missing images. Update `docs/src/how-to/index.md` with direct links. Add short cross-links from `docs/src/primer.md`, `docs/src/tutorial.md`, and existing how-tos only where they answer a next task. Update `docs/src/api/rendering.md` and `docs/src/api/phylopic_db.md` introductions with links back to the new how-to pages; do not add tutorial prose or duplicate keyword catalogs to the API pages.

### 5. Run verification and report completion

**Type**: TEST
**Output**: The tranche completion report records command results, generated PNG paths, source-text audits, and any remaining risks.
**Depends on**: tasks 1, 2, 3, and 4.
**Positive contract**: Every Tranche 4 lock item has a named verification artifact, and the repository is green for the docs scope.
**Negative contract**: Do not report completion with only a docs build. Do not ignore rendered PNG absence, stale forbidden phrases, DataCaches overclaims, or tracked generated PNGs.
**Files**: `.workflow-docs/202608140015_diataxis-docs-rewrite/03-06_tranche-04--tasking-2.md` for completion reporting after execution; no other files except documentation files already changed by tasks 1 through 4.
**Out of scope**: Git commits, branch changes, source behavior changes, CI changes.
**Verification**: Run the complete command set listed in Failure-oriented verification. Run `julia --project=test test/runtests.jl` if source docstrings or comments changed during execution; otherwise record that no source files changed.

Run:

- `julia --project=docs docs/make.jl`.
- `file docs/build/how-to/adjust-placement/placement-adjustments.png docs/build/how-to/handle-missing-images/missing-image-policies.png`.
- `rg -n "offline_silhouette|_offline_silhouette|preloaded image matrix|preloaded-image|generated in-memory image|offline-capable|required learning path remains offline|required tutorial remains offline|live UUID examples are optional|load an image matrix|secret offline image|local image fixture|local fixture" README.md docs/src src docs/build`.
- `rg -n "generic anchored-overlay substrate|shared internal anchored-overlay substrate|projected pixel-anchor placement mechanics|owner layer|data-anchor|pixel-anchor|anchored-overlay substrate|placement mechanics" README.md docs/src src docs/build`.
- `rg -n "DataCaches|autocache|batch_primary_images|batch_images|_load_phylopic_image" docs/src/how-to/choose-phylopic-images.md docs/src/how-to/repeated-queries.md docs/src/api/rendering.md docs/src/index.md docs/src/primer.md`.
- `git ls-files docs/src examples docs README.md | rg '\\.png$'`.
- `git status --short`.

Write a completion report that names all changed files, all generated images,
all commands and results, any unrun checks with reasons, and whether Tranche 5
can start without further remediation.

## Completion report

Completed on 2026-08-17 by `codex/01a01289-3340-7192-834c-685a0fb39570`.

### User-ratified execution correction

The user confirmed that the doubled `how-to/how-to` image path was a tasking
glitch. The tasking now correctly uses the rendered page's local directories:
`joinpath("adjust-placement", "placement-adjustments.png")` and
`joinpath("handle-missing-images", "missing-image-policies.png")`. A fresh
Documenter build produced the required single-`how-to` output paths.

### Changed files

- `docs/src/how-to/adjust-placement.md`
- `docs/src/how-to/choose-phylopic-images.md`
- `docs/src/how-to/handle-missing-images.md`
- `docs/make.jl`
- `docs/src/how-to/index.md`
- `docs/src/how-to/points.md`
- `docs/src/how-to/ranges.md`
- `docs/src/how-to/table-columns.md`
- `docs/src/how-to/repeated-queries.md`
- `docs/src/primer.md`
- `docs/src/tutorial.md`
- `docs/src/api/rendering.md`
- `docs/src/api/phylopic_db.md`
- `docs/src/explanation/index.md`
- this tasking file

The pre-existing modifications to `02_tranches.md` and
`03-05_tranche-r1--tasking-1.md` were preserved and not changed by this
execution.

### Lock-item verification

1. The placement guide demonstrates `glyph_size`, `placement`, `xoffset`,
   `yoffset`, 90-degree `rotation`, and `mirror`, and saves the placement PNG.
2. The image-choice guide covers direct UUID plotting, the required PhyloPicDB
   record and batch APIs, exact local DataCaches boundaries, rendering values,
   and the SVG-capable FileIO-plugin caveat.
3. The missing-image guide visibly distinguishes `:skip` from `:placeholder`
   and shows caught `:error` behavior without inventing another policy.
4. The sidebar, how-to overview, route pages, existing how-tos, and reference
   introductions provide reader-appropriate links to the new guides.
5. No source, tests, example scripts, dependencies, or CI files changed.
6. The two generated PNG artifacts are under `docs/build/` only and are not
   tracked source assets.

### Commands and results

- `julia --project=docs docs/make.jl` completed successfully. Documenter
  emitted only its normal deployment-environment autodetection warning.
- `file docs/build/how-to/adjust-placement/placement-adjustments.png docs/build/how-to/handle-missing-images/missing-image-policies.png`
  identified both artifacts as RGBA PNG images: 1800x1280 and 1680x720,
  respectively.
- Both required forbidden-phrase `rg` audits returned no matches.
- The DataCaches audit found only the documented `DataCaches.autocache`,
  `batch_primary_images`, `batch_images`, and `_load_phylopic_image` boundaries
  supported by the named local sources.
- `find docs/build/how-to -path "*/how-to/how-to/*" -type f` returned no
  files, confirming that the corrected paths did not produce a doubled route.
- `git diff --check` passed.
- `git ls-files docs/src examples docs README.md | rg '\\.png$'` returned no
  matches.
- `git status --short` was reviewed; it contains the documentation changes
  above plus the preserved pre-existing workflow-document modifications.

The rendered PNGs were visually reviewed. No package test suite was run because
this execution changed no source docstrings or comments. Tranche 5 can begin
without further remediation. The live PhyloPic figures retain normal upstream
availability variability; `on_missing = :placeholder` keeps their documented
layouts buildable when an image request cannot complete.
