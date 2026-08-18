---
date-created: 2026-08-17T20:34:00-07:00
workflow-instrument: Tasking plan
workflow-status: Completed
date-completed: 2026-08-17T21:29:39-07:00
workflow-agent-thread-id: codex/01a012ba-cb10-78b0-9d1f-e67e161099d1
workflow-agent-implementing-id:
  - codex/01a012ba-cb10-78b0-9d1f-e67e161099d1
workflow-location: /home/jeetsukumaran/site/storage/local/computing/research/20260414_PhyloPicMakie.jl/PhyloPicMakie.jl
workflow-production-id: diataxis-docs-primer
workflow-prd: .workflow-docs/202608140015_diataxis-docs-rewrite/01_prd.md
workflow-tranche: .workflow-docs/202608140015_diataxis-docs-rewrite/02_tranches.md
---

# Tasks for tranche 5: Write thumbnail gallery how-tos

## Settled user decisions and environment baseline

- Tranche R1 and Tranche 4 are complete. The normal reader path starts from
  PhyloPic node UUIDs, taxon-derived node UUIDs supplied by another package, or
  another package-supported PhyloPic lookup. It does not start from a local
  image matrix, a docs-private fixture, or `offline_silhouette()`.
- This tranche is documentation-only. It may change the named Markdown pages
  and Documenter navigation. It must not change `phylopic_thumbnail_grid!`,
  `phylopic_thumbnail_grid`, PhyloPicDB requests, DataCaches behavior,
  exported names, package dependencies, CI behavior, or plotting behavior.
- The primary how-to recipe uses the existing vector UUID factory
  `phylopic_thumbnail_grid(node_uuids; node_labels, ...)`. It supplies
  `node_labels` explicitly because the reader's labels become the
  `:taxon_name` portion of each gallery-cell label. The guide makes no
  network-request-count claim from that choice.
- A taxon-name workflow belongs to
  `PaleobiologyDB.PhyloPicPBDB.phylopic_thumbnail_grid!`. The new guide may
  route readers to that external public surface, but it must not present
  PhyloPicMakie itself as accepting taxon names.
- `phylopic_thumbnail_grid` accepts UUIDs and chooses image records internally.
  It does not accept a vector of `PhyloPicImage` records as a public input.
  The prebuilt-cell overload accepts decoded image matrices, labels, and group
  sizes. Mention that overload only as a secondary reference path for readers
  who already have decoded images; do not give it the primary recipe.
- `image_layout = :blocks` keeps each non-empty UUID group on a fresh row and
  wraps that group at `ncols`; `:rows` gives each non-empty group one unwrapped
  row; `:flat` ignores group boundaries. The primary recipe uses `:blocks`.
- The cache boundary is fixed: `PhyloPicDB.batch_primary_images` and
  `PhyloPicDB.batch_images` deduplicate UUIDs and call `DataCaches.autocache`
  in `src/PhyloPicDB/_bulk.jl`. Direct gallery resolution uses
  `primary_image`, `clade_images`, or `node_images` in
  `src/_node_thumbnail_grid.jl`; it does not call either batch function.
  `_download_image` reaches the DataCaches-backed decoded-image loader for a
  selected URL. The guide must not claim that a direct gallery call receives
  the batch-query cache.
- `examples/src/thumbnail_gallery.jl` is a deterministic local rendering
  example for the generic prebuilt-cell overload. It is a PNG verification
  artifact and an advanced rendering example, not the normal PhyloPic-backed
  reader path. Its current 2026-08-17 revalidation created
  `/tmp/thumbnail_gallery-t5-revalidation.png`, identified as a 2368×2226
  RGBA PNG.
- Generated PNGs are build products and verification artifacts. Do not add a
  PNG to version control or `docs/src/`. Documenter page examples that create
  output must write below their page-specific directory in `docs/build/`.
  This tasking deliberately keeps the normal gallery recipe as a `julia` code
  block because it performs live PhyloPic requests; it does not add a
  network-sensitive `@example` image to the documentation build.
- The repository has no `CONTRIBUTING*.md`, `STYLE-python.md`, or
  `STYLE-domain-vocabulary.md`. The twelve shared governance documents are
  byte-identical to the bundled policy copies. `STYLE-vocabulary.md` is a
  separate repo-local authority. No `codebases-and-documentation` directory is
  available.

## Governance

Before implementation, read each authority below line by line and comply with
it throughout the work:

