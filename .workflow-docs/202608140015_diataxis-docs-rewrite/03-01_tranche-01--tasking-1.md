---
date-created: 2026-08-15T20:01:53-07:00
workflow-instrument: Tasking plan
workflow-status: Approved
workflow-agent-thread-id: codex/01a0087f-f87d-7e83-80ba-3f7e605ea267
workflow-agent-implementing-id:
  - codex/01a008a3-8d6f-7953-acf1-4c115c163051
workflow-location: /home/jeetsukumaran/site/storage/local/computing/research/20260414_PhyloPicMakie.jl/PhyloPicMakie.jl
workflow-production-id: diataxis-docs-primer
workflow-prd: .workflow-docs/202608140015_diataxis-docs-rewrite/01_prd.md
workflow-tranche: .workflow-docs/202608140015_diataxis-docs-rewrite/02_tranches.md
---

# Tasks for tranche 1: Establish the documentation map

## Supersession note: 2026-08-16 owner correction

This approved and implemented tasking file is archival. It predates the project owner's 2026-08-16 correction that the normal documentation trajectory must start from PhyloPic identifiers, taxon-derived identifiers, or package-supported PhyloPic lookup, not from local image matrices.

Any instruction in this file that treats an offline-capable local image path, preloaded image matrices, or live PhyloPic node UUID examples as out of scope for the required reader path is superseded by `.workflow-docs/202608140015_diataxis-docs-rewrite/02_tranches.md` Tranche R1 and the revised PRD. Future agents must not reuse that stale premise when changing `README.md`, `docs/src/index.md`, route pages, primer, tutorial, or how-to navigation.

This file also predates the repo-local `STYLE-agent-language.md` update. Any
instruction below that uses ownership, contract, boundary, layer, invariant,
compatibility, verification, source, or responsibility language is not
executable unless Tranche R1 or a regenerated tasking file expands it with the
exact file, function, module, public surface, or external contract; the
behavior; the consumer; the duplicate or bypass path that must not keep the
behavior; and the verification artifact that fails the vague statement.

## Settled user decisions and environment baseline

- Treat this as a documentation feature. No public API behavior, exported name, plotting semantic, example-script behavior, dependency, CI, or network-behavior change is authorized in this tranche.
- The documentation must follow Diataxis. Tranche 1 establishes the rendered navigation and reader map before later tranches write the full primer, tutorial, how-to guides, explanation pages, and reference reorganization.
- `docs/make.jl` is the single authoritative implementation for rendered Documenter navigation through the `pages` keyword.
- `docs/src/index.md` is the reader-facing documentation map and table of contents.
- `README.md` is the repository-level first contact.
- Generated PNG files are build products and verification artifacts. This tranche must not add committed PNG assets.
- The required learning path remains offline-capable. Live PhyloPic node UUID examples remain out of scope for tranche 1.
- Minimal route pages may be created for navigation, but they must be honest gateway pages. They must not claim that later primer, tutorial, how-to, or explanation content already exists.
- The tasking agent verified `CODEX_THREAD_ID=01a0087f-f87d-7e83-80ba-3f7e605ea267`; downstream workflow documents in this thread must use `codex/01a0087f-f87d-7e83-80ba-3f7e605ea267`.
- No exact public inference, typed-return, migration, or schema guarantee is part of this tranche.

## Governance

Before implementation, read these governance documents line by line and comply with them throughout the work:

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

Expected governance files not found during tasking:

- Repo-local `CONTRIBUTING*.md`.
- Repo-local `STYLE-python.md`.
- Repo-local `STYLE-domain-vocabulary.md`.

Read-only git and shell commands may be used freely. Mutating git operations such as commit, merge, push, branch, checkout, rebase, and reset remain the human project owner's responsibility unless the user explicitly instructs otherwise.

## Upstream primary sources and settled contract conclusions

Read these upstream primary sources before implementation because they constrain the navigation design:

- Diataxis home: https://diataxis.fr/.
- Diataxis start page: https://diataxis.fr/start-here/.
- Diataxis applying guide: https://diataxis.fr/application/.
- Diataxis tutorials: https://diataxis.fr/tutorials/.
- Diataxis how-to guides: https://diataxis.fr/how-to-guides/.
- Diataxis reference: https://diataxis.fr/reference/.
- Diataxis explanation: https://diataxis.fr/explanation/.
- Documenter public API for `makedocs`, `pages`, `doctest`, `checkdocs`, `pagesonly`, and build behavior: https://documenter.juliadocs.org/stable/lib/public/.
- Documenter guide for documentation structure and sidebar behavior: https://documenter.juliadocs.org/stable/man/guide/.
- Documenter syntax for `@contents`, `@index`, `@example`, `@setup`, and output behavior: https://documenter.juliadocs.org/stable/man/syntax/.

Tasking conclusions from those sources:

- Diataxis requires separate reader paths for tutorial, how-to guide, reference, and explanation needs. The navigation must make those paths visible instead of grouping everything as Home, Examples, and API Reference.
- Tutorial and how-to content is not complete in tranche 1. Route pages must therefore identify the route honestly and point to existing material without pretending that later content has been written.
- Reference content stays under API reference. Tranche 1 may link to existing API pages, but it must not move tutorial or how-to teaching burden into API reference pages.
- Documenter's `pages` keyword is the verified owner for sidebar order and grouping. Tranche 1 must update `docs/make.jl` directly rather than relying on file ordering.
- Documenter processes all Markdown files by default even when `pages` is present. Tranche 1 must list the new route pages in `pages` and must not set `pagesonly=true` or use `hide` to make weak navigation appear complete.
- The docs home should use an explicit reader map with meaningful links. Do not rely on `@index` as the home-page table of contents, because `@index` lists API docs spliced through `@docs` blocks rather than reader paths.

## Primary-goal lock

### Lock 1: Reader-centered first contact

- The work is not complete if `README.md`, `docs/src/index.md`, or the first rendered documentation page leads with internal implementation language instead of a reader-visible outcome.
- Direct red-state repro: `README.md` currently opens with "shared internal anchored-overlay substrate"; `docs/src/index.md` currently says the package owns a "generic anchored-overlay foundation" and "owner layer".
- Tasks that close it: tasks 3, 4, and 5.
- Verification artifact that must fail the old implementation or forbidden passing implementation: source-text audit of `README.md`, `docs/src/index.md`, `docs/src/primer.md`, `docs/src/tutorial.md`, `docs/src/how-to/index.md`, and `docs/src/explanation/index.md` for forbidden first-contact phrases, plus rendered home-page review after `julia --project=docs docs/make.jl`.

### Lock 2: Diataxis navigation and top-down map

- The work is not complete if `docs/make.jl` still exposes only Home, Examples, and API Reference, or if `docs/src/index.md` does not mirror the top-down reader map.
- Direct red-state repro: `docs/make.jl` currently defines only `"Home" => "index.md"`, `"Examples" => "examples.md"`, and `"API Reference" => [...]` under `pages`.
- Tasks that close it: tasks 1, 2, 3, and 5.
- Verification artifact that must fail the old implementation or forbidden passing implementation: inspection of `docs/make.jl` must show the exact navigation groups `Start here`, `Primer and tutorial`, `How-to guides`, `Explanation`, `API reference`, and `Examples`; rendered sidebar review must show those routes.

### Lock 3: Minimal route pages are honest gateways

- The work is not complete if route pages are absent, empty, labeled as TODO, or written as if the full primer, tutorial, how-to, or explanation content already exists.
- Direct red-state repro: `docs/src/` currently contains only `index.md`, `examples.md`, and API pages; no primer, tutorial, how-to overview, or explanation overview route exists.
- Tasks that close it: tasks 1, 2, 3, and 5.
- Verification artifact that must fail the old implementation or forbidden passing implementation: file-existence check for `docs/src/primer.md`, `docs/src/tutorial.md`, `docs/src/how-to/index.md`, and `docs/src/explanation/index.md`, plus source-text audit that those pages contain no `TODO`, `TBD`, or "coming soon" placeholder labels and no claim of complete later-tranche content.

