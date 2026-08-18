---
date-created: 2026-08-15T14:11:40-07:00
workflow-instrument: Tranche plan
workflow-status: Approved
workflow-agent-thread-id: codex/01a0073b-2d22-7863-9aaf-210666e76733
workflow-location: /home/jeetsukumaran/site/storage/local/computing/research/20260414_PhyloPicMakie.jl/PhyloPicMakie.jl
workflow-production-id: diataxis-docs-primer
workflow-prd: .workflow-docs/202608140015_diataxis-docs-rewrite/01_prd.md
---

# Tranche plan: Diataxis documentation rewrite

## Governance confirmation

The active workflow skill is `devflow-feature-02--prd-to-tranches`. The parent PRD is `.workflow-docs/202608140015_diataxis-docs-rewrite/01_prd.md`, and its status is `Approved`.

Governance files found and used:

- Repo-local `STYLE-workflow-docs.md`.
- Repo-local `STYLE-makie.md`.
- Repo-local `STYLE-git.md`.
- Repo-local `STYLE-writing.md`.
- Repo-local `STYLE-julia.md`.
- Repo-local `STYLE-docs.md`.
- Repo-local `STYLE-vocabulary.md`.
- Repo-local `STYLE-architecture.md`.
- Repo-local `STYLE-agent-language.md`.
- Repo-local `STYLE-agent-handoffs.md`.
- Repo-local `STYLE-workflow-vocabulary.md`.
- Repo-local `STYLE-verification.md`.
- Repo-local `STYLE-upstream-contracts.md`.
- Bundled baseline files for workflow docs, Makie, git, writing, Julia, docs, architecture, verification, and upstream contracts.

Expected governance files not found:

- Repo-local `CONTRIBUTING*.md`.
- Repo-local `STYLE-python.md`.
- Repo-local `STYLE-domain-vocabulary.md`.
- Bundled `CONTRIBUTING.md`.
- Bundled `STYLE-python.md`.

Active authorities for this run:

- User-supplied trancheing skill: `devflow-feature-02--prd-to-tranches`.
- Parent PRD: `.workflow-docs/202608140015_diataxis-docs-rewrite/01_prd.md`.
- Repo-local governance files listed above.
- Upstream primary sources listed below.

## Project-wide required reading

Every downstream tranche tasking file must require line-by-line reading of the active authorities before implementation, review, or audit. `STYLE-agent-language.md` is mandatory whenever the tranche uses ownership, contract, boundary, layer, invariant, compatibility, verification, source, or responsibility language.

Every implementation agent must read these local files before changing docs:

- `.workflow-docs/202608140015_diataxis-docs-rewrite/01_prd.md`.
- `.workflow-docs/202608140015_diataxis-docs-rewrite/02_tranches.md`.
- `STYLE-workflow-docs.md`.
- `STYLE-makie.md`.
- `STYLE-git.md`.
- `STYLE-writing.md`.
- `STYLE-julia.md`.
- `STYLE-docs.md`.
- `STYLE-vocabulary.md`.
- `STYLE-architecture.md`.
- `STYLE-agent-language.md`.
- `STYLE-agent-handoffs.md`.
- `STYLE-workflow-vocabulary.md`.
- `STYLE-verification.md`.
- `STYLE-upstream-contracts.md`.

Every implementation agent must also re-read the local source surfaces named in its tranche handoff packet before editing them.

Every implementation agent must apply `STYLE-agent-language.md` to public docs,
workflow docs, tasking files, implementation reports, and handoff packets. A
responsibility statement is incomplete unless it names the exact file,
function, module, public surface, or external contract; the behavior; the
consumer; the duplicate or bypass path that must not keep the behavior; and the
verification artifact that fails if the statement stays vague.

## Upstream primary sources

These upstream primary sources were reviewed for this tranche plan and must be passed forward where relevant:

- Diataxis home: https://diataxis.fr/.
- Diataxis start page: https://diataxis.fr/start-here/.
- Diataxis applying guide: https://diataxis.fr/application/.
- Diataxis tutorials: https://diataxis.fr/tutorials/.
- Diataxis how-to guides: https://diataxis.fr/how-to-guides/.
- Diataxis reference: https://diataxis.fr/reference/.
- Diataxis explanation: https://diataxis.fr/explanation/.
- Documenter public API for `makedocs`, `pages`, `doctest`, `checkdocs`, and build behavior: https://documenter.juliadocs.org/stable/lib/public/.
- Documenter guide for documentation structure and sidebar behavior: https://documenter.juliadocs.org/stable/man/guide/.
- Documenter syntax for `@autodocs`, `@docs`, `@example`, `@repl`, `@setup`, `@meta`, `@index`, and `@contents`: https://documenter.juliadocs.org/stable/man/syntax/.
- DataCaches upstream repository and README for file-backed caching, explicit `DataCache`, and automatic caching concepts: https://github.com/JuliaData/DataCaches.jl.
- Local `Project.toml`, which already declares `DataCaches = "0.4"` and the JuliaData source URL.
- Local `src/PhyloPicDB/PhyloPicDB.jl`, which states that PhyloPicDB includes deduplication and DataCaches-based caching.
- Local `src/PhyloPicDB/_bulk.jl`, which uses `DataCaches.autocache` in `PhyloPicDB.batch_primary_images` and `PhyloPicDB.batch_images`.
- Local `src/_glyph_resolution.jl`, which currently deduplicates direct UUID image resolution within one call but is not itself the DataCaches-backed batch API.

Working note: the project owner resolved on 2026-08-16 that live PhyloPic-backed examples are not optional side material. The normal reader path starts from PhyloPic node UUIDs, taxon-derived identifiers, or package-supported PhyloPic lookup, then places silhouettes. DataCaches usage may be hidden in first-contact documentation, but explicit DataCaches usage belongs in later how-to, explanation, or reference material.

Working note: the PRD still does not name an official PhyloPic API reference for behavior beyond the local implementation. Downstream work may use `src/PhyloPicDB/` implementation files and docstrings as the project-owned evidence for PhyloPicMakie behavior. If it needs external PhyloPic API semantics not defined locally, the implementer must stop and ask for the upstream primary source or project-owner ratification.

No `codebases-and-documentation` directory was found near the project root during tranche planning. Supplying upstream checkouts there could improve rigor for future Documenter, Makie, GraphMakie, or PhyloPic API contract work.

## Current-state diagnosis

The current documentation matches the PRD red state:

- `README.md` opens with internal implementation mechanics instead of a reader-visible result.
- `docs/src/index.md` mentions a generic anchored-overlay foundation and an owner layer near first contact.
- `docs/src/api/rendering.md` explains the public rendering API through internal overlay mechanics before helping the reference reader find task-oriented help.
- `docs/make.jl` defines only `"Home"`, `"Examples"`, and `"API Reference"` in `pages`.
- `docs/src/examples.md` lists commands and notes, but it does not provide a primer, tutorial, or goal-oriented how-to path.
- The existing example scripts in `examples/src/` provide runnable material for point overlays, range overlays, thumbnail galleries, and GraphMakie node-position snapshots.
- Completed tranches 1 through 3 improved the documentation map and added first-wave teaching material, but they introduced a wrong offline-first trajectory. The completed tasking files and current worktree refer to `docs/src/_offline_silhouette.jl`, `offline_silhouette()`, preloaded image matrices, and "offline-capable" first learning as if that were the reader's normal path. That is now a red state under the revised PRD.
- The normal reader path must start from taxon names, PBDB-derived identifiers, PhyloPic node UUIDs, coordinates, ranges, tables, or galleries. It must then show how the package fetches, selects, and places PhyloPic silhouettes. Caching for repeated queries is handled through documented DataCaches-backed APIs where that behavior exists.

The documentation responsibilities under repair are split deliberately:

- `docs/make.jl` defines rendered Documenter navigation through the `pages`
  keyword. Documentation pages consume that navigation in the rendered sidebar.
  No Markdown page may be the only navigation map. `julia --project=docs
  docs/make.jl` plus rendered-sidebar review fails if the sidebar omits the
  top-down Diataxis routes.
- `docs/src/index.md` presents the reader-facing outline and table of contents.
  README and route pages may link to it, but they must not duplicate a separate
  conflicting outline. Source-text review and rendered-home review fail if the
  outline is missing or inconsistent with `docs/make.jl`.
- `README.md` provides repository first contact. `docs/src/index.md` provides
  documentation first contact. Neither file may lead with internal placement
  mechanics. The forbidden-phrase audit fails if those files open with
  implementation-first language.
- Markdown files under `docs/src/primer.md`, `docs/src/tutorial.md`, and
  `docs/src/how-to/` provide Diataxis learning and task pages. They consume API
  facts from source docstrings and reference pages. They must not copy full
  parameter catalogs from `docs/src/api/rendering.md` or
  `docs/src/api/phylopic_db.md`. Rendered-page review and source-text audit
  fail duplicated reference catalogs.
- Source docstrings under `src/` provide API facts for reference pages. Tutorial
  and how-to pages must link to those reference pages for exhaustive facts
  instead of re-stating every keyword. Documenter build and rendered-reference
  review fail if API facts cannot be found in reference.
- `src/PhyloPicDB/_bulk.jl` is the local file that justifies
  DataCaches-backed batch-query prose because `PhyloPicDB.batch_primary_images`
  and `PhyloPicDB.batch_images` call `DataCaches.autocache`. Docs must not use
  vague caching prose or transfer that claim to direct UUID rendering.
  DataCaches source-text audit fails any broader claim.
- `src/_glyph_resolution.jl` resolves direct UUID images and deduplicates UUIDs
  within one call. It does not justify DataCaches-backed cross-call caching.
  DataCaches source-text audit fails if docs use direct `augment_phylopic!`
  UUID rendering as the DataCaches-backed example without a separate approved
  source change.
