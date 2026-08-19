---
date-created: 2026-08-17T23:22:09-07:00
workflow-instrument: Tasking plan
workflow-status: Approved
workflow-agent-thread-id: codex/01a01383-38ef-7d80-ab73-dcb18699e859
workflow-agent-implementing-id:
  - codex/01a01408-dbe2-7b43-9288-17f2b538d3a7
workflow-location: /home/jeetsukumaran/site/storage/local/computing/research/20260414_PhyloPicMakie.jl/PhyloPicMakie.jl
workflow-production-id: diataxis-docs-primer
workflow-prd: .workflow-docs/202608140015_diataxis-docs-rewrite/01_prd.md
workflow-tranche: .workflow-docs/202608140015_diataxis-docs-rewrite/02_tranches.md#tranche-7-write-phylopic-uuid-and-datacaches-documentation
---

# Tasks for Tranche 7: Write PhyloPic UUID and DataCaches documentation

## Settled user decisions and environment baseline

- This is a documentation-only tranche. It must not change public API behavior,
  exported names, plotting behavior, PhyloPic network behavior, or DataCaches
  behavior.
- PhyloPic node UUIDs, taxon-derived node UUIDs from another package, and
  package-supported PhyloPic lookup form the normal documentation path. A local
  image matrix remains a secondary path for readers who already have image data.
- Cache setup remains out of the primer and tutorial. Explicit repeated-query
  guidance belongs in later how-to material.
- `PhyloPicDB.batch_primary_images` and `PhyloPicDB.batch_images` are the
  public batch APIs that cache PhyloPic metadata queries through
  `DataCaches.autocache` in `src/PhyloPicDB/_bulk.jl`. Direct UUID rendering
  deduplicates UUIDs within one call in `src/_glyph_resolution.jl`; after image
  selection, `_load_phylopic_image(url)` caches decoded image matrices by URL
  through `DataCaches.autocache` in `src/_image_cache.jl`. Do not describe the
  former as cross-call metadata-query caching.
- The built-in UUID gallery accepts node UUIDs and optional labels; it does not
  accept a `Dict` returned by either batch API as gallery input. Supplying
  `node_labels` avoids the default `fetch_node` calls used to obtain preferred
  names in `src/_node_thumbnail_grid.jl`.
- Tranche R1 and the current later-tranche documentation work already provide
  the normal UUID trajectory, the repeated-query page, image-rendering guidance,
  and UUID gallery navigation. Do not create a second UUID or DataCaches page.
- The working tree contains user-owned, uncommitted Tranche 6 changes, including
  a change in `docs/src/how-to/thumbnail-gallery.md`. Preserve those edits,
  particularly the current `PaleobiologyDB.PBDBMakie` route and its explanation
  link. Generated PNGs remain build products and must not become source assets.
- No manifest, dependency, or path-override change is authorized. The approved
  dependency baseline is `DataCaches = "0.4"` from `Project.toml`.

## Governance

Read every governing document below line by line before implementation and pass
the mandates forward into every implementation report. The repo-local documents
are the project-specific authorities; the bundled documents at
`/home/jeetsukumaran/.codex/skills/development-policies/references/` remain the
baseline corpus.

- `STYLE-agent-handoffs.md`
- `STYLE-agent-language.md`
- `STYLE-architecture.md`
- `STYLE-docs.md`
- `STYLE-git.md`
- `STYLE-julia.md`
- `STYLE-makie.md`
- `STYLE-upstream-contracts.md`
- `STYLE-verification.md`
- `STYLE-vocabulary.md`
- `STYLE-workflow-docs.md`
- `STYLE-workflow-vocabulary.md`
- `STYLE-writing.md`

`CONTRIBUTING.md`, `STYLE-python.md`, and `STYLE-domain-vocabulary.md` are not
present in this repository. Read-only Git and shell commands are permitted.
Commit, merge, rebase, push, and branch operations remain the project owner's
responsibility.

## Primary-goal lock

### T7-01: Keep UUID galleries on the normal PhyloPic reader path