- `.workflow-docs/202608140015_diataxis-docs-rewrite/01_prd.md`.
- `.workflow-docs/202608140015_diataxis-docs-rewrite/02_tranches.md`.
- `.workflow-docs/202608140015_diataxis-docs-rewrite/03-05_tranche-r1--tasking-1.md`.
- `.workflow-docs/202608140015_diataxis-docs-rewrite/03-06_tranche-04--tasking-2.md`.
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

`STYLE-agent-language.md` applies to every statement about a responsibility,
contract, boundary, invariant, source, or verification artifact. Each such
statement must name the exact file, function, behavior, consuming page or
caller, duplicate or bypass path that must not keep the behavior, and the
verification artifact that exposes an incomplete result.

Read-only git and shell commands are allowed. Commit, merge, push, branch,
checkout, rebase, and reset remain the project owner's responsibility unless
the owner explicitly authorizes them.

## Upstream primary sources and local contract conclusions

Read these sources before implementation:

- Diataxis how-to guides: <https://diataxis.fr/how-to-guides/>.
- Documenter syntax for `@meta`, named `@setup`, named `@example`, and
  build-directory image paths: <https://documenter.juliadocs.org/stable/man/syntax/>.
- Documenter guide for the `docs/src` and `docs/make.jl` structure:
  <https://documenter.juliadocs.org/stable/man/guide/>.
- DataCaches README for transparent, instrumented caching and persistence:
  <https://github.com/JuliaData/DataCaches.jl>.

Read these local sources before implementation:

- `docs/make.jl`.
- `docs/src/index.md`.
- `docs/src/how-to/index.md`.
- `docs/src/examples.md`.
- `docs/src/api/rendering.md`.
- `docs/src/how-to/choose-phylopic-images.md`.
- `docs/src/how-to/repeated-queries.md`.
- `examples/src/thumbnail_gallery.jl`.
- `src/_thumbnail_grid.jl`.
- `src/_node_thumbnail_grid.jl`.
- `src/_image_cache.jl`.
- `src/PhyloPicDB/_bulk.jl`.
- `src/PhyloPicDB/_image_selector.jl`.
- `src/PhyloPicDB/_types.jl`.
- `test/test_render_core.jl`.

Resolved conclusions:

- Diataxis requires a how-to to address a user project through a practical,
  goal-oriented sequence. The page title is exactly "Build a thumbnail gallery".
  It begins with the gallery outcome, not the names of gallery functions or an
  explanation of rendering machinery.
- Documenter evaluates a named `@example` in the rendered page's build
  directory. Because the primary gallery API makes live PhyloPic requests and
  a failed record lookup can yield an empty group rather than a placeholder
  cell, the primary UUID recipe is a visible, non-evaluated `julia` block.
  This avoids representing a network-dependent result as deterministic build
  output. The established deterministic script remains the render artifact.
- `src/_node_thumbnail_grid.jl` defines the public UUID vector, single UUID,
  and table overloads. The UUID vector factory returns a `Makie.Figure`; the
  bang overload renders into a supplied `Makie.Axis` and returns `Nothing`.
  The page's normal recipe uses the vector factory and does not duplicate its
  complete keyword catalog.
- `src/_thumbnail_grid.jl` defines the generic prebuilt-cell overload and its
  group layout semantics. The new page may explain `:blocks` in the primary
  recipe and briefly point to `:rows` and `:flat`; complete layout and label
  keyword facts stay in the rendering reference.
- `src/_node_thumbnail_grid.jl` calls `primary_image`, `clade_images`, or
  `node_images` for direct gallery UUID resolution. It then calls
  `_download_image`, which delegates decoded URL loading to the cached image
  loader. The guide must distinguish that behavior from the batch record APIs
  in `src/PhyloPicDB/_bulk.jl`.
- `examples/src/thumbnail_gallery.jl` calls the generic overload with
  synthetic matrices. It reliably verifies the renderer and output file, but
  it is not evidence for a UUID-first reader recipe and must not be described
  as one.

## Primary-goal lock

### Lock T5-01: Provide a goal-oriented gallery how-to

- The work is not complete if thumbnail gallery guidance remains only the
  `thumbnail_gallery.jl` command in `docs/src/examples.md` or an API docstring.
- Direct red-state repro: `docs/src/examples.md` lists the command and calls
  the result "thumbnail-grid rendering with grouped labels"; no page tells a
  reader how to build a gallery for a labelled collection.