- `examples/src/explicit_overlays.jl`, `examples/src/thumbnail_gallery.jl`, and
  `examples/src/graph_anchors.jl` provide executable example behavior. Docs
  must not claim behavior those scripts or public APIs do not demonstrate.
  Example-script runs to temporary PNG files fail unsupported claims.
- `.github/workflows/CI.yml` defines the existing docs and doctest gate.
  Workflow docs may require stronger verification, but later work must not
  weaken that CI gate. CI diff review fails if the docs/deploy or doctest gate
  is removed without explicit project-owner approval.

## Primary-goal lock assignments

- Lock item 1, user-centered first contact: closed by Tranche 1 and Tranche 2 only after Tranche R1 remediation repairs the first-learning path.
- Lock item 2, Diataxis information architecture: closed by Tranche 1.
- Lock item 3, example-rich primer and tutorial: originally assigned to Tranche 2, now requires Tranche R1 remediation because Tranche 2 used the wrong offline-first starting point.
- Lock item 4, goal-oriented how-to guides: closed by Tranches 3, 4, 5, 6, and 7, with Tranche R1 repairing the already completed coordinate/table guidance where it inherited offline-first framing.
- Lock item 5, reference stays reference: closed by Tranche 8.
- Lock item 6, runnable examples remain real and use the right starting point: closed by Tranche 9, with Tranche R1 repairing completed first-wave examples.
- Lock item 7, no offline-first documentation trajectory: closed by Tranche R1 and preserved by every later tranche.
- Lock item 8, documentation-only authorization boundary: preserved by every tranche.
- Lock item 9, vocabulary and style compliance: preserved by every tranche and audited in Tranche 10.

## Granularity watchlist

- Tranche 2 is now historically completed but misframed. Its offline-first primer and tutorial are not acceptable as final completed work.
- Tranche 3 is now historically completed but must be audited because its point, range, and table how-tos may inherit the same offline-first premise.
- Tranche R1 is a special remedial tranche inserted after completed Tranches 1 through 3 and before any further page-production tranche is executed or approved.
- Tranche 4 covers placement, image choice, and missing-image policy, but its existing proposed tasking is blocked until Tranche R1 rewrites the first-learning model.
- Tranche 7 is no longer a decision point for whether PhyloPic-backed examples belong in the main docs. The project owner answered yes: PhyloPic-backed examples are the normal path. It may still require project-owner input only if implementation needs public API changes beyond the approved documentation boundary.

## Tranche 1: Establish the documentation map

**Type**: AFK
**Blocked by**: None -- can start immediately

### Governance and required reading

- Read the project-wide required reading listed above line by line.
- Read Diataxis home, start, applying, tutorial, how-to, reference, and explanation pages.
- Read Documenter public API and guide sections that define `makedocs`, `pages`, and sidebar behavior.
- Read current `docs/make.jl`, `docs/src/index.md`, `README.md`, and `docs/src/examples.md`.

### Primary-goal lock

- Closes lock item 1 for first-contact entrypoints.
- Closes lock item 2 for Diataxis information architecture.
- Preserves lock item 7 by refusing to make local image matrices the reader's normal starting point.
- Preserves lock items 8 and 9 through documentation-only scope, vocabulary, and style compliance.
- The work is not complete if `README.md`, `docs/src/index.md`, or rendered docs navigation still lead with internal overlay mechanics.
- The work is not complete if `docs/make.jl` still exposes only Home, Examples, and API Reference.

### What to build

This is a foundational tranche. It establishes the shared documentation map before page-level drafting continues.

Update `docs/make.jl` so Documenter `pages` names the top-down Diataxis structure from the PRD: start page, primer/tutorial, how-to guides, explanation or concepts, API reference, and examples. Update `docs/src/index.md` to present the reader-facing outline and table of contents. Rewrite the opening of `README.md` so repository first contact states what a user can make with PhyloPicMakie and points to the docs without internal overlay-mechanics prose.

Create any minimal route pages required by the new navigation, but do not claim complete tutorial or how-to content that later tranches have not built.

### Handoff packet

- **Active authorities**: Parent PRD; this tranche plan; repo-local `STYLE-workflow-docs.md`, `STYLE-docs.md`, `STYLE-writing.md`, `STYLE-vocabulary.md`, `STYLE-architecture.md`, `STYLE-verification.md`, `STYLE-upstream-contracts.md`; repo-local `STYLE-agent-language.md`, `STYLE-agent-handoffs.md`, and `STYLE-workflow-vocabulary.md`.
- **Parent documents**: `.workflow-docs/202608140015_diataxis-docs-rewrite/01_prd.md`; this `02_tranches.md`.
- **Settled decisions and non-negotiables**: The docs must follow Diataxis. The outline and rendered navigation must be top-down before broad prose rewrites. The main learning path starts from PhyloPic identifiers, taxon-derived identifiers, or package-supported PhyloPic lookup, not from local image matrices. Generated PNGs are build products, not committed source assets by default. Public API and implementation behavior must not change.
- **Authorization boundary**: In scope: `README.md`, `docs/make.jl`, `docs/src/index.md`, and route pages needed for navigation. Out of scope: source implementation, exported names, plotting behavior, network behavior, and generated PNG assets.
- **Current-state diagnosis**: `docs/make.jl` has only Home, Examples, and API Reference. `README.md` and `docs/src/index.md` foreground internal overlay mechanics.
- **Primary-goal lock**: Lock items 1, 2, 7, 8, and 9.
- **Direct red-state repros**: Read `README.md`, `docs/src/index.md`, and `docs/make.jl`; search for `generic anchored-overlay`, `owner layer`, `data-anchor`, `projected pixel-anchor`, and the Home/Examples/API-only navigation shape.
- **Named responsible entities and required behavior**: `docs/make.jl` must define the rendered sidebar through the Documenter `pages` argument; documentation readers consume that sidebar in the built docs, no Markdown-only list may replace it, and `julia --project=docs docs/make.jl` plus rendered-sidebar review fails if the Diataxis routes are absent. `docs/src/index.md` must present the reader-facing outline; README and route pages may link to it but must not define a conflicting outline, and source-text plus rendered-home review fails if the outline is missing or inconsistent with `docs/make.jl`. `README.md` must provide repository first contact; it must not delegate first-contact purpose to API pages, and the forbidden-phrase audit fails if README still opens with internal placement mechanics.
- **Exact files or surfaces in scope**: `README.md`; `docs/make.jl`; `docs/src/index.md`; new route pages under `docs/src/` that are necessary for the planned navigation.
- **Exact files or surfaces out of scope**: `src/`; `test/`; public API behavior; example script behavior; CI behavior except for no edits in this tranche.
- **Required upstream primary sources**: Diataxis home, start, applying, tutorials, how-to guides, reference, and explanation pages; Documenter public API and guide pages for `pages` and sidebar behavior.
- **Green-state gates**: `julia --project=docs docs/make.jl`; source-text audit for forbidden first-contact phrases in `README.md`, `docs/src/index.md`, and new first-contact route pages; rendered navigation review.
- **Stop conditions**: Stop if the navigation design requires public API changes, if the first-contact pages would need to teach from a hidden local image fixture, or if a Documenter sidebar behavior is not verified from primary sources.

### How to verify

- **Manual**: Build docs, open the rendered home page, and confirm the first viewport states the user-visible package purpose and points to primer/tutorial, how-to, reference, explanation, and examples. Open the sidebar and confirm it mirrors the top-down outline.
- **Automated**: Run `julia --project=docs docs/make.jl`. Run a source-text audit for forbidden first-contact phrases in `README.md`, `docs/src/index.md`, and any new first-contact page.

### Acceptance criteria

- [ ] Given a fresh reader opens `README.md`, when they read the opening, then they see what PhyloPicMakie helps them make before any internal implementation language.
- [ ] Given a reader opens rendered docs, when they scan the sidebar and home page, then they see distinct paths for primer/tutorial, how-to guides, reference, explanation or concepts, and examples.
- [ ] Given `docs/make.jl`, when `pages` is inspected, then it no longer has only Home, Examples, and API Reference.
- [ ] Given the documentation-only boundary, when the tranche diff is audited, then no public API or plotting implementation behavior changed.

### User stories addressed

- User story 1: Finished figure near the start.
- User story 15: Docs structure makes page type obvious.
- User story 17: README plain-language pitch and minimal example path.

## Tranche 2: Write the first primer and tutorial requiring remediation

**Type**: AFK
**Blocked by**: Tranche 1

### Remedial status

This tranche was approved and implemented before the 2026-08-16 owner correction. Its original offline-first framing is stale. Tranche R1 must repair the resulting primer and tutorial before they can satisfy the revised PRD.

### Governance and required reading

- Read the project-wide required reading listed above line by line.
- Read Diataxis tutorial guidance and the PRD sections for Primer, Tutorial, Testing decisions, and Primary-goal lock.
- Read `examples/src/explicit_overlays.jl`, `src/_augment_api.jl`, `src/_render_core.jl`, and current `docs/src/api/rendering.md`.
- Read Documenter syntax for `@example`, `@setup`, `@meta`, and image output behavior.

### Primary-goal lock

- Historically aimed to close lock item 3 for example-rich primer and tutorial, but now requires Tranche R1 remediation.
- Helps close lock item 1 by giving first-contact docs a visible learning path.
- Preserves lock item 6 only after Tranche R1 replaces the offline-first starting point with a PhyloPic-backed one.
- Must be remediated for lock item 7, no offline-first documentation trajectory.
- Preserves lock items 8 and 9.
- The work is not complete if a reader must understand the internal overlay implementation to complete the tutorial.
- The work is not complete if the required tutorial starts from a docs-private local image helper instead of PhyloPic identifiers or taxon-derived data.

### What to build

Write the primer and first tutorial pages from the top-down map.

