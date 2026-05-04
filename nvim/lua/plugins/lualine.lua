return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      local c = opts.sections.lualine_c
      if c then
        c[#c] = { "filename", path = 1 }
      end
    end,
  },
}
