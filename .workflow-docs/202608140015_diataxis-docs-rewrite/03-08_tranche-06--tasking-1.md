---
date-created: 2026-08-17T22:16:19-07:00
workflow-instrument: Tasking plan
workflow-status: Approved
workflow-agent-thread-id: codex/01a01344-533e-7d52-8136-aa179c54833b
workflow-agent-implementing-id:
  - codex/01a01360-99af-7963-b18e-d0f7da4bf898
workflow-location: /home/jeetsukumaran/site/storage/local/computing/research/20260414_PhyloPicMakie.jl/PhyloPicMakie.jl
workflow-production-id: diataxis-docs-primer
workflow-prd: .workflow-docs/202608140015_diataxis-docs-rewrite/01_prd.md
workflow-tranche: .workflow-docs/202608140015_diataxis-docs-rewrite/02_tranches.md
---

# Tasks for tranche 6: Write GraphMakie and PBDB workflow pages

## Settled user decisions and environment baseline

- Tranches R1, 4, and 5 are complete. The normal documentation path starts
  with PhyloPic node UUIDs, taxon-derived identifiers from another package, or
  package-supported PhyloPic lookup. It does not start with a local image
  matrix, a docs-private fixture, or `offline_silhouette()`.
- This is a documentation tranche. It may change the named Markdown pages,
  Documenter navigation, reader-route links, and the named source docstrings
  and comments that state external documentation facts. It must not change a
  Julia method body, public signature, export, package dependency, CI job,
  plotting behavior, PhyloPicDB behavior, GraphMakie behavior, or
  PaleobiologyDB behavior.
- `docs/make.jl` is the single file that defines the rendered Documenter
  sidebar through `makedocs(...; pages = ...)`. `docs/src/index.md` is the
  reader-facing documentation map. The how-to and explanation indexes consume
  those routes. Do not create a prose-only route that the sidebar omits.
- `examples/src/graph_anchors.jl` is the executable GraphMakie evidence. It
  creates `graph_plot` with `GraphMakie.graphplot`, calls
  `CairoMakie.Makie.update_state_before_display!(fig)`, reads
  `graph_plot[:node_pos][]` once, converts those points to explicit `xs` and
  `ys`, and calls `augment_phylopic!` with decoded images. It establishes a
  one-time coordinate hand-off; it does not establish a layout observer,
  reactive update path, or live attachment between the overlay and the graph.
- The new GraphMakie recipe must use the existing public UUID form of
  `augment_phylopic!`: explicit `xs` and `ys` derived from the snapshot plus a
  `node_uuid` vector. Keep that example in a plain `julia` fence because UUID
  resolution requires the network. Do not add a network-sensitive Documenter
  `@example`, a PNG source asset, or a docs-private glyph fixture.
- `PhyloPicMakie.augment_phylopic!` and
  `PhyloPicMakie.phylopic_thumbnail_grid!` are PhyloPic-native surfaces. They
  consume PhyloPic node UUIDs or decoded image data; they do not accept PBDB
  taxon names as direct PhyloPicMakie inputs.
- Current official PaleobiologyDB documentation names the taxon-name surface
  `PaleobiologyDB.PBDBMakie`, including its `augment_phylopic!` and
  `pbdb_phylopic_grid!` APIs. The repository's current Markdown and source
  docstrings instead name `PaleobiologyDB.PhyloPicPBDB`. That text is stale
  documentation, not a license to alter either package's implementation.
  This tranche corrects all named reader-facing and source-docstring mentions
  to `PaleobiologyDB.PBDBMakie` and links to the existing official rendering
  reference: <https://jeetsukumaran.github.io/PaleobiologyDB.jl/dev/api/phylopic_makie/>.
- The PBDB page is an explanation page, not a second reference or a tutorial.
  It explains the division of reader workflows: use PhyloPicMakie for a
  figure whose PhyloPic node UUIDs or decoded images are already available;
  use the official PaleobiologyDB PBDBMakie surface when a PBDB taxon-name
  workflow is required. It does not contain a copied keyword catalog or a
  new PBDB code example.
- Generated PNGs are build products and verification artifacts. The GraphMakie
  command writes only `/tmp/graph_anchors-tranche6.png`; no generated PNG may
  be added below `docs/src/`, `examples/`, or version control.