The primer should show a meaningful silhouette-annotated Makie figure quickly and name the main reader-facing ideas: silhouettes, PhyloPic node UUIDs, taxon-derived identifiers, coordinates, ranges, placement, DataCaches-hidden repeated-query behavior, and saved figures. The tutorial should guide a new reader through one successful PhyloPic-backed workflow, using a coherent example based on public package behavior.

The tutorial must not use generated in-memory image matrices or `offline_silhouette()` as the normal teaching path. It must save or render an output artifact during docs or example verification under documented network and cache assumptions.

### Handoff packet

- **Active authorities**: Parent PRD; this tranche plan; repo-local `STYLE-docs.md`, `STYLE-writing.md`, `STYLE-vocabulary.md`, `STYLE-makie.md`, `STYLE-verification.md`, `STYLE-upstream-contracts.md`; repo-local `STYLE-agent-language.md`, `STYLE-agent-handoffs.md`, and `STYLE-workflow-vocabulary.md`.
- **Parent documents**: `.workflow-docs/202608140015_diataxis-docs-rewrite/01_prd.md`; this `02_tranches.md`.
- **Settled decisions and non-negotiables**: Required tutorial path is PhyloPic-backed. Generated PNGs are build products and verification artifacts. DataCaches details may be hidden in initial prose and documented later. Internal overlay mechanics do not belong in first-contact teaching prose.
- **Authorization boundary**: In scope: primer page, tutorial page, links from README and home page, docs examples, and example-script alignment if needed. Out of scope: public API changes and source implementation changes unless the project owner separately approves them.
- **Current-state diagnosis**: `docs/src/examples.md` lists scripts but does not walk a reader through a successful figure-building experience. The implemented Tranche 2 page path then used `docs/src/_offline_silhouette.jl` and `offline_silhouette()` as the first learning substrate, which is now a red state.
- **Primary-goal lock**: Lock items 1, 3, 6, 7, and 8.
- **Direct red-state repros**: Read `docs/src/examples.md`; it lists commands without a lesson-style tutorial, expected output notes, or a complete visible first figure path.
- **Named responsible entities and required behavior**: `docs/src/primer.md` must provide the first conceptual pass consumed by new documentation readers; it must not become a reference page or hidden-fixture lesson, and rendered-page review plus source-text audit fails if it leads with `offline_silhouette()` or a parameter catalog. `docs/src/tutorial.md` must provide the first guided PhyloPic-backed learning path consumed by new readers; it must not use local image matrices as the normal path, and the tutorial example plus offline-first audit fails if it does. `src/PhyloPicDB/_bulk.jl` justifies DataCaches-backed batch-query prose because `PhyloPicDB.batch_primary_images` and `PhyloPicDB.batch_images` call `DataCaches.autocache`; docs must not claim that behavior for direct UUID rendering, and DataCaches prose audit fails if they do. `src/_glyph_resolution.jl` resolves direct UUID images and deduplicates UUIDs within one call; docs may cite that behavior only. `examples/src/explicit_overlays.jl` provides executable evidence for plotted point and range results; tutorial prose must not claim example behavior the script or public API does not demonstrate, and example-script verification fails unsupported claims.
- **Exact files or surfaces in scope**: New primer/tutorial Markdown files under `docs/src/`; `docs/src/index.md`; `docs/make.jl`; `docs/src/examples.md`; `examples/src/explicit_overlays.jl` only if alignment is required.
- **Exact files or surfaces out of scope**: Public API implementation under `src/` except docstrings if a reference fact is wrong; generated PNGs as committed source assets.
- **Required upstream primary sources**: Diataxis tutorials page; Documenter syntax for `@example`, `@setup`, `@meta`, and image output behavior; DataCaches repository and README; local `src/PhyloPicDB/_bulk.jl` and `src/_glyph_resolution.jl`.
- **Green-state gates**: `julia --project=docs docs/make.jl`; revised examples produce PNG outputs under documented network and cache assumptions; source-text audit for forbidden first-contact phrases and offline-first framing.
- **Stop conditions**: Stop if the tutorial cannot be made PhyloPic-backed without changing public API behavior, if a DataCaches claim is not supported by the local source, or if Documenter example execution semantics are uncertain and have not been verified from the Documenter syntax docs.

### How to verify

- **Manual**: Read the rendered primer and tutorial as a new user. Confirm the pages show what to make, what data is needed, the code to run, what output to expect, and where to go next.
- **Automated**: Run the docs build, run the revised documented example to a temporary PNG under documented network and cache assumptions, and check the file type with `file`.

### Acceptance criteria

- [ ] Given a new user reads the primer, when they reach the first example, then they see a concrete silhouette-annotated Makie figure path before implementation details.
- [ ] Given a user follows the tutorial, when they run the documented code or example script under the documented network and cache assumptions, then a PNG output is produced.
- [ ] Given the tutorial source, when it is audited, then it does not teach `offline_silhouette()`, preloaded image matrices, or equivalent local image fixtures as the normal starting point.
- [ ] Given first-contact prose, when searched for forbidden internal phrases, then none appear outside bounded reference or explanation context.

### User stories addressed

- User story 1: Finished figure near the start.
- User story 2: Place silhouettes at coordinates.
- User story 5: Repeated PhyloPic query performance.
- User story 7: Control size, placement, offsets, rotation, and mirroring through concrete examples.
- User story 14: Documentation examples are tested or rendered.
- User story 16: Direct red-state checks for developer babble.

## Tranche 3: Write coordinate, range, and table how-tos

**Type**: AFK
**Blocked by**: Tranche 1

### Remedial status

This tranche was approved and implemented before the 2026-08-16 owner correction. Tranche R1 must audit and repair any completed point, range, or table how-to that starts from `offline_silhouette()`, preloaded image matrices, or equivalent local image fixtures instead of PhyloPic identifiers or taxon-derived data.

### Governance and required reading

- Read the project-wide required reading listed above line by line.
- Read Diataxis how-to guide guidance.
- Read `examples/src/explicit_overlays.jl`, `src/_augment_api.jl`, `src/_coordinates.jl`, and tests that cover coordinate and range behavior.
- Read Documenter syntax for `@example`, `@docs`, and `@ref`.

### Primary-goal lock

- Closes the coordinate, range, and table-data portions of lock item 4.
- Preserves lock item 5 by linking API facts rather than reproducing a full parameter catalog.
- Preserves lock item 6 only after Tranche R1 verifies the examples use the right PhyloPic-backed starting point.
- Must be remediated for lock item 7, no offline-first documentation trajectory.
- Preserves lock items 8 and 9.
- The work is not complete if pages are organized around functions instead of user goals.
- The work is not complete if pages are organized around a local image fixture rather than a user's coordinate, range, table, taxon, or PhyloPic identifier problem.

### What to build

Write goal-oriented how-to pages for placing silhouettes on point coordinates, placing silhouettes on ranges, and using table columns for coordinates, labels, PhyloPic node UUIDs, and taxon-derived identifiers.

The pages should use concrete headings such as "Place silhouettes on points", "Place silhouettes on ranges", and "Use table columns". Each page should give a focused recipe, a short expected-result note, and a link to the relevant API reference facts.

### Handoff packet

- **Active authorities**: Parent PRD; this tranche plan; repo-local `STYLE-docs.md`, `STYLE-writing.md`, `STYLE-vocabulary.md`, `STYLE-makie.md`, `STYLE-verification.md`, `STYLE-upstream-contracts.md`; repo-local `STYLE-agent-language.md`, `STYLE-agent-handoffs.md`, and `STYLE-workflow-vocabulary.md`.
- **Parent documents**: `.workflow-docs/202608140015_diataxis-docs-rewrite/01_prd.md`; this `02_tranches.md`.
- **Settled decisions and non-negotiables**: How-to guides are goal-oriented and practical. They must not become API parameter catalogs. The main examples start from coordinates, ranges, table rows, and PhyloPic identifiers or taxon-derived identifiers. Local image matrices are secondary API material, not the first reader path.
- **Authorization boundary**: In scope: how-to Markdown pages, navigation links, and docs/example snippets. Out of scope: changing `augment_phylopic!`, `augment_phylopic_ranges!`, table extraction behavior, or range-anchor semantics.
- **Current-state diagnosis**: Current docs describe explicit-coordinate and range-anchor overlays without goal pages for points, ranges, or table data.
- **Primary-goal lock**: Lock items 4, 5, 6, 7, and 8.
- **Direct red-state repros**: Search `docs/src/` for goal pages named around points, ranges, and table columns; they do not exist in the original docs. Search the completed how-to pages for `offline_silhouette()`, `docs/src/_offline_silhouette.jl`, "preloaded image matrix", or equivalent offline-first prose; any first-path use is now a red state.
- **Named responsible entities and required behavior**: `docs/src/how-to/points.md` must provide the reader recipe for `augment_phylopic!` with point coordinates and PhyloPic-backed silhouettes; it must not start from a local image matrix, and source-text plus rendered-page review fails if it does. `docs/src/how-to/ranges.md` must provide the reader recipe for `augment_phylopic_ranges!`; it must not duplicate full range API reference content, and rendered-page review fails if it becomes a parameter catalog. `docs/src/how-to/table-columns.md` must provide the reader recipe for table selectors; it must not claim unsupported image-column behavior, and source-text audit against `src/_augment_api.jl` fails if it does. `src/_augment_api.jl` defines signatures, keyword meanings, and errors consumed by reference and how-to pages; Markdown pages must link to reference rather than re-state every signature, and duplicated-catalog audit fails if they do. `src/PhyloPicDB/_bulk.jl` justifies DataCaches-backed batch-query guidance where repeated-query guidance is needed; DataCaches prose audit fails broader claims.
- **Exact files or surfaces in scope**: New how-to Markdown files under `docs/src/`; `docs/make.jl`; `docs/src/index.md`; `docs/src/api/rendering.md` only for cross-links.
- **Exact files or surfaces out of scope**: `src/_augment_api.jl` behavior; `src/_coordinates.jl` behavior; public API names or keyword semantics; generated PNGs as committed assets.
- **Required upstream primary sources**: Diataxis how-to guides page; Documenter syntax for `@example`, `@docs`, and `@ref`; DataCaches repository and README when repeated-query caching is discussed; local `src/PhyloPicDB/_bulk.jl` and `src/_glyph_resolution.jl`.
- **Green-state gates**: `julia --project=docs docs/make.jl`; source-text audit that how-to titles and openings state user projects; source-text audit that completed how-tos do not make local images the first path; run revised example scripts or Documenter examples when cited as executable evidence.
- **Stop conditions**: Stop if a how-to requires a public API behavior that does not exist, or if it repeats reference facts so heavily that the page becomes a parameter catalog.

