# PRD: Rewrite Site Content to Be Honest and Grounded

## 1. Overview

The current site uses marketing-heavy copy that inflates and fabricates claims not supported by the resume. This refactor rewrites every piece of text on the site so that every word is grounded in the PDF resume as the single source of truth.

The tone shifts from "commercial landing page selling a staff architect" to "minimal, factual personal page for a working engineer." Let the facts speak. Short sentences, no marketing language, no cleverness.

**Source of truth:** `priv/static/assets/Andrei Scripcaru - Technical.pdf`

**Key insight from research:** The most distinctive facts in the resume — 80+ projects, 13 years of contract work, 10+ programming languages, trilingual — are currently invisible on the site. Instead, the site uses fabricated marketing copy ("Staff-level", "make the real work visible", "AI-accelerated teams") that contradicts the actual career.

## 2. Goals

- **Primary:** Every text claim on the site traces back to something in the resume. Nothing fabricated, nothing inflated.
- **Secondary:** The tone is minimal and factual. A hiring manager reads facts, not a pitch.
- **Success metric:** A reader who compares the site to the resume finds zero contradictions and no unsupported claims.

## 3. Functional Requirements

- FR-1: All text content must be rewritten to match the resume.
- FR-2: No fabricated titles. The resume uses "Full-Stack Engineer", "Full-Stack Developer", "Back-End Developer", "Front-End Developer" — not "Staff-level."
- FR-3: No marketing buzzwords that aren't in the resume.
- FR-4: The 80+ projects / 13 years / contract nature of the work must be visible, not hidden.
- FR-5: The dark card is replaced with real background info (education, languages, location).
- FR-6: The "How I work" section is replaced with honest working style facts derived from the resume.
- FR-7: The "Ask me about" section is rewritten with topics the resume supports.
- FR-8: Keep the cozy visual design. Only text changes — EXCEPT the projects section which gets a new two-tier layout.
- FR-9: Tone is minimal — short sentences, factual, no superlatives.
- FR-10: The projects section displays all 14 entries from the resume (13 companies + freelance aggregate) in a two-tier layout with progressive disclosure.

## 4. User Stories

### US-001: Rewrite the layout header text

**Description:** As a visitor, I want the header to introduce Andrei with an accurate, minimal subtitle.

**Acceptance Criteria:**
- [ ] Header name stays "Andrei Scripcaru"
- [ ] Subtitle changes from "Staff-level full-stack engineer" to a factual description grounded in the resume. The resume says "Software engineer with 13 years designing and delivering complete systems." Use that spirit — e.g., "Full-stack software engineer" or "Software engineer, 13 years." No titles the resume doesn't use.
- [ ] Header links (email, resume download) remain unchanged
- [ ] Typecheck passes
- [ ] Tests pass

**File:** `lib/scripness_web/components/layouts.ex` (the `app/1` function, lines 50–74)

**Tags:** [ui]
**Priority:** 1

---

### US-002: Rewrite the hero section

**Description:** As a visitor, I want the hero to state what Andrei does factually, without marketing language.

**Acceptance Criteria:**
- [ ] The uppercase label is replaced with something the resume supports. Could reflect the actual resume categories or the contract/freelance nature of the work. Example: "Full-stack engineering, contract & freelance" or similar factual framing.
- [ ] The headline is rewritten to be factual. The resume summary is the starting point: "Software engineer with 13 years designing and delivering complete systems. I work across the full stack — architecture, backend, frontend, infrastructure — and focus on shipping software that solves the actual problem." Capture that in a shorter headline. No invented claims.
- [ ] The description paragraph mentions: 13 years, breadth of stacks, contract/freelance nature, 80+ projects. These are the distinctive facts. No claims about "specializing" unless the resume demonstrates repeated work in that area.
- [ ] Skill tags reflect resume content. Good candidates from the resume's Skills section: "End-to-End Delivery", "Agentic Development", "Product-Oriented", or factual tags like "10+ languages", "Contract & remote". Do NOT invent categories.
- [ ] CTA buttons stay (email + resume PDF links). The button text can be simplified — e.g., "Email me" / "Resume (PDF)".
- [ ] Tone is minimal and factual
- [ ] Typecheck passes

**File:** `lib/scripness_web/controllers/page_html/home.html.heex` (lines 1–39)

**Tags:** [ui]
**Priority:** 2

---

### US-003: Build featured projects tier

**Description:** As a visitor, I want to see the most substantive projects with full detail, so I can understand the depth of Andrei's work.

This replaces the current 3-card "Proof of impact" section with a proper two-tier project layout. This story covers the Featured Tier (top).

