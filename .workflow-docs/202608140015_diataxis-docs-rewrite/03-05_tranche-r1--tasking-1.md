---
date-created: 2026-08-16T23:18:46-07:00
workflow-instrument: Tasking plan
workflow-status: Proposed
workflow-agent-thread-id: codex/019ff9d2-ef36-7e31-92dd-bea4892ee11e
workflow-location: /home/jeetsukumaran/site/storage/local/computing/research/20260414_PhyloPicMakie.jl/PhyloPicMakie.jl
workflow-production-id: diataxis-docs-primer
workflow-prd: .workflow-docs/202608140015_diataxis-docs-rewrite/01_prd.md
workflow-tranche: .workflow-docs/202608140015_diataxis-docs-rewrite/02_tranches.md
---

# Tasks for tranche R1: Remediate the completed offline-first path

## Settled user decisions and environment baseline

- This is a remedial documentation tranche for already completed Tranches 1
  through 3. It must run before Tranches 4 through 10 are executed, approved,
  or regenerated.
- The project owner corrected the product direction on 2026-08-16. The normal
  reader path does not start with "load an image matrix, then decide where to
  place it." It starts with taxon names, taxon-derived identifiers, PhyloPic
  node UUIDs, PhyloPic image records, or package-supported PhyloPic lookup,
  then places silhouettes in a Makie figure.
- `docs/src/_offline_silhouette.jl`, `offline_silhouette()`, preloaded image
  matrices, and equivalent local fixtures must not appear as the first-contact
  or main learning path. If any local image fixture remains, it is a test or
  emergency verification fixture only and must be named that way.
- DataCaches usage is the performance story for repeated PhyloPic queries
  where local source actually supports that claim. First-contact pages may
  hide cache setup details. Later how-to or explanation pages must state the
  explicit boundary: `src/PhyloPicDB/_bulk.jl` uses
  `DataCaches.autocache` in `PhyloPicDB.batch_primary_images` and
  `PhyloPicDB.batch_images`; `src/_glyph_resolution.jl` currently deduplicates
  direct UUID image resolution within one `augment_phylopic!` call but is not
  itself the DataCaches-backed batch API.
- Generated PNG files are build products and verification artifacts. Do not
  commit generated PNGs as source documentation assets.
- This tranche is documentation-only unless the project owner separately
  approves a source implementation change. Do not change public API behavior,
  exported names, plotting behavior, image-resolution behavior, network
  behavior, package dependencies, CI behavior, or example-script behavior
  merely to make documentation easier.
- The existing tasking files
  `.workflow-docs/202608140015_diataxis-docs-rewrite/03-01_tranche-01--tasking-1.md`,
  `.workflow-docs/202608140015_diataxis-docs-rewrite/03-02_tranche-02--tasking-1.md`,
  `.workflow-docs/202608140015_diataxis-docs-rewrite/03-03_tranche-03--tasking-1.md`,
  and
  `.workflow-docs/202608140015_diataxis-docs-rewrite/03-04_tranche-04--tasking-1.md`
  are workflow history. Keep their archival correction notes, but do not treat
  their stale offline-first instructions as executable product direction.

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

`STYLE-agent-language.md` applies to every responsibility, contract, boundary,
invariant, source, and verification statement in this tranche. Name the exact
file, function, behavior, consuming page or caller, prohibited duplicate or
bypass, and failing verification artifact.

Read-only git and shell commands may be used freely. Mutating git operations,
including commit, merge, push, branch, checkout, rebase, and reset, remain the
human project owner's responsibility unless the user explicitly instructs
otherwise.

## Upstream primary sources and settled contract conclusions

Read these sources before implementation:

- Diataxis home: https://diataxis.fr/.
- Diataxis tutorials: https://diataxis.fr/tutorials/.
- Diataxis how-to guides: https://diataxis.fr/how-to-guides/.
- Diataxis reference: https://diataxis.fr/reference/.
- Diataxis explanation: https://diataxis.fr/explanation/.
- Documenter syntax for `@meta`, `@setup`, named `@example`, generated
  multimedia, image paths, and page build behavior:
  https://documenter.juliadocs.org/stable/man/syntax/.
