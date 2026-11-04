# Phase 4 — System Analysis & Design Package

**Project:** NutriVision — AI-Driven Dietary Health Assistant
**Repository:** `Mahmoud-Younes/nesba_ai`
**Phase:** 4 — System Analysis & Design
**Author:** Ahmed (documentation owner per Task Assignment §3)
**Cross-review:** BassamEmad39
**Date:** 2026-11-04
**Status:** Draft for team review

> **Naming conflict (OI-01).** All project documentation names this project **NutriVision**. The repository and all GitHub issues name it **Nesba / nesba_ai**. This package uses *NutriVision* because that is the name used in every evidence source. A single authoritative name must be confirmed before submission. See [`13-open-items.md`](13-open-items.md).

---

## Status legend

Every non-trivial statement in this package carries one of these tags. Nothing is promoted to fact without a source.

| Tag | Meaning |
|-----|---------|
| `[E]` | **Evidence-based.** Traced to a named source document. The source is cited inline. |
| `[P]` | **Proposed.** A recommendation by the author. **Not approved.** Requires explicit team approval before it becomes binding. |
| `[U]` | **Unverified.** Stated by a team member from memory, or inferred, without a documentary source. Must be confirmed. |
| `[O]` | **Open item.** Unresolved question with no current answer. Tracked in `13-open-items.md`. |

An untagged sentence is connective prose, not a claim about the system.

---

## Evidence baseline

This package is grounded in the following sources, in priority order:

| # | Source | Location | Used for |
|---|--------|----------|----------|
| S1 | `NutriVision_01_Project_Planning_and_Management.pdf` | `Documents/` | Problem, objectives, scope, team roles, risks, KPIs |
| S2 | `NutriVision_02_Literature_Review.pdf` | `Documents/` | Technology review, future work, grading criteria |
| S3 | `NutriVision_03_Requirements_Gathering.pdf` | `Documents/` | Stakeholders, US-01…US-07, UC-01…UC-03, FR-01…FR-15, NFRs |
| S4 | `Project Documentation Guidelines` (trainer) | Issued by trainer | Phase 4 deliverable list, submission dates, grading weights |
| S5 | Task Assignment & Roles (module ownership) | Issued by team leader | Module ownership, screen ownership |
| S6 | GitHub issues #1–#10 | `Mahmoud-Younes/nesba_ai` | Scope boundary, out-of-scope list, task breakdown |

> **Baseline conflict (OI-02).** Issue #1 instructs that `DISCOVERY.md`, `05-REQUIREMENTS.md`, `06-DECISIONS.md` and `files/ui-ux/README.md` be preferred over the older PDFs. **None of those files exist in the repository.** This package therefore treats S1–S3 as the operative baseline. If the newer documents exist and are unpushed, this package must be re-reconciled against them.

---

## Deliverable index

Mapped to §4 of the trainer's *Project Documentation Guidelines* (S4).

| Brief item | Document | GitHub issue |
|---|---|---|
| 1 — Problem Statement & Objectives | [`01-problem-objectives-scope.md`](01-problem-objectives-scope.md) | #2 |
| 1 — Use Case Diagram & Descriptions | [`02-use-cases.md`](02-use-cases.md) | #3 |
| 1 — Functional & Non-Functional Requirements | [`03-requirements.md`](03-requirements.md) | #3 |
| 1 — Software Architecture | [`04-software-architecture.md`](04-software-architecture.md) | #4 |
| 2 — ER Diagram | [`05-data-model.md`](05-data-model.md) | #5 |
| 2 — Logical & Physical Schema | [`05-data-model.md`](05-data-model.md) | #5 |
| 3 — DFD / Sequence / Activity / State | [`06-data-flow-and-behaviour.md`](06-data-flow-and-behaviour.md) | #6 |
| 3 — Class Diagram | [`07-class-diagram.md`](07-class-diagram.md) | #7 |
| 4 — Wireframes & UI/UX Guidelines | [`08-ui-ux.md`](08-ui-ux.md) | #8 |
| 5 — Tech Stack / Deployment / Component Diagrams | [`09-deployment-and-integration.md`](09-deployment-and-integration.md) | #4, #9 |
| 6 — API Documentation | [`10-api-documentation.md`](10-api-documentation.md) | #9 |
| 6 — Testing & Validation | [`11-testing-and-validation.md`](11-testing-and-validation.md) | #9 |
| 6 — Deployment Strategy | [`12-deployment-strategy.md`](12-deployment-strategy.md) | #9 |
| — Traceability matrix | [`14-traceability-matrix.md`](14-traceability-matrix.md) | #2 |
| — Assumptions & open items | [`13-open-items.md`](13-open-items.md) | #2 |

---

## Diagram format

All diagrams are authored as **Mermaid** source embedded in Markdown. Rationale: issue #1 requires design assets to have "open, editable, reviewable source"; Mermaid renders natively on GitHub, diffs cleanly in pull requests, and requires no proprietary editor. If the trainer requires exported images, each block can be rendered to PNG/SVG without re-authoring.

---

## System boundary

**In scope** — the NutriVision Flutter mobile application and its documented external dependencies: Google Gemini (AI), USDA FoodData Central (nutrition lookup) `[U]`, Firebase Authentication, and Cloud Firestore.

**Out of scope** — admin or web portal, payments, social features, photo/image meal recognition, barcode scanning, wearable integration, medical advice, and allergen-safety guarantees. Per S2 §3, image recognition, barcode scanning and wearable integration are recorded as *future enhancements*, and per S3 the architecture must merely permit them later (NFR-12). Per S6 (#1) they are excluded from Phase 4.

**Platform** — Android is the primary and only committed target. iOS is a possible post-training extension and is **not** a Phase 4 commitment `[E: team decision, 2026-11-04]`. The repository currently contains `ios/`, `web/`, `windows/`, `macos/` and `linux/` scaffolding generated by `flutter create`; this scaffolding does not constitute a platform commitment.

---

## This phase's weight

Per S2 §4, the grading categories covered wholly or partly by this package total **40%** of the final mark: Project Documentation 20%, Requirements and Analysis 10%, UI/UX and Design 10%.
