# Agent Notes

Guidance for AI coding assistants (Claude Code, opencode, Copilot, Cursor, etc.) working in this repo.

## What this repo is

A GitHub **template repository** for hackathon attendees. When someone clicks "Use this template", they get a copy of these files in a fresh repo, then open a GitHub Codespace and land in a pre-configured Linux dev environment.

The contents of this repo are **scaffolding**, not a working application. Attendees will replace/extend it with their actual project code.

## Repo layout

- `.devcontainer/devcontainer.json` — Codespaces / dev container config. Defines the base image, language features, VS Code extensions, forwarded ports, and host requirements.
- `.devcontainer/setup.sh` — `postCreateCommand` script. Installs deploy CLIs (vercel, netlify, wrangler, railway), apt utilities, and opencode. Ends with version-check assertions so a broken install fails the Codespace build loudly.
- `README.md` — Attendee-facing. Non-technical tone. Covers using the template, what's installed, opencode auth, deploy targets, port sharing, free-tier limits.
- `ORGANIZER.md` — Event-organizer-facing. Covers template toggle, org Codespaces secrets for shared API keys, cost math, pre-event checklist.
- `.gitignore` — Standard Node + Python + deploy-tool-cache ignores.

## Conventions when editing

- **`setup.sh` must stay loud-on-failure.** Keep `set -euo pipefail` at the top and the version-check block at the bottom. A silent install is worse than a failed Codespace build — a failed build tells the attendee something is wrong; a silent miss leaves them debugging "why doesn't opencode work" mid-hack.
- **Idempotency in `setup.sh`.** Anything appended to shell rc files (PATH exports, etc.) must check for existence first. The script may run more than once if a Codespace is rebuilt.
- **README tone: friendly, non-technical.** Assume the reader has never used a terminal. Spell out clicks and menu paths. ORGANIZER.md can be denser and assume CLI familiarity.
- **Keep the dependency surface small.** Every tool added to `setup.sh` is one more thing that can break the Codespace build, and one more thing to explain. Add only what most hackathon teams will actually use.
- **Don't add example application code** (no sample Next.js app, no Flask hello-world). The template is deliberately empty so attendees can start from `npm create vite`, `npx create-next-app`, etc., without having to delete scaffolding first.

## When changing `devcontainer.json`

- Validate it parses as JSON before committing: `python3 -c "import json; json.load(open('.devcontainer/devcontainer.json'))"`.
- Port additions should include a friendly `label` in `portsAttributes` and use `onAutoForward: notify`.
- VS Code extensions go in `customizations.vscode.extensions` using their full marketplace IDs (e.g. `esbenp.prettier-vscode`, not just `prettier`).

## When changing `setup.sh`

- Validate syntax before committing: `bash -n .devcontainer/setup.sh`.
- Keep it executable: `chmod +x .devcontainer/setup.sh`.
- New version-check lines go in the final assertion block, not scattered through the script.

## What to push back on

- Requests to add framework-specific scaffolding (a starter Next.js app, etc.) — see "don't add example application code" above.
- Requests to pin every tool to an exact version — for a hackathon template, "latest stable" is usually right. Pinning becomes a maintenance burden when versions drift.
- Requests to add CI workflows. There's nothing to test; the codespace build itself is the only meaningful check.
