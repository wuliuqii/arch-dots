return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = function()
        vim.cmd.colorscheme(vim.o.background == "light" and "catppuccin-latte" or "catppuccin-macchiato")
      end,
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      -- transparent_background = true,
      term_colors = true,
    },
  },
}
