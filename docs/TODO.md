# TODO

Tracked work for this template. Items are roughly ordered by user-facing impact, not strict priority.

## First-time setup skill / instructions

Add a file (likely a skill that opencode picks up, or a top-level `SETUP.md` the attendee runs through with opencode) that walks a brand-new attendee through:

- Prompting them for their project idea ("What are you building? Who's it for? Stack preference?")
- Updating `README.md` to describe *their* project instead of the template explainer
- Updating `AGENTS.md` with the project's actual layout, conventions, and decisions
- Optionally: a quick VS Code orientation tour for first-time IDE users (terminal, file explorer, ports tab, source control)

Goal: cut the "blank-page paralysis" gap between "Codespace ready" and "actually coding on my idea."

## Initial `AGENTS.md` template

Ship an `AGENTS.md` aimed at AI assistants working on the attendee's *project* (not on the template itself — that's the current `AGENTS.md`, which would move or become a section of this doc). Should include:

- Repo layout placeholder ready for the setup skill to fill in
- A "what this project is" placeholder
- Conventions block (style, testing, commit messages) with sensible defaults the attendee can edit

Tension to resolve: the current `AGENTS.md` is template-meta guidance. After the setup skill runs, the attendee needs project-meta guidance. Decide whether to (a) rename current → `TEMPLATE_AGENTS.md` and ship a fresh `AGENTS.md`, or (b) have the setup skill rewrite `AGENTS.md` in place.

## Documentation rewrite for both audiences

The current `README.md` and `ORGANIZER.md` accumulated across this session and now mix template-explainer, attendee-onboarding, and AI-agent-guidance in ways that aren't always clearly separated. Pass:

- Make `README.md` aggressively friendly to non-technical first-time users (current tone is decent but assumes some terminal familiarity in places)
- Keep the template-explainer content useful but visually demote it so attendees don't have to skip past it to get started
- Make sure AI agents reading these files get clean, actionable instructions and not a guided tour
- Cross-link consistently — right now several "how to" details live in only one file