The work is not complete if the UUID gallery documentation makes a reader load
a local image matrix, treats UUID input as optional side material, or adds a
second page that duplicates the established UUID gallery recipe.

Direct red-state repro: the pre-remediation first-learning documents taught a
docs-private image path. The current normal gallery is
`docs/src/how-to/thumbnail-gallery.md`, which calls
`phylopic_thumbnail_grid(node_uuids; ...)`.

Tasks that close it: 1 and 2. The failing verification artifact is the gallery
page review: its only primary input remains `node_uuids`, it links to the
existing image-selection and repeated-query guides, and it contains no local
image-matrix first path or duplicate UUID-guide route.

### T7-02: State the supplied-label request boundary exactly

The work is not complete if a UUID-gallery reader cannot learn that
`node_labels` supplies the displayed taxon-name context and avoids the default
preferred-name lookup.

Direct red-state repro: `docs/src/how-to/thumbnail-gallery.md` currently says
what `node_labels` displays but omits the request consequence; meanwhile
`src/_node_thumbnail_grid.jl` calls `_resolve_node_labels` and then
`PhyloPicDB.fetch_node` whenever `node_labels` is `nothing`.

Tasks that close it: 1 and 2. The failing verification artifact is the gallery
page source and rendered review for one explicit sentence that names
`node_labels`, the default node-name lookup, and the fact that supplied labels
avoid it.

### T7-03: Separate direct UUID rendering, decoded-image caching, and batch metadata caching

The work is not complete if the documentation says that direct
`augment_phylopic!` or `phylopic_thumbnail_grid` calls use
`batch_primary_images` or `batch_images`, or says that a batch-result dictionary
is input to the built-in UUID gallery.

Direct red-state repro: a weak cache explanation can observe that all paths
eventually download images and then falsely call every UUID path
DataCaches-backed batch querying. In current code, `_resolve_images_by_uuid`
deduplicates only the direct call, `_load_phylopic_image` caches decoded URLs,
and the two batch functions cache metadata-query results across calls.

Tasks that close it: 1 and 2. The failing verification artifact is the
repeated-query and gallery prose audit against `src/_glyph_resolution.jl`,
`src/_image_cache.jl`, and `src/PhyloPicDB/_bulk.jl`; it fails any statement
that collapses those three distinct behaviors.

### T7-04: Retain the image-rendering choice route

The work is not complete if a reader with a PhyloPic node UUID cannot reach the
existing image-rendering choice guidance from the gallery guide, or if the
clarification duplicates its rendering-option facts in a second page.

Direct red-state repro: before the current later-tranche documentation work,
UUID gallery material did not provide a bounded route to image selection. The
gallery page now links to `docs/src/how-to/choose-phylopic-images.md`, whose
direct UUID example documents the supported `image_rendering` symbols.

Tasks that close it: 1 and 2. The failing verification artifact is the rendered
gallery link review plus the image-choice-page review for the current UUID and
rendering-quality guidance.

### T7-05: Keep cache details later and goal-oriented

The work is not complete if cache configuration or `DataCaches.autocache`
details are inserted into the primer or tutorial, or if the repeated-query page
becomes an API catalog instead of a practical guide for reusing image records.

Direct red-state repro: the rejected offline-first trajectory attempted to
teach infrastructure before a reader had made a figure. The current
`docs/src/primer.md` and `docs/src/tutorial.md` link to later repeated-query
guidance instead.

Tasks that close it: 1 and 2. The failing verification artifact is the
first-contact source and rendered review: cache setup does not appear in the
primer or tutorial, and the repeated-query guide uses direct plotting and the
two public batch APIs as bounded task guidance.

### T7-06: Preserve the documentation-only boundary and current Tranche 6 work

The work is not complete if source implementation, dependencies, Documenter
navigation, generated PNG policy, or existing user-owned Tranche 6 changes are
modified to make this documentation clarification pass.

Direct red-state repro: the PRD prohibits changing implementation behavior to
make the explanation easier. The current worktree already contains unrelated
Tranche 6 edits in source and navigation files, plus untracked documentation
files; those changes are a preserved execution baseline, not this tranche's
output.