**Design:**
- A section with a factual heading (e.g., "Work" or "Projects") and a subtle count ("14 engagements")
- 3-4 featured project cards, selected by whichever projects have the most resume bullet points. Based on the resume, the strongest candidates are:
  - **FinancialDocs** (4 bullets): Document generation SaaS — paystub platforms, legal docs, CMS, caching, AI workflows
  - **NIXAP** (3 bullets): Software agency — VoIP system, web apps, AI workflows
  - **Dispatch42** (2 bullets): Freight logistics — real-time CRM, serverless notifications, hardware integration
  - Other candidates with 2 bullets: **Travod** (translation CRM, GraphQL API)
- The implementer should select the 3-4 projects with the most resume substance

**Featured card design:**
- Each card is a `<details>` element that expands on click
- **Always visible (summary):** Company name (serif heading), role title from resume (e.g., "Full-Stack Engineer | Contract | Remote"), one-sentence summary of what was built
- **On expand:** Full bullet points from the resume (verbatim or faithful summary), tech stack as small rounded pills
- Each featured card gets a subtle 2px top border accent in a warm color variation (within the existing palette: `#7b4a2c`, `#a0826d`, `#c7b3a4`, `#d4a983`). This adds visual rhythm without breaking consistency.
- Cards use the existing cozy styling: `rounded-[28px] border border-white/30 bg-white/65 p-6 shadow-[...]`

**Acceptance Criteria:**
- [ ] Section has a factual heading, no marketing language
- [ ] 3-4 featured cards for the projects with the most resume substance
- [ ] Each card shows company name, role title (from resume), and a one-sentence summary at a glance
- [ ] Each card expands to show full resume bullet points and tech stack pills
- [ ] Each featured card has a subtle warm-colored top border accent (different per card)
- [ ] All text matches the resume exactly — no embellishments, no invented claims
- [ ] Uses native `<details>` elements (no JavaScript)
- [ ] Responsive: cards stack vertically on mobile
- [ ] Typecheck passes

**Company reference data (from resume + research):**

| Company | Role | Bullets | Domain | Tech |
|---------|------|---------|--------|------|
| FinancialDocs | Full-Stack Engineer, Contract, Remote | 4 | Document generation SaaS | TypeScript, PHP, React/Next.js, NestJS, PayloadCMS, MongoDB, PostgreSQL |
| NIXAP | Full-Stack Engineer, Contract, Hybrid | 3 | Software agency (VoIP build) | TypeScript, PHP/Symfony/Laravel, Node.js, Vue.js/Nuxt.js, Electron, VoIP/SIP, RabbitMQ, Elasticsearch, WebSocket |
| Dispatch42 | Full-Stack Developer, Full-Time, In-Office | 2 | Freight logistics | TypeScript, Kotlin, React, GraphQL, Node.js, AWS (Lambda, SQS, DynamoDB, CDK), Jest |
| Travod | Full-Stack Developer, Full-Time, In-Office | 2 | Translation services | Ruby/Rails, Vue/Nuxt, GraphQL, MySQL, RSpec |

**File:** `lib/scripness_web/controllers/page_html/home.html.heex` (replaces current lines 41–75)

**Tags:** [ui]
**Priority:** 3

---

### US-004: Build compact projects tier

**Description:** As a visitor, I want to see all remaining projects in a compact, browsable format so I can understand the breadth of Andrei's experience.

This is the second tier below the featured projects. It shows the remaining ~10 projects in a denser layout.

**Design:**
- A subtle label above the compact section (e.g., "More work" in small uppercase tracking)
- Each project is a compact expandable row using `<details>`:
  - **Always visible (summary):** Company name (semibold), one-line description of what was built
  - **On expand:** The full bullet point(s) from the resume + tech stack pills
- Arranged in a responsive grid: 2 columns on tablet/desktop, single column on mobile
- No employment type tags (Contract/Full-time/Remote) — keep it minimal. That info is in the resume PDF.
- Each compact card uses the existing item styling: `rounded-2xl border border-[#e0d2c4] bg-white/70 p-4`

**Acceptance Criteria:**
- [ ] All remaining projects from the resume are included (the ones not in the featured tier)
- [ ] Each compact card shows company name and one-line description at a glance
- [ ] Each compact card expands to show full resume bullet point(s) and tech stack pills
- [ ] All text matches the resume — no embellishments
- [ ] Responsive grid: 2 columns on md+, single column on mobile
- [ ] Uses native `<details>` elements
- [ ] Typecheck passes

**Company reference data for compact tier (all from resume):**