- Documenter public API for docs builds, doctests, `checkdocs`, and page
  processing: https://documenter.juliadocs.org/stable/lib/public/.
- DataCaches upstream repository and README:
  https://github.com/JuliaData/DataCaches.jl.
- Local `Project.toml`, which already declares `DataCaches = "0.4"` and the
  JuliaData source URL.
- Local `src/PhyloPicDB/PhyloPicDB.jl`, which describes the PhyloPicDB module
  and its DataCaches-backed caching.
- Local `src/PhyloPicDB/_bulk.jl`, which calls `DataCaches.autocache` in
  `PhyloPicDB.batch_primary_images` and `PhyloPicDB.batch_images`.
- Local `src/_glyph_resolution.jl`, which resolves direct UUID images and
  deduplicates UUIDs within one `augment_phylopic!` call.
- Local `src/_augment_api.jl`, which defines public `augment_phylopic!` methods,
  accepted coordinate inputs, table selectors, keyword behavior, and errors.
- Local `src/_thumbnail_grid.jl` and `src/_node_thumbnail_grid.jl`, which own
  thumbnail gallery behavior.

Settled conclusions:

- Diataxis requires the first lesson to be a guided user activity, not a
  reference-first or implementation-first tour.
- The package already depends on DataCaches, so repeated-query performance can
  be explained through the package's existing PhyloPicDB batch APIs instead of
  smuggling local image fixtures into the first lesson.
- Current local source does not justify a blanket claim that direct
  `augment_phylopic!` UUID rendering has DataCaches-backed cross-session
  caching. That path may be described as per-call deduplicated only unless a
  separate approved implementation change expands it.
- No official external PhyloPic API contract is named in the parent PRD. Use
  local `src/PhyloPicDB/` source and docstrings as the project-owned source for
  package behavior. Stop if a docs claim needs external PhyloPic API semantics
  not defined locally.

## Required revalidation before implementation

Run this diagnosis before editing docs:

- Read the revised PRD Primary-goal lock, Testing decisions, Vocabulary
  decisions, Handoff packet, and Further notes.
- Read Tranche R1 in `02_tranches.md`.
- Read the archival correction notes at the top of tasking files 03-01 through
  03-04.
- Inspect `README.md`, `docs/src/index.md`, `docs/src/primer.md`,
  `docs/src/tutorial.md`, `docs/src/how-to/index.md`,
  `docs/src/how-to/points.md`, `docs/src/how-to/ranges.md`,
  `docs/src/how-to/table-columns.md`, and `docs/src/_offline_silhouette.jl`.
- Run a source-text audit for:
  `offline_silhouette`, `_offline_silhouette`, "preloaded image matrix",
  "preloaded-image", "generated in-memory image", "offline-capable",
  "required learning path remains offline", "required tutorial remains
  offline", "live UUID examples are optional", and "load an image matrix".
- Read `Project.toml`, `src/PhyloPicDB/PhyloPicDB.jl`,
  `src/PhyloPicDB/_bulk.jl`, and `src/_glyph_resolution.jl` before writing
  any DataCaches sentence.

## Primary-goal lock

### Lock 1: Restore the user-first trajectory

- The work is not complete if a first-contact page starts with local image
  loading, preloaded image matrices, or docs-private fixtures.
- Direct red-state repro: `docs/src/primer.md`, `docs/src/tutorial.md`, or a
  first-wave how-to requires `offline_silhouette()` before showing how the
  user gets a PhyloPic silhouette.
- Closer: tasks 2, 3, and 4.
- Verification: source-text audit fails any first-contact or first-learning
  page that uses local image fixtures as the normal path.

### Lock 2: Keep caching in the right place

- The work is not complete if DataCaches setup details interrupt the primer or
  first tutorial, or if later docs describe caching vaguely.
- Direct red-state repro: a page says "cached" or "DataCaches" without naming
  `PhyloPicDB.batch_primary_images`, `PhyloPicDB.batch_images`, upstream
  DataCaches APIs, or an approved implementation change.