### Lock 4: Documentation-only authorization boundary

- The work is not complete if tranche 1 changes public API behavior, exported names, plotting behavior, live-network behavior, example-script behavior, CI behavior, package environments, or generated image assets.
- Direct red-state repro: the PRD states that proposed docs tranches must not change implementation to make explanation easier; this tranche's handoff limits scope to `README.md`, `docs/make.jl`, `docs/src/index.md`, and required route pages.
- Tasks that close it: task 5, with task-level scope limits on tasks 1 through 4.
- Verification artifact that must fail the old implementation or forbidden passing implementation: `git status --short -- README.md docs/make.jl docs/src src test examples .github docs/Project.toml examples/Project.toml` must show changes only in the allowed documentation files for this tranche.

### Lock 5: Governance and vocabulary compliance

- The work is not complete if new documentation violates `STYLE-docs.md`, `STYLE-writing.md`, `STYLE-vocabulary.md`, `STYLE-workflow-docs.md`, `STYLE-agent-handoffs.md`, `STYLE-workflow-vocabulary.md`, or `STYLE-agent-language.md`.
- Direct red-state repro: current first-contact prose uses internal terms such as "owner layer" and "anchored-overlay substrate" before reader-facing purpose; current `docs/src/index.md` uses a reference-style `@index` as the only generated index.
- Tasks that close it: tasks 1 through 5.
- Verification artifact that must fail the old implementation or forbidden passing implementation: source audit for forbidden phrases, sentence-case heading review, code-font review that ordinary reader-facing terms are not wrapped in code font, and task 5's rendered-documentation review.

## Forbidden passing implementation table

