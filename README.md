# Fixer

An AI support agent with real write access to accounts, orders, and tickets. Built on Xano for the DevNetwork [API + Cloud + AI] Hackathon 2026, Xano challenge track ("Rebuild a SaaS Tool You Hate").

## What it replaces

Zendesk and Intercom's habit of deflecting instead of resolving. Most AI support bots answer questions. Fixer has tools wired straight into the backend: it checks order status, issues refunds, restarts suspended services, extends trials, and escalates to a human, and every action lands in the database with a full audit trail.

## Architecture

- **Backend: Xano.** Three tables (`customer`, `order`, `ticket`), five XanoScript functions holding the actual business logic and refund policy, five AI tools that wrap those functions, a Xano AI agent ("Fixer") bound to the tools, a realtime channel that publishes every resolved or escalated ticket, and two API groups:
  - `fixer-actions` — plain REST endpoints (`check-order-status`, `issue-refund`, `restart-service`, `extend-trial`, `escalate-to-human`), the same webhook targets an external voice agent calls.
  - `fixer-dashboard` — read endpoints (`tickets`, `customers`, `orders`), a `chat` endpoint that talks to the agent directly, and a `seed` endpoint for demo data.
- **Voice front door: ElevenLabs Conversational AI.** The voice widget's tools call the same `fixer-actions` REST endpoints, so voice and chat hit identical backend logic.
- **Dashboard: a single static HTML page** (`static/index.html`), no framework, no build step. Polls the dashboard API for a live ticket/customer/order view and embeds the ElevenLabs widget plus a text-chat fallback.

## Setup

1. Install the Xano CLI and authenticate:
   ```bash
   npm install -g @xano/cli
   xano auth
   ```
2. Pull this workspace's code locally (or just push this repo to your own workspace):
   ```bash
   xano workspace push -w <your_workspace_id>
   ```
3. Seed demo data:
   ```bash
   curl -X POST https://<your-instance>.xano.io/api:fixer-dashboard/seed
   ```
4. Serve the dashboard:
   ```bash
   cd static && python -m http.server 8123
   ```
   Update `API_BASE` in `static/index.html` to your instance URL.
5. Create an ElevenLabs Conversational AI agent, add the five `fixer-actions` endpoints as webhook tools, and paste the agent ID into the `elevenlabs-convai` tag in `static/index.html`.

**Note:** Xano's Free plan rate-limits at 10 requests per 20 seconds. The dashboard polls all three read endpoints together every 8 seconds to stay under that.

## Build story

- **Replaced:** Zendesk / Intercom, specifically the pattern of AI "support" that only deflects to canned answers instead of resolving anything.
- **AI tools used:** Claude Code, driving the Xano CLI directly to write and push XanoScript (tables, functions, tools, agent, API endpoints) in one session.
- **Time:** built and verified end to end (database writes, policy enforcement, tool-calling agent, dashboard, rate-limit handling) in a single working session.
- **What AI + Xano made fast:** hand-rolling a backend with equivalent auth-free REST endpoints, a Postgres schema, an LLM tool-calling loop, and a realtime channel would normally mean picking a framework, wiring a database, and building an agent orchestration layer from scratch. Here the schema, the endpoints, and the agent are declarative XanoScript files pushed straight to a hosted backend, verified with real HTTP calls in the same session they were written.