### How to verify

- **Manual**: Open each rendered how-to page and confirm the page starts from a concrete user goal, gives runnable code, states expected result, and links to reference for details.
- **Automated**: Run the docs build and any revised example script or Documenter example to a temporary PNG when referenced.

### Acceptance criteria

- [ ] Given a user has x and y coordinates plus PhyloPic identifiers or taxon-derived identifiers, when they read the point how-to, then they can fetch or select silhouettes and place them without reading API internals.
- [ ] Given a user has interval data plus PhyloPic identifiers or taxon-derived identifiers, when they read the range how-to, then they can place silhouettes at start, stop, or midpoint.
- [ ] Given a user has a table, when they read the table how-to, then they can map columns to coordinates, labels, and PhyloPic node UUIDs or taxon-derived identifiers.
- [ ] Given a reader needs keyword facts, when the how-to reaches API details, then it links to reference instead of duplicating the full catalog.

### User stories addressed

- User story 2: Place silhouettes at coordinates.
- User story 3: Place silhouettes on ranges.
- User story 4: Map table columns.

## Tranche R1: Remediate the completed offline-first path

**Type**: AFK
**Blocked by**: Tranches 1, 2, and 3 as completed worktree state

### Governance and required reading

- Read the project-wide required reading listed above line by line.
- Read the revised parent PRD, especially the 2026-08-16 owner correction, lock item 7, Testing decisions, Handoff packet, and Further notes.
- Read all approved tasking files for completed Tranches 1 through 3.
- Read the current completed docs in `README.md`, `docs/src/index.md`, `docs/src/primer.md`, `docs/src/tutorial.md`, `docs/src/how-to/index.md`, and completed how-to pages under `docs/src/how-to/`.
- Read `docs/src/_offline_silhouette.jl` as the stale docs-private helper that must not own the first learning path.
- Read `src/_augment_api.jl`, `src/_glyph_resolution.jl`, `src/PhyloPicDB/PhyloPicDB.jl`, and `src/PhyloPicDB/_bulk.jl`.
- Read the DataCaches upstream repository and README for the external caching concepts being cited.

### Primary-goal lock

- Closes lock item 3 where completed primer and tutorial work used the wrong starting point.
- Closes lock item 4 where completed coordinate, range, and table how-tos inherited local-image framing.
- Closes lock item 6 where runnable examples must remain real and use the right starting point.
- Closes lock item 7, no offline-first documentation trajectory.
- Preserves lock items 8 and 9.
- The work is not complete if README, home, primer, tutorial, or first-wave how-to pages teach `offline_silhouette()`, `docs/src/_offline_silhouette.jl`, "preloaded image matrix", or equivalent local-image fixture language as the normal way users begin.
- The work is not complete if DataCaches is mentioned as a vague performance idea without tying explicit claims to `src/PhyloPicDB/_bulk.jl`, the upstream DataCaches docs, or a separately approved implementation change.

### What to build

This is a special remedial tranche. It repairs already completed Tranche 1 through 3 outputs and tasking drift before ordinary Tranche 4 work proceeds.

Rewrite the completed first-contact and first-learning documentation so the top-level reader path starts from a user's data and PhyloPic source: taxon-derived identifiers, PBDB-derived identifiers, PhyloPic node UUIDs, coordinates, ranges, tables, and galleries. Show that PhyloPicMakie fetches or selects silhouettes from PhyloPic and then places them in Makie figures.

Remove or demote the docs-private `offline_silhouette()` helper from public teaching. If any deterministic local image fixture remains for tests or emergency verification, it must be named as a test fixture only and must not appear as the reader's first task. Prefer deleting `docs/src/_offline_silhouette.jl` if the revised docs no longer need it.

Add or revise one later page section that explains explicit DataCaches usage for repeated PhyloPic queries. The page must state the exact current local boundary: `PhyloPicDB.batch_primary_images` and `PhyloPicDB.batch_images` use `DataCaches.autocache`; direct `augment_phylopic!` UUID rendering currently deduplicates UUIDs within one call through `src/_glyph_resolution.jl` but is not itself the DataCaches-backed batch API unless a separately approved source change makes that true.

Update completed tasking files only as archival workflow documents: add correction notes that their offline-first instructions are superseded by this tranche. Do not pretend the historical tasking remains valid for future execution.

### Handoff packet

- **Active authorities**: Parent PRD; this tranche plan; repo-local `STYLE-workflow-docs.md`, `STYLE-docs.md`, `STYLE-writing.md`, `STYLE-vocabulary.md`, `STYLE-architecture.md`, `STYLE-verification.md`, `STYLE-upstream-contracts.md`, `STYLE-makie.md`, and `STYLE-julia.md`; repo-local `STYLE-agent-language.md`, `STYLE-agent-handoffs.md`, and `STYLE-workflow-vocabulary.md`.
- **Parent documents**: `.workflow-docs/202608140015_diataxis-docs-rewrite/01_prd.md`; this `02_tranches.md`; approved tasking files for Tranches 1 through 3.
- **Settled decisions and non-negotiables**: The first documentation trajectory starts from PhyloPic identifiers, taxon-derived identifiers, or package-supported PhyloPic lookup. Users do not start by loading a local image matrix. DataCaches details stay hidden in initial prose but are documented explicitly later. Generated PNGs remain build products. Public API behavior must not change unless the project owner separately approves it.
- **Authorization boundary**: In scope: first-contact docs, completed primer/tutorial/how-to pages, docs navigation links, docs-private helper removal or demotion, workflow-document correction notes, and docs examples. Out of scope: public API changes, PhyloPic API client behavior changes, undocumented DataCaches behavior claims, CI secrets, and source-controlled generated PNG files.
- **Current-state diagnosis**: Completed Tranches 1 through 3 created and relied on `docs/src/_offline_silhouette.jl`, `offline_silhouette()`, and preloaded image-matrix examples. That is the wrong user trajectory.
- **Primary-goal lock**: PRD lock items 3, 4, 6, 7, 8, and 9.
- **Direct red-state repros**: Search completed docs and workflow files for `offline_silhouette`, `_offline_silhouette.jl`, "preloaded image matrix", "generated in-memory image", "offline-capable" as a first-learning requirement, and "required tutorial remains offline". Any first-path occurrence is a failure.
- **Named responsible entities and required behavior**: `README.md`, `docs/src/index.md`, `docs/src/primer.md`, `docs/src/tutorial.md`, and first-wave pages under `docs/src/how-to/` must provide first-contact and first-learning prose consumed by readers. They must not use `docs/src/_offline_silhouette.jl`, `offline_silhouette()`, or local image matrices as the normal first path, and the offline-first source-text audit plus rendered-doc review fails if they do. `src/PhyloPicDB/_bulk.jl` justifies DataCaches-backed batch-query prose because `PhyloPicDB.batch_primary_images` and `PhyloPicDB.batch_images` call `DataCaches.autocache`; docs must not transfer that claim to direct UUID rendering, and the DataCaches prose audit fails if they do. `src/_glyph_resolution.jl` resolves direct UUID images and deduplicates UUIDs within one call; docs may cite that behavior only. `docs/src/_offline_silhouette.jl` may remain only as a labeled test or emergency verification fixture if still needed; it must not appear in first-contact learning, and source-text audit fails if it does.
- **Exact files or surfaces in scope**: `README.md`; `docs/src/index.md`; `docs/src/primer.md`; `docs/src/tutorial.md`; `docs/src/how-to/index.md`; completed how-to pages under `docs/src/how-to/`; `docs/src/_offline_silhouette.jl` for deletion or demotion; `docs/make.jl` only for navigation changes required by remediation; workflow files in `.workflow-docs/202608140015_diataxis-docs-rewrite/`.
- **Exact files or surfaces out of scope**: `src/` behavior; test behavior except if docs-only tests already exist; `.github/workflows/CI.yml` unless a later approved verification tranche changes it; generated PNG files as committed assets.
- **Required upstream primary sources**: Diataxis pages listed above; Documenter syntax pages listed above; DataCaches upstream repository and README; local `Project.toml`, `src/PhyloPicDB/PhyloPicDB.jl`, `src/PhyloPicDB/_bulk.jl`, `src/_glyph_resolution.jl`, and `src/_augment_api.jl`.
- **Green-state gates**: docs build passes; doctests pass; revised first-learning examples produce build-product PNGs under documented network and cache assumptions; source-text audit confirms no offline-first first path remains; DataCaches claims match `src/PhyloPicDB/_bulk.jl` or upstream DataCaches docs; `git status --short` confirms generated PNGs are not tracked.
- **Stop conditions**: Stop if the remediation requires changing public API behavior; stop if a docs page needs DataCaches behavior not currently present in the cited source; stop if network-sensitive examples cannot be verified honestly under the documented assumptions; stop if a completed tasking file would need to be represented as still executable rather than archival.

### How to verify

