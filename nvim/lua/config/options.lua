-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- 行番号設定
vim.opt.relativenumber = false  -- 相対行番号を無効化
vim.opt.number = true            -- 絶対行番号を表示

-- ファイルが外部で変更された場合に自動リロード
vim.opt.autoread = true

-- フォーカス時やバッファ変更時に自動チェック
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  pattern = "*",
  command = "if mode() != 'c' | checktime | endif",
})

-- ファイル変更時に通知
vim.api.nvim_create_autocmd("FileChangedShellPost", {
  pattern = "*",
  callback = function()
    vim.notify("File changed on disk. Buffer reloaded.", vim.log.levels.WARN)
  end,
})

-- クリップボード統合
vim.opt.clipboard = "unnamedplus"
