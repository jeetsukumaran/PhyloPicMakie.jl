---
date-created: 2026-08-19T03:01:37-07:00
workflow-instrument: Tasking plan
workflow-status: Approved
workflow-agent-thread-id: codex/01a01974-a20a-71e1-899e-cea400b9d4c7
workflow-agent-implementing-id:
  - codex/01a019cf-398d-7700-a063-6581f1fd1436
workflow-location: /home/jeetsukumaran/site/storage/local/computing/research/20260414_PhyloPicMakie.jl/PhyloPicMakie.jl
workflow-production-id: diataxis-docs-primer
workflow-prd: .workflow-docs/202608140015_diataxis-docs-rewrite/01_prd.md
workflow-tranche: .workflow-docs/202608140015_diataxis-docs-rewrite/02_tranches.md#tranche-8-reorganize-reference-pages
---

# Tasks for Tranche 8: Reorganize reference pages

## Settled user decisions and environment baseline

- This is a documentation-only tranche. It may change reference Markdown and
  Documenter configuration, but it must not change package behavior, exported
  names, signatures, keyword semantics, network behavior, dependencies,
  manifests, path overrides, CI, or example-script behavior.
- `docs/src/api/rendering.md` is the canonical rendered reference surface for
  the six `PhyloPicMakie` exports in `src/PhyloPicMakie.jl`:
  `augment_phylopic!`, `augment_phylopic`, `augment_phylopic_ranges!`,
  `augment_phylopic_ranges`, `phylopic_thumbnail_grid!`, and
  `phylopic_thumbnail_grid`.
- `docs/src/api/phylopic_db.md` is the canonical rendered reference surface
  for the public exports of `PhyloPicMakie.PhyloPicDB`, as declared in
  `src/PhyloPicDB/PhyloPicDB.jl`.
- Reference pages are information-oriented. They give concise, ordered API
  facts and link to task-oriented material; primer, tutorial, and how-to pages
  retain user goals, recipes, expected results, and bounded examples.
- Use `@autodocs` with `Private = false`, an explicit `Order`, and explicit
  `Pages` lists. This is the settled design because Documenter documents all
  public names without copying method signatures into Markdown, while `Pages`
  supplies a stable source-file order. Do not switch to `@docs` lists, which
  would duplicate and maintain every exported method signature by hand.
- Set `checkdocs = :exports` in `docs/make.jl`. With public-only reference
  blocks, Documenter must check that exported docstrings are present while not
  demanding that intentionally excluded private implementation helpers appear
  in public reference pages.
- Existing source docstrings are the API fact source. No source docstring edit
  is authorized in this tranche: every export currently has a docstring and
  the required facts can be rendered from it. A discovery that this premise is
  false is a stop condition, not permission to change package source.
- Generated `docs/build/` files and PNGs are ignored build products. They are
  verification artifacts and must not be added as documentation source assets.

## Governance

Read every governing document below line by line before implementation and
pass its mandates forward into the implementation report. The repo-local files
are project-specific authorities; the matching bundled files in
`/home/jeetsukumaran/.codex/skills/development-policies/references/` remain
the baseline corpus.

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
present. Read-only Git and shell commands are allowed. Commit, merge, rebase,
push, and branch operations remain the project owner's responsibility.

Read these upstream primary sources before editing:

- [Diataxis reference guidance](https://diataxis.fr/reference/): reference
  material is concise, ordered, information-oriented description of the
  product rather than a tutorial or how-to.
- [Documenter `makedocs` public API](https://documenter.juliadocs.org/stable/lib/public/):
  `pages` sets rendered navigation order, and `checkdocs = :exports` checks
  exported docstring coverage.
- [Documenter syntax](https://documenter.juliadocs.org/stable/man/syntax/):
  `@autodocs` accepts `Private`, `Order`, and `Pages`; `Private = false`
  retains public names, and `Pages` both filters and orders docstrings.

## Primary-goal lock

### T8-01: Make rendering facts quick to find

The work is not complete if a reader opening the rendering reference cannot
find the six exported plotting and gallery APIs, their signatures, keywords,
valid symbols, return behavior, missing-image policy, and error behavior in
one public reference page.

Direct red-state repro: `docs/src/api/rendering.md` lines 16-26 lead with the
normal UUID path and DataCaches batch-query guidance before its bare,
unfiltered `@autodocs` block. That arrangement makes the reference opening
carry task guidance and lets private `PhyloPicMakie` docstrings appear.

Tasks that close it: 1 and 3. The failing verification artifact is the built
`docs/build/api/rendering.html` review plus the explicit exported-name audit in
Task 3; it fails a page that omits an export or does not expose the existing
docstring sections for facts and errors.

### T8-02: Make PhyloPicDB facts quick to find

The work is not complete if a reader opening the PhyloPicDB reference cannot
find the exported types, constants, lookup, image-selection, and batch-query
APIs in a stable public order with their existing return and error facts.

Direct red-state repro: `docs/src/api/phylopic_db.md` lines 7-12 have a
two-sentence implementation description and two task links, followed by an
unfiltered `@autodocs` block. It neither identifies the public API categories
nor prevents private helpers from being published beside public functions.

Tasks that close it: 2 and 3. The failing verification artifact is the built
`docs/build/api/phylopic_db.html` review plus the `Private = false`, ordered
`Pages` inspection in Task 3; it fails a reference that publishes private
helpers or loses an exported public docstring.

### T8-03: Preserve the Diataxis division between reference and task guidance

The work is not complete if either API page provides a multi-step plotting,
gallery, cache, or image-selection recipe, or if any primer, tutorial, or
how-to page copies a complete rendering or PhyloPicDB parameter catalog.

Direct red-state repro: `docs/src/api/rendering.md` lines 16-26 prescribe the
normal UUID input path and cross-call caching API; that guidance duplicates the
purpose of `docs/src/how-to/choose-phylopic-images.md`,
`docs/src/how-to/thumbnail-gallery.md`, and
`docs/src/how-to/repeated-queries.md`.

Tasks that close it: 1, 2, and 3. The failing verification artifact is the
source and rendered-page role review in Task 3: both API introductions contain
only concise scope and route links, while the named learning pages still link
to reference rather than reproduce the full catalog.

### T8-04: Give search arrivals an explicit route to task help

The work is not complete if an API-page reader cannot navigate to the tutorial
or a matching how-to page without interpreting internal implementation prose,
or if the page duplicates those guides instead of linking to them.

Direct red-state repro: the rendering page has links, but its opening groups
unrelated GraphMakie, placement, gallery, missing-image, and PBDB topics ahead
of the rendered public interface; the PhyloPicDB page links only to two how-tos
without a tutorial route.

Tasks that close it: 1, 2, and 3. The failing verification artifact is the
rendered link review in Task 3: rendering links point to tutorial, points,
ranges, table columns, placement, gallery, missing-image, and image-choice
guides; PhyloPicDB links point to tutorial, image choice, gallery, and repeated
queries.

### T8-05: Keep the documentation-only and generated-artifact boundaries

The work is not complete if the reference rewrite changes package source,
public behavior, environments, dependency files, CI, navigation structure, or
adds a generated build artifact to Git.

Direct red-state repro: the PRD prohibits API and behavior changes to make
documentation easier, while `Documenter.makedocs` rebuilds `docs/build/` and
the rendered examples can create PNG files there.

Tasks that close it: 1, 2, and 3. The failing verification artifact is the
before/after changed-file review and `git diff --check`; it fails an
implementation that alters any file outside the two API pages and
`docs/make.jl`, or stages a `docs/build/` file.

## Forbidden Passing Implementation Table

| Lock item | Required behavior | Current code state | Resolved implementation instruction | Forbidden passing implementation | Failing verification artifact |
| --- | --- | --- | --- | --- | --- |
| T8-01 | The rendering page exposes all six exported plotting and gallery APIs with their source-docstring facts in a concise public reference. | `docs/src/api/rendering.md` has only a bare `@autodocs` for `PhyloPicMakie`; the default exposes public and private docstrings. | In `docs/src/api/rendering.md`, replace the normal-path/cache paragraphs with a one-paragraph reference scope, task links, and one `@autodocs` block using `Modules = [PhyloPicMakie]`, `Private = false`, `Order = [:function]`, and `Pages = ["_augment_api.jl", "_node_thumbnail_grid.jl", "_thumbnail_grid.jl"]`. | Keep the bare all-name block and add headings around it, so internal helpers remain public and exported facts retain accidental order. | Built `docs/build/api/rendering.html`; source inspection of the exact `@autodocs` fields; exported-name audit for the six names. |
| T8-02 | The PhyloPicDB page exposes its exported constants, types, and functions in source-file order without private helpers. | `docs/src/api/phylopic_db.md` has a bare `@autodocs` for the whole submodule. | In `docs/src/api/phylopic_db.md`, use `Modules = [PhyloPicMakie.PhyloPicDB]`, `Private = false`, `Order = [:constant, :type, :function]`, and `Pages = ["_http.jl", "_build.jl", "_types.jl", "_api_nodes.jl", "_api_images.jl", "_api_resolve.jl", "_image_selector.jl", "_bulk.jl"]`. | Filter only the visible introduction while retaining default `@autodocs`, or manually list selected functions and silently omit exported constants or types. | Built `docs/build/api/phylopic_db.html`; source inspection of the exact block; export-to-rendered-reference audit. |
| T8-03 | Reference remains concise API information; task pages retain recipes and link back for exhaustive facts. | Rendering reference currently states normal UUID and batch-cache paths before API facts; how-to index already links to rendering reference. | Remove the task-path/cache prose from rendering reference; retain concise task links in both API introductions and leave all primer, tutorial, and how-to files unchanged. | Copy the repeated-query or image-selection instructions into the reference introduction, or paste every keyword table from source docstrings into a how-to. | Source/rendered role review of both API pages and the named tutorial/how-to pages; the build catches invalid links. |
| T8-04 | Readers arriving through either API page receive direct, relevant links to learning material. | Rendering links are an ungrouped list; PhyloPicDB links omit the tutorial and gallery route. | Write categorized one-line route lists in the two API introductions, using only the settled relative Markdown targets listed in T8-04. | Add generic “see the docs” text, retain no tutorial route, or replace guide links with internal-source links. | Rendered link review after `julia --project=docs docs/make.jl`; link destinations must be the named reader-facing pages. |
| T8-05 | The tranche changes only reference Markdown and the public-docs coverage setting needed by public-only blocks; generated output remains untracked. | `docs/make.jl` has `modules` but no `checkdocs` setting; `docs/build/` is ignored and regenerated by the build. | Add only `checkdocs = :exports` to the existing `makedocs` call. Limit the tranche diff to `docs/make.jl`, `docs/src/api/rendering.md`, and `docs/src/api/phylopic_db.md`. | Modify source docstrings, package environments, CI, `pages`, or examples to make reference output look better; add build HTML or PNG files. | Before/after `git status --short`, `git diff --check`, and changed-file inspection; build output is inspected but not staged. |

## Handoff packet

- **Active authorities**: the thirteen repo-local `STYLE-*.md` files named in
  Governance, the corresponding bundled corpus, the approved PRD, and the
  approved tranche plan. `STYLE-agent-language.md` controls every use of
  ownership, contract, boundary, responsibility, or verification language.
- **Parent documents**: `.workflow-docs/202608140015_diataxis-docs-rewrite/01_prd.md`;
  `.workflow-docs/202608140015_diataxis-docs-rewrite/02_tranches.md`.
- **Authorization boundary**: only `docs/make.jl`,
  `docs/src/api/rendering.md`, and `docs/src/api/phylopic_db.md` may change.
  Package source, all other docs, examples, environments, CI, navigation, and
  generated files are out of scope.
- **Current-state diagnosis**: both reference pages use unfiltered
  `@autodocs`. Rendering also carries normal-path and cache guidance before its
  API facts. The source exports and docstrings already provide the facts; no
  source edit is needed.
- **Responsible entities and consumers**: `docs/make.jl` owns Documenter
  coverage selection for the modules it passes to `makedocs`; public reference
  pages consume that selection. `docs/src/api/rendering.md` owns public
  `PhyloPicMakie` reference presentation; `docs/src/api/phylopic_db.md` owns
  public `PhyloPicDB` reference presentation. Primer, tutorial, and how-to
  pages consume them through links and must not become duplicate API catalogs.
- **Required upstream sources**: the three URLs named in Governance. The
  controlling project sources are `src/PhyloPicMakie.jl`,
  `src/_augment_api.jl`, `src/_thumbnail_grid.jl`,
  `src/_node_thumbnail_grid.jl`, `src/PhyloPicDB/PhyloPicDB.jl`, and the eight
  PhyloPicDB source files named in T8-02.
- **Green-state gates**: `julia --project=docs docs/make.jl`; generated API
  page review; exported-name and private-helper audits; `git diff --check`; a
  changed-file review restricted to the three authorized files.
- **Stop conditions**: stop and ask the project owner if an export lacks a
  docstring, an existing docstring states an incorrect public fact, a public
  behavior change appears necessary, or Documenter rejects the settled
  public-only `@autodocs`/`checkdocs` configuration.

## Required revalidation before implementation

- Read the tranche and parent PRD in full.
- Read the three authorized files and every source file named in the handoff
  packet in full.
- Read the three upstream primary sources in Governance in full.
- Confirm that the six root exports and all `PhyloPicDB` exports still match
  the public source declarations before setting `Private = false`.
- Re-check the documentation-only boundary and current Git status before every
  edit. Stop if current reality conflicts with the diagnosis or a higher
  authority.

## Tranche execution rule

The work begins and ends with a documentation-only, policy-compliant repository.
`docs/make.jl` may change only to enforce exported-docstring coverage for the
public-only reference blocks. `docs/src/api/rendering.md` and
`docs/src/api/phylopic_db.md` become the sole canonical public reference pages;
no duplicate public API catalog may be added elsewhere. Documentation must
adapt to the current API, not widen it.

## Non-negotiable execution rules

- Do not edit `src/`, `Project.toml`, `Manifest.toml`, `docs/Project.toml`,
  `docs/Manifest.toml`, `.github/`, `examples/`, or any non-reference Markdown.
- Do not alter `docs/make.jl` navigation, modules, `warnonly`, deployment, or
  doctest behavior. Add only `checkdocs = :exports`.
- Do not document private helpers, internal overlay mechanics, cache-key
  mechanics, or source-file call graphs as public reference material.
- Do not move tutorial, how-to, or cache recipes into either API page.
- Do not create source-text assertions, CI text policing, or a test helper that
  duplicates the documentation's reader-navigation responsibility.
- Do not commit, stage, or otherwise treat `docs/build/` HTML and PNG output as
  source material.

## Concrete anti-patterns or removal targets

- Remove the `docs/src/api/rendering.md` lines 16-26 task-path and DataCaches
  guidance from the reference introduction; the existing how-to pages remain
  responsible for that material.
- Replace each bare `@autodocs` block that defaults to public and private names
  with the exact public-only, ordered, source-filtered block fixed in T8-01 or
  T8-02.
- Prevent a second API catalog from appearing in `docs/src/primer.md`,
  `docs/src/tutorial.md`, or `docs/src/how-to/`; those files are read-only in
  this tranche and must retain their links to reference.
- Prevent `checkdocs = :all` from forcing private implementation documentation
  back into the public pages after `Private = false` excludes it.

## Failure-oriented verification

- Run `julia --project=docs docs/make.jl`. The command must complete without
  missing-exported-docstring, duplicate-docstring, cross-reference, or doctest
  errors.
- Inspect `docs/build/api/rendering.html` and `docs/build/api/phylopic_db.html`.
  The rendering page must expose exactly the six exported root entry points;
  the PhyloPicDB page must expose its exported constants, types, and functions.
  Neither page may expose underscored helpers such as `_extract_column`,
  `_resolve_node_labels`, `_build_node_grid_cells`, or `_download_image`.
- Inspect the two source blocks to verify every settled `@autodocs` option and
  the one settled `checkdocs = :exports` setting are present. This fails a
  cosmetic introduction-only rewrite.
- Review the rendered page openings. They must state scope and provide the
  explicit links fixed in T8-04, with no step-by-step cache, UUID, placement,
  gallery, or image-selection recipe.
- Review `docs/src/tutorial.md`, `docs/src/how-to/index.md`,
  `docs/src/how-to/choose-phylopic-images.md`,
  `docs/src/how-to/thumbnail-gallery.md`, and
  `docs/src/how-to/repeated-queries.md` read-only. They must still point to
  reference rather than contain an exhaustive copied parameter catalog.
- Run `git diff --check`, then compare `git status --short` with its pre-task
  snapshot. Only the three authorized files may differ; ignored build products
  must not be staged.

## Tasks

### 1. Publish an ordered public rendering reference

**Type**: WRITE
**Output**: `docs/src/api/rendering.md` renders the six public plotting and
gallery entry points in a stable source-file order, with concise links to
tutorial and matching how-to pages; `docs/make.jl` checks exported docstrings.
**Depends on**: none
**Positive contract**: The rendering reference begins with a concise statement
that it contains plotting and gallery API facts. It links to the tutorial;
point, range, and table guides; placement; thumbnail gallery; missing-image;
and image-choice guides. Its sole canonical API block is the exact public-only
`@autodocs` configuration in T8-01. `docs/make.jl` contains
`checkdocs = :exports` in the existing `makedocs` call.
**Negative contract**: The page does not prescribe a normal UUID path, explain
DataCaches batch use, reproduce a task recipe, show private helper docstrings,
or create a manual API signature list. Do not edit any tutorial or how-to page,
source docstring, navigation entry, or build product.
**Files**: `docs/make.jl`; `docs/src/api/rendering.md`.
**Out of scope**: `docs/src/api/phylopic_db.md`; every other Markdown page;
`src/`; `Project.toml`; docs environments; CI; `docs/build/`.
**Verification**: Run `julia --project=docs docs/make.jl`; inspect the rendered
rendering page for the six exports and absence of `_extract_column`,
`_resolve_node_labels`, `_build_node_grid_cells`, and `_download_image`; verify
the source has the exact T8-01 block and only `checkdocs = :exports` added to
`makedocs`; run `git diff --check`.

Replace the current paragraphs at lines 16-26 of
`docs/src/api/rendering.md` with the concise scope and route links fixed above.
Keep `CurrentModule = PhyloPicMakie`. Apply the exact `@autodocs` block stated
in T8-01; `Pages` order must group coordinate and range APIs before UUID-gallery
and generic-gallery APIs. Add `checkdocs = :exports` beside the existing
`modules` setting in `docs/make.jl`; Documenter's public API defines this as
the exported-docstring coverage mode needed after the reference excludes
private names. This task ends green for rendering-reference scope, even though
the PhyloPicDB reference remains for Task 2.

### 2. Publish an ordered public PhyloPicDB reference

**Type**: WRITE
**Output**: `docs/src/api/phylopic_db.md` renders all public PhyloPicDB API
facts in the stable constant/type/function and source-file order fixed in
T8-02, with direct routes to task-oriented material.
**Depends on**: 1
**Positive contract**: The page opens with a concise PhyloPicDB API scope and
links to the tutorial, image-choice guide, thumbnail-gallery guide, and
repeated-queries guide. Its canonical API block is exactly the public-only,
ordered `@autodocs` configuration in T8-02. Constants, types, and functions
render from the existing source docstrings.
**Negative contract**: The page does not call itself a tutorial, teach a
multi-step query/cache/gallery workflow, repeat a how-to recipe, expose a
private helper, or alter any source docstring to make an output look cleaner.
**Files**: `docs/src/api/phylopic_db.md`.
**Out of scope**: `docs/make.jl`; `docs/src/api/rendering.md`; all other
documentation; `src/`; dependencies; CI; `docs/build/`.
**Verification**: Run `julia --project=docs docs/make.jl`; inspect the source
for the exact T8-02 block; inspect rendered PhyloPicDB page categories and
confirm `_fetch_node_image_pool`, `_with_node_name`, and `_phylopic_get` do
not appear; run `git diff --check`.

Replace the current two-sentence introduction and bare `@autodocs` block with
the resolved concise reference opening and route list. Keep
`CurrentModule = PhyloPicMakie`; refer to the submodule by its fully qualified
name in the block. Use the exact order and `Pages` sequence in T8-02, which
places base URL/build facts first, record types next, then node/image resolution,
selection, and batch-query functions. Documenter allows `Pages` to filter and
sort by source file; this prevents private helpers from surviving as a second
public reference implementation. This task ends with a full docs build green.

### 3. Prove the public-reference boundary and reader routes

**Type**: TEST
**Output**: A completed, reproducible verification record in the implementation
report showing the docs build, exported-name coverage, private-helper absence,
reader routes, role separation, and limited diff all pass. No repository test
or source-text-policing file is created.
**Depends on**: 1, 2
**Positive contract**: The build succeeds; the two rendered pages satisfy every
T8 lock item; the known bare-block/private-helper and task-guidance regressions
fail the specified inspections; and the working-tree diff is restricted to the
three authorized files.
**Negative contract**: Do not add a CI rule, snapshot fixture, string-locking
test, or source-text checker to police reference prose. Do not treat a passing
build alone as sufficient, and do not stage generated HTML or PNG output.
**Files**: none; this task writes only the external implementation report.
**Out of scope**: all repository files, Git history, CI, generated build
output, package environments, and documentation prose.
**Verification**: Run `julia --project=docs docs/make.jl`, `git diff --check`,
and `git status --short`; inspect both rendered API pages and the source blocks
against the Failure-oriented verification list; compare public exports in
`src/PhyloPicMakie.jl` and `src/PhyloPicDB/PhyloPicDB.jl` with rendered names.

Record exact commands, outcomes, inspected generated paths, all rendered public
names, absent private helper names, verified route targets, and the final
changed-file list in the implementation report. State separately whether each
T8-01 through T8-05 lock closes. A docs build that passes while a private
helper, missing export, duplicated task recipe, missing reader route, or
out-of-scope file remains is not a green result.
