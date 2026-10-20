#!/bin/bash
# Installs claude2 + claude-next: a second Claude Code profile that shares everything except the login.
set -euo pipefail
REPO="https://raw.githubusercontent.com/Shohruxbek2202/claude-next/main"
BIN="$HOME/.local/bin"
P1="$HOME/.claude"
P2="$HOME/.claude-2"

command -v claude >/dev/null || { echo "Claude Code not found. Install it first: https://claude.com/claude-code"; exit 1; }
command -v python3 >/dev/null || { echo "python3 is required"; exit 1; }
mkdir -p "$BIN" "$P1" "$P2"

# local checkout -> copy, curl | bash -> download
here="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" 2>/dev/null && pwd || true)"
for f in claude2 claude-next; do
  if [ -f "$here/bin/$f" ]; then cp "$here/bin/$f" "$BIN/$f"; else curl -fsSL "$REPO/bin/$f" -o "$BIN/$f"; fi
  chmod +x "$BIN/$f"
done

# share config, memory and history; the login (.claude.json account keys) stays separate
for item in CLAUDE.md settings.json settings.local.json agents commands skills hooks plugins projects plans file-history history.jsonl; do
  [ -e "$P1/$item" ] || [ "$item" = projects ] || continue
  [ "$item" = projects ] && mkdir -p "$P1/projects"
  if [ -e "$P2/$item" ] && [ ! -L "$P2/$item" ]; then echo "skip $item (already exists in $P2)"; continue; fi
  ln -sfn "$P1/$item" "$P2/$item"
done

# copy MCP servers & preferences, but not the account
if [ ! -f "$P2/.claude.json" ] && [ -f "$HOME/.claude.json" ]; then
  python3 - "$HOME/.claude.json" "$P2/.claude.json" <<'PY'
import sys, json
d = json.load(open(sys.argv[1]))
for k in ("oauthAccount", "userID", "primaryApiKey", "customApiKeyResponses"):
    d.pop(k, None)
json.dump(d, open(sys.argv[2], "w"), indent=2)
PY
fi

[ -f "$HOME/.claude-profile" ] || echo 1 > "$HOME/.claude-profile"

echo "Done."
case ":$PATH:" in *":$BIN:"*) ;; *) echo "Add to your shell config:  export PATH=\"\$HOME/.local/bin:\$PATH\"";; esac
echo "Next: run  claude2  once and log in with your second account."