| Lock item | Required behavior | Current code state | Resolved implementation instruction | Forbidden passing implementation | Failing verification artifact |
| --- | --- | --- | --- | --- | --- |
| Lock 1: Reader-centered first contact | `README.md`, `docs/src/index.md`, and the first rendered docs page open with what users can make with PhyloPic silhouettes in Makie figures, then point to the docs map. | `README.md` lines 8-14 describe a shared internal anchored-overlay substrate. `docs/src/index.md` lines 9-14 describe a generic anchored-overlay foundation and owner layer. | Task 3 rewrites `docs/src/index.md` with the headings `What you can make`, `What data you need`, `Where to go next`, and `Documentation map`. Task 4 rewrites the README opening so the first prose after badges is a plain-language package purpose and docs path. | Delete the exact bad paragraph but replace it with different implementation-first wording such as "projection plumbing", "placement mechanics", or "internal owner" before showing a reader-visible result. | `rg -n "generic anchored-overlay|shared internal anchored-overlay substrate|owner layer|data-anchor|projected pixel-anchor|placement mechanics|projection mechanics|internal owner" README.md docs/src/index.md docs/src/primer.md docs/src/tutorial.md docs/src/how-to/index.md docs/src/explanation/index.md` must return no matches; rendered home-page review must show user-visible purpose before implementation language. |
| Lock 2: Diataxis navigation and top-down map | `docs/make.jl` explicitly defines a top-down Documenter sidebar with Start here, Primer and tutorial, How-to guides, Explanation, API reference, and Examples. `docs/src/index.md` mirrors that map. | `docs/make.jl` lines 15-23 define only Home, Examples, and API Reference. | Task 2 replaces the `pages` vector with the exact group labels and route files specified in that task. Task 3 mirrors those labels and routes on the home page. | Add prose links to `docs/src/index.md` while leaving `docs/make.jl` with only Home, Examples, and API Reference, or add route files but rely on filename ordering instead of `pages`. | `rg -n '"Start here" => "index.md"|"Primer and tutorial" =>|"How-to guides" =>|"Explanation" =>|"API reference" =>' docs/make.jl` must show all required labels; `rg -n '"Home" => "index.md"|"API Reference"' docs/make.jl` must return no matches; rendered sidebar review must show the required groups. |
| Lock 3: Minimal route pages are honest gateways | The new route pages exist and honestly identify their Diataxis route without pretending later pages have been completed. | `find docs/src -maxdepth 3 -type f -print` currently lists only `docs/src/index.md`, `docs/src/examples.md`, `docs/src/api/rendering.md`, and `docs/src/api/phylopic_db.md`. | Task 1 creates only `docs/src/primer.md`, `docs/src/tutorial.md`, `docs/src/how-to/index.md`, and `docs/src/explanation/index.md`, each with a sentence-case H1, existing `@meta` pattern, route purpose, links to current docs/examples/API pages, and no full later-tranche tutorial/how-to/reference content. | Create empty files, TODO pages, or full-looking pages that contain headings for all required later how-tos without runnable content or verification. | `test -f docs/src/primer.md && test -f docs/src/tutorial.md && test -f docs/src/how-to/index.md && test -f docs/src/explanation/index.md`; `rg -n "TODO|TBD|coming soon|complete tutorial|complete how-to|full guide" docs/src/primer.md docs/src/tutorial.md docs/src/how-to/index.md docs/src/explanation/index.md` must return no matches. |
| Lock 4: Documentation-only authorization boundary | The tranche changes only the allowed documentation files and creates only the allowed route pages. | The tranche plan authorizes `README.md`, `docs/make.jl`, `docs/src/index.md`, and route pages needed for navigation; it explicitly excludes `src/`, `test/`, public API behavior, example script behavior, and CI behavior. | Tasks 1 through 4 name exact allowed files. Task 5 performs the diff audit and sends any required correction back to the task responsible for the allowed file. | Modify `src/`, example scripts, `.github/workflows/CI.yml`, `docs/Project.toml`, or generated PNG assets to make the docs build or narrative easier. | `git status --short -- README.md docs/make.jl docs/src src test examples .github docs/Project.toml examples/Project.toml` must show changes only to `README.md`, `docs/make.jl`, `docs/src/index.md`, `docs/src/primer.md`, `docs/src/tutorial.md`, `docs/src/how-to/index.md`, and `docs/src/explanation/index.md`. |
| Lock 5: Governance and vocabulary compliance | New docs use sentence-case headings, direct neutral prose, correct project vocabulary, and code font only for exact syntax. | Current first-contact prose uses internal owner/mechanics terms; current home page has `## Quick Index` and `@index`, which does not provide a reader-path map. | Tasks 1, 3, and 4 require sentence-case headings and user-facing terminology; Task 3 removes the `Quick Index`/`@index` home-page pattern and replaces it with a manual reader map. | Pass docs build while leaving title-case headings, rhetorical headings, ordinary prose terms in code font, or an API index as the home-page map. | Manual governance review of changed Markdown, `rg -n "^## Quick Index|```@index" docs/src/index.md` must return no matches, and the forbidden-phrase audit in task 5 must pass. |

## Handoff packet

