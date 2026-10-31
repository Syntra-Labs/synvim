# synvim

Minimalist Neovim configuration focused on window tiling, terminal splits, and a monochrome theme.

---

## Features

- **Monochrome Theme**: High-contrast black-and-white colorscheme (`mono.lua`).
- **Tiling Splits & Directional Navigation**: Move between window splits, swap splits, and zoom splits with `Alt` shortcuts.
- **Integrated Terminal Splits**: Open terminal splits right or down (`Alt + +`, `Alt + _`) with automatic directory tracking across editor buffers.
- **Smart Terminal Handling**: `<Esc>` drops back to Normal mode at the shell prompt without breaking escape keys inside CLI applications.
- **LSP Configuration**: Pre-configured Language Server Protocol setup (`lsp.lua`) for C++, Rust, and Python.

---

## Installation

```bash
git clone https://github.com/Syntra-Labs/synvim.git
cd synvim
./setup.sh
```

This deploys the configuration to `~/.config/nvim` and installs plugins via `lazy.nvim`.

---

## Window & Split Shortcuts

| Shortcut | Action |
| :--- | :--- |
| `Alt + Arrow` | Move focus between splits |
| `Alt + h/j/k/l` | Swap current split with adjacent neighbor |
| `Alt + z` | Zoom / maximize current split (toggle) |
| `Alt + q` / `Alt + w` | Close current split |
| `Alt + +` | Split right with a new terminal |
| `Alt + _` | Split down with a new terminal |
| `Esc` | Return to Normal mode from terminal prompt |

Run `:Synvim help` inside Neovim at any time to view this quick reference.

---

## Related Repositories

- **[`scribe`](https://github.com/Syntra-Labs/scribe)**: Standalone speech-to-text CLI for microphone recording.
- **[`router`](https://github.com/Syntra-Labs/router)**: Fast C++ code search and data routing library.
- **[`taskflow`](https://github.com/Syntra-Labs/taskflow)**: Source-first task manager tracking dependencies in code comments.
- **[`tutor`](https://github.com/Syntra-Labs/tutor)**: Systems programming problem sets and C++ test runner.