- Tasks that close it: 1 and 2.
- Failing verification artifact: the docs build must produce
  `docs/build/how-to/thumbnail-gallery/index.html`; the rendered page review
  fails if its title or opening does not state the gallery task and expected
  reader result.

### Lock T5-02: Keep the normal gallery path PhyloPic-backed

- The work is not complete if the new guide teaches synthetic or preloaded
  image matrices before PhyloPic node UUIDs.
- Direct red-state repro: `examples/src/thumbnail_gallery.jl` builds
  `cell_images` from `fish_glyph`, `bird_glyph`, and `fern_glyph`, then calls
  the generic prebuilt-cell overload. That is a deterministic renderer
  artifact, not a reader's normal input path.
- Tasks that close it: 1 and 3.
- Failing verification artifact: the source-and-rendered-page audit fails if
  the page's first executable recipe uses `glyph`, `cell_images`,
  `offline_silhouette`, a preloaded image matrix, or a docs-private fixture;
  it also fails if the primary recipe omits `node_uuids`.

### Lock T5-03: Explain only public gallery behavior that the source implements

- The work is not complete if the page fails to show explicit labels, grouped
  `:blocks` layout, `ncols`, primary-image selection, and the expected labelled
  gallery, or if it attributes unsupported record or taxon-name input to
  PhyloPicMakie.
- Direct red-state repro: no gallery how-to currently exists, while
  `src/_node_thumbnail_grid.jl` exposes UUID input and `node_labels`, and
  `src/_thumbnail_grid.jl` defines `:blocks`, `:rows`, and `:flat` layout
  semantics.
- Tasks that close it: 1.
- Failing verification artifact: rendered-page review compares the recipe to
  the documented UUID factory signature and fails a page that presents
  `PhyloPicImage` records or taxon names as direct PhyloPicMakie inputs; the
  gallery source inspection fails claims that `:blocks` ignores group
  boundaries or that `:rows` wraps a group.

### Lock T5-04: State the cache boundary without overclaiming

- The work is not complete if the page says or implies that direct
  `phylopic_thumbnail_grid` calls use `batch_primary_images` or `batch_images`,
  or if it omits the available repeated-query route.
- Direct red-state repro: current gallery documentation has no cache guidance;
  the surrounding docs could invite a broad DataCaches statement despite
  `_build_node_grid_cells` calling direct selector functions rather than batch
  APIs.
- Tasks that close it: 1.
- Failing verification artifact: source review against `src/_node_thumbnail_grid.jl`,
  `src/_image_cache.jl`, and `src/PhyloPicDB/_bulk.jl` fails any sentence that
  assigns `DataCaches.autocache` batch-query behavior to direct gallery UUID
  resolution. The page must link to `repeated-queries.md` for the explicit
  batch-record route.

### Lock T5-05: Make the guide reachable from each reader route

- The work is not complete if Documenter's how-to navigation, the how-to index,
  the documentation map, the examples page, or the rendering-reference entry
  leaves the gallery task inaccessible.
- Direct red-state repro: `docs/make.jl` and `docs/src/how-to/index.md` have
  no thumbnail-gallery route; `docs/src/examples.md` has only the script
  command; and `docs/src/api/rendering.md` links only placement and missing-
  image how-tos.
- Tasks that close it: 2 and 3.
- Failing verification artifact: the built sidebar and each named source page
  must link to `how-to/thumbnail-gallery.md`; the docs build fails a missing
  page or bad link, and rendered navigation review fails an omitted route.

### Lock T5-06: Retain a real visual verification artifact without committing it

- The work is not complete if the repository no longer has a runnable gallery
  PNG check, or if a generated PNG becomes a tracked documentation source
  asset.
- Direct red-state repro: a docs-only command list can pass a build without
  establishing that the gallery renderer still writes an image file.
- Tasks that close it: 3.
- Failing verification artifact: running
  `julia --project=examples examples/src/thumbnail_gallery.jl /tmp/thumbnail_gallery.png`
  must create a file that `file /tmp/thumbnail_gallery.png` identifies as PNG
  image data. `git status --short` and `git diff --name-only` fail the task if
  the run adds a tracked PNG or changes an unapproved surface.

### Lock T5-07: Preserve the documentation-only authorization boundary

- The work is not complete if the gallery API, PhyloPic request behavior,
  DataCaches behavior, package manifests, CI, or generated image tracking is
  changed to make the documentation example convenient.
