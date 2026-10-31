# synvim

> **Fast, Minimalist Neovim Setup with Black-and-White Theme, Window Splits, and Voice Dictation**

---

## 1. Overview

`synvim` is a streamlined Neovim configuration built for speed, focused editing, and simple window management.

- **Black-and-White Theme**: Clean high-contrast grayscale colorscheme (`mono.lua`) that is easy to read.
- **Tiling Splits & Terminals**: Quickly split windows, launch terminals, and track directories across editor buffers.
- **Voice Dictation (`:Listen` / `<leader>v`)**: Speak into your microphone to insert text into your buffer using [`scribe`](https://github.com/Syntra-Labs/scribe).
- **Fast Code Search (`:Find` / `<leader>f`)**: Fast file, symbol, and documentation search powered by [`router`](https://github.com/Syntra-Labs/router).
- **Recent Files (`:History` / `<leader>h`)**: Jump back to recently opened files with quick preview.

---

## 2. Installation

```bash
git clone https://github.com/Syntra-Labs/synvim.git
cd synvim
./setup.sh
```

This copies the configuration to `~/.config/nvim` and installs plugins via `lazy.nvim`.

---

## 3. Core Commands

Run `:Synvim help` inside Neovim at any time to view this quick reference.

| Command | Shortcut | Action |
| :--- | :--- | :--- |
| `:Find [query]` | `<leader>f` | Search files, words, and code symbols |
| `:Find @deps <query>` | | Search in project dependencies (`node_modules`, `.venv`, `.lake`) |
| `:Find @algo <query>` | | Search algorithms and data structures |
| `:Find @loogle <query>` | | Search Lean 4 & Mathlib theorems |
| `:Find @docs <query>` | | Search language documentation |
| `:History` | `<leader>h` | Open recent files list |
| `:History clear` | | Clear recent files history |
| `:Listen` | `<leader>v` | Voice dictation into buffer via `scribe` |
| `:Synvim help` | | Open command and shortcut help window |

---

## 4. Window & Split Shortcuts

| Shortcut | Action |
| :--- | :--- |
| `Alt + Arrow` | Move focus between splits |
| `Alt + h/j/k/l` | Swap current split with neighbor |
| `Alt + z` | Zoom / unzoom current split |
| `Alt + q` / `Alt + w` | Close current split |
| `Alt + +` | Split right with a new terminal |
| `Alt + _` | Split down with a new terminal |
| `Esc` | Return to Normal mode from terminal prompt |

---

## 5. Related Tools

- **Task Management**: [`Syntra-Labs/taskflow`](https://github.com/Syntra-Labs/taskflow) — Track tasks directly in code comments.
- **Voice Transcription**: [`Syntra-Labs/scribe`](https://github.com/Syntra-Labs/scribe) — Fast local speech-to-text CLI.
- **Code Search**: [`Syntra-Labs/router`](https://github.com/Syntra-Labs/router) — Fast C++ search engine.
- **Practice Exercises**: [`Syntra-Labs/tutor`](https://github.com/Syntra-Labs/tutor) — Systems programming problem sets.
