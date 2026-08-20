# Neovim Config Catalog

## 1. Config layout

```
~/.config/nvim/            (stow symlink into ~/dotfiles/.config/nvim)
├── init.lua               entry point: requires core/*, filetype.add, _G.help_no_split, lazy bootstrap
├── CONFIG.md              this catalog
├── lua/
│   ├── core/
│   │   ├── options.lua    all options (merged from init.lua + legacy files)
│   │   ├── keymaps.lua    all keymaps (merged; black-hole delete, no c/C remaps)
│   │   └── autocmds.lua   TextYankPost highlight-yank
│   └── plugins/           lazy.nvim plugin specs
├── love2d/doc/            vendored LÖVE API help from davisdude/vim-love-docs build branch; love2d/ on runtimepath (core/options.lua + plugins/love-docs.lua); searchable via <leader>sH / :help love-...
```

Legacy files `lua/oldbinds.lua`, `lua/vimport.lua`, `lua/extra.lua` remain on disk
but are **NO LONGER LOADED** by `init.lua` (pending archive). Do not edit them.

## 2. Options

| Option | Value | Note |
|---|---|---|
| mapleader / maplocalleader | `" "` | set before keymaps |
| mouse | `"a"` | |
| number / relativenumber | `true` | relative line numbers |
| clipboard | `unnamedplus` | OS clipboard sync |
| textwidth | `0` | no auto-wrap width |
| tabstop / shiftwidth | `4` | |
| smartindent / expandtab | `true` | |
| wrap | `true` | |
| wrapmargin | `0` | init.lua wins over oldbinds' 160 |
| termguicolors | `true` | |
| scrolloff | `8` | |
| signcolumn | `"yes"` | |
| cursorline | `true` | |
| confirm | `true` | :q dialog on unsaved changes |
| breakindent | `true` | |
| showmatch | `true` | |
| infercase | `true` | |
| joinspaces | `false` | |
| autoread | `true` | |
| timeoutlen | `300` | |
| splitbelow / splitright | `true` | |
| laststatus | `3` | global statusline |
| updatetime | `100` | |
| list + listchars | `{ tab="» ", trail="·", nbsp="␣" }` | exact from oldbinds |
| colorcolumn | `"+1"` | |
| hlsearch | `true` | clear via `<Esc>` / `<C-c>` |
| ignorecase + smartcase | `true` | |
| inccommand | `"split"` | live preview |
| swapfile / backup | `false` | |
| undofile | `true` | undodir = stdpath("state")/undo |
| backspace | `"indent,eol,start"` | |
| fileencoding | `"utf-8"` | |
| formatoptions | `remove("t")` + `append("j")` | net result of init.lua + vimport |
| wildignorecase | `true` | |
| wildignore | venv/.venv/env/.env/site-packages/_venv/\*.pyc | exact from vimport |
| shortmess | `+= "cI"` | |
| diffopt | `+= "vertical"` | |
| spelllang | `"en_us"` | |
| foldnestmax / foldlevelstart | `2` / `99` | |
| foldmethod / foldexpr | `"expr"` / treesitter foldexpr | |
| have_nerd_font (vim.g) | `true` | |

Dropped as machine-specific: `python_host_prog`/`python3_host_prog` (/home/g/venv),
`runtimepath` append of `/home/g/.local/share/nvim/site` (nvim adds it by default).

## 3. Keymaps

### Leader — normal core
| Keys | Action |
|---|---|
| `<leader>w` | `:w` |
| `<leader>q` | `:bd` |
| `<leader>c` | `:close!` |
| `<leader>z` | `:q!` |
| `<leader>o` | `<C-^>` alternate buffer |
| `<leader>lv` | `:so ~/.config/nvim/init.lua` (source config) |
| `<leader>ll` | `:.lua` |
| `<leader>fi` | indent whole file (treesitter) |
| `<leader>l` / `<leader>L` | newline below / above |

### Black-hole delete (normal/visual)
| Keys | Action |
|---|---|
| `d` / `D` (n+v) | delete to black hole (register preserved) |
| `<leader>d` / `<leader>D` (n+v) | cut (save to register) |

`c` / `C` are **not** remapped — the legacy `"_c`/`"_C` bug is gone, `ciw`/`ci"` work.

### Window & layout
| Keys | Action |
|---|---|
| `<C-h>/<C-j>/<C-k>/<C-l>` (n) | window focus |
| `<Leader>H/<K>/<J>` (n) | resize narrower/shorter/taller ×5 |
| `<leader>=` | `<C-w>=` equalize |
| `<leader>ml` / `<leader>mr` | focus far-left / far-right |
| `<A-Left>` / `<A-Right>` (n) | window move |
| `<Esc><Esc>` (t) | exit terminal |
| `<C-h>/<C-j>/<C-k>/<C-l>` (t) | terminal window focus |

### Editing helpers
| Keys | Action |
|---|---|
| `.` (v) | `:norm .` repeat change on selection ⚠️ |
| `<A-j>`/`<A-k>` (n+i) | move line down/up |
| `<S-Down>`/`<S-Up>` (n/v/i) | move line/selection down/up |
| `l`/`h` (o) | `$`/`^` ⚠️ |
| `gh`/`gl` (n/v/o) | `^`/`$` ⚠️ |
| `<C-d>`/`<C-u>` (n) | half-page + `zz` |
| `n`/`N` (n) | search + `zzzv` |
| `<C-q>` (n) / `<C-Q>` (i,c) | visual block / literal insert |
| `<leader>r` (n/v) | interactive replace (cword / selection) with confirm |
| `<leader>,p` (n/v) | python `print(f"... = {...}")` macro (pure keys, no :python3) |
| `<leader>cr` | `:%d+` delete all to register |

