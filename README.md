# Hackathon Starter Template

Welcome! This template gives you a fully-configured cloud dev environment in about 2 minutes. No installs on your laptop, no "works on my machine." You just click a few buttons in the browser and you're coding.

## Getting started

1. **Click the green "Use this template" button** at the top of this repo, then **Create a new repository**. Give it any name — this is your hackathon project repo.
2. Open the new repo you just created.
3. Click the green **`<> Code`** button → **Codespaces** tab → **Create codespace on main**.
4. Wait ~2 minutes while it builds. You'll see a VS Code window in your browser when it's ready.
5. Start building!

> **Tip:** If you'd rather use the desktop VS Code app, install the "GitHub Codespaces" extension and connect to your codespace from there.

## What's pre-installed

| Tool | What it's for |
| --- | --- |
| Node.js 24 (LTS) | JavaScript / TypeScript runtime |
| Python 3.13 | Python projects |
| Docker | Run containers inside your codespace |
| GitHub CLI (`gh`) | Talk to GitHub from the terminal |
| opencode | AI coding assistant in your terminal |
| Vercel CLI | Deploy frontends and serverless apps |
| Netlify CLI | Deploy static sites and functions |
| Wrangler | Deploy to Cloudflare Workers / Pages |
| Railway CLI | Deploy full-stack apps with databases |
| `httpie`, `jq`, `ripgrep`, `fd`, `tmux`, `tree` | Handy command-line utilities |
| opencode VS Code extension | Launch opencode in the editor's integrated terminal |
| Prettier, ESLint, Pylance, Tailwind, Docker extensions | Auto-formatting and language support in VS Code |
| Markdown All in One | Better markdown editing and preview |
| DotENV | Syntax highlighting for `.env` files |

Format-on-save is already turned on — your code gets tidied every time you hit save.

## Using opencode (terminal AI assistant)

opencode is an AI coding agent that lives in your terminal. Open a terminal in VS Code (`` Ctrl+` ``) and run:

```bash
opencode
```

You'll need to authenticate first. There are three ways:

### Option 1: Shared org API key (easiest, if organizers set this up)
If the event organizers pre-provisioned a shared API key, **it's already there as an environment variable** — opencode will pick it up automatically. Just run `opencode` and start chatting.

### Option 2: Bring your own API key
Set the appropriate environment variable in your codespace terminal:

```bash
export ANTHROPIC_API_KEY=sk-ant-...
# or
export OPENAI_API_KEY=sk-...
```

To persist across terminal sessions, add it as a [Codespaces user secret](https://github.com/settings/codespaces) — it'll auto-load every time.

### Option 3: Log in with your Claude or ChatGPT subscription
If you have a paid Claude or ChatGPT account, run:

```bash
opencode auth login
```

Pick your provider and follow the browser prompt. This uses your subscription instead of pay-per-token API credits.

## Where to deploy your project

| Project type | Recommended host |
| --- | --- |
| Static site (HTML, plain React, Astro) | **Cloudflare Pages** (`wrangler pages deploy`) |
| Frontend with API routes (Next.js, SvelteKit, Remix) | **Vercel** (`vercel`) or **Netlify** (`netlify deploy`) |
| Full-stack app needing a database | **Render** (web UI, generous free tier) |
| Anything with a Dockerfile | **Railway** (`railway up`) |

All four CLIs are pre-installed. Each one walks you through login the first time you run it.

## Sharing a preview URL during the hack

Need to show your in-progress app to a teammate or judge?

1. Run your dev server (e.g. `npm run dev`).
2. In VS Code, open the **Ports** tab (bottom panel, next to Terminal).
3. Find your port (3000, 5173, 8000, or 8080 — they're forwarded by default).
4. **Right-click** the port → **Port Visibility** → **Public**.
5. Copy the URL from the **Forwarded Address** column and share it.

> The URL stops working when your codespace stops. Deploy to one of the hosts above for anything you want to keep alive.

## Codespaces free-tier limits — important!

GitHub gives each personal account a monthly Codespaces quota:

- **Free plan:** 120 core-hours + 15 GB storage / month
- **Pro / Student plan:** 180 core-hours + 20 GB storage / month

A 2-core codespace burns 2 core-hours per real hour of use. A weekend hackathon won't blow through the hours — but storage is the silent killer.

### **Delete your codespace after the event** (don't just stop it)

A *stopped* codespace still eats your 15 GB storage quota. To actually free it up:

1. Go to <https://github.com/codespaces>.
2. Click the **`...`** menu next to your codespace.
3. Click **Delete**.

Push your code to GitHub first if you want to keep it!

## Stuck?

Most issues during the event will be auth-related — your AI tool or deploy CLI asking for credentials. Re-read the opencode section above, or ask an organizer. Happy hacking!