Tasks that close it: 1 and 2. The failing verification artifact is a changed-file
and diff review that permits only the two named Markdown pages, besides this
tasking file, and confirms no generated image is added.

### T7-07: Retain Diataxis role and controlled vocabulary compliance

The work is not complete if the clarification uses internal-first terms,
changes the existing goal-titled gallery guide into a reference page, or uses a
proscribed project term.

Direct red-state repro: the PRD identifies developer-centered prose and
reference/tutorial role drift as explicit failures. The current gallery page is
a goal-titled how-to, and `docs/src/how-to/repeated-queries.md` is the bounded
later guide.

Tasks that close it: 1 and 2. The failing verification artifact is a rendered
page review plus a controlled-vocabulary audit of the modified prose.

## Forbidden Passing Implementation Table

| Lock item | Required behavior | Current code state | Resolved implementation instruction | Forbidden passing implementation | Failing verification artifact |
| --- | --- | --- | --- | --- | --- |
| T7-01 | UUID galleries begin from PhyloPic node UUIDs and remain part of the existing normal how-to route. | `docs/src/how-to/thumbnail-gallery.md` already calls `phylopic_thumbnail_grid(node_uuids; ...)`; `docs/make.jl` already exposes that page. | Amend the existing gallery page only; retain its UUID-first code and existing links. Do not create a UUID-guide file or change `docs/make.jl`. | Add a new UUID page, link only to it, and leave the gallery's request behavior unclear; or replace the gallery recipe with decoded `glyph` matrices. | Gallery source and rendered review finds the UUID-first recipe, existing links, and no new UUID route or local-image first path. |
| T7-02 | Supplied `node_labels` are documented as display labels that prevent the default preferred-name lookup. | `src/_node_thumbnail_grid.jl` lines 265-275 calls `_resolve_node_labels` only when labels are absent; the gallery page describes the label text but not the avoided request. | Add one concise sentence immediately after the existing `node_labels` paragraph in `docs/src/how-to/thumbnail-gallery.md`. It must state that labels correspond one-for-one with UUIDs and avoid the default node-name lookup. | Say only that labels improve display text, leaving readers unaware of the request-saving behavior. | A targeted source and rendered-page review fails unless the sentence names `node_labels`, the default lookup, and the avoided request. |
| T7-03 | The docs distinguish per-call UUID deduplication, decoded-image URL caching, and cross-call batch metadata caching. | `_resolve_images_by_uuid` deduplicates one direct call; `_load_phylopic_image` calls `autocache` by URL; `_bulk.jl` wraps `primary_image` and `fetch_images` in `autocache`. | Revise the final decision paragraph of `docs/src/how-to/repeated-queries.md` to state the three boundaries and to state that batch results are for reader code that needs records, not built-in UUID-gallery input. Preserve the existing API names. | Say that direct rendering calls batch APIs, that direct gallery metadata queries are batch-cached, or that a batch `Dict` can be passed to `phylopic_thumbnail_grid`. | Compare every revised cache statement with the three named source files and run the targeted prose audit described in Task 2. |
| T7-04 | Gallery readers retain one route to current UUID image-rendering options without a duplicate option catalog. | `docs/src/how-to/thumbnail-gallery.md` links to `docs/src/how-to/choose-phylopic-images.md`; that page documents direct UUID rendering with the supported `image_rendering` symbols. | Retain the existing image-selection link and do not edit `choose-phylopic-images.md`, `docs/make.jl`, or reference pages. | Copy the rendering-symbol catalog into the gallery page or remove the image-selection route while leaving the new label sentence. | Rendered gallery-link review and image-choice-page review fail a missing route or duplicated catalog. |
| T7-05 | Cache implementation detail remains later guidance rather than first-contact content. | `docs/src/primer.md` and `docs/src/tutorial.md` link to `how-to/repeated-queries.md`; the later page carries the detailed cache content. | Limit cache prose edits to `docs/src/how-to/repeated-queries.md`; leave primer and tutorial unchanged. | Insert `DataCaches.autocache` setup, cache keys, or batch-query instructions into primer or tutorial prose. | Source and rendered review of primer, tutorial, and repeated-query page fails the moved cache detail. |
| T7-06 | The clarification changes documentation prose only and preserves the existing dirty Tranche 6 work. | `git status --short` reports modified Tranche 6 documentation and source files before this task begins. | Record the pre-task Git-status and changed-file lists, then touch only `docs/src/how-to/thumbnail-gallery.md` and `docs/src/how-to/repeated-queries.md`; retain the current PBDB route text in the gallery page. | Modify `src/`, `Project.toml`, `docs/make.jl`, CI, dependencies, or generated assets to avoid documenting a boundary. | The before/after changed-file comparison, the limited `git diff --check` command, and Git-status review expose a non-baseline file edit, whitespace damage, or tracked PNG asset. |
| T7-07 | The two pages remain direct, goal-oriented how-to material with canonical terminology. | The pages are titled “Build a thumbnail gallery” and “Cache repeated PhyloPic queries”; the PRD reserves implementation details for bounded context. | Use direct prose about UUIDs, labels, galleries, image records, and repeated queries; link to reference for keyword catalogs. | Turn either page into an internal implementation explanation, reproduce a full parameter catalog, or use proscribed vocabulary. | Rendered role review and `STYLE-vocabulary.md` audit of the changed paragraphs fail the drift. |