- Closer: task 5.
- Verification: source-text audit and rendered-page review confirm first pages
  hide cache setup details while later pages state the exact API boundary.

### Lock 3: Repair completed first-wave docs

- The work is not complete if completed Tranche 2 and Tranche 3 outputs still
  teach an offline-first or local-image-first path.
- Direct red-state repro: `docs/src/primer.md`, `docs/src/tutorial.md`,
  `docs/src/how-to/points.md`, `docs/src/how-to/ranges.md`, or
  `docs/src/how-to/table-columns.md` begins from `offline_silhouette()`.
- Closer: tasks 3 and 4.
- Verification: docs build, rendered-doc review, and audit over those files
  fail the stale implementation.

### Lock 4: Keep generated PNGs as build products

- The work is not complete if a generated PNG is added under `docs/src/`,
  `examples/`, or another source-controlled asset path.
- Direct red-state repro: docs pass only because a generated image was copied
  into source instead of being built.
- Closer: tasks 3, 4, 6, and 7.
- Verification: `git status --short` confirms generated PNGs are not tracked;
  file checks inspect only build or temporary outputs.

### Lock 5: Preserve the documentation-only boundary

- The work is not complete if this tranche changes source behavior to make the
  new story easier to tell.
- Direct red-state repro: the implementation diff changes public API behavior,
  plotting semantics, network behavior, or caching behavior without explicit
  project-owner approval.
- Closer: every task.
- Verification: diff audit shows only documentation, examples documentation,
  docs build wiring, and workflow-document correction notes changed.

### Lock 6: Keep tasking history honest

- The work is not complete if completed tasking files still look like valid
  future instructions for the offline-first path.
- Direct red-state repro: a future agent can read 03-02 or 03-03 and treat
  `offline_silhouette()` as the required learning path.
- Closer: task 7.
- Verification: workflow-doc audit confirms correction notes exist and the R1
  tasking is present.

## Forbidden passing implementation table

| Goal | Forbidden passing implementation | Required failing artifact |
| --- | --- | --- |
| User-first trajectory | Keep `offline_silhouette()` in the primer or tutorial but add one later PhyloPic paragraph. | Source-text audit over `README.md`, `docs/src/index.md`, `docs/src/primer.md`, and `docs/src/tutorial.md` fails. |
| Real PhyloPic source path | Rename the local fixture so the forbidden string search passes while the docs still start from local matrices. | Rendered-doc review and broader audit for "local fixture", "image matrix", and first-task code fail. |
| Correct DataCaches boundary | Claim direct `augment_phylopic!` UUID rendering is DataCaches-backed without local-source support. | Audit of DataCaches prose against `src/PhyloPicDB/_bulk.jl` and `src/_glyph_resolution.jl` fails. |
| Build-product images | Commit generated PNGs into `docs/src/` or `examples/` to satisfy image checks. | `git status --short` and diff audit fail. |
| Documentation-only boundary | Change source behavior, dependencies, or network behavior without owner approval. | Diff audit against `src/`, `Project.toml`, `docs/Project.toml`, `.github/`, and `examples/src/` fails unless separately approved. |
| Workflow history | Leave completed tasking files without a correction note or delete history to hide the mistake. | Workflow-doc audit fails for missing archival correction and missing R1 tasking. |

## Handoff packet

- **Active authorities**: Parent PRD; `02_tranches.md`; this tasking file;
  repo-local `STYLE-workflow-docs.md`, `STYLE-agent-language.md`,
  `STYLE-agent-handoffs.md`, `STYLE-workflow-vocabulary.md`,
  `STYLE-docs.md`, `STYLE-writing.md`, `STYLE-vocabulary.md`,
  `STYLE-makie.md`, `STYLE-julia.md`, `STYLE-git.md`,
  `STYLE-architecture.md`, `STYLE-verification.md`, and
  `STYLE-upstream-contracts.md`.
- **Parent documents**:
  `.workflow-docs/202608140015_diataxis-docs-rewrite/01_prd.md`;
  `.workflow-docs/202608140015_diataxis-docs-rewrite/02_tranches.md`.
