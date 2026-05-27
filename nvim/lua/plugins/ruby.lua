return {
  { import = "lazyvim.plugins.extras.lang.ruby" },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ruby_lsp = {
          -- cmd は上書きしない。デフォルト設定の cmd 関数が cwd=root_dir(=medley-clinic)
          -- を立て、グローバルの ruby-lsp が Gemfile を自動検出してプロジェクトの bundle
          -- (ruby-lsp / ruby-lsp-rails) を使う。VSCode/Cursor と同じ挙動。
          -- ここで cmd を固定リストにすると cwd が固定されず、rbenv が誤ったバージョンを
          -- 掴んで起動失敗→reuse_client が噛み合わず二重起動する。
          -- rubocop には触らせない（コードジャンプ専用）。
          -- 整形・診断は medley-clinic 側の rubocop 運用(CLI)に任せ、ruby-lsp の rubocop 連携で
          -- 起きる .rubocop.yml 読み込み失敗(ruby-lsp #3046)も回避する。
          init_options = {
            formatter = "none",
            linters = {},
          },
        },
        -- LazyVim ruby extra が有効化する別建ての rubocop LSP は使わない。
        -- ruby-lsp と診断が重複し、プロジェクトの rubocop 運用とも競合するため無効化。
        rubocop = { enabled = false },
      },
    },
  },

  -- conform からも ruby の rubocop 整形を外す（保存時の自動整形を抑止）。
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        ruby = {},
      },
    },
  },
}