- Direct red-state repro: modifying `src/_thumbnail_grid.jl`,
  `src/_node_thumbnail_grid.jl`, or package configuration would make the guide
  pass by changing product behavior rather than documenting it.
- Tasks that close it: 1, 2, and 3.
- Failing verification artifact: the final diff inspection must show changes
  only in Task 1 and Task 2 documentation files plus this workflow tasking
  file; it fails any changed path under `src/`, `test/`, `.github/`,
  `Project.toml`, `docs/Project.toml`, `examples/Project.toml`, or a generated
  PNG path.

### Lock T5-08: Preserve reader-facing style and vocabulary

- The work is not complete if the new user-facing page uses internal-first
  overlay language, title case headings, developer-centered prose, or presents
  the API reference as the teaching surface.
- Direct red-state repro: the previous documentation trajectory used terms
  such as "generic anchored-overlay substrate" and "preloaded image matrix"
  before the reader had a visible plotting task.
- Tasks that close it: 1, 2, and 3.
- Failing verification artifact: rendered-page review and the targeted source
  audit fail internal-first opening prose, proscribed offline-first terms, a
  non-sentence-case heading, or an exhaustive keyword catalog copied into the
  how-to.

## Forbidden passing implementation table

| Lock item | Required behavior | Current code state | Resolved implementation instruction | Forbidden passing implementation | Failing verification artifact |
| --- | --- | --- | --- | --- | --- |
| T5-01 | A reader can follow a labelled gallery recipe from a task page. | `docs/src/examples.md` contains only the `thumbnail_gallery.jl` command; `docs/src/how-to/thumbnail-gallery.md` does not exist. | Create `docs/src/how-to/thumbnail-gallery.md` with the exact task-oriented title and a UUID-first gallery recipe, then add the route in Task 2. | Add only another command bullet to `docs/src/examples.md`, leaving readers without a gallery page. | `docs/build/how-to/thumbnail-gallery/index.html` exists after the docs build and rendered review finds the title, action sequence, and expected gallery result. |
| T5-02 | The first recipe starts from `node_uuids` and supplied labels. | `examples/src/thumbnail_gallery.jl` creates synthetic `cell_images` and calls the prebuilt-cell overload. | Put the UUID vector factory recipe first in `docs/src/how-to/thumbnail-gallery.md`; describe prebuilt cells only as a secondary reference route. | Embed or adapt the synthetic glyph script as the new how-to's opening recipe. | Targeted page audit finds `node_uuids` in the first executable block and finds no `glyph`, `cell_images`, `offline_silhouette`, or preloaded-image framing before the secondary note. |
| T5-03 | The guide accurately shows explicit labels, `image_filter = :primary`, `image_layout = :blocks`, and `ncols`, then routes taxon-name and predecoded-image cases without inventing input overloads. | `src/_node_thumbnail_grid.jl` exposes UUID, label, table, and factory overloads; `src/_thumbnail_grid.jl` defines the group layouts; no guide applies them. | Use the vector factory in `docs/src/how-to/thumbnail-gallery.md`, give the exact group-layout meanings, link taxon names to `PaleobiologyDB.PhyloPicPBDB.phylopic_thumbnail_grid!`, and link decoded images to reference rather than making a second recipe. | State that PhyloPicMakie accepts taxon names or `PhyloPicImage` vectors directly, or describe `:blocks` as a flat grid. | Compare the rendered page with the public docstrings in `src/_node_thumbnail_grid.jl` and layout logic in `src/_thumbnail_grid.jl`; those sources contradict the forbidden statements. |
| T5-04 | The guide links readers needing repeated record queries to the batch APIs and does not assign their cache to direct gallery resolution. | `_build_node_grid_cells` uses `primary_image`, `clade_images`, or `node_images`; `_bulk.jl` alone defines the two cached batch record APIs. | Add one concise cache-boundary paragraph to `docs/src/how-to/thumbnail-gallery.md` and link `repeated-queries.md`; name the two batch functions and state that the direct gallery path does not call them. | Claim that repeating `phylopic_thumbnail_grid` automatically invokes `batch_primary_images` or `batch_images`. | Review the page beside `src/_node_thumbnail_grid.jl`, `src/_image_cache.jl`, and `src/PhyloPicDB/_bulk.jl`; a direct-gallery batch-cache claim fails that source comparison. |
| T5-05 | Reader navigation exposes the same gallery guide from the sidebar, map, how-to index, examples page, and rendering reference. | `docs/make.jl`, `docs/src/how-to/index.md`, `docs/src/index.md`, and `docs/src/api/rendering.md` contain no gallery-guide link. | In Task 2, add the single `Build a thumbnail gallery` route to `docs/make.jl` and exact relative links from all four reader surfaces. | Create the page but omit it from Documenter navigation or leave the API page pointing only to placement and missing-image guides. | The docs build and rendered sidebar show the route; source link inspection finds the exact relative page link in each named surface. |
| T5-06 | The gallery renderer still produces a PNG, and generated PNGs remain build products. | The existing deterministic script produces a valid `/tmp/thumbnail_gallery-t5-revalidation.png`, but no T5 documentation verification command records that gate. | Do not change the script. Run it to `/tmp/thumbnail_gallery.png`, inspect the file type, and inspect the final diff and git status. | Skip the image render because the docs build passes, or add its PNG under `docs/src/`. | The command creates a PNG identified by `file`; status and diff inspection expose a generated or source-tracked PNG. |
| T5-07 | The documentation patch preserves existing public behavior. | Gallery behavior is defined in `src/_thumbnail_grid.jl` and `src/_node_thumbnail_grid.jl`; no change is authorized. | Limit edits to the exact documentation files listed in Tasks 1 and 2. | Add a taxon-name or image-record overload to the gallery API to make the prose simpler. | Final changed-path inspection fails any change under `src/`, `test/`, `.github/`, manifests, or generated outputs. |
| T5-08 | The guide is clear, sentence case, task-focused, and links to reference rather than copying it. | No gallery page exists, and historical docs have used internal-first language. | Use the opening and scoped links specified in Task 1; retain reference catalogs in `docs/src/api/rendering.md` and `docs/src/api/phylopic_db.md`. | Fill the guide with parameter documentation or begin with internal rendering mechanics. | Rendered-page review and targeted content audit expose forbidden opening language, non-sentence-case headings, or a copied keyword catalog. |

