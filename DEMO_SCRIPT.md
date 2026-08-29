# Fixer demo script

Target length: 2:30–3:30 (challenge cap is 4:00). Full screen, mic on, one take. Voice widget on, text chat as backup if the mic hiccups.

Before recording: hit `reset-demo` so the ticket feed starts empty. Have the dashboard open and the voice widget visible from the first second.

---

## The pitch (0:00–0:20)

*(Screen: dashboard, customer side visible)*

"This is Fixer. It replaces the part of Zendesk and Intercom that never actually works: the AI layer that answers questions but can't touch your account. Fixer has real write access. It checks orders, issues refunds, restarts suspended services, and knows when to hand off to a human. Every action lands in a database in real time. It's built entirely on Xano."

## Show both sides (0:20–0:45)

*(Point at the two columns)*

"Two sides share this screen. On the left is what a customer sees: the conversation, and the outcome. On the right is what Loopline, the company, sees: the live ticket feed and the account records. The customer never sees the right side. That split is the whole point. Support agents today just chat. This one acts, and the business gets a record of exactly what it did."

## Live calls (0:45–2:00)

*(Start the voice widget)*

**Call 1: a refund that works**

"Hi, this is Rairo, rairorr@gmail.com. Can you check order one?"

*(Wait for the check, let it read back the order)*

"Great, can you refund it?"

*(Let it run. Point at the ticket feed populating live, and the resolution card on the customer side.)*

"That's a real write. Order one just flipped to refunded in Xano's database, live, while I was talking."

**Call 2: a refund that correctly fails**

"What about order two, can you refund that one too?"

*(It should decline, order two is pending, not delivered)*

"It didn't just say no. It checked the actual order status against policy and explained why. That's the difference between a chat layer and a support agent with rules."

**Call 3: a real fix**

"My service is suspended, can you restart it?"

*(Point at the customers table on the right, service status flips from suspended to active)*

"That's not a canned response. That's a row changing in a live database."

## The architecture, fast (2:00–2:20)

*(Screen: brief look at Xano workspace, or just narrate over the dashboard)*

"Behind this: three tables, five functions holding the actual refund and eligibility logic, an AI agent bound to five tools, and a realtime channel pushing every action to this feed. The same tools that power the voice call are exposed as plain REST endpoints, so an ElevenLabs voice agent calls the exact same backend a human-built frontend would."

## Build story (2:20–2:50)

"I replaced Zendesk and Intercom's habit of answering without resolving. I built this with Claude Code, driving the Xano CLI directly: writing XanoScript, pushing tables and functions, wiring the agent, and testing every call against the real API in the same session. Hand-building an equivalent backend, a tool-calling agent loop, and a realtime feed from scratch would normally take days of picking a framework and wiring infrastructure. Here the schema, the logic, and the agent are declarative files pushed straight to a hosted backend, verified against live calls as they were written."

## Close (2:50–3:10)

"Fixer. Support that actually does something. Built on Xano."

*(Cut.)*

---

## Notes for the take

- If a tool call hangs mid-sentence, that's the Xano free-plan rate limit, not a bug. Give it a beat, it recovers. Don't call attention to it on camera.
- Say "Rairo" and the email out loud clearly; the agent needs both to verify identity, and it's a good moment to show that rule working.
- Keep the ticket feed visible in frame the whole time. The live update is the best five seconds of the video.
- If voice stumbles twice, switch to the text chat fallback and keep going. It hits the identical backend, so nothing about the story changes.