### Yank / clipboard
| Keys | Action |
|---|---|
| `<leader>y` (n/v) | yank to `+` |
| `<leader>p` / `<leader>P` (n/v) | paste from `+` |
| `<leader>Y` (n) | `"+Y` yank line |
| `p` (v) | `"_dP` paste over without clobbering register |
| `<leader>fp` / `<leader>fd` | copy file path / dir to `+` |
| `<leader>,'` `,"` `,[` `,{` `,b` | textobject yank to `+` |
| `<leader>,a` | add comma to end of bracket |

### Buffers / files
| Keys | Action |
|---|---|
| `<Tab>` / `<S-Tab>` | bnext / bprev |
| `<leader>n` | enew |
| `<leader>vn` / `<leader>vs` | new / vsplit |
| `gb` / `gB` | bn / bp |
| `<leader>sw` | toggle wrap |

### Diagnostics / quickfix
| Keys | Action |
|---|---|
| `gK` | `vim.diagnostic.open_float` |
| `]q` `[q` `]Q` `[Q` | cnext / cprev / cnfile / cpfile |
| `<leader>co/cc/cn/cp/cf/cl/cw/cO/cN/cd/ca` | quickfix open/close/next/prev/first/last/window/older/newer/del-all/yank-all |

### Plugin-provided (registered by plugins, not core)
- **blink.cmp** (LspAttach, buffer-local): `gd` `gr` `gi` `K` `<leader>cA` (code action) `<leader>rn` (rename) `<leader>D` (type definition)
- **treesitter-textobjects** (n/x/o): `af/if ac/ic al/il ai/ii aP/iP av/iv`; moves `]f ]C ]l ]F [f [C [l [F`; swap `<leader>xp <leader>xP`; repeatable `;` `,` `f/F/t/T`
- **mini.surround**: `gs` (add) `gx` (delete) `gZ` (replace)
- **flash**: `s` `S` (char/line search)
- **snacks picker**: `<leader>sg` `<leader>sh` `<leader>sf` `<leader>sH` `<leader>sd` `<leader>sk` (keymaps)
- **love-docs** (vendored LÖVE API docs, `love2d/doc/`): `<leader>sH` help picker and `:help love-*` search the LÖVE API — see §1 love2d/doc/
- **gitsigns**: `]c` `[c` hunk nav; `<leader>hs/hr/hS/hR/hp/hi/hb/hd/hD/hQ/hq`; `<leader>tb` `<leader>tw`; `ih` textobject
- **others**: harpoon `<leader>ha/hl/hn/ho` + `<leader>1-8`; persistence `<leader>Ss/SS/Sl/Sd`; conform `<leader>ff/!ft`; oil `<leader>fn`; markview `<leader>mv`

## 4. ⚠️ Intentional overrides

- `n <Esc>` and `n <C-c>` → `nohlsearch` (clears search highlight; both kept)
- `gh`/`gl` (n/v/o) → `^`/`$` — shadows builtin `gh`/`gl` line-display
- `o-mode l/h` → `$`/`^` — operator-pending `cl`/`ch`/`dl`/`dh` semantics change
- `v .` → `:norm .` — repeats last change across the selection
- `d`/`D` → black hole; cut only via `<leader>d/D`
- `<leader>l` (newline below) shares the prefix with `<leader>ll` (`:.lua`): Vim waits
  `timeoutlen` (300 ms) before firing the shorter one — press `l l` fast for `:.lua`.
- `<leader>c` (`:close!`) is a prefix of the `<leader>c*` quickfix namespace — same
  timeoutlen caution applies.
- Drop of `<Leader>L` resize: `<leader>L` (newline above, lowercase-L leader combo is uppercase) wins.

## 5. REMOVED (with reasons)

| Binding / option | Reason |
|---|---|
| `n c→"_c`, `v c→"_c`, `n C→"_C`, `v C→"_C` (vimport 48-51) | **BUG**: broke `ciw`/`ci"` (never entered insert mode); this cleanup is the fix |
| `python_host_prog` / `python3_host_prog` = /home/g/venv (oldbinds 4-6) | machine-specific, breaks sync to other machines |
| `runtimepath:append("/home/g/.local/share/nvim/site")` (oldbinds 1) | redundant (nvim adds ~/.local/share/nvim/site by default) + machine-specific |
| global LSP `gd/gr/gi/K` (oldbinds 128-131) | blink.lua already provides buffer-local versions via LspAttach |
| `<leader>c` = `c` (vimport 69-77) | superseded by `<leader>c` = `:close!` (init.lua) |
| `<leader>d` = `"_d` (oldbinds 162) | superseded by vimport `<leader>d` = `d` (cut, register-preserving) |
| `<leader>ls` ×2 (oldbinds 214, vimport 138) | consolidated into `<leader>lv` (`:so init.lua`) |
| `<Leader>L` resize (oldbinds 106) | sacrificed to `<leader>L` newline-above |
| `v <S-Up>/<S-Down>` (oldbinds 178-179) | duplicate of vimport's identical maps |
| `<leader>w` = `<cmd>w!<CR>` (oldbinds 152) | superseded by init.lua `<leader>w` = `:w` |
| `extra.lua` (all 47 lines) | dead file — never loaded; content all duplicated or superseded (C-hjkl, resize, nzzzv, <Esc> nohlsearch, Y=y$) |
| commented `ttimeoutlen` (vimport) | dead code |