| Company | Bullets | Domain | One-line summary (from resume) |
|---------|---------|--------|-------------------------------|
| Rio | 1 | Live streaming | Backend services (Kotlin, Node.js) and frontend for a live-streaming platform |
| Crawless | 1 | Browser automation | Backend systems and internal CRM for an Electron-based browser automation IDE |
| Deditech Com | 1 | Software services | B2B CRM and a home rental platform from scratch |
| eToro | 1 | Recruitment/HR | Backend API for a mobile app serving job seekers and recruiters |
| MKM | 1 | E-commerce (UK building supplies) | UK e-commerce platform integrating headless CRM and payment APIs |
| GoodLeap | 1 | Solar financing (fintech) | Serverless microservices for solar financing, DocuSign and payment integrations |
| RentInsider | 1 | Rental marketplace (Romania) | Frontend from scratch for a Romanian/European rental platform |
| Virail | 1 | Travel metasearch | Backend and frontend for a high-traffic travel search engine, Elasticsearch |
| Deutsche Fintech Solutions | 1 | WealthTech (Germany) | Frontend and micro-frontend architecture transition for B2C/B2B financial apps |
| Travod | 2 | Translation services | Backend/frontend for Traduno translation CRM + GraphQL API layer |

Note: If Travod is placed in the featured tier (US-003), it should not appear here. Adjust accordingly.

**File:** `lib/scripness_web/controllers/page_html/home.html.heex` (part of the projects section)

**Tags:** [ui]
**Priority:** 4

---

### US-005: Add freelance aggregate card

**Description:** As a visitor, I want to see the "80+ projects" freelance history as a distinct anchor at the bottom of the projects section, so I understand the full scope of Andrei's experience.

**Design:**
- Placed after all individual project cards as the final element of the projects section
- Uses the dark card style (`bg-[#1a0f09]/90 text-white`) for visual contrast — matching the existing dark card pattern
- Content from the resume:
  - Headline: "Independent Freelancing" (or similar)
  - "Delivered 80+ projects across CRM, SaaS, and e-commerce — handling client requirements, architecture, implementation, and ongoing maintenance end-to-end"
  - "Worked across web, desktop, and mobile stacks with direct client interaction throughout"
- Tech stack pills showing the full range: PHP, JavaScript/TypeScript, Python, Vue.js, React, Node.js, MySQL, PostgreSQL, MongoDB, DynamoDB, Flutter, Delphi
- NOT expandable — content is short enough to show in full. This card is always fully visible.

**Acceptance Criteria:**
- [ ] Dark card at the bottom of the projects section
- [ ] Both resume bullet points included, verbatim or faithful summary
- [ ] Tech stack pills in muted white-on-dark style
- [ ] "80+ projects" is typographically prominent — this is the anchor fact
- [ ] Dark card styling matches existing pattern: `rounded-[28px] border border-white/10 bg-[#1a0f09]/90 p-6 text-white`
- [ ] Typecheck passes

**File:** `lib/scripness_web/controllers/page_html/home.html.heex` (end of projects section)

**Tags:** [ui]
**Priority:** 5

---

### US-006: Replace the dark "Roles" card with background info

**Description:** As a visitor, I want to see real background information (education, languages, location) instead of fabricated positioning claims.

**Acceptance Criteria:**
- [ ] The dark card currently in the right column (hero area) is replaced with factual background info from the resume:
  - **Education:** Free International University of Moldova — Information Technology
  - **Languages:** English (C2), Romanian (Native), Russian (Native)
  - **Location:** Moldova (mentioned naturally, not emphasized — just factual)
  - **Work style:** Mostly contract, mostly remote (derived from the fact that 12 of 14 listed roles are contract, and most are remote)
- [ ] Remove all current content: "Roles I'm best for" / "Roles I'm not best for" — these are fabricated
- [ ] The dark card visual style is preserved (dark background, white text, rounded corners)
- [ ] Typecheck passes

**File:** `lib/scripness_web/controllers/page_html/home.html.heex` (lines 65–74 of the current file)

**Tags:** [ui]
**Priority:** 6

---

### US-007: Replace "How I work" with honest working style

**Description:** As a visitor, I want to understand Andrei's actual working style based on what the resume demonstrates.

**Acceptance Criteria:**
- [ ] Section heading is updated — e.g., "How I work" can stay, but the subtitle must be factual
- [ ] The 4 cards are replaced with honest working style facts derived from the resume:
  1. **Ramps up fast:** 80+ projects across different stacks and domains. The resume shows he joins codebases in TypeScript, PHP, Ruby, Python, Kotlin, and more — each time at a different company.
  2. **Full-stack ownership:** The resume shows backend, frontend, infrastructure, and deployment work across almost every role. Not just one layer.
  3. **Remote and async:** Almost every role is listed as "Remote." Only 2 of 14 company roles were in-office. 13 years of remote contract work.
  4. **AI-assisted workflows:** FinancialDocs was "delivered entirely using agentic AI workflows." NIXAP mentions "developed with AI-assisted workflows." Frame as current practice, not a career-long identity.