- **Manual**: Read the rendered README, home page, primer, tutorial, and first-wave how-to pages as a new user. Confirm the path begins with PhyloPic identifiers or taxon-derived data, then silhouette selection or fetching, then placement in a Makie figure. Confirm cache setup details do not interrupt first-contact teaching.
- **Automated**: Run `julia --project=docs docs/make.jl`; run the doctest gate used by CI; run source-text audits for offline-first forbidden phrases; run documented examples to build-product PNGs under the documented network and cache assumptions; check PNG file types; run `git status --short` to confirm generated PNGs are not tracked.

### Acceptance criteria

- [ ] Given a reader opens README, home, primer, or tutorial, when they follow the first path, then they start from PhyloPic identifiers, taxon-derived identifiers, or package-supported PhyloPic lookup.
- [ ] Given completed first-wave docs are audited, then `offline_silhouette()`, `docs/src/_offline_silhouette.jl`, "preloaded image matrix", and equivalent local-image fixture language do not appear as the main reader path.
- [ ] Given later cache documentation is audited, then explicit DataCaches claims name `PhyloPicDB.batch_primary_images`, `PhyloPicDB.batch_images`, or the upstream DataCaches API being used.
- [ ] Given direct UUID rendering is described, then docs distinguish its current per-call deduplication from DataCaches-backed batch APIs unless a separately approved source change has expanded caching.
- [ ] Given the remedial diff is audited, then public API behavior, PhyloPic API client behavior, and generated PNG asset policy have not changed without explicit approval.

### User stories addressed

- User story 1: Finished figure near the start.
- User story 2: Place silhouettes at coordinates.
- User story 3: Place silhouettes on ranges.
- User story 4: Map table columns.
- User story 5: Repeated PhyloPic query performance.
- User story 6: PhyloPic-backed node UUID workflow.
- User story 8: Thumbnail gallery source path.
- User story 9: Cached repeated gallery queries.
- User story 14: Documentation examples are tested or rendered.
- User story 16: Direct red-state checks.
- User story 17: README first-contact path.

## Tranche 4: Write placement, PhyloPic source, and missing-image how-tos

**Type**: AFK
**Blocked by**: Tranche R1

### Governance and required reading

- Read the project-wide required reading listed above line by line.
- Read Diataxis how-to guide and explanation guidance.
- Read `src/_coordinates.jl`, `src/_glyph_resolution.jl`, `src/_render_core.jl`, `src/_thumbnail_grid.jl`, and `src/PhyloPicDB/_types.jl` for image rendering symbols.
- Read tests that cover `placement`, `at`, `on_missing`, `image_rendering`, rotation, mirroring, and thumbnail behavior.

### Primary-goal lock

- Closes the placement, size, offsets, rotation, mirroring, image quality, and missing-image portions of lock item 4.
- Helps preserve lock item 5 by keeping API facts in reference and user recipes in how-to pages.
- Preserves lock items 6, 7, 8, and 9.
- The work is not complete if `:skip`, `:error`, `:placeholder`, `:thumbnail`, `:raster`, `:vector`, `glyph_size`, `placement`, `xoffset`, `yoffset`, `rotation`, and `mirror` appear only as API facts with no reader-facing examples.
- The work is not complete if the image-source guide teaches "load an image matrix, then place it" as the normal user path.

### What to build

Write how-to pages for adjusting placement and visual appearance, choosing PhyloPic images and rendering quality, and handling missing images.

The adjustment guide should show placement, size, offset, rotation, and mirroring through concrete examples that start from PhyloPic-backed silhouettes. The source guide should explain PhyloPic node UUIDs, image selection, rendering choices, and where DataCaches-backed batch APIs help repeated queries. Local image matrices may appear only as a secondary "already have image data" path. The missing-image guide should make `:skip`, `:error`, and `:placeholder` meaningful through examples.

### Handoff packet

- **Active authorities**: Parent PRD; this tranche plan; repo-local `STYLE-docs.md`, `STYLE-writing.md`, `STYLE-vocabulary.md`, `STYLE-makie.md`, `STYLE-verification.md`, `STYLE-upstream-contracts.md`; repo-local `STYLE-agent-language.md`, `STYLE-agent-handoffs.md`, and `STYLE-workflow-vocabulary.md`.
- **Parent documents**: `.workflow-docs/202608140015_diataxis-docs-rewrite/01_prd.md`; this `02_tranches.md`.
- **Settled decisions and non-negotiables**: User-facing pages use "placement" with a plain-language explanation. Internal phrases such as "data-anchor" and "projected pixel-anchor" are not used in how-to openings. PhyloPic-backed examples are the normal path. DataCaches details may be hidden in first-contact prose and shown explicitly later.
- **Authorization boundary**: In scope: how-to Markdown, navigation links, docs examples, and reference links. Out of scope: changing placement math, missing-image behavior, image-fetch behavior, or public keyword semantics.
- **Current-state diagnosis**: Current docs expose these options primarily through API docstrings and example script keywords, not through task pages.
- **Primary-goal lock**: Lock items 4, 5, 6, 7, 8, and 9.
- **Direct red-state repros**: Current `docs/src/api/rendering.md` delegates almost everything to `@autodocs`; no goal page explains adjustment, missing-image policy, or image quality at user level.
- **Named responsible entities and required behavior**: The placement how-to must provide user recipes for `placement`, `glyph_size`, `xoffset`, `yoffset`, `rotation`, and `mirror`; it must not explain those choices through internal placement mechanics first, and rendered-page review fails if it does. The PhyloPic source how-to must provide user guidance for node UUIDs, rendering choices, and DataCaches-backed repeated-query behavior; it must not start from local image matrices, and offline-first audit fails if it does. The missing-image how-to must provide examples for `on_missing = :skip`, `on_missing = :error`, and `on_missing = :placeholder`; it must not invent behavior beyond `src/_render_core.jl`, and source-text audit against that file fails if it does. `src/_coordinates.jl`, `src/_glyph_resolution.jl`, `src/_render_core.jl`, `src/PhyloPicDB/_types.jl`, and `src/PhyloPicDB/_bulk.jl` provide API facts consumed by the how-to pages; how-to pages must link to reference for exhaustive facts, and duplicated-catalog audit fails if they copy the reference.
- **Exact files or surfaces in scope**: New how-to Markdown files under `docs/src/`; `docs/make.jl`; `docs/src/index.md`; `docs/src/api/rendering.md` and `docs/src/api/phylopic_db.md` only for links.
- **Exact files or surfaces out of scope**: Placement math; image download logic; public API behavior; generated PNGs as committed source assets.
- **Required upstream primary sources**: Diataxis how-to guides page; Diataxis explanation page if conceptual placement prose is needed; Documenter syntax for executable examples and links; DataCaches upstream repository and README; local `src/PhyloPicDB/_bulk.jl` and `src/_glyph_resolution.jl`.
- **Green-state gates**: `julia --project=docs docs/make.jl`; source-text audit for goal-oriented how-to titles and forbidden internal-first prose; example render checks when snippets are runnable.
- **Stop conditions**: Stop if a guide needs a new keyword or changed behavior, if an image-rendering or DataCaches claim is not supported by local source, or if the page would reintroduce local image matrices as the normal first path.

### How to verify

- **Manual**: Read the rendered pages and confirm each option is introduced through a task and expected visual result, not an internal implementation explanation.
- **Automated**: Run docs build and any cited example scripts or Documenter examples. Search the how-to openings for forbidden internal terms.

### Acceptance criteria

- [ ] Given a user wants to adjust a figure, when they read the placement guide, then they can change size, placement, offsets, rotation, and mirroring with concrete code.
- [ ] Given a user needs to choose a PhyloPic image, when they read the source guide, then they understand node UUIDs, rendering choices, and the DataCaches-backed repeated-query path where supported.
- [ ] Given a user encounters missing images, when they read the missing-image guide, then `:skip`, `:error`, and `:placeholder` are explained through examples.
- [ ] Given a user chooses image quality, when they read the image-source guide, then thumbnail, raster, vector, and source-file options are explained at user level and linked to reference.

### User stories addressed

- User story 5: Repeated PhyloPic query performance.
- User story 7: Control visual placement and appearance.
- User story 19: Missing-image policies.
- User story 20: Image quality choices.

## Tranche 5: Write thumbnail gallery how-tos

**Type**: AFK
**Blocked by**: Tranche R1

### Governance and required reading

- Read the project-wide required reading listed above line by line.
- Read Diataxis how-to guide guidance.
- Read `examples/src/thumbnail_gallery.jl`, `src/_thumbnail_grid.jl`, `src/_node_thumbnail_grid.jl`, and `docs/src/api/rendering.md`.
- Read Documenter syntax for examples and image outputs.

### Primary-goal lock

- Closes the thumbnail gallery portion of lock item 4.
- Helps lock item 6 by using `examples/src/thumbnail_gallery.jl` as runnable evidence.
- Preserves lock items 5, 7, 8, and 9.
- The work is not complete if thumbnail-gallery guidance remains only a command list or API reference entry.

### What to build

Write a how-to page for building a thumbnail gallery from PhyloPic node UUIDs, PhyloPic image records, or taxon-derived identifiers plus labels. Use existing gallery code and examples as source material where they remain true, but do not frame preloaded images as the normal starting point. Explain grouping, labels, layout choices, image selection, DataCaches-backed repeated-query behavior where supported, and expected output at task level.

Local image matrices may appear only as a secondary advanced path for readers who already have image data.

### Handoff packet