- **Active authorities**: Parent PRD, parent tranche plan, this tasking file, repo-local governance files listed in Governance, and repo-local `STYLE-agent-language.md`, `STYLE-agent-handoffs.md`, and `STYLE-workflow-vocabulary.md`.
- **Parent documents**: `.workflow-docs/202608140015_diataxis-docs-rewrite/01_prd.md`; `.workflow-docs/202608140015_diataxis-docs-rewrite/02_tranches.md`.
- **Settled decisions and non-negotiables**: Diataxis structure is required; `docs/make.jl` defines rendered navigation through Documenter `pages`; `docs/src/index.md` provides the reader map; `README.md` provides repository first contact; public API and plotting behavior must not change; generated PNGs remain build products; live network examples are out of scope.
- **Authorization boundary**: In scope: `README.md`, `docs/make.jl`, `docs/src/index.md`, and exactly four route pages: `docs/src/primer.md`, `docs/src/tutorial.md`, `docs/src/how-to/index.md`, and `docs/src/explanation/index.md`. Out of scope: `src/`, `test/`, `.github/workflows/CI.yml`, `docs/Project.toml`, `examples/Project.toml`, `examples/src/`, `examples/README.md`, generated PNG files, public API behavior, plotting behavior, and live network behavior.
- **Current-state diagnosis**: `docs/make.jl` has only Home, Examples, and API Reference. `README.md` and `docs/src/index.md` foreground internal overlay mechanics. `docs/src/` lacks route pages for primer, tutorial, how-to guides, and explanation.
- **Primary-goal lock**: Lock items 1 through 5 in this tasking file.
- **Direct red-state repros**: inspect `README.md`, `docs/src/index.md`, and `docs/make.jl`; run the forbidden-phrase audit in task 5; inspect `docs/src/` route-file absence.
- **Named responsible entities and required behavior**: `docs/make.jl` defines the Documenter `pages` sidebar consumed by rendered docs; no Markdown-only route list may replace it, and docs build plus rendered sidebar review fail missing routes. `docs/src/index.md` provides the reader-facing map consumed by the docs home page; route pages and README links may point to it, but no other page may define a conflicting table of contents, and source plus rendered review fail inconsistency. `README.md` provides repository first contact consumed by package visitors before they open the docs; docs route pages must not duplicate the README synopsis as their full body, and README opening review fails implementation-first prose.
- **Exact files in scope**: `README.md`; `docs/make.jl`; `docs/src/index.md`; `docs/src/primer.md`; `docs/src/tutorial.md`; `docs/src/how-to/index.md`; `docs/src/explanation/index.md`.
- **Exact files and surfaces out of scope**: `src/`; `test/`; `.github/workflows/CI.yml`; `docs/Project.toml`; `examples/Project.toml`; `examples/src/`; `examples/README.md`; generated image files; public API signatures; exported names; plotting behavior; live network behavior.
- **Required upstream primary sources**: Diataxis and Documenter URLs listed above.
- **Green-state gates**: `julia --project=docs docs/make.jl`; CI-style doctest command from task 5; forbidden-phrase source audit; route-file existence and honesty audit; rendered home-page/sidebar review; diff audit for documentation-only boundary.
- **Stop conditions**: Stop if the navigation requires a public API or plotting behavior change; stop if a route page needs full later-tranche content to be honest; stop if Documenter behavior needed by the implementation conflicts with the upstream sources listed here; stop if the required diff would touch out-of-scope files.

## Required revalidation before implementation

- Read the parent PRD, parent tranche plan, and this tasking file in full.
- Read all governance documents listed in Governance line by line.
- Read the cited Diataxis and Documenter upstream primary sources in full where they constrain this tranche.
- Read `README.md`, `docs/make.jl`, `docs/src/index.md`, `docs/src/examples.md`, `docs/src/api/rendering.md`, and `docs/src/api/phylopic_db.md` in full before changing documentation.
- Re-run the direct red-state inspections before editing.
- If the current repository already satisfies a lock item, preserve that state and complete the remaining lock items without regressing it.
- If current code differs materially from this diagnosis, stop and update the tasking or ask the project owner for direction before implementation.

## Tranche execution rule

The work may reorganize documentation files named in scope, but it must begin and end with a green documentation build and the existing doctest gate intact. This tranche is not authorized to change public API behavior, plotting behavior, package environments, CI behavior, example scripts, or live network behavior.

For this documentation-map tranche:

- `docs/make.jl` must stop exposing only Home, Examples, and API Reference.
- `docs/src/index.md` must stop using internal-mechanics prose and `@index` as the first-contact map.
- `README.md` must stop using implementation-substrate prose as the repository synopsis.
- Route pages must not become second implementations of later tranches. They are honest navigation targets only.

## Non-negotiable execution rules

- Do not edit `src/`, `test/`, `.github/workflows/CI.yml`, `docs/Project.toml`, `examples/Project.toml`, `examples/src/`, or `examples/README.md` in this tranche.
- Do not change exported names, signatures, keyword meanings, return values, errors, plotting behavior, or network behavior.
- Do not set `pagesonly=true` or use `hide` in `docs/make.jl` as a way to make incomplete navigation appear complete.
- Do not commit generated PNG files or other generated docs build output as source documentation assets.
- Do not replace the bad first-contact prose with different internal-first prose.
- Do not write full tutorial, how-to, reference, or live UUID content in this tranche.
- Do not add CI text checks, source-text policing tests, or YAML policing. The text audits in this tasking are implementation-session verification artifacts, not new product logic.
- Do not use `@index` as the home-page table of contents.

