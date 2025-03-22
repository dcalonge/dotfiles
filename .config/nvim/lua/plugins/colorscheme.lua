return {
  -- Add the Nightfox colorscheme plugin
  { "EdenEast/nightfox.nvim" },

  -- Configure LazyVim to use Nightfox as the default colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "carbonfox",
    },
  },
}