## Handoff packet

- **Active authorities**: The parent PRD and tranche plan; completed R1 and
  Tranche 4 tasking; every governance file listed above; Diataxis, Documenter,
  and DataCaches primary sources.
- **Parent documents**: `.workflow-docs/202608140015_diataxis-docs-rewrite/01_prd.md`
  and `.workflow-docs/202608140015_diataxis-docs-rewrite/02_tranches.md`.
- **Settled decisions and non-negotiables**: UUIDs are the normal gallery
  input; explicit `node_labels` avoids extra name lookups; taxon names route
  to PaleobiologyDB; decoded matrices are a secondary reference path; direct
  gallery resolution is not the cached batch-record API; the current script is
  a deterministic renderer check; generated PNGs are not source assets.
- **Authorization boundary**: Modify only Task 1 and Task 2 documentation
  files. Do not change package source, tests, configuration, CI, dependencies,
  manifests, public API, request behavior, cache behavior, or the existing
  gallery script.
- **Current-state diagnosis**: There is no thumbnail-gallery how-to or
  navigation route. The only reader-facing gallery material is a command list;
  the executable script uses synthetic matrices, which cannot become the
  normal learning path.
- **Primary-goal lock and direct red-state repros**: Locks T5-01 through
  T5-08 above. Start by reading `docs/src/examples.md`,
  `examples/src/thumbnail_gallery.jl`, `src/_thumbnail_grid.jl`, and
  `src/_node_thumbnail_grid.jl`.
- **Responsible entities and consumers**: `docs/make.jl` controls the built
  Documenter sidebar that readers consume. `docs/src/how-to/thumbnail-gallery.md`
  provides the task recipe that readers consume. `src/_node_thumbnail_grid.jl`
  defines the UUID public entry points that the recipe calls; no Markdown page
  may present a different direct-input contract. `src/PhyloPicDB/_bulk.jl`
  defines the cached batch-record functions; direct gallery prose must not
  reassign that behavior. The named rendered page, source comparison, and PNG
  command fail each duplicated or bypassed responsibility.
- **Exact scope**: `docs/src/how-to/thumbnail-gallery.md`; `docs/make.jl`;
  `docs/src/how-to/index.md`; `docs/src/index.md`; `docs/src/examples.md`; and
  `docs/src/api/rendering.md`.
- **Exact out-of-scope surfaces**: all `src/`; all `test/`; all project files;
  all workflow and CI configuration; `examples/src/thumbnail_gallery.jl`; and
  every generated PNG path.
