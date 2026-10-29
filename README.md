# My Emacs settings

Personal Emacs configuration, mainly for Go and Rust, with solid support for
web frontend (JS/TS/HTML/CSS), Python and config files (Docker, YAML, JSON,
systemd, ...).

# Highlights

- **Package management**: [straight.el](https://github.com/radian-software/straight.el)
  + `use-package`. Packages track upstream (no lockfile), so every machine gets
  a similar, not identical, environment.
- **Completion**
  - Minibuffer: `vertico` + `orderless` + `marginalia` + `consult`
  - In buffer: `company` (`TAB`)
  - AI: GitHub Copilot inline suggestions (duplicated closing brackets are
    removed automatically after accepting)
- **LSP**: `lsp-mode` + `lsp-ui` + `flycheck`, debugging with `dap-mode`
- **Languages**

  | Language               | Mode                                  | Notes                                     |
  |------------------------|---------------------------------------|-------------------------------------------|
  | Go                     | `go-mode`                             | gopls, `goimports` on save, delve         |
  | Rust                   | `rust-mode`                           | rust-analyzer, inlay hints                |
  | TypeScript / TSX       | `typescript-ts-mode` / `tsx-ts-mode`  | TypeScript 7 native LSP (tsgo), prettier  |
  | JavaScript             | `js-mode`                             | tsgo                                      |
  | JSX / HTML             | `web-mode`                            | embedded JS/CSS, emmet                    |
  | CSS / SCSS / Sass      | `css-mode` / `scss-mode` / `ssass-mode` |                                         |
  | Python                 | `python-mode`                         | pyright                                   |
  | Protobuf               | `protobuf-mode`                       | buf LSP, clang-format on save             |
  | JSON                   | `json-mode`                           | `consult-jq`                              |
  | YAML / TOML / Markdown | `yaml-mode` / `toml-mode` / `markdown-mode` |                                     |
  | Others                 | Dockerfile, systemd, nginx, nix       |                                           |

- **Tools**: magit, treemacs, docker, kubernetes, pass, tramp, rime (Chinese
  input method), telega (Telegram client)

# Requirements

### Required

- Emacs 30 or newer
- git
- A C compiler (tree-sitter grammars for TS/TSX are built on first start)
- Node.js and npm (Copilot and several language servers)
- Font `UbuntuMono Nerd Font Mono` (the default; see [custom.el](#per-machine-settings-customel) to use another one)

### Language servers and tools

Install the ones for the languages you use. Servers marked *lsp-mode* can be
installed from inside Emacs with `M-x lsp-install-server`.

| Tool                                         | Used by          | Install                                                    |
|----------------------------------------------|------------------|------------------------------------------------------------|
| gopls, goimports                             | Go               | `go install golang.org/x/tools/gopls@latest golang.org/x/tools/cmd/goimports@latest` |
| delve (optional)                             | Go debugging     | `go install github.com/go-delve/delve/cmd/dlv@latest`      |
| rust-analyzer                                | Rust             | `rustup component add rust-analyzer`                       |
| tsgo                                         | JS / TS          | *lsp-mode*: `tsgo`                                         |
| pyright                                      | Python           | *lsp-mode*: `pyright`                                      |
| HTML / CSS / JSON servers                    | web, JSON        | *lsp-mode*: `html-ls`, `css-ls`, `json-ls`                 |
| yaml-language-server                         | YAML             | *lsp-mode*: `yamlls`                                       |
| marksman (optional)                          | Markdown         | *lsp-mode*: `marksman`                                     |
| taplo (optional)                             | TOML             | `cargo install taplo-cli --locked`                         |
| buf                                          | Protobuf         | `go install github.com/bufbuild/buf/cmd/buf@latest`        |
| clang-format                                 | Protobuf         | system package (e.g. `apt install clang-format`)           |
| prettier                                     | JS / TS          | per project (`npm i -D prettier`), run through `npm exec`  |
| librime (optional)                           | rime             | system package (e.g. `apt install librime-dev`)            |
| docker (optional)                            | telega, docker   | system package                                             |

Protobuf projects need a `buf.yaml` at the project root so imports resolve.

# Install

Backup and remove your `~/.emacs.d` and `~/.emacs` first.

### With curl

```sh
curl https://raw.githubusercontent.com/Ronmi/emacs/master/install.sh | bash
```

### With wget

```sh
wget -q -O - https://raw.githubusercontent.com/Ronmi/emacs/master/install.sh | bash
```

The script clones this repo to `~/.emacs.d`, links `~/.emacs` to `config.el`
and creates an empty `custom.el`. Run it again to update (`git pull --ff-only`).

# First start

1. Start Emacs. straight.el clones and builds every package, and the TS/TSX
   grammars are compiled. This takes a few minutes, only the first time.
2. `M-x all-the-icons-install-fonts`. Run it again whenever icons look broken.
3. `M-x copilot-install-server`, then `M-x copilot-login`.
4. `M-x lsp-install-server` for the servers you need (see the table above).
   lsp-mode also offers to install a missing server when you open a file.

# Per-machine settings: custom.el

`custom.el` is not tracked by git and holds settings that differ between
machines. Settings saved by `M-x customize` also go there. It must exist:
`config.el` loads it on startup and fails loudly if it is missing.

Example: use another font, including CJK characters:

```elisp
(set-face-attribute 'default nil :font "Maple Mono NF CN" :height 131)
(dolist (charset '(kana han symbol cjk-misc bopomofo))
  (set-fontset-font t charset (font-spec :family "Maple Mono NF CN")))
```

# Key bindings

Only bindings that differ from Emacs and package defaults are listed.

| Key                     | Command                                         |
|-------------------------|-------------------------------------------------|
| `C-x b`                 | `consult-buffer`                                |
| `C-c c g` / `f` / `l` / `m` | consult grep / find / line / mark           |
| `C-c c q`               | `consult-jq`                                    |
| `C-c c s` / `S`         | LSP symbols in workspace / current file         |
| `C-c c e`               | LSP diagnostics                                 |
| `TAB` (code)            | indent or complete with company                 |
| `C-'` (code)            | `consult-company`                               |
| `C-<return>`            | accept Copilot suggestion                       |
| `C-n` / `C-p`           | next / previous Copilot suggestion              |
| `C-c l d` / `t` / `i` / `r` | LSP definition / type / implementation / references |
| `C-c l n`               | LSP rename                                      |
| `C-c l a`               | LSP code action                                 |
| `C-c l e`               | LSP error list (treemacs)                       |
| `C-c l w`               | restart LSP workspace                           |
| `s-l f d` / `f t` / `f i` / `f r` | same as `C-c l d` / `t` / `i` / `r` |
| `s-l s r` / `s-l s a` / `s-l w r` | rename / code action / restart LSP  |
| `s-l u d` / `s-l u i`   | LSP doc / imenu (lsp-ui)                        |
| `C-x g`                 | `magit-status`                                  |
| `DEL` (find-file)       | delete one path component                       |