- The current repository baseline is clean. `julia --project=docs docs/make.jl`
  passed on 2026-08-17. A direct GraphMakie revalidation initially failed only
  because the sandbox made Julia's shared compiled-cache directory read-only;
  the execution environment, not the repository code, caused that failure. A
  rerun with only Julia's compiled-cache location redirected to `/tmp` wrote
  `/tmp/graph_anchors-tranche6-revalidation.png`, which `file` identified as a
  1200×900 RGBA PNG and visual review showed as the expected graph-and-
  silhouettes figure. The normal project command remains the required tranche
  gate.
- The repository has no `CONTRIBUTING*.md`, `STYLE-python.md`,
  `STYLE-domain-vocabulary.md`, or `codebases-and-documentation` directory.
  The local governance files mirror the bundled files except `STYLE-makie.md`;
  the repo-local copy is the controlling project authority and the bundled
  copy remains supplemental.

## Governance

Before implementation, read every authority below line by line and comply with
it throughout the work:

- `.workflow-docs/202608140015_diataxis-docs-rewrite/01_prd.md`.
- `.workflow-docs/202608140015_diataxis-docs-rewrite/02_tranches.md`.
- `.workflow-docs/202608140015_diataxis-docs-rewrite/03-05_tranche-r1--tasking-1.md`.
- `.workflow-docs/202608140015_diataxis-docs-rewrite/03-06_tranche-04--tasking-2.md`.
- `.workflow-docs/202608140015_diataxis-docs-rewrite/03-07_tranche-05--tasking-1.md`.
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

The matching bundled governance corpus under
`/home/jeetsukumaran/.codex/skills/development-policies/references/` is also
in force as a supplemental baseline. `STYLE-agent-language.md` applies to
every statement about a responsible entity, contract, boundary, invariant,
source, or verification artifact. Such statements must name the exact file,
function, behavior, consumer, prohibited duplicate or bypass, and verification
artifact.

Read-only Git and shell commands are permitted. Commit, merge, push, branch,
checkout, rebase, and reset remain the project owner's responsibility unless
the owner explicitly authorizes them.

## Upstream primary sources and local contract conclusions

Read these upstream primary sources before implementation:

- Diataxis how-to guides: <https://diataxis.fr/how-to-guides/>.
- Diataxis explanation: <https://diataxis.fr/explanation/>.
- Documenter syntax for `@meta`, Markdown links, and `@ref` links:
  <https://documenter.juliadocs.org/stable/man/syntax/>.
- PaleobiologyDB's current PhyloPic rendering reference:
  <https://jeetsukumaran.github.io/PaleobiologyDB.jl/dev/api/phylopic_makie/>.

Read these local sources before implementation:

- `docs/make.jl`.
- `docs/src/index.md`.
- `docs/src/examples.md`.
- `docs/src/how-to/index.md`.
- `docs/src/explanation/index.md`.
- `docs/src/how-to/thumbnail-gallery.md`.
- `docs/src/api/rendering.md`.
- `examples/README.md`.
- `examples/src/graph_anchors.jl`.
- `src/_augment_api.jl`.
- `src/_render_core.jl`.
- `src/_thumbnail_grid.jl`.
- `src/_node_thumbnail_grid.jl`.
- `src/PhyloPicMakie.jl`.

Resolved conclusions:

- Diataxis how-to guidance requires a goal-oriented, action-focused sequence.
  The GraphMakie page title is exactly "Place silhouettes on GraphMakie
  node-position snapshots." It opens with the result a reader needs and
  limits explanation to the coordinate hand-off necessary to complete that
  task. The page links to reference material rather than reproducing a keyword
  catalog.
- Diataxis explanation guidance requires bounded, understanding-oriented
  material. The PBDB page title is exactly "About PaleobiologyDB workflows."
  It connects the two package surfaces and links to the external reference. It
  does not instruct a reader through a tutorial or restate the complete API.