- **Settled decisions and non-negotiables**: The normal reader starts from
  PhyloPic-backed data, not a secret local image. DataCaches details are hidden
  initially and explicit later. Generated PNGs are build products. Public API
  behavior is not changed by this tranche.
- **Authorization boundary**: In scope: `README.md`, `docs/make.jl`,
  `docs/src/index.md`, `docs/src/primer.md`, `docs/src/tutorial.md`,
  `docs/src/how-to/index.md`, `docs/src/how-to/points.md`,
  `docs/src/how-to/ranges.md`, `docs/src/how-to/table-columns.md`,
  `docs/src/explanation/index.md`,
  `docs/src/how-to/reuse-phylopic-queries.md`,
  `docs/src/_offline_silhouette.jl`, and workflow correction notes under
  `.workflow-docs/202608140015_diataxis-docs-rewrite/`.
- **Out of scope**: Public API implementation, exported names, plotting
  semantics, PhyloPicDB behavior, DataCaches behavior, network behavior,
  package dependency changes, CI changes, generated PNGs as source assets, and
  example-script behavior unless separately approved.
- **Current-state diagnosis**: Completed Tranches 1 through 3 created or
  normalized an offline-first docs path through `docs/src/_offline_silhouette.jl`,
  `offline_silhouette()`, and preloaded image matrices. Tranche 4 tasking is
  proposed but stale and blocked.
- **Primary-goal lock**: PRD lock items 3, 4, 6, 7, 8, and 9, plus R1 locks 1
  through 6 in this file.
- **Direct red-state repros**: Run the required source-text audit and inspect
  the first learning pages. The stale state survives if the first path is still
  "load local image matrix, plot it."
- **Named responsible entities and required behavior**: `README.md` must provide
  repository first contact; `docs/src/index.md` must provide documentation
  first contact and the reader-facing outline. Neither file may introduce the
  package through local image matrices or internal placement mechanics, and the
  forbidden-phrase audit fails if they do. `docs/src/primer.md` and
  `docs/src/tutorial.md` must provide first learning from PhyloPic identifiers,
  taxon-derived identifiers, PhyloPic image records, or package-supported
  lookup; `docs/src/_offline_silhouette.jl` and renamed local fixtures must not
  provide the normal first path, and the offline-first source-text audit fails
  if they do. `docs/src/how-to/points.md`, `docs/src/how-to/ranges.md`, and
  `docs/src/how-to/table-columns.md` must provide first-wave goal recipes that
  start from user data plus PhyloPic-backed silhouette inputs; they must not
  duplicate full API parameter catalogs from reference pages, and rendered-page
  review plus source-text audit fails if they do. If task 5 creates
  `docs/src/how-to/reuse-phylopic-queries.md`, that file must provide later
  explicit repeated-query caching guidance; primer and tutorial pages must not
  teach cache setup, and rendered-doc review fails if cache setup interrupts
  first-contact learning. `src/PhyloPicDB/_bulk.jl` justifies DataCaches-backed
  batch-query prose because `PhyloPicDB.batch_primary_images` and
  `PhyloPicDB.batch_images` call `DataCaches.autocache`; docs must not claim
  the same behavior for direct UUID rendering, and DataCaches source-text audit
  fails if they do. `src/_glyph_resolution.jl` resolves direct UUID images and
  deduplicates UUIDs within one call; docs may cite it for that behavior only.
- **Exact files or surfaces in scope**: the files listed in the Authorization
  boundary.
- **Exact files or surfaces out of scope**: the files and behaviors listed in
  Out of scope.
- **Required upstream primary sources**: Diataxis, Documenter, DataCaches, and
  local source files listed above.
- **Green-state gates**: docs build passes; doctests pass if the project has a
  doctest gate; rendered-doc review confirms the first path is PhyloPic-backed;
  source-text audit confirms no offline-first first path remains; DataCaches
  prose matches local source; generated PNGs are build or temporary products;
  workflow-doc audit confirms archival correction notes and R1 tasking.
