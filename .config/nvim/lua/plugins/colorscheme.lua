return {
  -- 1. Tell LazyVim to load our validated colorscheme name
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "mini-matugen",
    },
  },

  -- 2. Inject your high-contrast Matugen properties smoothly
  {
    "nvim-mini/mini.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      local function apply_matugen_theme()
        local filepath = vim.fn.stdpath("config") .. "/lua/config/matugen-theme.yaml"
        if vim.fn.filereadable(filepath) ~= 1 then
          return
        end

        -- Parse the generated Matugen YAML file securely
        local palette = {}
        for line in io.lines(filepath) do
          local key, val = line:match('^%s*(base%x%x):%s*"#?(%x+)"')
          if key and val then
            palette[key] = "#" .. val
          end
        end

        -- Load the color properties directly into the base16 constructor engine
        if next(palette) ~= nil then
          require("mini.base16").setup({
            palette = palette,
            use_cterm = false,
          })
        end
      end

      -- Intercept the initialization loop when our custom file name is evaluated
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "mini-matugen",
        callback = function()
          apply_matugen_theme()
        end,
      })

      -- Run immediately on boot to frame render the current terminal environment
      apply_matugen_theme()

      -- Hot-reload signal catcher listener (handles 'pkill -USR1 nvim' from Matugen)
      local signal = vim.uv.new_signal()
      if signal then
        signal:start(
          "sigusr1",
          vim.schedule_wrap(function()
            apply_matugen_theme()
          end)
        )
      end
    end,
  },
}