- Documenter's established local pattern is a `@meta CurrentModule =
  PhyloPicMakie` block followed by ordinary relative Markdown links between
  pages. Use that pattern in both new Markdown pages. The two external PBDB
  links remain ordinary absolute Markdown links; do not add DocumenterInterLinks
  or `@extref` infrastructure.
- `examples/src/graph_anchors.jl` proves only three GraphMakie facts used by
  the how-to: `graphplot` materializes a plot object, `graph_plot[:node_pos][]`
  provides the positions captured by the example, and explicit coordinates can
  be supplied to `augment_phylopic!`. The new page makes no stronger claim.
- `src/_augment_api.jl` documents the PhyloPic-native `node_uuid` API;
  `src/_render_core.jl` documents the decoded-image rendering method; and
  `src/_node_thumbnail_grid.jl` and `src/_thumbnail_grid.jl` document UUID and
  pre-resolved-image gallery paths. Their descriptive text must point
  taxon-name readers at current `PaleobiologyDB.PBDBMakie` documentation while
  leaving all implementations unchanged.
- The official PBDB reference identifies `PaleobiologyDB.PBDBMakie` and shows
  that its `augment_phylopic!` accepts a `taxon` vector while its
  `pbdb_phylopic_grid!` accepts taxon names. The new PBDB explanation may
  state this division of public surfaces. The task must stop before adding a
  claim about another external PBDB API not shown by that reference.

## Primary-goal lock

### Lock T6-01: Provide a goal-oriented GraphMakie how-to

- The work is not complete if GraphMakie guidance remains a command and a
  one-sentence note in `docs/src/examples.md` instead of a reader task page.
- Direct red-state repro: `docs/src/examples.md` lists
  `examples/src/graph_anchors.jl` and says that positions are read from
  `p[:node_pos][]`, but `docs/src/how-to/graphmakie-node-positions.md` does
  not exist and the sidebar has no GraphMakie task route.
- Tasks that close it: 2 and 4.
- Failing verification artifact: `test -f
  docs/build/how-to/graphmakie-node-positions/index.html` fails before the
  page exists; rendered-page review fails a page whose heading and opening do
  not name placing silhouettes on GraphMakie node-position snapshots.

### Lock T6-02: Preserve the snapshot-only GraphMakie contract

- The work is not complete if the GraphMakie how-to presents the overlay as
  tracking later graph-layout changes or fails to show the one-time coordinate
  hand-off.
- Direct red-state repro: a weak page can call `graphplot` and
  `augment_phylopic!` without showing `graph_plot[:node_pos][]`, leaving a
  reader to infer a nonexistent ongoing relationship between the two plots.
- Tasks that close it: 2 and 4.
- Failing verification artifact: the page-source audit fails unless the page
  contains `graph_plot[:node_pos][]`, converts the captured positions to
  explicit coordinate vectors, uses those vectors in `augment_phylopic!`, and
  contains no `reactive`, `Observable`, `listener`, or automatic-tracking
  language. The GraphMakie PNG render verifies that the executable local
  snapshot procedure still produces a visible figure.

### Lock T6-03: Keep the new GraphMakie reader path PhyloPic-backed

- The work is not complete if the new how-to teaches a local glyph matrix or a
  docs fixture before PhyloPic node UUIDs.
- Direct red-state repro: `examples/src/graph_anchors.jl` deliberately creates
  deterministic `fish_glyph`, `bird_glyph`, and `fern_glyph` matrices to
  verify the renderer. Those matrices prove a local render but are not the
  user-facing PhyloPic acquisition path.
- Tasks that close it: 2 and 4.
- Failing verification artifact: the first executable block in the new page
  must contain `node_uuid` and must not contain `glyph`, `cell_images`,
  `offline_silhouette`, `preloaded image matrix`, or a docs-private helper.

### Lock T6-04: Give PBDB readers an accurate, bounded route

- The work is not complete if a PBDB reader cannot distinguish the
  PhyloPicMakie UUID/image workflow from the taxon-name workflow offered by
  PaleobiologyDB, or if the new route retains the obsolete
  `PaleobiologyDB.PhyloPicPBDB` name.
- Direct red-state repro: `docs/src/api/rendering.md`,
  `docs/src/how-to/thumbnail-gallery.md`, and public source docstrings refer
  to `PaleobiologyDB.PhyloPicPBDB`, while the current official PBDB rendering
  reference exposes `PaleobiologyDB.PBDBMakie`.
- Tasks that close it: 1, 3, and 4.
- Failing verification artifact: `rg -n
  'PaleobiologyDB\\.PhyloPicPBDB|PhyloPicPBDB' README.md docs src examples`
  must return no matches. The PBDB rendered-page review fails unless it links
  to the official reference, names `PaleobiologyDB.PBDBMakie`, states that
  PhyloPicMakie takes UUIDs or decoded images, and states that the PBDB surface
  handles the taxon-name workflow.

### Lock T6-05: Put both pages in the deliberate Diataxis map

- The work is not complete if the two new pages exist but a reader cannot find
  them from Documenter navigation, the documentation map, and their section
  indexes.
- Direct red-state repro: `docs/make.jl` currently lists neither page, and
  `docs/src/how-to/index.md` and `docs/src/explanation/index.md` have no links
  to them.
- Tasks that close it: 2, 3, and 4.
- Failing verification artifact: the docs build and rendered sidebar fail the
  omission; source inspection fails unless `docs/make.jl`, `docs/src/index.md`,
  `docs/src/how-to/index.md`, and `docs/src/explanation/index.md` contain the
  exact relative routes for their assigned page type.

### Lock T6-06: Retain the documentation-only and build-artifact boundary

- The work is not complete if this documentation tranche changes plotting,
  GraphMakie, PBDB, or PhyloPicDB implementation behavior, or adds a generated
  PNG as a source asset.
- Direct red-state repro: an apparent documentation improvement could replace
  the snapshot procedure with a new listener, add an external package
  dependency, change `augment_phylopic!`, or commit the rendered PNG.
- Tasks that close it: 1 through 4.
- Failing verification artifact: the final changed-file audit fails any file
  outside the named documentation text, named docstring/comment locations, and
  this tasking file; `git status --short` and `git diff --name-only` fail if a
  PNG under `docs/src/` or `examples/` is staged or modified.

## Forbidden passing implementation table

| Lock item | Required behavior | Current code state | Resolved implementation instruction | Forbidden passing implementation | Failing verification artifact |
| --- | --- | --- | --- | --- | --- |
| T6-01 | A reader can find and use a GraphMakie snapshot recipe from a goal-titled how-to. | `docs/src/examples.md` contains only the `graph_anchors.jl` command and a short note; no GraphMakie how-to file or sidebar route exists. | Create `docs/src/how-to/graphmakie-node-positions.md` with the exact title, then add its route in `docs/make.jl` and the named reader links in Task 2. | Add another example-gallery bullet or a generic GraphMakie paragraph without a how-to page. | The page-existence check, rendered heading review, and `docs/make.jl` sidebar inspection fail. |
| T6-02 | The how-to shows a one-time `graph_plot[:node_pos][]` coordinate snapshot and never promises ongoing layout tracking. | `examples/src/graph_anchors.jl` captures node positions once; the existing docs do not teach that sequence. | Use `graph_plot[:node_pos][]`, explicit coordinate vectors, and `augment_phylopic!` in the new page's plain UUID code fence; state that rerunning the sequence captures a revised layout. | Describe silhouettes as staying aligned while GraphMakie recalculates layout, or omit the snapshot expression. | The new-page audit for the snapshot expression and forbidden reactive terms fails; the GraphMakie PNG run verifies the local snapshot sequence. |
| T6-03 | The GraphMakie page begins from PhyloPic node UUIDs, not from the deterministic local matrices in the verification script. | `examples/src/graph_anchors.jl` builds `images` from local shape matrices so it can render without a live lookup. | Make the first executable block use `node_uuid = [...]` with the captured coordinates. Keep the deterministic script only as a linked runnable verification artifact. | Copy the script's `images` and local glyph factory into the first how-to recipe. | The first-block audit fails when it finds `glyph`, `cell_images`, an offline helper, or missing `node_uuid`. |
| T6-04 | PBDB readers see the current `PaleobiologyDB.PBDBMakie` route and understand that taxon-name resolution is outside PhyloPicMakie's direct input surface. | Existing Markdown and source docstrings name `PaleobiologyDB.PhyloPicPBDB`; the official PBDB reference names `PaleobiologyDB.PBDBMakie`. | Replace the named stale text in Task 1, then create `docs/src/explanation/paleobiologydb-workflows.md` and cross-link it in Task 3. | Add a new PBDB page while leaving old route names in existing user-facing text, or say PhyloPicMakie directly accepts PBDB taxon names. | The stale-name search and rendered-page comparison with the official PBDB reference fail. |
| T6-05 | Documenter navigation, the home map, and both section indexes expose the how-to and explanation in their appropriate Diataxis groups. | `docs/make.jl`, `docs/src/index.md`, `docs/src/how-to/index.md`, and `docs/src/explanation/index.md` omit both routes. | Add the GraphMakie page only to the "How-to guides" group and the PBDB page only to the "Explanation" group; add the exact relative links in the home and section indexes. | Create both files but rely on filename discovery, a prose mention, or an API page as their only route. | The docs build, rendered sidebar review, and source link inspection fail the missing route. |
| T6-06 | The result is documentation and documentation-fact maintenance only; PNGs remain temporary verification artifacts. | No GraphMakie or PBDB documentation page exists; a broad implementation change could falsely appear to make the docs simpler. | Limit source-file edits to the named docstrings/comments and Markdown/navigation edits to the named documentation files. Write the render only to `/tmp/graph_anchors-tranche6.png`. | Add a GraphMakie listener, alter a public method, add a dependency, edit CI, or commit a generated PNG. | Changed-file, diff, and Git-status audits expose every forbidden file or tracked artifact. |

## Handoff packet

- **Active authorities**: The user-supplied `devflow-feature-03--tranche-to-tasks`
  workflow, the parent PRD and tranche plan, the local governance list in
  this file, and the supplemental bundled governance corpus. `STYLE-agent-language.md`
  governs all responsibility and verification language.
- **Parent documents**: `.workflow-docs/202608140015_diataxis-docs-rewrite/01_prd.md`
  and `.workflow-docs/202608140015_diataxis-docs-rewrite/02_tranches.md`.
  The completed R1, Tranche 4, and Tranche 5 tasking files named under
  Governance provide the corrected first-learning policy and current page
  patterns. Do not execute superseded tasking files.
- **Settled decisions and non-negotiables**: The GraphMakie workflow is a
  single node-position snapshot. PhyloPic-backed UUID input is the normal
  reader path. The PBDB page is bounded explanation. `PBDBMakie` is the
  current official external route. DataCaches claims are outside this tranche
  except for existing links; do not expand them. Generated PNGs are build
  products only.
- **Authorization boundary**: The named Markdown, navigation, cross-links,
  source docstrings, and comments may change. Function bodies, exported API,
  dependencies, CI, the example script, GraphMakie internals, and
  PaleobiologyDB implementation may not change.
- **Current-state diagnosis**: The GraphMakie behavior has executable evidence
  but no task page. Existing PBDB text names an obsolete external surface.
  Both routes are absent from Documenter navigation and the documentation map.
- **Primary-goal lock**: T6-01 through T6-06 are separate completion gates;
  use the table and the direct red-state repros rather than treating a green
  docs build as sufficient evidence.
- **Named responsible entities and consumers**: `docs/make.jl` controls the
  sidebar consumed by rendered-doc readers. `docs/src/index.md`,
  `docs/src/how-to/index.md`, and `docs/src/explanation/index.md` expose reader
  routes and must not maintain divergent route inventories. The GraphMakie
  page explains the one-time coordinate hand-off consumed by a reader who
  calls `augment_phylopic!`; no docs page may construct a second tracking
  mechanism. The PBDB explanation routes taxon-name readers to the external
  official surface; PhyloPicMakie docs and docstrings must not retain a second
  stale external namespace. `examples/src/graph_anchors.jl` remains the only
  executable verification script for its deterministic local snapshot render.
- **Exact scope in**: Every file named in Tasks 1 through 3, ignored
  `docs/build/` output, and `/tmp/graph_anchors-tranche6.png`.
- **Exact scope out**: Every file and surface not named in Tasks 1 through 3,
  including `examples/src/graph_anchors.jl`, `Project.toml`,
  `docs/Project.toml`, `examples/Project.toml`, `.github/workflows/CI.yml`,
  all `test/` files, function bodies, and external repositories.
- **Required upstream primary sources**: The four URLs under Upstream primary
  sources and local sources under that section. Do not make a new GraphMakie
  claim that exceeds the local script without first reading the official
  GraphMakie source that establishes it.
- **Green-state gates**: The docs build passes; the CI-equivalent doctest
  command passes; the GraphMakie script writes a PNG recognized by `file`; the
  source and rendered-document audits close T6-01 through T6-06; the final
  diff is documentation-only.
- **Stop conditions**: Stop and escalate before changing an implementation or
  external behavior, before introducing a new GraphMakie claim not proven by
  the local script or official primary source, before asserting a new PBDB API
  not shown by the official reference, or when a governance authority conflicts
  with the tasking.

## Required revalidation before implementation

- Read the tranche plan and parent PRD in full.
- Read every authority and source listed under Governance and Upstream primary
  sources in full.
- Re-read the exact current source and documentation files named by the tasks.
- Confirm that `PaleobiologyDB.PBDBMakie` remains the public module named by
  the official rendering reference before replacing stale text.
- Confirm that `examples/src/graph_anchors.jl` still captures
  `graph_plot[:node_pos][]` exactly once and that no source has added a
  tracking implementation.
- Re-check `git status --short`, the docs build, and the GraphMakie temporary
  PNG command before editing. Stop and report any diagnosis that no longer
  matches this tasking.

## Tranche execution rule

Begin and end with a documentation-only green state. `docs/make.jl` remains
the only Documenter navigation declaration. `examples/src/graph_anchors.jl`
remains the single executable snapshot demonstration; the new Markdown page
may explain and link to it but may not absorb its deterministic image factory
or move example behavior into documentation checks. Documentation must adapt to
the current public API and external primary source; source code must not be
altered to satisfy stale prose.

## Non-negotiable execution rules

- Do not create a GraphMakie listener, observable callback, or reactive
  overlay behavior.
- Do not say that PhyloPicMakie directly resolves PBDB taxon names.
- Do not retain `PaleobiologyDB.PhyloPicPBDB` in reader-facing Markdown,
  source docstrings, or source comments after Task 1.
- Do not alter a function body, signature, return type, export, dependency,
  CI configuration, example-script behavior, or generated-asset policy.
- Do not make a live UUID example a Documenter `@example`, and do not commit
  generated images.
- Do not turn the PBDB explanation into a step-by-step guide, API catalog, or
  description of unpublished integration behavior.
- Do not replace page-level usability verification with only a source-text
  assertion. The rendered page, sidebar, docs build, and GraphMakie PNG remain
  required artifacts.

## Concrete anti-patterns and removal targets

- Remove the stale external namespace `PaleobiologyDB.PhyloPicPBDB` from the
  exact Markdown, docstring, and comment surfaces in Task 1; no compatibility
  wording, alias explanation, or second route may preserve it.
- Prevent the generic `p[:node_pos][]` examples-page notation from surviving;
  `docs/src/examples.md` must name the actual local variable
  `graph_plot[:node_pos][]` and link to the how-to.
- Prevent a GraphMakie page that begins with `glyph`, local matrix construction,
  `offline_silhouette`, or an equivalent fixture. The deterministic matrices
  remain inside the executable verification script only.
- Prevent a PBDB page that duplicates `docs/src/api/rendering.md` keyword
  documentation, claims a direct PhyloPicMakie taxon-name input, or creates a
  local adapter to the external package.
- Prevent navigation drift by keeping each route in the Documenter `pages`
  list and in the appropriate index; do not add a second manually maintained
  page inventory elsewhere.

## Failure-oriented verification

- Run `julia --project=docs docs/make.jl`. This runs the docs build and must
  render both new routes.
- Run the CI-equivalent doctest command:

  ```sh
  julia --project=docs -e 'using Documenter: DocMeta, doctest; using PhyloPicMakie; DocMeta.setdocmeta!(PhyloPicMakie, :DocTestSetup, :(using PhyloPicMakie); recursive=true); doctest(PhyloPicMakie)'
  ```

- Run `julia --project=examples examples/src/graph_anchors.jl
  /tmp/graph_anchors-tranche6.png`, then run
  `file /tmp/graph_anchors-tranche6.png`. The file must exist and be identified
  as PNG data.
- Confirm `docs/build/how-to/graphmakie-node-positions/index.html` and
  `docs/build/explanation/paleobiologydb-workflows/index.html` exist after the
  docs build. Read both rendered pages and the rendered sidebar.
- Run the stale-namespace search from T6-04 and require its normal no-match
  exit status. Inspect every replacement against the official PBDB reference.
- Audit the GraphMakie page's first executable block and confirm the required
  UUID and snapshot expressions plus the forbidden fixture and tracking terms
  specified in T6-02 and T6-03.
- Inspect the final diff and Git status. The repository must contain no tracked
  PNG and no implementation, dependency, CI, or external-package change.

## Tasks

### 1. Correct stale PBDB route facts in existing documentation surfaces

**Type**: WRITE
**Output**: Existing reader-facing Markdown, source docstrings, and comments name the current `PaleobiologyDB.PBDBMakie` taxon-name route and no longer name `PhyloPicPBDB`.
**Depends on**: none
**Positive contract**: `docs/src/how-to/thumbnail-gallery.md` and the named source docstrings direct a taxon-name reader to the official PBDB rendering reference while preserving the explicit distinction that PhyloPicMakie consumes PhyloPic node UUIDs or decoded images.
**Negative contract**: No `PaleobiologyDB.PhyloPicPBDB` text, compatibility alias, source-level behavior change, dependency addition, or claim that PhyloPicMakie itself accepts taxon names may survive.
**Files**: `docs/src/api/rendering.md`; `docs/src/how-to/thumbnail-gallery.md`; `src/PhyloPicMakie.jl`; `src/_augment_api.jl`; `src/_render_core.jl`; `src/_thumbnail_grid.jl`; `src/_node_thumbnail_grid.jl`.
**Out of scope**: Every function body and signature in the named source files; all navigation files and the new explanation route, which Tasks 2 and 3 change; `examples/src/graph_anchors.jl`; every dependency, test, workflow, and generated image.
**Verification**: The stale-namespace search in T6-04 returns no matches across `README.md`, `docs`, `src`, and `examples`; each named documentation sentence agrees with the official PBDB rendering reference; `julia --project=docs docs/make.jl` passes.

Replace the exact `PhyloPicPBDB` mentions in the listed files with
`PaleobiologyDB.PBDBMakie` and retain the existing official rendering-reference
URL. In `docs/src/api/rendering.md`, retain the existing direct UUID guidance
and replace only the external-route text; Task 3 adds its explanation-page
cross-link. Update prose, docstrings, and explanatory comments only. In
`src/_augment_api.jl` and `src/_render_core.jl`, retain the fact that
`augment_phylopic!` is PhyloPic-native and accepts UUIDs or decoded images; the
replacement text routes taxon-name readers outward rather than widening the
local public API. In `src/_thumbnail_grid.jl` and
`src/_node_thumbnail_grid.jl`, retain the distinction between pre-resolved
cells, UUID-backed gallery calls, and external taxon-name resolution. Do not
modify the current direct-gallery and cache behavior described by those files.

### 2. Add the PhyloPic-backed GraphMakie snapshot how-to and its reader routes

**Type**: WRITE
**Output**: A rendered, goal-oriented GraphMakie how-to teaches the one-time node-position snapshot sequence, starts with `node_uuid`, and is reachable from the sidebar, documentation map, how-to index, examples page, and rendering reference.
**Depends on**: 1
**Positive contract**: `docs/src/how-to/graphmakie-node-positions.md` contains a plain UUID-first code fence that materializes `graph_plot`, calls `CairoMakie.Makie.update_state_before_display!(fig)`, captures `graph_plot[:node_pos][]`, derives explicit coordinate vectors, calls `augment_phylopic!` with `node_uuid`, and tells a reader to rerun the sequence after changing the graph layout. Every named reader route links to the page.
**Negative contract**: The first executable block must not use a local glyph matrix, `cell_images`, `offline_silhouette`, a preloaded-image phrase, a Documenter `@example`, a GraphMakie observer, or tracking language. The task must not change `examples/src/graph_anchors.jl`, add GraphMakie behavior, or copy the complete `augment_phylopic!` keyword catalog.
**Files**: `docs/src/how-to/graphmakie-node-positions.md`; `docs/make.jl`; `docs/src/index.md`; `docs/src/how-to/index.md`; `docs/src/examples.md`; `docs/src/api/rendering.md`.
**Out of scope**: `README.md`; `docs/src/explanation/`; every source file; `examples/src/graph_anchors.jl`; `Project.toml`; `docs/Project.toml`; `examples/Project.toml`; tests; CI; generated PNG files.
**Verification**: `test -f docs/build/how-to/graphmakie-node-positions/index.html` after a successful docs build; the target page source contains `graph_plot[:node_pos][]` and `node_uuid`; the first executable block contains none of `glyph`, `cell_images`, `offline_silhouette`, or `@example`; the target page contains no `reactive`, `Observable`, `listener`, or automatic-tracking language; the GraphMakie command creates `/tmp/graph_anchors-tranche6.png` recognized as PNG data.

Create the page with the established `@meta CurrentModule = PhyloPicMakie`
block and the exact sentence-case title. Begin with the figure-level result,
then give the compact sequence that snapshots a materialized graph plot and
places PhyloPic silhouettes at the captured coordinates. The code fence uses
ordinary Julia Markdown because its UUID lookup is network-sensitive. It
derives `xs` and `ys` directly from the captured points rather than importing
the private `point_components` helper from the example script. Add an expected
result stating that the silhouettes use the positions captured by that run; a
revised graph layout requires rerunning the capture and placement sequence.
Link to `examples.md`, `api/rendering.md`, and the how-to index for adjacent
reader routes. Add the exact relative links in the named map, index, example,
and API pages. In `docs/make.jl`, place this route only under "How-to guides"
with the title "Place silhouettes on GraphMakie node-position snapshots."

### 3. Add the bounded PaleobiologyDB explanation and complete the Diataxis map

**Type**: WRITE
**Output**: A rendered explanation page routes PBDB taxon-name readers to the current official PBDBMakie surface and is visible from the explanation group, home map, rendering reference, and related GraphMakie and gallery routes.
**Depends on**: 1 and 2
**Positive contract**: `docs/src/explanation/paleobiologydb-workflows.md` names `PaleobiologyDB.PBDBMakie`, links to the official rendering reference, clearly separates the UUID/decoded-image PhyloPicMakie path from the PBDB taxon-name path, and provides concise conceptual context without changing any package behavior. Documenter navigation lists it only under "Explanation."
**Negative contract**: The page must not contain a PBDB code tutorial, an API keyword table, a second local integration implementation, the obsolete `PhyloPicPBDB` name, a claim that PhyloPicMakie directly takes taxon names, or a new DataCaches claim. The task must not modify function code, the GraphMakie script, dependencies, CI, or generated assets.
**Files**: `docs/src/explanation/paleobiologydb-workflows.md`; `docs/make.jl`; `docs/src/index.md`; `docs/src/explanation/index.md`; `docs/src/api/rendering.md`; `docs/src/how-to/graphmakie-node-positions.md`; `docs/src/how-to/thumbnail-gallery.md`.
**Out of scope**: Every `src/` file after Task 1; every example script; `README.md`; all project and manifest files; tests; CI; local PBDB implementation; PNG output.
**Verification**: `test -f docs/build/explanation/paleobiologydb-workflows/index.html` after a successful docs build; the page source contains `PaleobiologyDB.PBDBMakie` and the official URL; the stale-namespace search returns no matches; the rendered sidebar shows the page in "Explanation" and the GraphMakie page in "How-to guides"; rendered-page review confirms each page retains its assigned Diataxis role.

Create the page with the established `@meta` block and the exact sentence-case
title. Its first paragraph explains the reader-facing choice between existing
UUID/image data and a PBDB taxon-name starting point. Connect that choice to
the two packages without describing private call chains or giving an API
catalog. Link to the official PBDB rendering reference and to the local
rendering reference, UUID gallery guide, and GraphMakie snapshot guide. Add
the page to the Explanation group in `docs/make.jl`, the explanation index,
and the home map. Add one concise PBDB-explanation link from the rendering
reference and reciprocal cross-links from the GraphMakie and gallery guides.
Keep navigation facts synchronized across every file named in this task.

### 4. Verify rendered routes, external-route accuracy, and the artifact boundary

**Type**: TEST
**Output**: A recorded green verification pass proves all six locks, including both rendered pages, the GraphMakie PNG artifact, the external-route correction, and the documentation-only diff.
**Depends on**: 1, 2, and 3
**Positive contract**: The docs build and CI-equivalent doctest gate pass; both HTML routes and the GraphMakie temporary PNG exist; the new pages are readable from the correct sidebar groups; every audit in Failure-oriented verification succeeds.
**Negative contract**: A green build alone is insufficient. Do not accept a page that omits the snapshot code, uses local matrices as its primary recipe, retains a stale PBDB name, places either page in the wrong Diataxis group, claims tracking behavior, or changes implementation or generated-source assets.
**Files**: No tracked files. The only permitted generated files are ignored `docs/build/` content and `/tmp/graph_anchors-tranche6.png`.
**Out of scope**: Any remediation edit. Return to the owning WRITE task for every failed gate; do not fix a failure by weakening an audit, changing CI, or adding an exception.
**Verification**: Run every command and inspection in Failure-oriented verification, then inspect `git diff --check`, `git diff --name-only`, and `git status --short` against T6-06.

Run the docs build, the CI-equivalent doctest command, and the GraphMakie
example command exactly as stated above. Confirm both rendered HTML locations
and review the rendered pages together with the sidebar. Compare the PBDB
route text with the official upstream rendering reference, not with the
superseded workflow wording. Audit the GraphMakie first code block for the
UUID-first and one-time-snapshot requirements. Finish by checking the changed
file list against Tasks 1 through 3 and verifying that no generated image is
tracked. Record the exact failing command or inspection for any red result and
return to the task that names the responsible file.