- **Stop conditions**: Stop if the remediation requires public API behavior,
  network behavior, caching behavior, dependency, or CI changes not separately
  approved. Stop if a DataCaches claim cannot be tied to local source or the
  upstream DataCaches docs. Stop if an external PhyloPic API behavior claim is
  needed without an official primary source or owner ratification.

## Tranche execution rule

Complete the tasks in order. Do not mark the tranche complete until the
verification task has run and the completion report records command results,
remaining stale-text matches, generated image locations, and a diff audit. If
any task needs public API, dependency, CI, or network-behavior changes, stop
and request project-owner approval before editing those surfaces.

## Non-negotiable execution rules

- Do not let `offline_silhouette()` or any renamed local fixture become the
  normal reader path.
- Do not replace a user-first PhyloPic path with implementation language about
  overlays, substrates, projection mechanics, or owner layers.
- Do not describe DataCaches as magic background behavior. Name the exact local
  APIs or the upstream DataCaches API being shown.
- Do not use `src/_glyph_resolution.jl` as proof of DataCaches-backed
  cross-session caching.
- Do not commit generated PNG files.
- Do not hide the historical correction by deleting approved tasking files.

## Tasks

### Task 1: Revalidate and inventory the stale path

**Positive contract**: Read the required sources and inspect the current docs.
Record in the implementation report which first-contact and first-wave pages
still teach `offline_silhouette()`, `_offline_silhouette.jl`, preloaded image
matrices, local image fixtures, "offline-capable" first learning, or live UUID
examples as optional side material. Confirm the current DataCaches boundary
from `src/PhyloPicDB/_bulk.jl` and `src/_glyph_resolution.jl`.

**Negative contract**: Do not edit docs in this task. Do not infer caching
behavior from package names or dependency declarations alone.

**Files**: `README.md`; `docs/src/index.md`; `docs/src/primer.md`;
`docs/src/tutorial.md`; `docs/src/how-to/index.md`;
`docs/src/how-to/points.md`; `docs/src/how-to/ranges.md`;
`docs/src/how-to/table-columns.md`; `docs/src/_offline_silhouette.jl`;
`Project.toml`; `src/PhyloPicDB/PhyloPicDB.jl`; `src/PhyloPicDB/_bulk.jl`;
`src/_glyph_resolution.jl`; `src/_augment_api.jl`.

**Out of scope**: Source edits, dependency edits, generated images, CI.

**Verification**: The implementation report names every stale source-text
match that will be repaired or deliberately retained as archival/test-fixture
language.

### Task 2: Repair first contact and the top-down outline

**Positive contract**: Update `README.md`, `docs/src/index.md`,
`docs/src/how-to/index.md`, and `docs/src/explanation/index.md` so the outline
starts with the user's problem: choose or resolve PhyloPic silhouettes for taxa
or nodes, place them in Makie figures, then learn placement, galleries,
caching, and reference details. Update `docs/make.jl` when the sidebar needs a
new, removed, or renamed page entry to match that outline. Ensure the docs
table of contents makes the corrected progression visible.

**Negative contract**: Do not describe implementation substrates, projected
pixel anchors, owner layers, or hidden fixtures in first contact. Do not add
links to pages that do not exist at the end of this task unless they are
honest route pages clearly marked as next material.

**Files**: `README.md`; `docs/src/index.md`; `docs/src/how-to/index.md`;
`docs/src/explanation/index.md`; `docs/make.jl`.

**Out of scope**: `src/`; public API behavior; generated PNGs as source
assets.

**Verification**: Run a source-text audit over these files for forbidden
internal-first phrases and offline-first language. Rendered navigation must
show primer/tutorial, how-to, explanation, reference, examples, and any R1
caching page in a coherent order.

### Task 3: Repair the primer and tutorial

**Positive contract**: Rewrite `docs/src/primer.md` and `docs/src/tutorial.md`
so the first learning path starts from PhyloPic identifiers, taxon-derived
identifiers, PhyloPic image records, or package-supported lookup. The primer
shows a quick visible result. The tutorial walks one coherent user activity
from source identifiers through a saved or rendered Makie figure with
silhouettes. Network and cache assumptions must be stated where they affect
running the example, but cache setup details stay out of the first-contact
flow.

