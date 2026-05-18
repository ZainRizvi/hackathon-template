#!/usr/bin/env bash
set -euo pipefail

echo "==> Setting up hackathon dev environment..."

echo "==> Installing global npm CLIs (vercel, netlify, wrangler, railway)..."
npm install -g \
  vercel \
  netlify-cli \
  wrangler \
  @railway/cli

echo "==> Installing apt packages (httpie, jq, tmux, tree, ripgrep, fd-find)..."
sudo apt-get update
sudo apt-get install -y \
  httpie \
  jq \
  tmux \
  tree \
  ripgrep \
  fd-find

echo "==> Installing opencode..."
curl -fsSL https://opencode.ai/install | bash

OPENCODE_PATH_LINE='export PATH="$HOME/.opencode/bin:$PATH"'
for rc in "$HOME/.bashrc" "$HOME/.zshrc" "$HOME/.profile"; do
  if [ -f "$rc" ] || [ "$rc" = "$HOME/.profile" ]; then
    touch "$rc"
    if ! grep -Fqx "$OPENCODE_PATH_LINE" "$rc"; then
      echo "$OPENCODE_PATH_LINE" >> "$rc"
      echo "    added opencode PATH to $rc"
    else
      echo "    opencode PATH already present in $rc"
    fi
  fi
done

export PATH="$HOME/.opencode/bin:$PATH"

echo "==> Verifying installs..."
node --version
python3 --version
gh --version | head -n1
vercel --version
netlify --version | head -n1
wrangler --version
opencode --version

echo "==> Setup complete. Happy hacking!"
