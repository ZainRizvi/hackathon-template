# Agent Notes

Guidance for AI coding assistants (Claude Code, opencode, Copilot, Cursor, etc.) working in this repo.

## What this repo is

A GitHub **template repository** for hackathon attendees. When someone clicks "Use this template", they get a copy of these files in a fresh repo, then open a GitHub Codespace and land in a pre-configured Linux dev environment.

The contents of this repo are **scaffolding**, not a working application. Attendees will replace/extend it with their actual project code.

## Repo layout

- `.devcontainer/devcontainer.json` — Codespaces / dev container config. References `Dockerfile.local` via `build:`, layers the docker-in-docker feature, declares VS Code extensions, forwarded ports, and host requirements.
- `.devcontainer/Dockerfile.local` — Thin amd64-pinning wrapper around the prebuilt image. Referenced by `devcontainer.json`'s `build:` stanza so the platform pin is honored at feature-extension time (runArgs alone is too late). No tools live here; see `Dockerfile` for image contents.
- `.devcontainer/Dockerfile` — The prebuilt dev environment image. Bakes in apt utilities, gh CLI, Node, Python, uv, opencode, and the deploy CLIs so a Codespace start is one image pull (no live `apt-get` or `npm install`). Ends with sanity-check assertions so a broken image fails the build instead of silently shipping.
- `.github/workflows/build-devcontainer-image.yml` — Builds the Dockerfile and pushes to `ghcr.io/<owner>/hackathon-template-env:latest` on push to `main`. Only triggers on changes to the Dockerfile or the workflow itself.
- `README.md` — Attendee-facing. Non-technical tone. Covers using the template, what's installed, opencode auth, deploy targets, port sharing, free-tier limits.
- `ORGANIZER.md` — Event-organizer-facing. Covers the prebuilt-image setup (including the one-time "make package public" step), template toggle, org Codespaces secrets for shared API keys, cost math, pre-event checklist.
- `opencode.json` — opencode configuration. Defaults the model to `opencode/deepseek-v4-flash-free` (free, no API key needed) so attendees can start chatting immediately.
- `.gitignore` — Standard Node + Python + deploy-tool-cache ignores.

## Conventions when editing

- **The Dockerfile must stay loud-on-failure.** Keep the sanity-assertion `RUN` block at the bottom that runs `--version` on every tool. A silent install is worse than a failed image build — a failed build is visible in the GitHub Actions log; a silent miss leaves attendees debugging "why doesn't X work" mid-hack.
- **Layer order: roughly slowest-changing to fastest-changing.** So most rebuilds hit the cache from the top. The current Dockerfile puts apt utilities first, then apt-based third-party CLIs (gh), then language runtimes (node, python), then npm globals, then the fastest-moving curl-installed CLIs (uv, opencode).
- **README tone: friendly, non-technical.** Assume the reader has never used a terminal. Spell out clicks and menu paths. ORGANIZER.md can be denser and assume CLI familiarity.
- **Keep the dependency surface small.** Every tool added to the Dockerfile is one more thing that can break the image build, slow it down, and one more thing to explain. Add only what most hackathon teams will actually use.
- **Don't add example application code** (no sample Next.js app, no Flask hello-world). The template is deliberately empty so attendees can start from `npm create vite`, `npx create-next-app`, etc., without having to delete scaffolding first.

## When changing `.devcontainer/Dockerfile`

- Build locally before pushing: `cd .devcontainer && docker buildx build --platform linux/amd64 -t test .`. The build must succeed, including the final sanity-assertion `RUN` step.
- New tools must get a matching `--version` line in the sanity-assertion `RUN` block — not scattered through the file.
- Prefer `apt-get install -y --no-install-recommends`, end with `rm -rf /var/lib/apt/lists/*` in the same `RUN`, to keep layers small.
- For `curl | sh`-style installers, check if the installer exposes an install-dir override (e.g. uv's `UV_INSTALL_DIR`) before resorting to a post-install `mv` dance.

## When changing `.devcontainer/devcontainer.json`

- Validate it parses as JSON before committing: `python3 -c "import json; json.load(open('.devcontainer/devcontainer.json'))"`.
- Port additions should include a friendly `label` in `portsAttributes` and use `onAutoForward: notify`.
- VS Code extensions go in `customizations.vscode.extensions` using their full marketplace IDs (e.g. `esbenp.prettier-vscode`, not just `prettier`).

## When changing `.github/workflows/build-devcontainer-image.yml`

- The first publish requires a manual "make package public" step in the GitHub UI (see ORGANIZER.md section 0). If you change the package name, attendees will hit a pull failure until that step is repeated.

## What to push back on

- Requests to add framework-specific scaffolding (a starter Next.js app, etc.) — see "don't add example application code" above.
- Requests to pin every tool to an exact version — for a hackathon template, "latest stable" is usually right. Pinning becomes a maintenance burden when versions drift.
- Requests to install VS Code or extensions into the Dockerfile — Codespaces installs the VS Code server and the extensions listed in `devcontainer.json` into a separate volume at container start. Pre-installing them in the image is unsupported and conflicts.
