---
date-created: 2026-08-14T00:15:41
workflow-instrument: PRD
workflow-status: Approved
workflow-agent-thread-id: codex/019ff9d2-ef36-7e31-92dd-bea4892ee11e
workflow-location: /home/jeetsukumaran/site/storage/local/computing/research/20260414_PhyloPicMakie.jl/PhyloPicMakie.jl
workflow-production-id: diataxis-docs-primer
---

# PRD: Diataxis documentation rewrite

## User statement

Initial statement:

> The `docs` language is awful. Developer babble. This should be an example rich primer, tutorial, and how-tos, following the Diataxi framework [https://diataxis.fr/](https://diataxis.fr/)

Follow-up statement:

> This is what's wrong:
>
> "The public explicit-coordinate API is implemented on top of the package's
> generic anchored-overlay substrate. Internally, `PhyloPicMakie` now owns both
> data-anchor and projected pixel-anchor placement mechanics, along with aspect
> preservation, placement offsets, and reactive resize or relimit behavior.
> "
>
> How many users of this packagfe will understand what it is talking about?
>
> But worse, how many users of thjis package will CARE about this???
>
> This is like a developer describing his own fevered dreams to himself.
>
> UGH
>
> I alreaedy said what I wanted:
>
> This should be an example rich primer, tutorial, and how-tos, following the Diataxi framework [https://diataxis.fr/](https://diataxis.fr/)

Second follow-up statement:

> PNG's are build produicts
>
> We need a clear outline/TOC to bring everything together
>
> top-down design

Third follow-up statement:

> The entire progress trajectory starting with offline loading makes no fucking sense at all.
>
> No user on the planet comes to this package with an image, tand then decides where to place it.
>
> WTF??
>
> This is convoluted logic,
>
> We can use DataCaches.jl to help performance for repeated queries instead of secret offline images. This can be hidden in initial documentation, and explitict usage shown in later documentatiom.
>
> Revise all existing workflow docs to reflect this, creating a sdpecial remedial tasking tranche this for already completed treanches.

## Problem statement

The documentation speaks from the developer's internal implementation model instead of the user's task model. A reader who wants to place PhyloPic silhouettes in a Makie figure is first asked to parse terms such as "generic anchored-overlay substrate", "projected pixel-anchor placement mechanics", and "owner layer". Those terms may describe real implementation work, but they do not answer the reader's first questions: what can I make, what data do I need, what code do I run, and what should I expect to see?

The current docs also lack a clear Diataxis structure. They have a sparse home page, an examples page that mostly lists commands, and API pages driven by `@autodocs`. That makes reference material carry the job of primer, tutorial, how-to guide, and explanation all at once. The result is developer-centered prose, weak first-contact learning, and too little goal-oriented guidance.

The rewrite also needs a top-down design. The docs should not become a pile of improved pages that still fail to explain where a reader should begin, what comes next, and which section solves which kind of problem. A clear outline and table of contents must be the organizing control for the work.

The first learning trajectory must not start with offline image loading, preloaded image matrices, or a docs-private helper image. That trajectory is not how the package's users think. A normal reader starts with a biological or plotting question: taxon names, PhyloPic node UUIDs, PBDB-derived identifiers, coordinates, ranges, tables, or a gallery they want to make. The docs must present PhyloPic lookup and silhouette selection as the normal path, then explain placement. DataCaches-backed caching is the right performance and repeat-query story. It may stay invisible in first-contact documentation, but it must be documented explicitly in later how-to or explanation material.

## Solution

Rewrite the public documentation as an example-rich learning and task surface organized around Diataxis:

- a top-down outline and table of contents that makes the whole documentation set legible
- a short primer that tells readers how to get from biological identifiers or plotting data to visible PhyloPic silhouettes in a Makie figure
- at least one tutorial that guides a reader through making a useful figure from PhyloPic node UUIDs or taxon-derived identifiers
- how-to guides organized around real user goals, not internal subsystems
- reference pages that remain precise, neutral, and complete
- bounded explanation pages for concepts that users may want after they have seen the package work

Internal implementation details should remain available only where they help the right reader at the right time: reference for API facts, or explanation for deeper context. First-contact pages must talk about figures, silhouettes, taxon or PhyloPic identifiers, coordinates, ranges, galleries, labels, PhyloPic lookup, DataCaches-backed repeated-query performance, and Makie workflows. They must not lead by asking readers to load or invent image matrices.

## Documentation outline

The rewrite must be designed from the following top-down outline before individual pages are drafted. Page names may change during implementation, but the reader paths and information roles must remain intact.

1. Repository entrypoint: README.

   Purpose: explain in plain language that PhyloPicMakie places PhyloPic silhouettes in Makie figures, show or link to one immediate result, and send readers to the full documentation. The README is not a design note and must not lead with internal overlay mechanics.

2. Documentation home: start here.

   Purpose: orient the reader to the package and the documentation. It should answer "What can I make?", "What data do I need?", and "Which page should I read next?" The page should include a compact table of contents that points to the primer, tutorial, how-to guides, reference, and explanation pages.

3. Primer: place silhouettes in Makie figures.

   Purpose: give the conceptual first pass. It should show a complete visible result, name the main user-facing ideas, and explain only enough to make the first examples meaningful.

4. Tutorial: make your first silhouette-annotated figure from PhyloPic data.

   Purpose: guide a new reader through one successful workflow from PhyloPic identifiers to a saved figure. The tutorial should use small steps, expected results, and one coherent example rather than a survey of all options. It may rely on existing package behavior that hides caching details, but it must not frame the first task as loading a secret local image.

5. How-to guides.

   Purpose: help readers solve concrete plotting and gallery tasks. Required guide topics are:

   - add silhouettes to point coordinates
   - add silhouettes to ranges
   - use table columns for coordinates, images, labels, and PhyloPic node UUIDs
   - build a thumbnail gallery
   - choose images and rendering quality from PhyloPic results
   - handle missing images
   - use PhyloPic node UUIDs and taxon-derived identifiers
   - use DataCaches for repeated PhyloPic queries
   - place silhouettes on GraphMakie node-position snapshots
   - adjust placement, size, offsets, rotation, and mirroring

6. Explanation: concepts.

   Purpose: explain concepts after the reader has seen the package work. Candidate pages are "Placement, anchors, and offsets", "PhyloPic identifiers, image selection, and caching", and "How PhyloPicMakie fits with PaleobiologyDB workflows". Implementation substrate details may appear here only when connected to observable user behavior.

7. Reference.

   Purpose: provide precise facts about exported functions, signatures, keywords, valid symbols, return behavior, missing-image policies, and errors. Reference pages should link back to the tutorial and how-to guides, but should not carry the teaching burden.

8. Example scripts and generated outputs.

   Purpose: keep repository examples aligned with the docs and verification. PNG outputs from examples are build products and verification artifacts. They should be generated by docs/example runs, checked for existence and file type, and not committed as source documentation assets by default. Example support code may create deterministic fixtures for tests, but first-contact prose must not present hidden local images as the reader's starting point.

## Primary-goal lock

1. User-centered first contact.

   The work is not complete if `README.md`, `docs/src/index.md`, or the first rendered documentation page leads with internal implementation language instead of a reader-visible outcome.

   Direct red-state repro: read the current `README.md` opening paragraph or `docs/src/api/rendering.md`; the text describes a "shared internal anchored-overlay substrate" and "projected pixel-space anchor workflows" before showing the user what to make.

   Expected closer: documentation entrypoint and primer tranche.

   Verification artifact: source-text audit and rendered-docs review fail if first-contact pages still contain "generic anchored-overlay substrate", "owner layer", "data-anchor and projected pixel-anchor placement mechanics", or equivalent internal-first prose outside a bounded explanation or reference context.

2. Diataxis information architecture.

   The work is not complete if the documentation remains organized only as Home, Examples, and API reference, or if pages are rewritten without a coherent top-down outline and table of contents.

   Direct red-state repro: `docs/make.jl` currently defines `"Home"`, `"Examples"`, and `"API Reference"` as the whole page structure.

   Expected closer: documentation navigation tranche.

   Verification artifact: `docs/make.jl`, `docs/src/index.md`, and rendered navigation show a deliberate outline with distinct reader paths for primer/tutorial, how-to guides, API reference, and explanation or concepts.

3. Example-rich primer and tutorial.

   The work is not complete if a new reader cannot copy a short, documented example that starts from PhyloPic identifiers or taxon-derived data and produces a visible Makie figure with silhouettes without understanding the internal overlay implementation.

   Direct red-state repro: `docs/src/examples.md` lists script commands but does not walk through a successful figure-building experience, expected output, or what the reader should notice. The already completed tranche 2 tasking then replaced that gap with a docs-private `offline_silhouette()` helper and preloaded image matrices, which is also a red state because it starts from the wrong user problem.

   Expected closer: remedial first-learning-path tranche, followed by primer and tutorial repair.

   Verification artifact: docs build plus at least one tutorial example that starts from PhyloPic node UUIDs or taxon-derived identifiers, can be run or checked as a documentation example under the documented network and cache assumptions, and produces a rendered or saved output artifact. Source-text audit fails any first-contact page that makes `offline_silhouette()`, preloaded image matrices, or equivalent hidden image fixtures the normal reader path.

4. Goal-oriented how-to guides.

   The work is not complete if how-to content is organized around functions or internal mechanisms rather than user goals.

   Direct red-state repro: current docs say "public explicit-coordinate and range-anchor overlays" but do not provide goal pages such as "Add silhouettes to points", "Add silhouettes to ranges", or "Make a thumbnail gallery".

   Expected closer: how-to tranche.

   Verification artifact: source and rendered-docs audit confirms how-to page titles and openings state user projects, and each how-to contains concrete code and expected result notes.

5. Reference stays reference.

   The work is not complete if API reference pages become tutorial dumps, or if user-facing tutorial/how-to pages become API parameter catalogs.

   Direct red-state repro: current `docs/src/api/rendering.md` mixes a small user-facing summary with internal implementation explanation, then delegates almost everything to `@autodocs`.

   Expected closer: reference reorganization tranche.

   Verification artifact: rendered API reference provides neutral, complete facts about exported functions, keywords, return behavior, error behavior, and examples, while tutorial and how-to pages link to reference instead of reproducing whole parameter catalogs.

6. Runnable examples remain real and use the right starting point.

   The work is not complete if examples in the docs cannot be run under the documented project environments, or if the main reader path is replaced by hidden offline image fixtures. Network requirements, build pinning, and DataCaches behavior must be stated at the right level for each page.

   Direct red-state repro: existing example scripts are runnable gallery scripts, but docs do not promote them into verified learning artifacts. The subsequent completed primer/tutorial work created a local `_offline_silhouette.jl` helper and taught from a preloaded matrix before teaching why or how a user obtains a PhyloPic silhouette.

   Expected closer: examples and verification tranche.

   Verification artifact: `julia --project=docs docs/make.jl`, Documenter doctests, documented PhyloPic-backed examples or explicitly labeled network examples, and the example scripts that remain in scope run to saved PNG outputs in a temporary directory. Generated PNGs are checked as build products, not committed as source assets by default. Source-text audit fails if a docs-private local image helper is used as first-contact teaching.

7. No offline-first documentation trajectory.

   The work is not complete if the README, documentation home, primer, tutorial, or first how-to sequence starts from "load an image matrix, then place it" rather than "choose or resolve a PhyloPic silhouette for this taxon or node, then place it".

   Direct red-state repro: completed tranches 2 and 3 introduced `docs/src/_offline_silhouette.jl`, `offline_silhouette()`, and repeated "preloaded image matrix" framing in first-learning documents and tasking files.

   Expected closer: special remedial tranche for completed tranches 1 through 3.

   Verification artifact: source-text audit over `README.md`, `docs/src/index.md`, `docs/src/primer.md`, `docs/src/tutorial.md`, `docs/src/how-to/index.md`, and completed first-wave how-to pages fails if `offline_silhouette()`, docs-private image fixtures, "preloaded image matrix" language, or equivalent offline-first framing appears as the main reader path. Rendered-doc review confirms the first path begins with PhyloPic identifiers, taxon-derived identifiers, or package-supported lookup.

8. Documentation-only authorization boundary.

   The work is not complete if public API behavior, exported names, plotting semantics, or network behavior are changed as part of this documentation rewrite without explicit project-owner approval.

   Direct red-state repro: a proposed docs tranche changes implementation to make explanation easier rather than documenting the existing public surface.

   Expected closer: all tranches.

   Verification artifact: implementation diff audit shows the work is limited to documentation, examples, and documentation-build wiring unless the project owner explicitly approves a separate API or implementation change.

9. Vocabulary and style compliance.

   The work is not complete if new documentation violates `STYLE-vocabulary.md`, `STYLE-docs.md`, or `STYLE-writing.md`.

   Direct red-state repro: current user-facing prose uses internal terms without reader context and mixes machinery language into introductory prose.

   Expected closer: all documentation tranches.

   Verification artifact: source-text audit confirms canonical project terms are used correctly, headings use sentence case, prose is direct, and ordinary reader-facing terms are not wrapped in code font unless they are exact syntax.

## User stories

1. As a new Makie user, I want to see a finished PhyloPicMakie figure near the start of the docs, so that I understand why the package exists.

2. As a scientist with x and y coordinates and taxon or PhyloPic identifiers, I want a simple example that gets silhouettes and places them at those coordinates, so that I can annotate my own plot.

3. As a scientist with interval data, I want a guide that places silhouettes at the start, stop, or midpoint of ranges, so that I can annotate stratigraphic or temporal intervals.

4. As a reader with a table of data, I want to learn how to map columns to coordinates and PhyloPic node UUIDs or taxon-derived identifiers, so that I do not need to manually split vectors before plotting.

5. As a reader making repeated PhyloPic queries, I want the package to avoid unnecessary repeated work where it already supports caching, so that examples and exploratory sessions stay usable.

6. As a reader who has PhyloPic node UUIDs, I want a normal how-to that explains the PhyloPic-backed path, so that I can fetch real silhouettes for my data.

7. As a reader making a figure panel, I want to control glyph size, placement, offsets, rotation, and mirroring through concrete examples, so that I can adjust the visual result intentionally.

8. As a reader making a thumbnail gallery, I want a guide that starts from taxa, PhyloPic node UUIDs, or PhyloPic image records and labels, so that I can build a gallery without first learning the full PhyloPic API.

9. As a reader with PhyloPic node UUIDs, I want a guide that builds a thumbnail gallery directly from UUIDs and explains caching for repeated queries, so that I can browse or compare images for taxa.

10. As a GraphMakie user, I want a guide that explains the node-position snapshot workflow, so that I can place silhouettes on graph nodes without expecting unsupported live reactive behavior.

11. As a PaleobiologyDB user, I want clear links to the PBDB-integrated package surface, so that I know when this package is the right layer and when another package resolves taxon names for me.

12. As a reference reader, I want the API pages to list signatures, keyword meanings, valid symbols, return values, and error policies, so that I can check facts quickly while coding.

13. As a reader confused by placement terminology, I want a short explanation of what "placement" and "anchor" mean in figure terms, so that I can reason about offsets without reading internal code.

14. As a maintainer, I want documentation examples to be tested or rendered, so that future API changes do not silently break the docs.

15. As a contributor, I want the docs structure to make the intended page type obvious, so that I know whether to write a tutorial, a how-to guide, reference, or explanation.

16. As a reviewer, I want direct red-state checks for developer babble, so that a passing docs build does not hide a failed reader experience.

17. As a user who only skims the README, I want a plain-language pitch and a minimal example path, so that I can decide whether to open the full docs.

18. As a user who lands on an API page from search, I want links back to tutorial and how-to pages, so that I can find task-oriented help if reference is not enough.

19. As a user encountering missing images, I want the missing-image policies explained through examples, so that `:skip`, `:error`, and `:placeholder` are meaningful.

20. As a reader choosing image quality, I want image-rendering options explained at the right level, so that I can choose thumbnail, raster, or vector results from PhyloPic data without learning irrelevant internals first.

21. As a reader who already has a local image matrix, I want that supported API path documented as a secondary advanced or reference path, so that I can use it without confusing it with the normal PhyloPic workflow.

## Implementation decisions

- Treat this as a documentation feature, not an implementation refactor.
- Preserve the existing public API and examples unless the project owner separately approves API or example-code changes.
- Design the documentation top down from the outline and table of contents before rewriting individual pages.
- Reorganize the rendered documentation around Diataxis page types.
- Keep the README short and reader-facing. It should link to the primer/tutorial and docs, not explain internals.
- Convert the current examples page from a command list into a gateway to tutorial and how-to content.
- Keep API reference generated from docstrings, but surround it with better page structure, links, and short reference introductions.
- Move implementation-mechanics language into a bounded explanation or maintainer-facing note only when it helps a reader understand observable behavior.
- The primary tutorial and first how-to path must start from PhyloPic identifiers, taxon-derived identifiers, or package-supported PhyloPic lookup. It must not start from a docs-private local image or a preloaded image matrix.
- DataCaches-backed repeated-query behavior may stay hidden in first-contact docs, but explicit DataCaches usage belongs in later how-to, explanation, or reference material.
- Network requirements must be honest. Do not make the reader think a local image fixture is the normal PhyloPic workflow. Do not make CI or docs builds silently depend on unlabelled live network access.
- Treat generated PNG files as build products and verification artifacts. Do not commit generated PNGs as source documentation assets by default.
- The examples already in the repository are the initial source material for tutorial and how-to pages.
- The documentation navigation must be explicit in Documenter configuration rather than relying on filename ordering.
- Completed tranches 1 through 3 require a remedial tranche because their tasking and produced docs used an offline-first trajectory.

## Module design

### Documentation navigation

- **Name**: Documentation navigation
- **Responsibility**: Define the rendered documentation structure from the top-down outline and make the Diataxis page types visible in navigation.
- **Interface**: Readers see a coherent table of contents and page groups for primer/tutorial, how-to guides, API reference, and explanation or concepts. Contributors update the Documenter page list and the docs home outline when adding, removing, or moving pages.
- **Tested**: yes, through docs build and rendered navigation review.

### Documentation outline

- **Name**: Documentation outline
- **Responsibility**: Hold the reader-facing map that ties the docs together before page-level drafting begins.
- **Interface**: The docs home page presents reader paths for first learning, task solving, API lookup, and conceptual understanding. The Documenter navigation mirrors that outline.
- **Tested**: yes, through source-text audit, rendered home-page review, and `docs/make.jl` navigation review.

### README synopsis

- **Name**: README synopsis
- **Responsibility**: Give repository visitors a plain-language package summary and direct path to the docs.
- **Interface**: A short introductory paragraph, a minimal usage pointer, links to stable/dev docs, and no internal implementation narrative.
- **Tested**: yes, through source-text audit.

### Primer

- **Name**: Primer
- **Responsibility**: Introduce what PhyloPicMakie does for a user and show one meaningful result quickly.
- **Interface**: A first-read page with a concrete outcome, compact runnable code, expected result notes, and links to tutorial, how-to, and reference pages.
- **Tested**: yes, through docs build and runnable example verification.

### Tutorial

- **Name**: Tutorial
- **Responsibility**: Guide a new reader through making a successful figure step by step.
- **Interface**: A lesson-style page that uses small steps, expected output, and minimal explanation, following Diataxis tutorial guidance. The lesson starts from PhyloPic node UUIDs or taxon-derived identifiers, then places the resulting silhouettes in a Makie figure. It does not teach a docs-private local image helper as the normal first path.
- **Tested**: yes, through docs build, doctest or example-block execution where practical, and rendered output verification.

### How-to guides

- **Name**: How-to guides
- **Responsibility**: Help competent users solve specific plotting and gallery tasks.
- **Interface**: Goal-titled pages for point overlays, range overlays, table data, thumbnail galleries, GraphMakie node-position snapshots, PhyloPic identifier use, DataCaches-backed repeated-query workflows, missing-image policy, and image selection.
- **Tested**: yes, through docs build, examples where practical, and source-text audit that page titles and openings are goal-oriented.

### PhyloPic lookup and caching guidance

- **Name**: PhyloPic lookup and caching guidance
- **Responsibility**: Explain how readers get silhouettes from PhyloPic and how repeated queries use caching where supported.
- **Interface**: First-contact pages use the package's normal PhyloPic-backed path without requiring cache setup knowledge. Later how-to or explanation pages show explicit DataCaches usage and name the current project-owned APIs that use `DataCaches.autocache`, including `PhyloPicDB.batch_primary_images` and `PhyloPicDB.batch_images`.
- **Tested**: yes, through source-text audit, rendered-doc review, and examples or reference checks tied to the documented PhyloPicDB APIs.

### API reference

- **Name**: API reference
- **Responsibility**: Provide precise facts about exported functions, data types, keyword arguments, valid symbols, return values, and error behavior.
- **Interface**: Reference pages based on `@autodocs` or `@docs`, with short neutral introductions and links to task-oriented pages.
- **Tested**: yes, through Documenter build, doctests, and checkdocs behavior.

### Explanation

- **Name**: Explanation
- **Responsibility**: Give bounded conceptual context after readers have seen the package work.
- **Interface**: Short pages about placement, anchors, offsets, aspect preservation, PhyloPic identifiers, DataCaches-backed repeated-query behavior, and the relationship to PBDB-integrated workflows.
- **Tested**: yes, through docs build and prose audit.

### Example artifacts

- **Name**: Example artifacts
- **Responsibility**: Keep runnable examples aligned with documentation claims.
- **Interface**: Scripts that can save visible PNG files to build or temporary output locations. Generated PNG files are verification artifacts, not committed source assets by default. Test fixtures may exist for verification, but user-facing first-contact prose must not present hidden fixture images as the normal package workflow.
- **Tested**: yes, through example-script execution and file existence/type checks for output images.

### Remedial first-learning realignment

- **Name**: Remedial first-learning realignment
- **Responsibility**: Repair completed tranche outputs and tasking that taught the wrong offline-first mental model.
- **Interface**: A special remedial tranche and tasking file audit and update `README.md`, `docs/src/index.md`, `docs/src/primer.md`, `docs/src/tutorial.md`, `docs/src/how-to/index.md`, completed how-to pages, and existing workflow documents. The correction removes or demotes `offline_silhouette()` and preloaded-image language from first-contact teaching and replaces it with PhyloPic identifier or taxon-derived workflows.
- **Tested**: yes, through source-text audit, rendered-doc review, docs build, and generated PNG checks tied to the revised examples.

## Cross-cutting ownership and invariants

- The file `docs/make.jl` is the single implementation that defines rendered documentation navigation through Documenter `pages`. No separate navigation structure should be described in prose without updating this file.
- The file `docs/src/index.md` is responsible for the reader-facing outline and table of contents. It must stay aligned with `docs/make.jl`.
- The Markdown files under `docs/src/` are responsible for narrative documentation. They should contain primer, tutorial, how-to, reference, and explanation pages according to their Diataxis role.
- Source docstrings under `src/` are responsible for API reference facts. Tutorial and how-to pages may quote or link to those facts, but must not become duplicated parameter catalogs.
- The file `README.md` is responsible for the repository-level first impression. It must not lead with internal placement mechanics.
- The scripts under `examples/src/` are responsible for executable example behavior. Documentation pages may adapt them, but must not claim behavior that the scripts or public API do not demonstrate.
- Generated PNGs from docs and examples are build products. They are used to verify that examples produce visible output, but they are not source-controlled documentation assets by default.
- The CI documentation job in `.github/workflows/CI.yml` is responsible for the existing docs/deploy and doctest gate. Downstream work may strengthen docs verification, but must not weaken this gate.
- The required first-learning path must be PhyloPic-backed. It may hide DataCaches details, but it must not hide the fact that silhouettes come from PhyloPic identifiers or taxon-derived identifiers.
- Local image matrices and docs fixtures are secondary support paths. They must not own first-contact learning or appear as the normal way users begin.
- `PhyloPicDB.batch_primary_images` and `PhyloPicDB.batch_images` are the current project-owned APIs that explicitly use `DataCaches.autocache` for repeated PhyloPic queries. If documentation needs to claim DataCaches behavior outside those APIs, downstream work must first verify the exact local implementation or stop for approval to change it.
- Internal terms such as "anchored-overlay substrate" may appear only in bounded reference, explanation, or maintainer-facing prose where the reader has a reason to care.

## Governance and controlled vocabulary

Downstream agents and contributors must read the following line by line before trancheing, tasking, implementation, review, or audit:

- `STYLE-workflow-docs.md`
- `STYLE-agent-language.md`
- `STYLE-agent-handoffs.md`
- `STYLE-workflow-vocabulary.md`
- `STYLE-makie.md`
- `STYLE-git.md`
- `STYLE-writing.md`
- `STYLE-julia.md`
- `STYLE-docs.md`
- `STYLE-vocabulary.md`
- `STYLE-architecture.md`
- `STYLE-verification.md`
- `STYLE-upstream-contracts.md`

Expected but not found as repo-local files:

- `CONTRIBUTING*.md`
- `STYLE-python.md`
- `STYLE-domain-vocabulary.md`

`STYLE-agent-language.md` is a controlling repo-local authority for this PRD,
the tranche plan, all tasking files, all implementation reports, and all target
documentation pages. Any sentence in this workflow that uses ownership,
contract, boundary, layer, invariant, compatibility, verification, source, or
responsibility language must name the exact file, function, module, public
surface, or external contract; the behavior; the consuming surface; the
duplicate or bypass path that must not retain that behavior; and the
verification artifact that fails if the statement stays vague.

Vocabulary decisions:

- Use "PhyloPic silhouette" or "silhouette" for the user-visible image.
- Use "place silhouettes on points" and "place silhouettes on ranges" in reader-facing tutorial and how-to prose.
- Use "PhyloPic node UUID" when discussing PhyloPic-backed examples.
- Use "DataCaches-backed cache" or "DataCaches-backed repeated-query behavior" when discussing caching that is actually implemented through `DataCaches.autocache`.
- Use "local image matrix" only for the secondary API path where the user already has image data. Do not use "preloaded image" or "image matrix" as the first-contact reader path.
- Use "placement" for the public keyword, with a plain-language explanation such as "which part of the silhouette touches the coordinate".
- Avoid "generic anchored-overlay substrate", "owner layer", "data-anchor", "projected pixel-anchor", "placement mechanics", and equivalent internal-first phrasing in first-contact pages.
- Avoid `offline_silhouette()`, "secret offline image", "preloaded image matrix", and equivalent offline-first framing in README, home, primer, tutorial, and first how-to prose.
- Follow `STYLE-vocabulary.md`: do not use proscribed project terms in examples or prose, and keep exact API spellings only when referring to code.

## Primary upstream references

- Diataxis home: https://diataxis.fr/
- Diataxis start page: https://diataxis.fr/start-here/
- Diataxis applying guide: https://diataxis.fr/application/
- Diataxis tutorials: https://diataxis.fr/tutorials/
- Diataxis how-to guides: https://diataxis.fr/how-to-guides/
- Diataxis reference: https://diataxis.fr/reference/
- Diataxis explanation: https://diataxis.fr/explanation/
- Documenter public API for `makedocs`, `pages`, `doctest`, `checkdocs`, and build behavior: https://documenter.juliadocs.org/stable/lib/public/
- Documenter guide for documentation structure and sidebar behavior: https://documenter.juliadocs.org/stable/man/guide/
- Documenter syntax for `@autodocs`, `@docs`, `@example`, `@repl`, `@setup`, `@meta`, `@index`, and `@contents`: https://documenter.juliadocs.org/stable/man/syntax/
- DataCaches upstream repository and README for file-backed caching, `@filecache`, explicit `DataCache`, and automatic caching concepts: https://github.com/JuliaData/DataCaches.jl
- Local `Project.toml` for the approved `DataCaches = "0.4"` dependency and source URL.
- Local `src/PhyloPicDB/PhyloPicDB.jl` for the project-owned statement that PhyloPicDB includes deduplication and DataCaches-based caching.
- Local `src/PhyloPicDB/_bulk.jl` for the exact `DataCaches.autocache` use in `PhyloPicDB.batch_primary_images` and `PhyloPicDB.batch_images`.
- Local `src/_glyph_resolution.jl` for the current distinction between per-call UUID deduplication and DataCaches-backed cross-call caching.

## Testing decisions

- Run the documentation build: `julia --project=docs docs/make.jl`.
- Run the Documenter doctest gate used by CI.
- Run the existing test suite if docstrings or examples embedded in source are changed.
- Run example scripts or revised documentation examples to saved PNGs in a temporary directory:
  - `julia --project=examples examples/src/explicit_overlays.jl /tmp/explicit_overlays.png`
  - `julia --project=examples examples/src/thumbnail_gallery.jl /tmp/thumbnail_gallery.png`
  - `julia --project=examples examples/src/graph_anchors.jl /tmp/graph_anchors.png`
- Check generated PNGs with a file-type check and treat them as build products.
- Confirm no generated PNG files are added to source control by default.
- Perform a source-text audit for forbidden first-contact phrases and for Diataxis role drift.
- Perform a source-text audit that `offline_silhouette()`, docs-private image fixtures, "preloaded image matrix", and equivalent offline-first language do not appear as the first-contact learning path in README, home, primer, tutorial, or first how-to pages.
- Perform a source-text audit that DataCaches claims are tied to the exact project-owned APIs that use `DataCaches.autocache`, or to the upstream DataCaches docs when explicit cache setup is shown.
- Perform a source-text and rendered-docs audit that the docs home page provides a clear outline and table of contents, and that the navigation mirrors it.
- Perform a rendered-docs review of the home page, primer/tutorial page, representative how-to page, and API reference.
- Network use must be explicit at the page level. Initial pages may hide cache setup details, but they must not hide the PhyloPic-backed nature of the workflow behind local image fixtures.

## Handoff packet

- **Active authorities**: repo-local `STYLE-workflow-docs.md`, `STYLE-agent-language.md`, `STYLE-agent-handoffs.md`, `STYLE-workflow-vocabulary.md`, `STYLE-makie.md`, `STYLE-git.md`, `STYLE-writing.md`, `STYLE-julia.md`, `STYLE-docs.md`, `STYLE-vocabulary.md`, `STYLE-architecture.md`, `STYLE-verification.md`, and `STYLE-upstream-contracts.md`; this PRD once approved.
- **Parent documents**: this PRD.
- **Settled decisions and non-negotiables**: documentation must follow Diataxis; the rewrite must start from a clear top-down outline and table of contents; first-contact prose must be reader-facing; the main learning path starts from PhyloPic identifiers, taxon-derived identifiers, or package-supported PhyloPic lookup; DataCaches-backed repeated-query behavior is the performance story and may be hidden initially but documented explicitly later; generated PNGs are build products and verification artifacts, not source assets by default; API and implementation behavior must not change without explicit approval; internal overlay-mechanics prose must not lead user-facing docs.
- **Authorization boundary**: documentation, README, examples, docs navigation, docs verification, and documentation-build wiring are in scope. Public API changes, plotting implementation changes, exported-name changes, and network behavior changes are out of scope unless the project owner explicitly reopens the boundary.
- **Current-state diagnosis**: `README.md`, `docs/src/index.md`, and `docs/src/api/rendering.md` originally foregrounded internal implementation mechanics. `docs/make.jl` originally exposed only Home, Examples, and API Reference. Completed tranches 1 through 3 improved navigation and added tutorial/how-to material, but they introduced a wrong offline-first trajectory built around `docs/src/_offline_silhouette.jl`, `offline_silhouette()`, and preloaded image matrices. That trajectory must be remediated before later tranches build on it.
- **Primary-goal lock**: preserve all lock items in this PRD as separate proof obligations.
- **Direct red-state repros**: grep or read for "generic anchored-overlay substrate", "data-anchor and projected pixel-anchor", "owner layer", and equivalent intro prose; inspect `docs/make.jl` for only Home/Examples/API structure; inspect `docs/src/index.md` for lack of a clear outline and table of contents; inspect `docs/src/examples.md` for command-list-only examples; inspect docs pages for lack of tutorial/how-to goal pages; inspect completed first-wave docs and tasking for `offline_silhouette()`, `docs/src/_offline_silhouette.jl`, "preloaded image matrix", or equivalent offline-first framing.
- **Named responsible entities and required behavior**: `docs/make.jl` must define the rendered Documenter navigation through its `pages` argument; no prose-only table of contents may be the only navigation map, and `julia --project=docs docs/make.jl` plus rendered-sidebar review fails if the navigation drifts. `docs/src/index.md` must present the reader-facing outline and table of contents consumed by documentation readers; no later page may become the only place where the top-down outline exists, and source-text plus rendered-home review fails if the outline is missing. `README.md` must provide repository first contact; `docs/src/index.md` must provide documentation first contact; neither file may lead with internal placement mechanics, and the forbidden-phrase audit fails if they do. `docs/src/primer.md`, `docs/src/tutorial.md`, and first how-to pages must start from PhyloPic identifiers or taxon-derived data; `docs/src/_offline_silhouette.jl` and local image matrices must not provide the normal first path, and the offline-first source-text audit fails if they do. `src/PhyloPicDB/_bulk.jl` is the single local file currently allowed to justify DataCaches-backed batch-query prose because `PhyloPicDB.batch_primary_images` and `PhyloPicDB.batch_images` call `DataCaches.autocache`; docs must not claim the same behavior for direct UUID rendering unless a separate approved source change adds it, and the DataCaches prose audit fails if the claim is broader. `src/_glyph_resolution.jl` resolves direct UUID images and deduplicates UUIDs within one call; docs must not use that file as evidence for DataCaches-backed cross-call caching, and the DataCaches prose audit fails if they do. Source docstrings under `src/` provide API facts for reference pages; tutorial and how-to Markdown must link to reference instead of copying full parameter catalogs, and rendered-reference review plus source-text audit fails duplicated catalogs. `examples/src/` scripts provide executable example behavior; docs must not claim example behavior the scripts or public API do not show, and example-script runs to temporary PNG files fail unsupported claims. Generated PNGs must remain build products; `git status --short` fails completion if generated PNGs are tracked as source assets.
- **Exact files or surfaces in scope**: `README.md`; `docs/make.jl`; `docs/src/index.md`; `docs/src/examples.md`; `docs/src/api/rendering.md`; `docs/src/api/phylopic_db.md`; `docs/src/primer.md`; `docs/src/tutorial.md`; `docs/src/how-to/`; `docs/src/explanation/`; workflow documents under `.workflow-docs/202608140015_diataxis-docs-rewrite/`; `examples/README.md`; existing example scripts if needed to support docs; `.github/workflows/CI.yml` only if docs verification is strengthened.
- **Exact files or surfaces out of scope**: public API implementation in `src/` except docstrings; exported names; package dependency changes except documentation/example environment changes approved by the project owner; live PhyloPic API behavior; PaleobiologyDB integration implementation.
- **Required upstream primary sources**: Diataxis pages listed in "Primary upstream references"; Documenter pages listed in "Primary upstream references"; DataCaches upstream repository and README; local `Project.toml`; local `src/PhyloPicDB/PhyloPicDB.jl`, `src/PhyloPicDB/_bulk.jl`, `src/_glyph_resolution.jl`, `docs/make.jl`, CI docs job, and public docstrings listed above.
- **Green-state gates**: docs build passes; doctests pass; documented examples produce PNG outputs in build or temporary locations; generated PNGs are checked but not committed as source assets by default; source-text audit passes for internal-babble removal and offline-first removal; rendered-docs review confirms a clear outline, Diataxis roles, PhyloPic-backed first learning, and reader-facing first contact; DataCaches claims match local `DataCaches.autocache` use or cited upstream DataCaches docs; no unapproved implementation or public API changes appear in diff.
- **Stop conditions**: stop if the work appears to require changing public API behavior; stop if a docs page needs DataCaches behavior that is not present in the cited local APIs; stop if governance rules conflict with a proposed docs pattern; stop if Documenter, DataCaches, or PhyloPicDB behavior needed by the design is uncertain and no primary source has been read; stop if a downstream document omits governance, vocabulary, upstream-source, or lock-item obligations.

## Out of scope

- Changing public function names, signatures, keyword semantics, return values, or error behavior.
- Rewriting the internal anchored-overlay implementation.
- Adding new plotting capabilities.
- Making PaleobiologyDB integration changes.
- Replacing Documenter with another documentation system.
- Creating a broad theory manual for Makie or PhyloPic beyond what this package needs.
- Committing generated example PNG files as source documentation assets by default.
- Presenting local image matrices, generated image matrices, or docs-private image helpers as the normal first-contact workflow.

## Open questions

No open question remains about whether live PhyloPic-backed examples belong in the main docs. The project owner resolved that the offline-first trajectory is wrong. The docs should use PhyloPic-backed workflows as the normal reader path, keep DataCaches details hidden in initial prose, and show explicit DataCaches usage later.

## Further notes

Diataxis uses four documentation forms with different reader needs: tutorials for learning, how-to guides for goals, reference for information, and explanation for understanding. The current docs blur these needs. This rewrite should not simply rename pages. It should change the reader experience: first see what the package makes possible, then do a small successful task, then find goal-specific recipes, then consult exact API facts when needed.

The top-down outline is the design control for downstream trancheing. Tranches should establish the documentation map and rendered navigation before doing broad prose rewrites, so later page work has a shared destination and review target.

The 2026-08-16 correction is also a design control. Existing workflow documents and completed first-wave tranche outputs must be treated as stale wherever they teach from `offline_silhouette()`, preloaded image matrices, or an offline-first source decision. Downstream work must create and execute a special remedial tranche before continuing ordinary page production.
