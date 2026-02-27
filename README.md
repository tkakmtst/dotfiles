# dotfiles

個人用の dotfiles リポジトリ。

## セットアップ

他の端末でこの dotfiles を使用する場合は、以下のコマンドを実行してください。

```sh
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/dotfiles
cd ~/dotfiles
./setup.sh
```

セットアップスクリプトは以下を自動的に行います：
- 既存ファイルのバックアップ（タイムスタンプ付き）
- `.tmux.conf` → `~/.tmux.conf` のシンボリックリンク作成
- `nvim/` → `~/.config/nvim` のシンボリックリンク作成
- `bin/work` → `~/bin/work` のシンボリックリンク作成
- `bin/wt` → `~/bin/wt` のシンボリックリンク作成
- スクリプトへの実行権限付与

セットアップ後、`~/bin` を PATH に追加する必要がある場合があります（スクリプトが案内します）。

## 構成

```
.
├── .tmux.conf          # tmux 設定
├── bin/
│   ├── work            # 開発用 tmux ワークスペース起動スクリプト
│   └── wt              # git worktree 管理スクリプト
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

## bin/wt

git worktree を簡単に管理するためのスクリプト。

### 使い方

```sh
# 既存ブランチのworktreeを作成
wt add feat/new-feature

# 新しいブランチを作成してworktreeに
wt new fix/bug-123

# worktree一覧を表示
wt list

# worktreeを削除
wt remove feat/new-feature

# 不要なworktree情報をクリーンアップ
wt prune

# ヘルプを表示
wt help
```

### 特徴

- worktreeは `~/worktrees/<repo-name>/<branch-name>` に自動作成される
- ブランチ名のスラッシュは自動的にハイフンに置換される
- 環境変数 `WORKTREE_BASE` でworktreeの作成先を変更可能

### 例

```sh
# feat/user-auth ブランチのworktreeを作成
$ wt add feat/user-auth
# → ~/worktrees/myproject/feat-user-auth に作成される

# 新しいfix/login-bugブランチを作成してworktreeに
$ wt new fix/login-bug
# → fix/login-bug ブランチが作成され、~/worktrees/myproject/fix-login-bug にworktreeが作成される
```
