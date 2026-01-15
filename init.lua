-- ==========================================================================
-- Legend@Yuki // RED TEAM COMMAND & CONTROL v19.0 [THE ULTIMATE FIX]
-- ==========================================================================

-- 1. BOOTSTRAP LAZY.NVIM
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- 2. SYSTEM HARDENING
vim.g.mapleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.cursorline = true
vim.opt.laststatus = 3
vim.opt.timeoutlen = 300

-- 3. THE PLUGINS
require("lazy").setup({
  -- THEME
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({ style = "night", transparent = false, terminal_colors = true })
      vim.cmd[[colorscheme tokyonight-night]]
    end,
  },

  -- THE HUD
  { "folke/which-key.nvim", event = "VeryLazy", config = function() require("which-key").setup() end },

  -- THE DASHBOARD (Switching to Doom for mobile stability)
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('dashboard').setup({
        theme = 'doom', -- GHOST "A" IS OFFICIALLY DELETED
        config = {
          header = {
            [[                                                       ]],
            [[  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗   ]],
            [[  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║   ]],
            [[  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║   ]],
            [[  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║   ]],
            [[  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║   ]],
            [[  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝   ]],
            [[                (   Neovim, BTW   )                    ]],
            [[                                                       ]],
            [[              +-------------------------+              ]],
            [[              |         F U C K         |              ]],
            [[              |      V S   C O D E      |              ]],
            [[              +-------------------------+              ]],
            [[                                                       ]],
          },
          center = {
            { icon = '󰊄 ', desc = '105M Tokens      ', action = 'Telescope find_files', key = 'f' },
            { icon = ' ', desc = 'LFS Book         ', action = 'vsplit | terminal w3m https://www.linuxfromscratch.org/lfs/view/stable/', key = 'l' },
            { icon = ' ', desc = 'The Lab (Git)    ', action = 'LazyGit', key = 'g' },
            { icon = ' ', desc = 'Identity Config  ', action = 'e $MYVIMRC', key = 'c' },
            { icon = '󰓾 ', desc = 'Scan Network     ', action = 'ReconLocal', key = 'n' },
          },
          footer = { "Mommy's talented little operator is live~" },
        },
      })
    end,
    dependencies = { {'nvim-tree/nvim-web-devicons'}}
  },

  -- WEAPONRY
  { "kdheepak/lazygit.nvim", cmd = { "LazyGit" }, keys = { { "<leader>gg", "<cmd>LazyGit<CR>" } } },
  { 'nvim-telescope/telescope.nvim', tag = '0.1.8', dependencies = { 'nvim-lua/plenary.nvim' } },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  {
    'nvim-lualine/lualine.nvim',
    config = function() require('lualine').setup({ options = { theme = 'tokyonight' } }) end
  },
})

-- 4. RECON FUNCTIONS
vim.api.nvim_create_user_command("ReconLocal", function()
  vim.cmd("vsplit | terminal nmap -sn 192.168.10.0/24")
end, {})

-- 5. THE TOKYO OVERRIDES (The Glow)
vim.api.nvim_set_hl(0, "DashboardHeader", { fg = "#bb9af7" }) -- Tokyo Pink
vim.api.nvim_set_hl(0, "DashboardIcon", { fg = "#7aa2f7" })   -- Tokyo Blue
vim.api.nvim_set_hl(0, "DashboardKey", { fg = "#9ece6a" })    -- Tokyo Green
vim.api.nvim_set_hl(0, "DashboardDesc", { fg = "#c0caf5" })   -- Tokyo Text
vim.api.nvim_set_hl(0, "DashboardFooter", { fg = "#565f89" }) -- Comment Gray

-- 6. KEYMAPS
vim.keymap.set("n", "<leader>sc", "<cmd>e $MYVIMRC<CR>", { desc = "Edit Config" })