- **Green-state gates**: successful docs build; built gallery page and sidebar
  review; the deterministic gallery PNG plus file-type check; targeted content
  audit; final changed-path inspection.
- **Stop conditions**: Stop and request project-owner direction if a required
  reader story needs a new public gallery overload, a changed PhyloPic request,
  a changed DataCaches rule, a network-dependent docs image represented as
  deterministic, external PhyloPic semantics not established by local source,
  or a governance conflict.

## Required revalidation before implementation

- Read the parent PRD and tranche plan in full.
- Read the R1 and Tranche 4 tasking files in full, including their settled
  cache and network-example boundaries.
- Read every governance document named above in full.
- Read every local source and documentation surface listed above in full.
- Re-read the Diataxis, Documenter, and DataCaches primary sources above.
- Re-run the direct red-state repros and confirm that no current worktree
  change has already created a gallery guide or modified the documented public
  surface.
- Stop before editing if the tranche diagnosis conflicts with the current
  source, public docstrings, or authorization boundary.

## Tranche execution rule

This is a documentation cleanup and addition tranche. `docs/src/how-to/thumbnail-gallery.md`
must become the only task-page responsibility for teaching the UUID-first
thumbnail-gallery workflow. `docs/src/examples.md` may continue to point to
the deterministic script as a runnable repository artifact, but it must not
become a competing second how-to or describe synthetic matrices as normal user
input. The API reference retains exhaustive signatures and keywords. The
documentation must adapt to the existing public API; no API change is
authorized to satisfy prose.

## Non-negotiable execution rules

- Do not teach a local image matrix, generated matrix, `glyph`, `cell_images`,
  or docs-private image helper as the first gallery input.
- Do not claim that PhyloPicMakie accepts taxon names or `PhyloPicImage` records
  directly in a gallery call.
- Do not claim that the UUID gallery method calls cached batch-record APIs.
- Do not turn the primary live UUID recipe into a network-sensitive Documenter
  image artifact.
- Do not copy the full gallery keyword catalog into the how-to.
- Do not change the deterministic example script merely to make it resemble
  the normal reader path.
- Do not add a PNG below `docs/src/`, the examples directory, or any tracked
  documentation surface.
- Do not solve guide discoverability with source-text policing alone. The
  built navigation and rendered page must expose a usable reader path.

## Concrete anti-patterns or removal targets

- The command-only gallery treatment in `docs/src/examples.md` must no longer
  be the sole gallery guidance.
- The missing "Build a thumbnail gallery" entry in `docs/make.jl` and
  `docs/src/how-to/index.md` must no longer leave the route absent.
- The missing gallery link in `docs/src/index.md` and `docs/src/api/rendering.md`
  must no longer force readers to infer the route.
- The local `cell_images` recipe in `examples/src/thumbnail_gallery.jl` must
  not be copied into the how-to's first executable block or recast as the
  public UUID workflow.
- A `DataCaches.autocache` claim must not move from the named batch functions
  in `src/PhyloPicDB/_bulk.jl` to the direct gallery entry points in
  `src/_node_thumbnail_grid.jl`.

## Failure-oriented verification

- Build documentation with `julia --project=docs docs/make.jl`. Confirm the
  build emits `docs/build/how-to/thumbnail-gallery/index.html` and a sidebar
  link headed "Build a thumbnail gallery".
- Read the rendered gallery page. Its opening must name a reader who wants to
  compare PhyloPic silhouettes in a labelled gallery. Its first executable
  recipe must use `node_uuids`, `node_labels`, `image_filter = :primary`,
  `image_layout = :blocks`, and `ncols`; it must state the expected labelled
  gallery result.
- Audit the guide before its secondary reference note. It must not contain
  `offline_silhouette`, `preloaded image matrix`, `load an image matrix`,
  `glyph`, or `cell_images`, and it must not call a batch API from the direct
  gallery recipe.
- Compare cache prose with `src/_node_thumbnail_grid.jl`,
  `src/_image_cache.jl`, and `src/PhyloPicDB/_bulk.jl`. It must name the two
  cached batch functions and separate them from direct gallery resolution.
- Confirm navigation links from `docs/make.jl`, `docs/src/index.md`,
  `docs/src/how-to/index.md`, `docs/src/examples.md`, and
  `docs/src/api/rendering.md` resolve to the new page.
