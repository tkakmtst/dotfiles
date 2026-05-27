return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 300,
      },
      current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
    },
    keys = {
      { "<leader>gB", function() require("gitsigns").blame_line({ full = true }) end, desc = "Blame Line (full)" },
      { "<leader>gt", function() require("gitsigns").toggle_current_line_blame() end, desc = "Toggle Line Blame" },
    },
  },

  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFileHistory" },
    keys = {
      { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File History (current)" },
      { "<leader>gH", "<cmd>DiffviewFileHistory<cr>",   desc = "File History (repo)" },
      { "<leader>gv", "<cmd>DiffviewOpen<cr>",          desc = "Diff View" },
      { "<leader>gV", "<cmd>DiffviewClose<cr>",         desc = "Diff View Close" },
    },
  },

  {
    "akinsho/git-conflict.nvim",
    version = "*",
    event = "BufReadPre",
    opts = {
      default_mappings = true,
      default_commands = true,
      disable_diagnostics = false,
      list_opener = "copen",
      highlights = {
        incoming = "DiffAdd",
        current = "DiffText",
      },
    },
    keys = {
      { "<leader>gco", "<cmd>GitConflictChooseOurs<cr>",    desc = "Conflict: Choose Ours" },
      { "<leader>gct", "<cmd>GitConflictChooseTheirs<cr>",  desc = "Conflict: Choose Theirs" },
      { "<leader>gcb", "<cmd>GitConflictChooseBoth<cr>",    desc = "Conflict: Choose Both" },
      { "<leader>gc0", "<cmd>GitConflictChooseNone<cr>",    desc = "Conflict: Choose None" },
      { "<leader>gcl", "<cmd>GitConflictListQf<cr>",        desc = "Conflict: List in Quickfix" },
      { "]x",          "<cmd>GitConflictNextConflict<cr>",  desc = "Next Conflict" },
      { "[x",          "<cmd>GitConflictPrevConflict<cr>",  desc = "Prev Conflict" },
    },
  },
}