- **Active authorities**: Parent PRD; this tranche plan; repo-local `STYLE-docs.md`, `STYLE-writing.md`, `STYLE-vocabulary.md`, `STYLE-makie.md`, `STYLE-verification.md`, `STYLE-upstream-contracts.md`; repo-local `STYLE-agent-language.md`, `STYLE-agent-handoffs.md`, and `STYLE-workflow-vocabulary.md`.
- **Parent documents**: `.workflow-docs/202608140015_diataxis-docs-rewrite/01_prd.md`; this `02_tranches.md`.
- **Settled decisions and non-negotiables**: The thumbnail-gallery how-to starts from PhyloPic-backed inputs. Generated gallery PNGs are verification artifacts, not committed source docs assets by default. DataCaches-backed repeated-query behavior must be tied to `PhyloPicDB.batch_primary_images` or `PhyloPicDB.batch_images` unless a separate implementation change is approved.
- **Authorization boundary**: In scope: thumbnail-gallery how-to Markdown, navigation links, examples page links, and example script alignment if necessary. Out of scope: changing `phylopic_thumbnail_grid!` behavior or live node UUID fetching.
- **Current-state diagnosis**: Current docs list `thumbnail_gallery.jl`, but do not explain the gallery-building task or expected result.
- **Primary-goal lock**: Lock items 4, 5, 6, 7, 8, and 9.
- **Direct red-state repros**: Read `docs/src/examples.md`; it lists `thumbnail_gallery.jl` as a command rather than a goal-oriented guide.
- **Named responsible entities and required behavior**: The thumbnail gallery how-to must provide the reader recipe for `phylopic_thumbnail_grid` and `phylopic_thumbnail_grid!` using PhyloPic-backed inputs, labels, and group sizes; it must not frame preloaded images as the normal starting point, and source-text audit fails if it does. `src/_thumbnail_grid.jl` and `src/_node_thumbnail_grid.jl` define gallery behavior consumed by the how-to page; the how-to must not claim behavior those files do not expose, and docs build plus example-script verification fails unsupported claims. `src/PhyloPicDB/_bulk.jl` justifies DataCaches-backed repeated-query prose for batch image lookups; DataCaches prose audit fails broader claims.
- **Exact files or surfaces in scope**: New thumbnail how-to page; `docs/make.jl`; `docs/src/index.md`; `docs/src/examples.md`; `examples/src/thumbnail_gallery.jl` only if docs alignment is needed.
- **Exact files or surfaces out of scope**: Public gallery API behavior; PhyloPic fetch behavior; committed generated PNG files.
- **Required upstream primary sources**: Diataxis how-to guides page; Documenter syntax for examples and image outputs; DataCaches upstream repository and README; local `src/PhyloPicDB/_bulk.jl`.
- **Green-state gates**: `julia --project=docs docs/make.jl`; run `julia --project=examples examples/src/thumbnail_gallery.jl /tmp/thumbnail_gallery.png`; check `/tmp/thumbnail_gallery.png` exists and is a PNG; source-text audit for goal-oriented title and opening.
- **Stop conditions**: Stop if the guide requires changing gallery API behavior, or if it cannot produce a visible output artifact without committing generated PNGs.

### How to verify

- **Manual**: Open the rendered thumbnail gallery how-to and confirm it starts from PhyloPic-backed inputs and labels, explains grouping, and shows the expected gallery result.
- **Automated**: Run docs build and the thumbnail gallery example script to a temporary PNG, then check file type.

### Acceptance criteria

- [ ] Given a reader has PhyloPic node UUIDs or taxon-derived identifiers and labels, when they read the gallery how-to, then they can build a grouped thumbnail gallery.
- [ ] Given the gallery example script is run to `/tmp/thumbnail_gallery.png`, then the file exists and is a PNG.
- [ ] Given the source diff is audited, then generated PNGs are not committed as source documentation assets.

### User stories addressed

- User story 8: Build a thumbnail gallery from PhyloPic-backed inputs and labels.
- User story 14: Documentation examples are tested or rendered.

## Tranche 6: Write GraphMakie and PBDB workflow pages

**Type**: AFK
**Blocked by**: Tranche R1

### Governance and required reading

- Read the project-wide required reading listed above line by line.
- Read Diataxis how-to and explanation guidance.
- Read `examples/src/graph_anchors.jl`, `examples/README.md`, `docs/src/examples.md`, and the local GraphMakie-related example comments.
- Read Documenter syntax for cross-references.

### Primary-goal lock

- Closes the GraphMakie node-position snapshot portion of lock item 4.
- Closes the PBDB workflow explanation portion of the PRD user-story set.
- Helps lock item 6 through the GraphMakie example artifact.
- Preserves lock items 5, 7, 8, and 9.
- The work is not complete if the docs imply unsupported live reactive GraphMakie overlay tracking.

### What to build

Write a how-to page for placing silhouettes on GraphMakie node-position snapshots. It must explain that the example materializes `graphplot`, snapshots `graph_plot[:node_pos][]`, and passes explicit coordinates to `augment_phylopic!`; it must not claim live reactive overlay tracking.

Write a bounded explanation page that tells PaleobiologyDB users when PhyloPicMakie is the right layer and when PBDB-integrated package surfaces should resolve taxon names. The page should link outward to the PBDB-integrated surface already referenced by current docs, but it must not add PBDB implementation work.

### Handoff packet

- **Active authorities**: Parent PRD; this tranche plan; repo-local `STYLE-docs.md`, `STYLE-writing.md`, `STYLE-vocabulary.md`, `STYLE-makie.md`, `STYLE-verification.md`, `STYLE-upstream-contracts.md`; repo-local `STYLE-agent-language.md`, `STYLE-agent-handoffs.md`, and `STYLE-workflow-vocabulary.md`.
- **Parent documents**: `.workflow-docs/202608140015_diataxis-docs-rewrite/01_prd.md`; this `02_tranches.md`.
- **Settled decisions and non-negotiables**: GraphMakie support is a node-position snapshot workflow, not live reactive overlay tracking. PBDB integration implementation is out of scope.
- **Authorization boundary**: In scope: GraphMakie how-to page, PBDB explanation page, navigation links, example script documentation. Out of scope: GraphMakie API changes, PhyloPicMakie plotting implementation changes, PaleobiologyDB implementation.
- **Current-state diagnosis**: Current examples mention the GraphMakie hand-off note, but docs do not provide a goal page that sets reader expectations.
- **Primary-goal lock**: Lock items 4, 6, 7, 8, and 9.
- **Direct red-state repros**: Read `docs/src/examples.md`; it notes the snapshot behavior only in a script command list. No GraphMakie user goal page exists.
- **Named responsible entities and required behavior**: The GraphMakie how-to must provide the reader recipe for snapshot coordinates; it must not claim live reactive overlay tracking, and source-text audit plus rendered-page review fails if it does. `examples/src/graph_anchors.jl` provides executable evidence for materializing `graphplot`, reading `graph_plot[:node_pos][]`, and passing explicit coordinates to `augment_phylopic!`; the how-to must not claim behavior beyond that script unless a GraphMakie upstream primary source is read, and example-script verification fails unsupported claims. The PBDB explanation page must route readers between PhyloPicMakie and PBDB-integrated package surfaces; it must not add PBDB implementation obligations, and diff audit fails if source implementation changes appear.
- **Exact files or surfaces in scope**: New GraphMakie how-to page; new PBDB workflow explanation page; `docs/make.jl`; `docs/src/index.md`; `docs/src/examples.md`; `examples/src/graph_anchors.jl` only if wording and output alignment require it.
- **Exact files or surfaces out of scope**: GraphMakie internals; live reactive overlay support; PaleobiologyDB implementation; public API changes.
- **Required upstream primary sources**: Diataxis how-to and explanation pages; Documenter syntax for cross-references. If changing or making new claims about GraphMakie behavior beyond the local script, read official GraphMakie primary sources first.
- **Green-state gates**: `julia --project=docs docs/make.jl`; run `julia --project=examples examples/src/graph_anchors.jl /tmp/graph_anchors.png`; check `/tmp/graph_anchors.png` exists and is a PNG; source-text audit that no page claims live reactive GraphMakie overlays.
- **Stop conditions**: Stop if the page needs to assert GraphMakie behavior not demonstrated by `examples/src/graph_anchors.jl` and no GraphMakie primary source has been read.

### How to verify

- **Manual**: Read the rendered GraphMakie how-to and confirm it names the snapshot workflow and does not imply live tracking. Read the PBDB explanation and confirm it routes users without changing package responsibilities.
- **Automated**: Run docs build and the GraphMakie example script to a temporary PNG, then check file type.

### Acceptance criteria

- [ ] Given a GraphMakie user reads the how-to, when they follow it, then they snapshot node positions and pass explicit coordinates to `augment_phylopic!`.
- [ ] Given the GraphMakie page is audited, then it does not claim live reactive overlay tracking.
- [ ] Given a PBDB user reads the explanation, then they know when PhyloPicMakie handles silhouettes and when another package resolves taxon names.

### User stories addressed

- User story 10: GraphMakie node-position snapshot workflow.
- User story 11: PBDB-integrated package routing.

## Tranche 7: Write PhyloPic UUID and DataCaches documentation

**Type**: AFK
**Blocked by**: Tranche R1

### Governance and required reading

- Read the project-wide required reading listed above line by line.
- Read the PRD 2026-08-16 owner correction that resolves live PhyloPic-backed examples as the normal path.
- Read `src/_augment_api.jl`, `src/_glyph_resolution.jl`, `src/_node_thumbnail_grid.jl`, and relevant `src/PhyloPicDB/` files.
- Read `src/PhyloPicDB/_bulk.jl` and the DataCaches upstream repository and README before making caching claims.
- Read Diataxis how-to guidance and Documenter syntax for examples and warnings.

### Primary-goal lock

- Closes the PhyloPic node UUID portions of lock item 4.
- Closes the explicit DataCaches documentation path for lock items 5, 6, and 7.
- Preserves lock items 8 and 9.
- The work is not complete if PhyloPic-backed examples are framed as rare optional side material.
- The work is not complete if DataCaches is discussed without naming the exact local APIs that use `DataCaches.autocache` or the upstream DataCaches API being shown.

### What to build