- Run `julia --project=examples examples/src/thumbnail_gallery.jl
  /tmp/thumbnail_gallery.png`; run `file /tmp/thumbnail_gallery.png`; confirm
  the output identifies as PNG image data. This proves the visual renderer
  produces a real artifact without asserting that synthetic matrices are the
  normal reader input.
- Inspect `git status --short` and the final changed-path list. No PNG, source,
  test, CI, dependency, manifest, or configuration change may survive.

## Tasks

### 1. Write the UUID-first thumbnail gallery guide

**Type**: WRITE
**Output**: `docs/src/how-to/thumbnail-gallery.md` is a goal-oriented how-to
page with a normal PhyloPic UUID recipe, a stated expected result, concise
layout and label guidance, an honest cache boundary, and secondary routes.
**Depends on**: none.
**Positive contract**: The page starts with the reader outcome of comparing
PhyloPic silhouettes in a labelled gallery. Its first executable recipe uses
the vector `phylopic_thumbnail_grid` factory with UUID literals
`"8f901db5-84c1-4dc0-93ba-2300eeddf4ab"` and
`"36c04f2f-b7d2-4891-a4a9-138d79592bf2"`, paired with the clearly illustrative
reader-supplied labels `"Example group A"` and `"Example group B"`,
`image_filter = :primary`, `image_layout = :blocks`,
`image_label = [:taxon_name]`, `ncols = 2`, and a title. It states that this
factory returns a figure and gives the reader an expected labelled-gallery
result. It explains that `:blocks` begins each
non-empty UUID group on a new row and wraps it at `ncols`, while `:rows` and
`:flat` serve the distinct alternatives described in the local public
docstrings. It tells readers to pass labels from their own data and routes
taxon-name resolution to `PaleobiologyDB.PhyloPicPBDB.phylopic_thumbnail_grid!`.
It gives one concise cache paragraph naming `PhyloPicDB.batch_primary_images`
and `PhyloPicDB.batch_images`, links to `repeated-queries.md`, and states that
the direct gallery method does not call those batch APIs. It links to
`choose-phylopic-images.md` for selection and quality, and to rendering and
PhyloPicDB reference pages for complete keyword and client facts.
**Negative contract**: The primary recipe must not use decoded matrices,
`glyph`, `cell_images`, `offline_silhouette`, a docs-private helper, taxon
names, or `PhyloPicImage` records as direct input. The page must not claim that
the direct gallery API has DataCaches-backed batch-query behavior, must not
present `examples/src/thumbnail_gallery.jl` as normal user input, and must not
copy a reference keyword catalog or explain internal renderer mechanics.
**Files**: `docs/src/how-to/thumbnail-gallery.md` only.
**Out of scope**: `docs/make.jl`; every existing documentation page; all
`src/`, `test/`, `examples/`, project, CI, manifest, API, network, and cache
surfaces; generated images.
**Verification**: Run `julia --project=docs docs/make.jl` to preserve the
already configured documentation build. Audit the new source page before its
secondary decoded-image note: its first executable block must contain
`node_uuids`, `node_labels`, `image_filter = :primary`,
`image_layout = :blocks`, `image_label = [:taxon_name]`, and `ncols = 2`, and
must contain none of `glyph`, `cell_images`, `offline_silhouette`, or
`preloaded image matrix`. Compare every API, layout, and cache sentence with
`src/_node_thumbnail_grid.jl`, `src/_thumbnail_grid.jl`,
`src/_image_cache.jl`, and `src/PhyloPicDB/_bulk.jl`. The audit fails the
forbidden primary recipe or a direct-gallery batch-cache claim. Task 2 exposes
this page to the Documenter build and Task 3 performs rendered-page review.

Create the page with the project-standard `@meta` module declaration and the
sentence-case heading "Build a thumbnail gallery". Use a non-evaluated
`julia` block for the first live UUID recipe because the API needs PhyloPic
requests and cannot promise a deterministic Documenter image when a record
lookup fails. The two labels are illustrative display labels supplied by the
reader's own data; they are not asserted PhyloPic taxonomic names. Describe
saving the returned figure as the reader's next action, but do not introduce
an `@example` output image. Keep the page practical: add only the action
sequence, expected result, group-layout choice, label choice, selection and
cache routes, and reference links. State explicitly that the prebuilt-cell
overload is a secondary reference route for existing decoded images, then link
to reference without another recipe.

### 2. Add the gallery route and reader-facing cross-links