## Concrete anti-patterns or removal targets

- Remove first-contact prose in `README.md` that leads with `shared internal anchored-overlay substrate` and related projection-mechanics language.
- Remove first-contact prose in `docs/src/index.md` that leads with `generic anchored-overlay foundation`, `owner layer`, `data-anchor`, `projected pixel-anchor`, or equivalent internal-mechanics language.
- Remove the Home/Examples/API-only navigation shape from `docs/make.jl`.
- Remove the `Quick Index`/`@index` pattern from `docs/src/index.md` as the home-page map.
- Prevent empty TODO route pages, route pages that claim full later-tranche content, and route pages that only exist to satisfy `docs/make.jl`.

## Failure-oriented verification

These checks must fail the old implementation or the forbidden passing implementations listed above:

- `rg -n "generic anchored-overlay|shared internal anchored-overlay substrate|owner layer|data-anchor|projected pixel-anchor|placement mechanics|projection mechanics|internal owner" README.md docs/src/index.md docs/src/primer.md docs/src/tutorial.md docs/src/how-to/index.md docs/src/explanation/index.md`.
- `rg -n '"Home" => "index.md"|"API Reference"' docs/make.jl`.
- `rg -n "^## Quick Index|```@index" docs/src/index.md`.
- `test -f docs/src/primer.md && test -f docs/src/tutorial.md && test -f docs/src/how-to/index.md && test -f docs/src/explanation/index.md`.
- `rg -n "TODO|TBD|coming soon|complete tutorial|complete how-to|full guide" docs/src/primer.md docs/src/tutorial.md docs/src/how-to/index.md docs/src/explanation/index.md`.
- `git status --short -- README.md docs/make.jl docs/src src test examples .github docs/Project.toml examples/Project.toml`.

Positive verification must also prove the simplified result is good:

- The rendered home page states what a reader can make with PhyloPicMakie before any implementation details.
- The rendered sidebar shows the top-down routes Start here, Primer and tutorial, How-to guides, Explanation, API reference, and Examples.
- The home page links to the new route pages and tells readers which route to use for learning, task solving, reference lookup, concepts, and examples.

## Tasks

### 1. Create honest route pages

**Type**: WRITE  
**Output**: Four minimal route pages exist and build as honest navigation targets.  
**Depends on**: none.  
**Positive contract**: `docs/src/primer.md`, `docs/src/tutorial.md`, `docs/src/how-to/index.md`, and `docs/src/explanation/index.md` exist, use the existing Documenter `@meta CurrentModule = PhyloPicMakie` pattern, have sentence-case H1 headings, state their Diataxis route, and link to current useful material without claiming later content is complete.  
**Negative contract**: No route page may be empty, labeled TODO, labeled "coming soon", filled with internal implementation mechanics, or written as a complete primer/tutorial/how-to/explanation page. No route page may duplicate API parameter catalogs or example-script command lists as a fake substitute for later tranches.  
**Files**: `docs/src/primer.md`; `docs/src/tutorial.md`; `docs/src/how-to/index.md`; `docs/src/explanation/index.md`.  
**Out of scope**: `docs/make.jl`; `docs/src/index.md`; `README.md`; `docs/src/examples.md`; `docs/src/api/rendering.md`; `docs/src/api/phylopic_db.md`; `examples/`; `src/`; `test/`; `.github/workflows/CI.yml`; package environment files.  
**Verification**: `test -f docs/src/primer.md && test -f docs/src/tutorial.md && test -f docs/src/how-to/index.md && test -f docs/src/explanation/index.md`; `rg -n "TODO|TBD|coming soon|complete tutorial|complete how-to|full guide" docs/src/primer.md docs/src/tutorial.md docs/src/how-to/index.md docs/src/explanation/index.md` returns no matches; `rg -n "generic anchored-overlay|owner layer|data-anchor|projected pixel-anchor|placement mechanics" docs/src/primer.md docs/src/tutorial.md docs/src/how-to/index.md docs/src/explanation/index.md` returns no matches.