- [ ] No invented process claims. Everything traces to resume facts.
- [ ] Card styling preserved (rounded corners, warm borders, white backgrounds)
- [ ] Tone is minimal — short factual statements
- [ ] Typecheck passes

**File:** `lib/scripness_web/controllers/page_html/home.html.heex` (lines 78–103 of the current file)

**Tags:** [ui]
**Priority:** 7

---

### US-008: Rewrite the "Ask me about" expandable section

**Description:** As a visitor, I want the expandable topics to cover things the resume actually supports.

**Acceptance Criteria:**
- [ ] 4 expandable topics, all grounded in resume content:
  1. **Working across many stacks:** TypeScript, PHP, Ruby, Python, Kotlin, Go, C#, Elixir, Delphi. Acknowledge depth varies ("TypeScript and PHP are where I've spent the most time"). No overclaiming.
  2. **80+ projects as a freelancer:** Use resume wording: "Delivered 80+ projects across CRM, SaaS, and e-commerce — handling client requirements, architecture, implementation, and ongoing maintenance end-to-end."
  3. **Legacy codebases:** FinancialDocs: "evolving a shared codebase of 2,000+ service classes without breaking production" across three interconnected platforms.
  4. **Agentic AI development:** FinancialDocs and NIXAP both mention AI workflows. Frame as current practice. Be specific.
- [ ] Remove "Cross-functional leadership" — no resume support
- [ ] Remove "Scaling real-time systems" — one project doesn't make a specialty
- [ ] Each expanded description uses resume wording or faithful summaries
- [ ] The `<details>` interactive pattern is preserved
- [ ] Tone is minimal and factual
- [ ] Typecheck passes

**File:** `lib/scripness_web/controllers/page_html/home.html.heex` (lines 105–149 of the current file)

**Tags:** [ui]
**Priority:** 8

## 5. Non-Goals

- **No new pages.** Single-page content rewrite + project section redesign.
- **No backend changes.** No new routes, controllers, or LiveViews.
- **No JavaScript changes.** No new JS interactivity. All progressive disclosure uses native `<details>` elements.
- **No AI chat feature.** The YouTube transcript describes this — it is NOT part of this work.
- **No external images or logos.** We don't have company logos and won't use external assets.
- **No company links.** Don't link to company websites — some may be defunct. The resume is the source of truth, not the companies' current websites.

## 6. Technical Considerations

- **Files affected:**
  - `lib/scripness_web/components/layouts.ex` — header text in the `app/1` function
  - `lib/scripness_web/controllers/page_html/home.html.heex` — all page content
- **Patterns to follow:**
  - Keep the existing cozy design system: warm colors, rounded corners, serif headings, soft shadows
  - Use native `<details>` elements for progressive disclosure (already used in the "Ask me about" section)
  - All styling via Tailwind utility classes, no `@apply`, no DaisyUI
  - Heroicons available via `<.icon name="hero-*">` for any small icons needed (e.g., chevron for expand)
- **Source of truth:** `priv/static/assets/Andrei Scripcaru - Technical.pdf`
- **Validation:** Run `mix precommit` after changes (per CLAUDE.md).
- **Tone rule:** If you can't trace a sentence back to the resume, delete it.

### Design system reference (existing)

| Element | Classes |
|---------|---------|
| Section card | `rounded-[32px] border border-white/30 bg-white/70 p-8 shadow-[0_30px_80px_rgba(28,17,12,0.12)]` |
| Inner card | `rounded-[28px] border border-white/30 bg-white/65 p-6 shadow-[0_20px_60px_rgba(28,17,12,0.12)]` |
| Item card | `rounded-2xl border border-[#e0d2c4] bg-white/70 p-4` |
| Dark card | `rounded-[28px] border border-white/30 bg-[#1a0f09]/90 p-6 text-white` |
| Skill pill | `rounded-full border border-[#c7b3a4] bg-white/60 px-4 py-2 text-sm` |
| Tech pill (small) | `rounded-full bg-[#1a0f09]/5 px-2.5 py-0.5 text-xs text-[#3b2b22]` |
| Dark tech pill | `rounded-full border border-white/20 px-2.5 py-0.5 text-xs text-white/70` |
| Primary text | `text-[#1a0f09]` |
| Secondary text | `text-[#3b2b22]` |
| Accent text | `text-[#7b4a2c]` |
| Heading font | Cormorant Garamond (serif) — applied via Tailwind `font-semibold` |
| Body font | Source Sans 3 (sans-serif) |
| Warm accent colors | `#7b4a2c`, `#a0826d`, `#c7b3a4`, `#d4a983` (for featured card top borders) |

## 7. Open Questions

None. All decisions have been made.