Write PhyloPic node UUID and DataCaches documentation according to the project decision recorded in the PRD on 2026-08-16. PhyloPic-backed examples are part of the main docs. The first-contact pages may hide cache setup details, but this tranche must provide explicit later guidance for repeated queries.

The UUID documentation should explain when `node_uuid` is appropriate, how to pass labels to avoid extra label-fetching calls where applicable, how to choose image rendering options, and where DataCaches-backed batch APIs improve repeated PhyloPic queries. It must distinguish the current direct `augment_phylopic!` UUID path from the batch APIs that explicitly call `DataCaches.autocache`.

### Handoff packet

- **Active authorities**: Parent PRD; this tranche plan; repo-local `STYLE-docs.md`, `STYLE-writing.md`, `STYLE-vocabulary.md`, `STYLE-makie.md`, `STYLE-verification.md`, `STYLE-upstream-contracts.md`; repo-local `STYLE-agent-language.md`, `STYLE-agent-handoffs.md`, and `STYLE-workflow-vocabulary.md`.
- **Parent documents**: `.workflow-docs/202608140015_diataxis-docs-rewrite/01_prd.md`; this `02_tranches.md`.
- **Settled decisions and non-negotiables**: PhyloPic-backed examples belong in the main docs. Cache setup details stay out of first-contact prose but are shown explicitly later. Public API, network behavior, and caching behavior must not change without separate approval.
- **Authorization boundary**: In scope: UUID documentation, node UUID gallery documentation, DataCaches usage documentation tied to current local APIs, navigation placement, and reference links. Out of scope: PhyloPic API client behavior, new caching behavior, network semantics, public API changes.
- **Current-state diagnosis**: Current docs and completed tasking pushed live UUID use into optional later material and elevated local image matrices into the first path. That is now stale.
- **Primary-goal lock**: Lock items 4, 5, 6, 7, 8, and 9.
- **Direct red-state repros**: Search `docs/src/` and completed tasking for claims that the required tutorial remains offline, that live UUID examples are optional, or that DataCaches behavior applies to direct UUID rendering without local-source support.
- **Named responsible entities and required behavior**: The UUID and caching pages must provide reader guidance for PhyloPic-backed examples and repeated queries; first-contact pages must link to this later material instead of teaching cache setup, and rendered-doc review fails if caching interrupts first learning. `src/_glyph_resolution.jl` defines direct UUID image resolution and per-call deduplication consumed by `augment_phylopic!` UUID examples; docs must not claim DataCaches-backed cross-call caching from that file, and DataCaches prose audit fails if they do. `src/_node_thumbnail_grid.jl` defines UUID-backed thumbnail gallery behavior consumed by gallery docs; gallery docs must not claim unsupported inputs, and example verification fails unsupported claims. `src/PhyloPicDB/_bulk.jl` justifies DataCaches-backed batch-query prose because `PhyloPicDB.batch_primary_images` and `PhyloPicDB.batch_images` call `DataCaches.autocache`; docs must name those APIs when describing repeated-query caching, and DataCaches prose audit fails vague claims.
- **Exact files or surfaces in scope**: New or revised UUID and DataCaches how-to or explanation pages; `docs/make.jl`; `docs/src/index.md`; reference links.
- **Exact files or surfaces out of scope**: `src/PhyloPicDB/` behavior; `_resolve_images_by_uuid` behavior; network behavior; public API behavior.
- **Required upstream primary sources**: Diataxis how-to guides page; Documenter syntax for examples; DataCaches upstream repository and README. Local `src/PhyloPicDB/` source and docstrings are required project-owned sources. If external PhyloPic API behavior is needed, stop and request the official upstream primary source or owner ratification.
- **Green-state gates**: `julia --project=docs docs/make.jl`; source-text audit that PhyloPic-backed examples are normal docs material; source-text audit that DataCaches claims match cited local source; rendered-doc review confirms cache setup details do not interrupt first-contact pages.
- **Stop conditions**: Stop if a DataCaches claim needs implementation behavior not present in local source. Stop if external API semantics are needed but no primary source is available.

### How to verify

- **Manual**: Read the rendered UUID and caching content and confirm it is part of the main docs without crowding first-contact pages.
- **Automated**: Run docs build. Run source-text audit that the docs do not frame UUID use as optional side material and do not overclaim DataCaches behavior.

### Acceptance criteria

- [ ] Given a reader has PhyloPic node UUIDs, when they read the UUID how-to, then they can fetch or render silhouettes.
- [ ] Given a reader wants a UUID-based gallery, when they read the gallery content, then they can use the PhyloPic-backed path without being redirected to local image matrices.
- [ ] Given a reader repeats PhyloPic queries, when they read the caching content, then they understand the current DataCaches-backed batch APIs and their boundary.
- [ ] Given first-contact pages are audited, then cache setup details remain later-page material.

### User stories addressed

- User story 6: PhyloPic-backed how-to for node UUIDs.
- User story 9: Cached PhyloPic node UUID gallery queries.
- User story 20: Image quality choices for live images.

## Tranche 8: Reorganize reference pages

**Type**: AFK
**Blocked by**: Tranche R1 and Tranches 4, 5, 6, and 7

### Governance and required reading

- Read the project-wide required reading listed above line by line.
- Read Diataxis reference guidance.
- Read Documenter public API and syntax for `@autodocs`, `@docs`, `@ref`, `checkdocs`, and `modules`.
- Read `docs/src/api/rendering.md`, `docs/src/api/phylopic_db.md`, `src/PhyloPicMakie.jl`, `src/_augment_api.jl`, `src/_render_core.jl`, `src/_thumbnail_grid.jl`, `src/_node_thumbnail_grid.jl`, and `src/PhyloPicDB/PhyloPicDB.jl`.

### Primary-goal lock

- Closes lock item 5 for reference stays reference.
- Supports lock item 4 by linking reference pages back to how-to pages.
- Preserves lock items 7, 8, and 9.
- The work is not complete if API pages carry the tutorial or how-to teaching burden.
- The work is not complete if tutorial and how-to pages duplicate full API parameter catalogs.

### What to build

Reorganize API reference pages so they provide precise, neutral facts about exported functions, signatures, keyword meanings, valid symbols, return values, missing-image policies, error behavior, and examples. Keep `@autodocs` or switch to targeted `@docs` where the reference needs stable ordering.

Add short reference introductions and links back to the relevant primer, tutorial, and how-to pages. Move or rewrite internal overlay-mechanics prose so it appears only in bounded explanation or maintainer-facing context when it helps observable behavior.

### Handoff packet

- **Active authorities**: Parent PRD; this tranche plan; repo-local `STYLE-docs.md`, `STYLE-writing.md`, `STYLE-vocabulary.md`, `STYLE-julia.md`, `STYLE-verification.md`, `STYLE-upstream-contracts.md`; repo-local `STYLE-agent-language.md`, `STYLE-agent-handoffs.md`, and `STYLE-workflow-vocabulary.md`.
- **Parent documents**: `.workflow-docs/202608140015_diataxis-docs-rewrite/01_prd.md`; this `02_tranches.md`.
- **Settled decisions and non-negotiables**: API reference pages are information-oriented. Tutorial and how-to pages link to reference for details. Source docstrings under `src/` remain the API fact source.
- **Authorization boundary**: In scope: reference Markdown, cross-links, and docstrings only where necessary to make generated reference accurate and user-facing. Out of scope: function behavior, exported names, keyword semantics, and network behavior.
- **Current-state diagnosis**: `docs/src/api/rendering.md` mixes a small user-facing summary with internal implementation prose, then delegates almost everything to `@autodocs`.
- **Primary-goal lock**: Lock items 5, 7, 8, and 9.
- **Direct red-state repros**: Read `docs/src/api/rendering.md`; it includes "generic anchored-overlay substrate" and "data-anchor and projected pixel-anchor placement mechanics" before reference facts.
- **Named responsible entities and required behavior**: `docs/src/api/rendering.md` must provide rendered reference for `PhyloPicMakie` exports. `docs/src/api/phylopic_db.md` must provide rendered reference for `PhyloPicMakie.PhyloPicDB` exports. Source docstrings under `src/` provide exact API facts consumed by both reference pages. Tutorial and how-to Markdown pages must provide teaching and task recipes, not full API catalogs. Rendered-reference review fails if API facts are missing, and duplicated-catalog audit fails if tutorial or how-to pages carry the reference burden.
- **Exact files or surfaces in scope**: `docs/src/api/rendering.md`; `docs/src/api/phylopic_db.md`; source docstrings in `src/` only if needed for reference accuracy; cross-links from how-to/tutorial pages.
- **Exact files or surfaces out of scope**: Public API implementation behavior; example-script behavior except links; generated docs build output as source asset.
- **Required upstream primary sources**: Diataxis reference page; Documenter public API and syntax for `@autodocs`, `@docs`, `@ref`, `checkdocs`, and `modules`.
- **Green-state gates**: `julia --project=docs docs/make.jl`; CI doctest gate or equivalent local doctest command; rendered reference review; source-text audit that reference pages link to task pages and do not carry tutorial burden.
- **Stop conditions**: Stop if reference correctness requires public API changes, or if Documenter `@docs`/`@autodocs` behavior is uncertain and not verified from primary sources.

### How to verify

- **Manual**: Open rendered API pages from search-like entry and confirm a reader can find facts quickly and can navigate back to task-oriented help.
- **Automated**: Run docs build and doctests. Run source-text audit for internal-first prose in API openings and for excessive parameter catalogs copied into how-to pages.

### Acceptance criteria

- [ ] Given a reader opens the rendering API page, when they scan it, then they find signatures, keywords, valid symbols, return behavior, missing-image policy, and errors.
- [ ] Given a reader lands on an API page from search, when they need task help, then links point to tutorial or how-to pages.
- [ ] Given tutorial and how-to pages are audited, then they link to reference instead of duplicating whole parameter catalogs.
- [ ] Given the diff is audited, then no public API behavior changed.