Create the four route pages. Use these exact H1 headings: `Place silhouettes in Makie figures`, `Make your first silhouette-annotated figure`, `How-to guides`, and `Concepts`. Each page should contain a short route description and links to existing pages that are true today: the examples page for runnable scripts, the rendering API page for exact API facts, and the home page for the map. State that the page is the route for the later full content without using placeholder labels. Keep the prose reader-facing: silhouettes, Makie figures, coordinates, ranges, galleries, image matrices, saved figures, and examples are allowed reader terms. The internal substrate terms listed in the verification command are forbidden on these route pages.

### 2. Replace Documenter navigation with the Diataxis map

**Type**: WRITE  
**Output**: `docs/make.jl` defines the rendered navigation through the top-down Diataxis route map.  
**Depends on**: task 1.  
**Positive contract**: The `pages` vector in `docs/make.jl` lists the rendered navigation in this exact order: `Start here` mapped to `index.md`; `Primer and tutorial` containing `Primer` mapped to `primer.md` and `Tutorial` mapped to `tutorial.md`; `How-to guides` containing `Overview` mapped to `how-to/index.md`; `Explanation` containing `Concepts` mapped to `explanation/index.md`; `API reference` containing `Rendering` and `PhyloPicDB`; `Examples` mapped to `examples.md`.  
**Negative contract**: The old `Home`, `Examples`, and `API Reference`-only structure must not survive. The implementation must not rely on file ordering, `hide`, or `pagesonly=true` to make the sidebar appear complete. The implementation must not change `deploydocs`, `format`, `modules`, `authors`, `sitename`, assets, or doctest setup.  
**Files**: `docs/make.jl`.  
**Out of scope**: `README.md`; all Markdown files under `docs/src/`; `docs/Project.toml`; `.github/workflows/CI.yml`; `examples/`; `src/`; `test/`.  
**Verification**: `rg -n '"Start here" => "index.md"|"Primer and tutorial" =>|"How-to guides" =>|"Explanation" =>|"API reference" =>' docs/make.jl` shows all required labels; `rg -n '"Home" => "index.md"|"API Reference"|pagesonly|hide\(' docs/make.jl` returns no matches.

Edit only the `pages` keyword argument in `docs/make.jl`. Keep the existing `using`, `DocMeta.setdocmeta!`, `makedocs` metadata, `format`, and `deploydocs` settings unchanged. The Documenter public API verifies that `pages` controls hierarchical navigation and order, so `docs/make.jl` is the file that must change for this tranche. Use sentence-case labels exactly as listed in the positive contract, with `PhyloPicDB` preserving the module's proper-case spelling.

### 3. Rewrite the docs home as the reader map

**Type**: WRITE  
**Output**: `docs/src/index.md` is a reader-facing start page and table of contents that mirrors `docs/make.jl`.  
**Depends on**: tasks 1 and 2.  
**Positive contract**: `docs/src/index.md` opens with a plain-language package purpose, then includes these sentence-case sections: `What you can make`, `What data you need`, `Where to go next`, and `Documentation map`. The page links to `primer.md`, `tutorial.md`, `how-to/index.md`, `explanation/index.md`, `examples.md`, `api/rendering.md`, and `api/phylopic_db.md`.  
**Negative contract**: The home page must not lead with internal overlay mechanics, must not use `@index` or `Quick Index` as the reader map, must not duplicate API reference catalogs, and must not claim that later tranche pages already contain complete content.  
**Files**: `docs/src/index.md`.  
**Out of scope**: `README.md`; `docs/make.jl`; `docs/src/primer.md`; `docs/src/tutorial.md`; `docs/src/how-to/index.md`; `docs/src/explanation/index.md`; `docs/src/examples.md`; `docs/src/api/rendering.md`; `docs/src/api/phylopic_db.md`; `examples/`; `src/`; `test/`.  
**Verification**: `rg -n "What you can make|What data you need|Where to go next|Documentation map" docs/src/index.md` shows all required section headings; `rg -n "generic anchored-overlay|owner layer|data-anchor|projected pixel-anchor|placement mechanics|Quick Index|```@index" docs/src/index.md` returns no matches; `rg -n "primer.md|tutorial.md|how-to/index.md|explanation/index.md|examples.md|api/rendering.md|api/phylopic_db.md" docs/src/index.md` shows all required route links.