## Handoff packet

- **Active authorities**: the thirteen repo-local `STYLE-*.md` files named in
  Governance, the corresponding bundled governance corpus, the approved PRD,
  and the parent tranche plan.
- **Parent documents**: `.workflow-docs/202608140015_diataxis-docs-rewrite/01_prd.md`
  and `.workflow-docs/202608140015_diataxis-docs-rewrite/02_tranches.md`.
- **Authorization boundary**: only the two named how-to Markdown pages may
  change. Public API behavior, source implementation, dependencies, networking,
  navigation, CI, example scripts, and generated assets remain outside scope.
- **Current-state diagnosis**: the broad UUID and cache pages requested by the
  original tranche already exist after Tranche R1 and the current later
  documentation work. The remaining reader-facing omission is the label-fetch explanation;
  the repeated-query guide needs an explicit guard against treating batch
  metadata records as gallery input.
- **Named responsible code entities**: `_resolve_node_labels` in
  `src/_node_thumbnail_grid.jl` fetches default preferred names; supplied
  `node_labels` bypasses it. `_resolve_images_by_uuid` in
  `src/_glyph_resolution.jl` deduplicates direct UUIDs per call.
  `_load_phylopic_image` in `src/_image_cache.jl` caches decoded URLs.
  `PhyloPicDB.batch_primary_images` and `PhyloPicDB.batch_images` in
  `src/PhyloPicDB/_bulk.jl` cache metadata-query results.
- **Consumers and prohibited bypasses**: `phylopic_thumbnail_grid` consumes
  UUIDs and optional labels; it must not be described as consuming batch `Dict`
  values. `augment_phylopic!` consumes a `node_uuid` vector or a local `glyph`.
  No docs page may reframe a local glyph as normal first contact.
- **Required upstream primary sources**: Diataxis how-to guidance at
  <https://diataxis.fr/how-to-guides/>; Documenter syntax for `@example`,
  `@setup`, and document links at
  <https://documenter.juliadocs.org/stable/man/syntax/>; DataCaches upstream
  repository and README at <https://github.com/JuliaData/DataCaches.jl>.
