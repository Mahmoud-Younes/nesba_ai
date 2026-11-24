# Product

<!-- impeccable:product-schema 1 -->

## Platform

android

## Users

General users who want to track and improve their diet, including people with little or no professional nutrition knowledge. They describe meals in natural language and need nutritional information and suggestions explained in an understandable way.

## Product Purpose

The current phase aims to help users record meals, understand their nutritional content, and make informed dietary improvements. The documented product concept uses AI to analyze meal descriptions and provide nutritional guidance, healthier alternatives, and recipes tailored to a user's dietary preferences and restrictions.

Success means making meal tracking more approachable and turning meal records into understandable, useful guidance. The accuracy and reliability of AI-generated nutrition information remain product risks; the app is not a substitute for professional medical advice.

## Positioning

The documented distinguishing mechanism is natural-language meal entry paired with AI-generated nutritional interpretation and personalized suggestions. The final product name is unresolved: project materials use both “NutriVision” and “Nesba.” Do not treat either as the confirmed product name until the team decides.

## Operating Context

The only committed platform for the current phase is Android. iOS, web, and other platforms are outside the current implementation scope; their presence in the repository is scaffolding, not a product commitment.

The Phase 4 system analysis and design documents describe meal logging and history, AI meal analysis, recipe and healthier-alternative suggestions, dietary preferences and restrictions, a nutritional dashboard, and cross-device meal synchronization. Those documents are marked draft or proposed in places; implementation and architecture choices that they identify as proposed are not approvals.

## Capabilities and Constraints

- Current-phase goals documented by the team include meal logging and history, AI nutritional analysis and recommendations, tailored recipes and healthier alternatives, dietary preference and restriction support, nutritional charts, and meal synchronization.
- Android is the only committed implementation target for this phase.
- Meal input is described as natural language. Image-based meal recognition and barcode scanning are excluded from the current scope.
- The product must not provide medical advice or guarantee allergen safety.
- The use of USDA FoodData Central for nutrition lookup is unresolved. Do not assume a USDA integration or source of nutrition data until the team decides.
- The product name is unresolved between “NutriVision” and “Nesba.”
- Authentication, detailed service architecture, and other choices marked proposed in the Phase 4 documents remain subject to team approval.

## Evidence on Hand

- `Documents/Phase 4 System Analysis & Design/` contains draft system analysis and design materials, including problem objectives, requirements, architecture, UI/UX, deployment, and open items.
- The Phase 4 package identifies its source planning, literature review, requirements, team assignment, and repository issues. Some of those source documents are not present in this repository, and the package records resulting conflicts and open items.
- No validated user research, testimonials, clinical evidence, or production usage data is established by the reviewed project materials. Future work must not invent these.

## Product Principles

- Make meal tracking approachable through natural-language entry.
- Explain nutrition in terms that non-specialists can understand.
- Tailor suggestions to the user's stated preferences and dietary restrictions.
- Keep guidance informational and avoid medical or allergen-safety claims.
- Preserve unresolved team decisions as open questions rather than presenting proposals as commitments.