### User stories addressed

- User story 12: API pages list facts quickly.
- User story 18: API pages link back to tutorial and how-to pages.

## Tranche 9: Wire example artifacts and verification

**Type**: AFK
**Blocked by**: Tranche R1 and Tranches 4, 5, 6, 7, and 8

### Governance and required reading

- Read the project-wide required reading listed above line by line.
- Read PRD Testing decisions and Primary-goal lock.
- Read `examples/src/explicit_overlays.jl`, `examples/src/thumbnail_gallery.jl`, `examples/src/graph_anchors.jl`, `examples/README.md`, `docs/make.jl`, and `.github/workflows/CI.yml`.
- Read Documenter public API and syntax for docs builds, doctests, and example output behavior.

### Primary-goal lock

- Closes lock item 6 for runnable examples remain real.
- Supports lock items 3 and 4 by proving documented examples still run.
- Preserves lock items 7, 8, and 9.
- The work is not complete if docs cite example outputs that are not generated or checked.
- The work is not complete if generated PNGs are committed as source docs assets by default.

### What to build

Wire verification around the documented examples. Ensure the docs and examples can produce the required temporary PNG artifacts:

- `/tmp/explicit_overlays.png`.
- `/tmp/thumbnail_gallery.png`.
- `/tmp/graph_anchors.png`.

Strengthen docs verification when documented examples are not already generated and checked by the docs build, doctest command, or example-script commands listed in this tranche. If CI changes are made, they must preserve the existing docs/deploy and doctest gate in `.github/workflows/CI.yml`.

### Handoff packet

- **Active authorities**: Parent PRD; this tranche plan; repo-local `STYLE-docs.md`, `STYLE-writing.md`, `STYLE-vocabulary.md`, `STYLE-makie.md`, `STYLE-julia.md`, `STYLE-verification.md`, `STYLE-upstream-contracts.md`, `STYLE-git.md`; repo-local `STYLE-agent-language.md`, `STYLE-agent-handoffs.md`, and `STYLE-workflow-vocabulary.md`.
- **Parent documents**: `.workflow-docs/202608140015_diataxis-docs-rewrite/01_prd.md`; this `02_tranches.md`.
- **Settled decisions and non-negotiables**: Generated PNGs are build products and verification artifacts. They are not committed as source documentation assets by default. The existing CI docs and doctest gate must not be weakened.
- **Authorization boundary**: In scope: docs/example verification wiring, examples README, docs build configuration, `.github/workflows/CI.yml` only if docs verification is strengthened. Out of scope: public API behavior, plotting semantics, package dependency changes unless approved by the project owner.
- **Current-state diagnosis**: Example scripts are runnable gallery scripts, but docs do not yet promote them into verified learning artifacts with output checks.
- **Primary-goal lock**: Lock items 3, 4, 6, 7, 8, and 9.
- **Direct red-state repros**: Current docs describe example commands, but a passing docs build alone does not prove the three example scripts generated visible PNG outputs.
- **Named responsible entities and required behavior**: `examples/src/explicit_overlays.jl`, `examples/src/thumbnail_gallery.jl`, and `examples/src/graph_anchors.jl` must remain the executable example scripts for point/range overlays, thumbnail galleries, and GraphMakie snapshots. Documentation pages may cite those scripts, but they must not claim output the scripts do not generate. The verification task must run those scripts to temporary PNG paths and check file type; a docs build alone does not satisfy this lock item. `.github/workflows/CI.yml` defines CI docs and doctest gates; verification wiring must not weaken those gates, and CI diff audit fails if it does.
- **Exact files or surfaces in scope**: `examples/src/explicit_overlays.jl`; `examples/src/thumbnail_gallery.jl`; `examples/src/graph_anchors.jl`; `examples/README.md`; docs pages that cite outputs; `docs/make.jl`; `.github/workflows/CI.yml` only if needed.
- **Exact files or surfaces out of scope**: Public API implementation; generated PNGs as committed source docs assets; live network API behavior.
- **Required upstream primary sources**: Documenter public API and syntax for docs builds, doctests, and example outputs; Makie-family docs or source only if verification changes depend on Makie behavior not already demonstrated locally.
- **Green-state gates**: `julia --project=docs docs/make.jl`; CI-style doctest command from `.github/workflows/CI.yml`; run all three example scripts to `/tmp/*.png`; file-type check that all three outputs are PNG images; `git status --short` confirms no generated PNGs are staged or added as source assets.
- **Stop conditions**: Stop if strengthening verification requires new package dependencies or CI secrets without project-owner approval.

### How to verify

- **Manual**: Inspect generated PNGs in `/tmp` if visual review is required. Confirm docs cite outputs that the scripts actually create.
- **Automated**: Run docs build, doctests, the three example script commands, and file-type checks.

### Acceptance criteria

- [ ] Given all documentation examples are built, when verification runs, then the docs build and doctests pass.
- [ ] Given each example script is run with a `/tmp/*.png` output path, then each output exists and is a PNG.
- [ ] Given `git status --short`, then generated PNG outputs are not tracked as source documentation assets.
- [ ] Given CI docs behavior is changed, then the existing docs/deploy and doctest gate is not weakened.

### User stories addressed

- User story 14: Documentation examples are tested or rendered.
- User story 16: Direct red-state checks for developer babble.

## Tranche 10: Run final role and vocabulary audit

**Type**: AFK
**Blocked by**: Tranche R1 and Tranches 4, 5, 6, 7, 8, and 9

### Governance and required reading

- Read the project-wide required reading listed above line by line.
- Re-read the PRD Primary-goal lock, Handoff packet, Testing decisions, Vocabulary decisions, and Out of scope sections.
- Re-read all changed documentation pages, `docs/make.jl`, `README.md`, examples docs, and reference pages.

### Primary-goal lock

- Audits all lock items.
- Closes final confirmation for lock items 8 and 9.
- The work is not complete if any primary-goal lock item can still survive behind a green docs build.

### What to build

Perform the final cross-doc audit and make only tightly scoped polish fixes required to satisfy the PRD locks.

Check Diataxis role boundaries, source vocabulary, rendered navigation, first-contact wording, how-to goal orientation, reference neutrality, example artifact treatment, network-dependency labeling, and documentation-only authorization boundaries.

### Handoff packet

- **Active authorities**: Parent PRD; this tranche plan; all repo-local governance files found and used; repo-local `STYLE-agent-language.md`, `STYLE-agent-handoffs.md`, and `STYLE-workflow-vocabulary.md`.
- **Parent documents**: `.workflow-docs/202608140015_diataxis-docs-rewrite/01_prd.md`; this `02_tranches.md`; all completed tranche tasking documents and implementation reports.
- **Settled decisions and non-negotiables**: All PRD non-negotiables remain in force. No public API or implementation behavior change is authorized. Generated PNGs remain build products by default.
- **Authorization boundary**: In scope: final docs-source polish, links, heading style, wording, and verification reports. Out of scope: new features, public API behavior, plotting implementation, network behavior, broad refactors.
- **Current-state diagnosis**: The pre-rewrite docs failed first-contact, Diataxis structure, goal-oriented how-to content, reference separation, and example verification. This tranche verifies those failures no longer survive.
- **Primary-goal lock**: All lock items 1 through 9.
- **Direct red-state repros**: Repeat every direct red-state repro from the PRD and from prior tranches: forbidden phrase search, navigation inspection, examples command-list check, how-to goal-title check, API reference role check, example PNG generation, generated asset check, and implementation diff audit.
- **Named responsible entities and required behavior**: `README.md` must provide repository first contact. `docs/make.jl` must define rendered navigation through Documenter `pages`. `docs/src/index.md` must provide the reader-facing outline. Tutorial, how-to, reference, and explanation pages must each satisfy their Diataxis role and must not substitute for each other. `examples/src/` scripts must provide executable output evidence for cited examples. Source docstrings under `src/` must provide API facts for reference pages. Final audit fails if rendered-doc review, source-text audit, example PNG verification, or diff audit shows that any of those responsibilities moved to an unnamed or conflicting surface.
- **Exact files or surfaces in scope**: All documentation and example surfaces changed during this workflow; verification commands and reports.
- **Exact files or surfaces out of scope**: Any source implementation behavior not already explicitly approved; new dependencies; live network behavior.
- **Required upstream primary sources**: All upstream primary sources listed in this tranche plan. Add any extra upstream primary source to the audit report if final verification depends on it.
- **Green-state gates**: Full docs build; doctests; relevant test suite if docstrings or examples embedded in source changed; all three example PNG commands and file-type checks; source-text audit; rendered-docs review; diff audit for documentation-only boundary.
- **Stop conditions**: Stop if a primary-goal lock item survives, if any tranches changed public behavior without approval, or if verification depends on an upstream contract not read from a primary source.

### How to verify

- **Manual**: Review rendered home page, primer/tutorial, representative how-to pages, explanation pages, and API reference. Confirm each page has the intended Diataxis role and reader level.
- **Automated**: Run all green-state gates listed above and record failures for remediation before tasking completion.

### Acceptance criteria

- [ ] Given every PRD primary-goal lock item, when the final audit checks it, then the old red state cannot survive behind passing docs build or tests.
- [ ] Given source documentation prose, when audited for vocabulary and style, then canonical terms are used correctly and forbidden first-contact phrases are absent outside bounded reference or explanation context.
- [ ] Given the diff, when audited against the authorization boundary, then no public API behavior, plotting behavior, exported name, or network behavior changed without explicit approval.
- [ ] Given generated example PNGs, when `git status --short` is inspected, then they are not tracked as source docs assets by default.

### User stories addressed

- User story 15: Docs structure makes page type obvious.
- User story 16: Direct red-state checks for developer babble.
- All user stories indirectly through final lock verification.