**Negative contract**: Do not use `offline_silhouette()`, `_offline_silhouette.jl`,
preloaded image matrices, or a renamed local fixture as the main path. Do not
make the tutorial a reference page or a catalog of every keyword. Do not
change source implementation to make the example work.

**Files**: `docs/src/primer.md`; `docs/src/tutorial.md`; `docs/Project.toml`
only if a docs-environment correction is separately approved and required by
the rendered example.

**Out of scope**: `src/`; `examples/src/`; `.github/`; package dependency
changes without owner approval.

**Verification**: Run `julia --project=docs docs/make.jl`. Verify the primer
and tutorial generated or rendered their documented output artifacts under
`docs/build/` or `/tmp`. Run source-text audits that fail the old
`offline_silhouette()` and preloaded-image tutorial.

### Task 4: Repair completed point, range, and table how-tos

**Positive contract**: Rewrite `docs/src/how-to/points.md`,
`docs/src/how-to/ranges.md`, and `docs/src/how-to/table-columns.md` so each
how-to begins from a user data problem plus PhyloPic-backed silhouette inputs.
The table guide must treat `node_uuid` or taxon-derived identifier columns as
part of the normal documented path while staying precise about which overloads
and selectors exist in `src/_augment_api.jl`.

**Negative contract**: Do not keep local image matrices as the first example.
Do not claim unsupported table image-column behavior. Do not make live network
behavior look offline. Do not copy a full API parameter catalog into the
how-to pages.

**Files**: `docs/src/how-to/points.md`; `docs/src/how-to/ranges.md`;
`docs/src/how-to/table-columns.md`; `docs/src/how-to/index.md`;
`src/_augment_api.jl` as read-only fact source.

**Out of scope**: Public table-overload behavior, range placement behavior,
source implementation, generated PNGs as source assets.

**Verification**: Run docs build. Source-text audit fails if any first-wave
how-to starts from `offline_silhouette()`, "preloaded image matrix", or an
equivalent local fixture. Rendered-doc review confirms each how-to starts with
a task a user actually has.

### Task 5: Add explicit later repeated-query caching guidance

**Positive contract**: Add `docs/src/how-to/reuse-phylopic-queries.md` as a
later how-to for repeated PhyloPic queries, or update an equivalent later page
if one already exists. Show explicit DataCaches usage only where supported by
local source or by the upstream DataCaches API being demonstrated. State that
`PhyloPicDB.batch_primary_images` and `PhyloPicDB.batch_images` are
DataCaches-backed through `src/PhyloPicDB/_bulk.jl`, and distinguish them from
direct `augment_phylopic!` UUID rendering in `src/_glyph_resolution.jl`.
Update `docs/make.jl` when the repeated-query page needs a sidebar entry.
Update `docs/src/how-to/index.md` and `docs/src/explanation/index.md` when
they need a link to the repeated-query page or an updated cross-reference.

**Negative contract**: Do not imply that every PhyloPic fetch path is
DataCaches-backed. Do not place cache setup in the primer opening or the first
tutorial steps. Do not introduce new caching behavior in source code.

**Files**: `docs/src/how-to/reuse-phylopic-queries.md`; `docs/make.jl`;
`docs/src/how-to/index.md`; `docs/src/explanation/index.md`;
`src/PhyloPicDB/_bulk.jl` and `src/_glyph_resolution.jl` as read-only fact
sources.

**Out of scope**: `src/PhyloPicDB/` edits, DataCaches implementation changes,
network behavior changes, dependency changes.

**Verification**: Run docs build. Audit every DataCaches sentence and confirm
it names `PhyloPicDB.batch_primary_images`, `PhyloPicDB.batch_images`,
upstream DataCaches APIs, or an approved source change. Audit first-contact
pages to confirm cache setup details are not front-loaded.

### Task 6: Remove or demote the stale local image fixture

**Positive contract**: If the repaired docs no longer need a deterministic
local image fixture, delete `docs/src/_offline_silhouette.jl` and remove all
public-doc references to it. If a deterministic local image fixture is still
needed for tests or emergency no-network verification, rename or rewrite its
documentation so it is clearly a test fixture only, and keep it out of the
first-contact, primer, tutorial, and first-wave how-to path.

