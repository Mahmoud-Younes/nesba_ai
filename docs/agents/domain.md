# Domain Docs

How the engineering skills should consume this repo's domain documentation when exploring the codebase.

## Before exploring, read these

- **`GLOSSARY.md`** at the repo root.
- **`docs/adr/`**: read ADRs that touch the area you're about to work in.

If any of these files don't exist, **proceed silently**. Don't flag their absence; don't suggest creating them upfront. The `/domain-modeling` skill (reached via `/grill-with-docs` and `/improve-codebase-architecture`) creates them lazily when terms or decisions actually get resolved.

## File structure

Single-context repo:

```
/
├── GLOSSARY.md
├── docs/adr/          ← one file per decision, e.g. 0001-<slug>.md
└── lib/
```

## This repo's specifics

- The 30 existing decisions (`ADR-01`…`ADR-30`) are **rows** in `files/discovery/docs/discovery/06-DECISIONS.md`, not files under `docs/adr/`, and every one is `Proposed` until the team marks it accepted. Check there before treating a decision as settled; `docs/adr/` is only for decision files written from now on.
- `files/ui-ux/microcopy_glossary_ar.md` is Arabic UI copy, not the domain model — use it for user-facing strings, never as the source for naming code.
- The requirements vocabulary (`FR-`, `NFR-`, `US-`, `DAT-`, `INT-`) is defined in `files/discovery/docs/discovery/05-REQUIREMENTS.md`; cite those IDs in issues, branches and PRs.

## Use the glossary's vocabulary

When your output names a domain concept (in an issue title, a refactor proposal, a hypothesis, a test name), use the term as defined in `GLOSSARY.md`. Don't drift to synonyms the glossary explicitly avoids.

If the concept you need isn't in the glossary yet, that's a signal: either you're inventing language the project doesn't use (reconsider) or there's a real gap (note it for `/domain-modeling`).

## Flag ADR conflicts

If your output contradicts an existing ADR, surface it explicitly rather than silently overriding:

> _Contradicts ADR-0007 (event-sourced orders), but worth reopening because…_
