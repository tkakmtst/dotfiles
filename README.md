# dotfiles

個人用の dotfiles リポジトリ。

## 構成

```
.
├── .tmux.conf          # tmux 設定
├── bin/
│   └── work            # 開発用 tmux ワークスペース起動スクリプト
├── nvim/               # Neovim 設定 (~/.config/nvim)
│   ├── init.lua
│   ├── lazy-lock.json
│   ├── lazyvim.json
│   ├── .neoconf.json
│   └── lua/
│       ├── config/
│       │   ├── autocmds.lua
│       │   ├── keymaps.lua
│       │   ├── lazy.lua
│       │   └── options.lua
│       └── plugins/
│           └── example.lua
└── README.md
```

## Neovim

[LazyVim](https://www.lazyvim.org/) ベースの設定。プラグインマネージャーに [lazy.nvim](https://github.com/folke/lazy.nvim) を使用。

### プラグイン一覧

| カテゴリ | プラグイン |
|---|---|
| 補完 | blink.cmp, friendly-snippets, lazydev.nvim |
| LSP | nvim-lspconfig, mason.nvim, mason-lspconfig.nvim |
| Lint / Format | nvim-lint, conform.nvim |
| Treesitter | nvim-treesitter, nvim-treesitter-textobjects, nvim-ts-autotag, ts-comments.nvim |
| UI | lualine.nvim, bufferline.nvim, which-key.nvim, noice.nvim, nui.nvim, snacks.nvim, mini.icons |
| カラースキーム | tokyonight.nvim, catppuccin |
| ナビゲーション | flash.nvim, trouble.nvim, grug-far.nvim |
| Git | gitsigns.nvim |
| テキスト編集 | mini.ai, mini.pairs, todo-comments.nvim |
| セッション | persistence.nvim |

### カスタマイズ

`lua/config/` 配下のファイルを編集して LazyVim のデフォルトを上書きできる。

- `options.lua` — エディタオプション
- `keymaps.lua` — キーマップ
- `autocmds.lua` — 自動コマンド

カスタムプラグインは `lua/plugins/` に追加する。

## tmux

- マウス操作を有効化 (`set -g mouse on`)

## bin/work

tmux で開発ワークスペースを構築するスクリプト。

```
+---------------------------+----------+
|      nvim (70%)           | claude   |
|                           | (30%)    |
+---------------------------+          |
|    terminal (30%)         |          |
+---------------------------+----------+
```

カレントディレクトリ名をセッション名として tmux セッションを作成し、nvim と claude を自動起動する。

```sh
chmod +x bin/work
./bin/work
```
