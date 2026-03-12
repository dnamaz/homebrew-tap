# dnamaz/homebrew-tap

Homebrew formulae for developer tools by [dnamaz](https://github.com/dnamaz).

## Install

```bash
brew tap dnamaz/tap
```

## Formulae

### Cleave

AI-powered GitHub PR analysis — split large PRs into logical, reviewable groups.

```bash
brew install cleave
```

**First-time setup:**

```bash
# Interactive setup (prompts for GitHub App credentials)
cleave setup

# Or with an admin-provisioned token (one string, no prompts)
cleave setup --token CLEAVE-...
```

**Run:**

```bash
cleave
# Open http://localhost:9090
```

**Commands:**

| Command | Description |
|---------|-------------|
| `cleave` | Start the app |
| `cleave setup` | Interactive first-time setup |
| `cleave setup --token T` | Setup from admin token |
| `cleave admin-provision` | Generate a setup token for colleagues |
| `cleave status` | Show current configuration |
| `cleave reset` | Remove all config and data |
| `brew services start cleave` | Run as background service |

Configuration is stored at `~/.config/cleave/`.

---

### Noetic

Web search, crawl, and knowledge cache for AI coding assistants.

```bash
brew install noetic
```

**CLI usage (works immediately, no server needed):**

```bash
noetic --websearch.adapter.default-mode=cli search "your query"
noetic --websearch.adapter.default-mode=cli crawl "https://example.com"
```

**Run as MCP server:**

```bash
brew services start noetic
```

**Install AI assistant skills:**

```bash
noetic install-skill --target=cursor
noetic install-skill --list
```