Rewrite the page around the PRD's top-down outline. The first paragraph should state that PhyloPicMakie places PhyloPic silhouettes in Makie figures and helps readers work with coordinates, ranges, galleries, preloaded image matrices, saved figures, and optional live PhyloPic data in later docs. The home page should tell a reader where to go for first learning, a guided tutorial, goal-oriented how-to guides, concepts, exact API facts, and runnable examples. Remove the `Quick Index` section and the `@index` block from the home page because API indexing belongs to reference, not first-contact orientation.

### 4. Rewrite the README first contact

**Type**: WRITE  
**Output**: `README.md` opens with a reader-facing package synopsis and points readers to the documentation map.  
**Depends on**: tasks 1, 2, and 3.  
**Positive contract**: The first prose after badges states that PhyloPicMakie places PhyloPic silhouettes in Makie figures and points readers to the stable/dev docs and the examples path. The README keeps useful example-environment information only after the plain-language purpose.  
**Negative contract**: The README must not lead with internal substrate, projection, owner, or placement-mechanics prose. It must not add a full tutorial, change example commands, change environment policy, or claim live UUID examples are part of the required path.  
**Files**: `README.md`.  
**Out of scope**: `docs/make.jl`; all files under `docs/src/`; `examples/README.md`; `examples/src/`; `docs/Project.toml`; `examples/Project.toml`; `src/`; `test/`; `.github/workflows/CI.yml`.  
**Verification**: `sed -n '1,45p' README.md` shows user-visible purpose before implementation details; `rg -n "generic anchored-overlay|shared internal anchored-overlay substrate|owner layer|data-anchor|projected pixel-anchor|placement mechanics|projection mechanics|internal owner" README.md` returns no matches; `rg -n "stable|dev|examples" README.md` shows docs and examples pointers still present.

Rewrite only the first-contact README prose and links needed to satisfy the task. Keep the badges. Keep the existing examples-environment policy true: `examples/Project.toml` is versioned, a local examples manifest is ignored, and the three example scripts can save PNG files when run as scripts. Move that operational information below the plain-language package purpose so a skimming reader sees the value proposition first.

### 5. Verify navigation, first contact, and scope

**Type**: TEST  
**Output**: Documentation build, doctest gate, source audits, rendered navigation review, and diff audit all pass for tranche 1.  
**Depends on**: tasks 1, 2, 3, and 4.  
**Positive contract**: The docs build succeeds, the CI-style doctest command succeeds, source audits fail the old bad prose and old navigation shape, rendered docs show the new top-down navigation, and the diff touches only allowed tranche files.  
**Negative contract**: Do not edit files in this task. Do not add CI text checks, source-text policing tests, generated PNG assets, or package-environment changes. If verification fails because a task output is wrong, return to that task and edit only that task's allowed files.  
**Files**: No file edits are allowed in this task.  
**Out of scope**: Any file modification; new tests; CI changes; generated assets as source files; public API, plotting, example-script, environment, or network-behavior changes.  
**Verification**: Run `julia --project=docs docs/make.jl`; run `julia --project=docs -e 'using Documenter: DocMeta, doctest; using PhyloPicMakie; DocMeta.setdocmeta!(PhyloPicMakie, :DocTestSetup, :(using PhyloPicMakie); recursive=true); doctest(PhyloPicMakie)'`; run the failure-oriented verification commands listed above; inspect `docs/build/index.html` and the rendered sidebar for Start here, Primer and tutorial, How-to guides, Explanation, API reference, and Examples; run the diff audit command from Lock 4.

Complete this as a verification-only task. The source-text audits are session verification artifacts and must not be turned into new CI checks in this tranche. The rendered review must confirm both the positive user result and the negative absence of implementation-first opening prose. The diff audit must confirm that the implementation respected the documentation-only authorization boundary.