**Type**: WRITE
**Output**: The built Documenter sidebar, documentation map, how-to index,
examples page, and rendering reference all link to the new thumbnail-gallery
guide with one consistent reader-facing title.
**Depends on**: 1.
**Positive contract**: `docs/make.jl` adds exactly one how-to sidebar item
headed "Build a thumbnail gallery" that targets
`how-to/thumbnail-gallery.md`. `docs/src/how-to/index.md` adds the same guide
to its available-guide list. `docs/src/index.md` links the gallery phrase in
the documentation map or how-to route to the exact page. `docs/src/examples.md`
links the gallery script description to the guide and accurately identifies the
script as a deterministic local rendering example rather than a normal
PhyloPic-input lesson. `docs/src/api/rendering.md` adds the gallery guide to
its short list of task-oriented examples.
**Negative contract**: Do not create a competing gallery outline, repeat the
entire guide in `docs/src/examples.md`, turn the API reference into a tutorial,
claim that local matrices are the usual gallery input, or change an existing
navigation role. Do not modify the gallery script, public docstrings, API
surface, or configuration.
**Files**: `docs/make.jl`, `docs/src/how-to/index.md`, `docs/src/index.md`,
`docs/src/examples.md`, and `docs/src/api/rendering.md` only.
**Out of scope**: `docs/src/how-to/thumbnail-gallery.md`; every other docs
page; all `src/`, `test/`, `examples/`, project, CI, manifest, API, network,
and cache surfaces; generated images.
**Verification**: Run `julia --project=docs docs/make.jl`. Confirm that
`docs/build/how-to/thumbnail-gallery/index.html` exists, the built sidebar
contains the exact title, and each of the five named Markdown or navigation
surfaces resolves to the page. The inspection fails an unlinked page, a
command-only replacement, or an example-page statement that makes synthetic
matrices the normal reader path.

Follow the `pages` nesting and relative-link patterns already used in
`docs/make.jl`, `docs/src/how-to/index.md`, and `docs/src/api/rendering.md`.
Keep the navigation entry beside the existing gallery-adjacent how-tos after
the table-columns route. Preserve the examples page's setup and command
instructions. Replace only the thumbnail-script bullet and its immediate
context needed to point readers to the new guide; name its deterministic
rendering role without teaching its local matrices. Retain the rendering
reference's concise task-link introduction and add the gallery link there;
do not alter its `@autodocs` block.

### 3. Verify the rendered guide and PNG artifact

**Type**: TEST
**Output**: A documented verification record that the docs build exposes the
new page and the existing gallery example creates a valid temporary PNG with
no unauthorized repository changes.
**Depends on**: 1 and 2.
**Positive contract**: The docs build succeeds and includes the gallery page
and sidebar route. The rendered page has a UUID-first task recipe and a usable
expected result. The deterministic gallery script saves `/tmp/thumbnail_gallery.png`,
and `file` identifies it as PNG image data. The final change inspection shows
only the files allowed by Tasks 1 and 2 plus this tasking file.
**Negative contract**: A passing docs build alone is not enough. Do not accept
a command-only guide, a page whose first recipe uses synthetic matrices, a
direct-gallery batch-cache claim, an omitted sidebar link, a non-PNG output,
or an unauthorized source/configuration/generated-PNG change.
**Files**: none. This task creates only temporary `/tmp/thumbnail_gallery.png`
and Documenter build products below the ignored `docs/build/` directory.
**Out of scope**: every tracked project file, including the gallery script,
documentation content, source, tests, configuration, CI, dependencies,
manifests, and generated source assets.
**Verification**: Run `julia --project=docs docs/make.jl`; inspect
`docs/build/how-to/thumbnail-gallery/index.html` and the rendered sidebar; run
`julia --project=examples examples/src/thumbnail_gallery.jl /tmp/thumbnail_gallery.png`;
run `file /tmp/thumbnail_gallery.png`; audit the new page against the named
local API and cache sources; then inspect `git status --short` and the changed
path list. Each inspection must fail the corresponding forbidden result named
in Locks T5-01 through T5-08.

Do not modify tracked files during this task. Confirm that the first executable
recipe in the rendered guide names UUIDs and explicit labels before the
secondary decoded-image route. Confirm that the cache paragraph says the batch
functions cache repeated image-record queries, not that the direct gallery
factory calls them. Confirm that the documented PNG check exercises the
existing deterministic renderer without changing its role in the user-facing
guide. Stop and report any docs-build, rendering, public-surface, or changed-
path failure rather than repairing a failure outside this tranche's scope.