- **Green-state gates**: Task 1's two-document review, `julia --project=docs
  docs/make.jl`, targeted source audits, rendered-page review, whitespace/diff
  review, and no generated-source-asset addition.
- **Stop conditions**: stop and request project-owner direction if a desired
  claim requires a cache behavior absent from the three cited local source
  files, a live PhyloPic API contract beyond those sources, a public API change,
  a dependency change, a navigation change, or an edit that overwrites the
  existing Tranche 6 changes.

## Required revalidation before implementation

- Read the parent PRD and Tranche 7 in full.
- Read `docs/src/how-to/thumbnail-gallery.md`,
  `docs/src/how-to/repeated-queries.md`, `docs/src/primer.md`,
  `docs/src/tutorial.md`, and `docs/make.jl` in full.
- Read `src/_node_thumbnail_grid.jl`, `src/_glyph_resolution.jl`,
  `src/_image_cache.jl`, and `src/PhyloPicDB/_bulk.jl` in full.
- Read the three required upstream primary sources in full.
- Inspect the current `git diff` before editing. Preserve the user-owned
  Tranche 6 hunk in the gallery page.
- Stop before changing a project file when the current diagnosis or an upstream
  contract differs from this handoff packet.

## Tranche execution rule

The tranche repairs prose in the two designated how-to pages and ends with the
existing documentation surface still UUID-first, cache details still later, and
the public implementation untouched. `docs/src/how-to/thumbnail-gallery.md`
and `docs/src/how-to/repeated-queries.md` are the only narrative surfaces that
receive changes. The requested simplification is positive: a reader with UUIDs
and labels learns which direct gallery call to use and avoids an unnecessary
name lookup; a reader reusing queries learns exactly which API preserves image
records and metadata-query cache entries.

## Non-negotiable execution rules

- Do not add a standalone UUID, DataCaches, or gallery page.
- Do not add `DataCaches.autocache` setup or cache-key detail to the primer,
  tutorial, or home page.
- Do not describe direct `augment_phylopic!` or `phylopic_thumbnail_grid` as a
  call to `batch_primary_images` or `batch_images`.
- Do not describe decoded-image URL caching as cached PhyloPic metadata lookup.
- Do not claim a batch-result dictionary can be passed to the UUID-gallery API.
- Do not change source, dependencies, nav configuration, CI, example scripts,
  API docstrings, generated PNG policy, or existing PBDB wording.
- Do not replace reader-facing verification with a broad text-policing test;
  use the targeted audit only to test the precise documentation contracts and
  pair it with a rendered-page review and the Documenter build.

## Concrete anti-patterns or removal targets

- The missing label-request explanation in
  `docs/src/how-to/thumbnail-gallery.md` must no longer be absent.
- The phrase in `docs/src/how-to/repeated-queries.md` that presents batch image
  pools as a built-in gallery prerequisite must be replaced by the exact
  metadata-record boundary.
- A duplicate UUID/DataCaches navigation route, a local-image gallery starting
  point, cache-first primer text, a batch-dictionary gallery recipe, and a
  source-code workaround are forbidden passing implementations.

## Failure-oriented verification

- Inspect the modified gallery paragraph against
  `src/_node_thumbnail_grid.jl` lines 126-149 and 265-275. It must tell readers
  that supplied `node_labels` avoid the default preferred-name lookup.
- Inspect all cache statements in the modified repeated-query page against
  `src/_glyph_resolution.jl` lines 51-74, `src/_image_cache.jl` lines 42-60,
  and `src/PhyloPicDB/_bulk.jl` lines 55-145. The prose must separately name
  direct-call deduplication, decoded-image URL caching, and batch metadata
  caching.
- Run `rg -n "offline_silhouette|_offline_silhouette|preloaded image matrix|secret offline image|local image fixture" README.md docs/src`; a normal
  no-match exit status is required.
- Run `rg -n "node_labels|default.*node|preferred-name" docs/src/how-to/thumbnail-gallery.md`
  and inspect the exact added sentence. This targeted check fails a label-only
  prose edit that omits the avoided lookup.
- Run `rg -n "batch_primary_images|batch_images|_load_phylopic_image|DataCaches.autocache" docs/src/how-to/repeated-queries.md docs/src/how-to/thumbnail-gallery.md`
  and compare every match with the cited local source files. This audit fails a
  claim that combines the distinct cache contracts.
- Run `julia --project=docs docs/make.jl`; Documenter executes `@example`
  blocks, so a failing build proves that the modified Markdown broke the
  rendered documentation surface.
- Review the rendered gallery, repeated-query, primer, and tutorial pages.
  Confirm the gallery remains UUID-first and goal-titled, the cache details
  stay later, links reach existing task/reference pages, and no parameter
  catalog is duplicated.
- Before Task 1, record `git status --short` and `git diff --name-only` in the
  implementation report. After Task 1, the changed-file list may differ from
  that baseline only by `docs/src/how-to/repeated-queries.md`; the gallery page
  already occurs in the baseline and its existing Tranche 6 paragraph must
  remain intact. Run `git diff --check -- docs/src/how-to/thumbnail-gallery.md
  docs/src/how-to/repeated-queries.md`. Confirm `git status --short` does not
  show a generated PNG added as a source asset.

## Tasks

### 1. Clarify UUID gallery labels and repeated-query cache boundaries

**Type**: WRITE
**Output**: The existing thumbnail-gallery and repeated-query how-to pages state
the label request behavior and exact cache boundaries without new navigation or
API behavior.
**Depends on**: none
**Positive contract**: `docs/src/how-to/thumbnail-gallery.md` states that
one-to-one supplied `node_labels` both supply gallery display labels and avoid
the default preferred-name lookup. `docs/src/how-to/repeated-queries.md`
distinguishes per-call direct UUID deduplication, decoded-image URL caching,
and cross-call metadata caching through the named batch APIs.
**Negative contract**: No standalone UUID/DataCaches page, no local-image first
path, no cache detail in first-contact pages, no batch dictionary gallery
recipe, no claim that direct UUID rendering calls batch APIs, and no loss of the
existing `PaleobiologyDB.PBDBMakie` link or explanation link in the gallery
page.
**Files**: `docs/src/how-to/thumbnail-gallery.md`; `docs/src/how-to/repeated-queries.md`.
**Out of scope**: `README.md`; `docs/make.jl`; all other `docs/src/` files;
all `src/` files; `Project.toml`; `docs/Project.toml`; examples; CI; generated
images; and workflow files other than this tasking plan.
**Verification**: Complete the two-page source review against the four cited
source files, run the three targeted `rg` audits in Failure-oriented
  verification, record the pre-task Git baseline to preserve Tranche 6 text,
  and run the limited `git diff --check` command.

Add one sentence after the existing `node_labels` explanation in the gallery
page. State that the vector aligns with `node_uuids`, supplies the displayed
taxon-name context, and avoids the default name lookup. In the repeated-query
page, replace the final recommendation sentence with a direct decision rule:
direct UUID plotting or the built-in UUID gallery is appropriate for immediate
rendering; the two batch APIs are appropriate when the reader's own code needs
image records or cross-call metadata-query caching. State that their returned
records are not an input form for `phylopic_thumbnail_grid`. Retain the current
links to image selection and reference rather than duplicating keyword tables.
The source facts require this exact division: the direct resolver calls
`primary_image` once per unique UUID in a call, the decoded loader caches by
URL, and the batch functions wrap metadata queries in `DataCaches.autocache`.

### 2. Prove the reader path, cache claims, and scope boundary

**Type**: TEST
**Output**: A documented implementation result records a green docs build and
the lock-by-lock audit outcome; no additional project file is created.
**Depends on**: 1
**Positive contract**: The rendered documentation builds, the gallery page
remains a goal-oriented UUID recipe, the repeated-query page has the exact
three-part cache explanation, first-contact pages remain cache-light, and the
change set remains inside the two Markdown files.
**Negative contract**: A green build alone is insufficient. Completion must not
ignore a missing label lookup explanation, a claim that direct gallery input is
a batch `Dict`, an overbroad DataCaches assertion, a changed source file, or a
tracked generated PNG.
**Files**: none; this is read-only verification after Task 1.
**Out of scope**: every project file, all Git mutations, and any repair beyond
the two Markdown files authorized in Task 1.
**Verification**: Run every command and complete every rendered/source/diff
inspection listed in Failure-oriented verification. Record the commands,
results, inspected source facts, and any stop condition in the implementation
report.

Run the Documenter build after the targeted source audits. Review four rendered
pages in this order: gallery, repeated queries, primer, tutorial. Compare the
two changed paragraphs to the exact source entities named in the Handoff packet.
Finish with changed-file and generated-asset inspection. Stop rather than
changing other files when a lock fails; return the failed lock, direct repro,
and source evidence to the project owner.

---