**Negative contract**: Do not preserve the helper under a friendlier name and
continue teaching from it. Do not delete a helper still required by a verified
docs example unless that example is repaired first.

**Files**: `docs/src/_offline_silhouette.jl`; any docs page still referencing
it after tasks 2 through 5.

**Out of scope**: Source rendering behavior, example scripts, generated PNGs
as source assets.

**Verification**: Run docs build. Run source-text audits for
`offline_silhouette`, `_offline_silhouette`, "preloaded image matrix", and
equivalent local-fixture language. Remaining matches are allowed only in
archival workflow docs or clearly labeled test-fixture context.

### Task 7: Preserve workflow correction notes

**Positive contract**: Confirm `.workflow-docs/202608140015_diataxis-docs-rewrite/01_prd.md`,
`02_tranches.md`, and tasking files 03-01 through 03-04 carry the 2026-08-16
correction forward. If a correction note is missing or contradicted by later
edits, repair it as an archival workflow-doc change. Keep this R1 tasking file
as the executable remedial plan.

**Negative contract**: Do not delete historical tasking files or silently edit
them so they look as if the old offline-first plan never happened. Do not mark
R1 complete unless the first-wave public docs are actually repaired.

**Files**: `.workflow-docs/202608140015_diataxis-docs-rewrite/01_prd.md`;
`.workflow-docs/202608140015_diataxis-docs-rewrite/02_tranches.md`;
`.workflow-docs/202608140015_diataxis-docs-rewrite/03-01_tranche-01--tasking-1.md`;
`.workflow-docs/202608140015_diataxis-docs-rewrite/03-02_tranche-02--tasking-1.md`;
`.workflow-docs/202608140015_diataxis-docs-rewrite/03-03_tranche-03--tasking-1.md`;
`.workflow-docs/202608140015_diataxis-docs-rewrite/03-04_tranche-04--tasking-1.md`;
this file.

**Out of scope**: Rewriting approved implementation history beyond correction
notes.

**Verification**: Workflow-doc audit confirms Tranche R1 exists, later tranches
are blocked by R1 where needed, 03-04 is not executable as-is, and completed
tasking files have correction notes.

### Task 8: Run verification and report completion

**Positive contract**: Run the full verification set and write a concise
completion report that names commands, outcomes, generated-image paths,
remaining allowed stale-text matches, DataCaches source proof, and any
follow-up tranches that must be regenerated.

**Negative contract**: Do not report completion with only a green docs build.
Do not ignore stale text in first-contact pages because it appears in a code
block or route page.

**Files**: Documentation files changed by tasks 2 through 7; generated outputs
under `docs/build/` or `/tmp` as verification artifacts only.

**Out of scope**: Committing changes, deleting user work outside this tranche,
or broad prose polish unrelated to the correction.

**Verification**:

- `julia --project=docs docs/make.jl`.
- The CI-style doctest command used by this repository, if present.
- Source-text audit for offline-first forbidden phrases in public docs.
- Source-text audit for DataCaches overclaiming.
- Rendered-doc review of README-equivalent opening, docs home, primer,
  tutorial, point/range/table how-tos, and the repeated-query caching page.
- File checks for any generated PNGs, all under `docs/build/` or `/tmp`.
- `git status --short` confirming generated PNGs are not tracked.

## Completion report requirements

The implementing agent's final report must include:

- Files changed.
- Verification commands and results.
- Generated image paths and whether they are build products or temporary
  artifacts.
- Remaining matches for `offline_silhouette`, `_offline_silhouette`,
  "preloaded image matrix", and related local-fixture language, with each
  remaining match justified as archival workflow text or a labeled test
  fixture.
- DataCaches claims made, each tied to `PhyloPicDB.batch_primary_images`,
  `PhyloPicDB.batch_images`, upstream DataCaches APIs, or a separately approved
  source change.
- Whether Tranche 4 tasking must be regenerated after R1.
