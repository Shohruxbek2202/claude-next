# claude-next

**English** · [O'zbekcha](README.uz.md)

Run Claude Code with two accounts (for example work + personal) and switch between them in one command, without losing your conversation.

- `claude` uses account 1 (normal `~/.claude`)
- `claude2` uses account 2 (`~/.claude-2`)
- `claude-next` switches to the other account and **continues the latest conversation** of the current folder

Both profiles share `CLAUDE.md`, settings, skills, agents, hooks, plugins, memory and history through symlinks. Only the login is separate.

## Install

macOS / Linux, with Claude Code and `python3` installed:

```bash
curl -fsSL https://raw.githubusercontent.com/Shohruxbek2202/claude-next/main/install.sh | bash
```

or

```bash
git clone https://github.com/Shohruxbek2202/claude-next && cd claude-next && ./install.sh
```

Then log in the second account once:

```bash
claude2        # then /login with account 2
```

If `~/.local/bin` is not in your `PATH`, add `export PATH="$HOME/.local/bin:$PATH"` to `~/.zshrc` or `~/.bashrc`.

## Usage

1. Work normally with `claude`.
2. When you want to switch account (e.g. a usage limit is reached), exit Claude (`Ctrl+C` twice).
3. In the **same folder**, in a normal terminal, run:

```bash
claude-next
```

It flips to the other profile and resumes the conversation. If the context is larger than 50,000 tokens, it runs `/compact` first: the new account has no prompt cache, so sending a huge history would burn its limit fast.

Run `claude-next` again to go back.

| Command | What it does |
|---|---|
| `claude-next` | switch account + continue |
| `CLAUDE_NEXT_LIMIT=100000 claude-next` | change the auto-compact threshold |
| `echo 2 > ~/.claude-profile` | tell it you are on profile 2 (next switch goes to 1) |
| `claude2 mcp add ...` | MCP servers added later must be added to both profiles |

Don't run `!claude-next` inside Claude. It needs a real terminal and will refuse.

## How it works

- `claude2` is `CLAUDE_CONFIG_DIR=~/.claude-2 claude`.
- The installer symlinks shared items from `~/.claude` into `~/.claude-2`. It copies `~/.claude.json` (MCP servers, preferences) without the account fields.
- `~/.claude-profile` remembers which profile you're on.
- Both profiles write transcripts to the same `projects` folder, so `--continue` finds the same conversation.

## Uninstall

```bash
rm -rf ~/.claude-2 ~/.claude-profile ~/.local/bin/claude2 ~/.local/bin/claude-next
```

## Note

Follow Anthropic's [terms](https://www.anthropic.com/legal/consumer-terms). Use accounts that are yours, and don't use this to get around usage limits in ways the terms don't allow.
