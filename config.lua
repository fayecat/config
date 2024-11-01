local keymap = lvim.builtin.which_key.mappings
local vkeymap = lvim.builtin.which_key.vmappings

-- General settings
lvim.log.level = "warn"
lvim.format_on_save = true
-- lvim.plugins = {
-- 	"Mofiqul/dracula.nvim",
-- }
-- lvim.colorscheme = "dracula"

lvim.plugins = {
	"projekt0n/github-nvim-theme",
}
lvim.colorscheme = "github-nvim-theme"

vim.wo.wrap = true
lvim.builtin.bufferline.active = false
lvim.builtin.telescope.defaults.find_files=({
	find_command = { "fd", "-t=f", "-a" },
	path_display = { "truncate" },
})

lvim.builtin.telescope.defaults.dynamic_preview_title = true
lvim.builtin.telescope.defaults.path_display = { absolute = true }
lvim.builtin.telescope.defaults.layout_strategy = "horizontal"
lvim.builtin.telescope.defaults.layout_config = {
  horizontal = {
    prompt_position = "bottom",
    preview_width = 0.5,
    results_width = 0.5,
  },
  width = 0.9,
  height = 0.8,
  preview_cutoff = 120,
}

lvim.builtin.telescope.defaults.borderchars = {
  prompt = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
  results = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
  preview = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
}

vim.cmd [[ set showtabline=0 ]]

-- Key mappings
lvim.leader = "space"
-- Add your custom key mappings here

-- Plugin configuration
lvim.plugins = {
  {
    "nvim-telescope/telescope.nvim",
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
  },
  {"kyazdani42/nvim-tree.lua"},
  {"akinsho/bufferline.nvim"},
  {"hrsh7th/nvim-cmp"},
  {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
  -- {"L3MON4D3/LuaSnip"},
  {"numToStr/Comment.nvim"},
  {"lewis6991/gitsigns.nvim"},
  {"folke/which-key.nvim"},
  {"Mofiqul/dracula.nvim"},
  {
    'projekt0n/github-nvim-theme',
    name = 'github-theme',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require('github-theme').setup({})
  
      vim.cmd('colorscheme github_dark')
    end,
  },
  {"windwp/nvim-autopairs"},
  {"SmiteshP/nvim-navic"},
  {"tpope/vim-rsi"},
  {"lukas-reineke/indent-blankline.nvim"},
  {"tanvirtin/monokai.nvim"},
  {"navarasu/onedark.nvim"},
  {"ribru17/bamboo.nvim"},
  {"nathom/filetype.nvim"},
  {"nvim-lua/plenary.nvim"},
  {"nvim-pack/nvim-spectre"},
  {"yamatsum/nvim-cursorline"},
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>xs",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
  {"dmmulroy/tsc.nvim"},
  {"romainl/vim-cool"},
  {
    "gennaro-tedesco/nvim-jqx",
    event = {"BufReadPost"},
    ft = { "json", "yaml" },
  },
  -- {
  --   "neovim/nvim-lspconfig",
    
  --   servers = {
  --     sourcekit = {
  --       cmd = "/usr/bin/sourcekit-lsp",
  --     },
  --   },
  -- },
  {
    "neovim/nvim-lspconfig",
    -- servers = {
    --   sourcekit = {
    --     cmd = "/usr/bin/sourcekit-lsp",
    --   },
    -- },
    lazy = false,
    config = function()
      local lspconfig = require('lspconfig')

      lspconfig.clangd.setup {}
      lspconfig.rust_analyzer.setup {}
      lspconfig.tsserver.setup {}

      lspconfig.sourcekit.setup({
        capabilities = {
          workspace = {
            didChangeWatchedFiles = {
              dynamicRegistration = true,
            },
          },
        },
      })

    vim.api.nvim_create_autocmd('LspAttach', {
      desc = 'LSP Actions',
      callback = function(args)
        -- Once we've attached, configure the keybindings
        local wk = require('which-key')
        wk.register({
          K = { vim.lsp.buf.hover, "LSP hover info"},
          gd = { vim.lsp.buf.definition, "LSP go to definition"},
          gD = { vim.lsp.buf.declaration, "LSP go to declaration"},
          gi = { vim.lsp.buf.implementation, "LSP go to implementation"},
          gr = { vim.lsp.buf.references, "LSP list references"},
          gs = { vim.lsp.buf.signature_help, "LSP signature help"},
          gn = { vim.lsp.buf.rename, "LSP rename"},
          ["[g"] = { vim.diagnostic.goto_prev, "Go to previous diagnostic"},
          ["g]"] = { vim.diagnostic.goto_next, "Go to next diagnostic"},
        }, {
          mode = 'n',
          silent = true,
        })
      end,
    })
    end
  },
  -- {
  --   "romgrk/nvim-treesitter-context",
  --   lazy = true,
  --   event = { "User FileOpened" },
  --   config = function()
  --       require("treesitter-context").setup({
  --           enable = true,
  --           throttle = true,
  --           max_lines = 0, 
  --           patterns = {
  --               default = {
  --                   "class",
  --                   "function",
  --                   "method",
  --               },
  --           },
  --       })
  --   end,
  -- },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    lazy = true,
    event = { "User FileOpened" },
  },
  {
    "rmagatti/goto-preview",
    lazy = true,
    keys = { "gp" },
    config = function()
        require("goto-preview").setup({
            width = 100,
            height = 20,
            default_mappings = true,
            debug = false,
            opacity = nil,
            post_open_hook = nil, 
            references = { -- Configure the telescope UI for slowing the references cycling window.
              telescope = require("telescope.themes").get_dropdown({ hide_preview = false })
            },
            -- You can use "default_mappings = true" setup option
            -- Or explicitly set keybindings
            -- vim.cmd("nnoremap gpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>")
            -- vim.cmd("nnoremap gpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>")
            -- vim.cmd("nnoremap gP <cmd>lua require('goto-preview').close_all_win()<CR>")
        })
    end,
  },
  {
    "ethanholz/nvim-lastplace",
    lazy = true,
    event = { "User FileOpened" },
    config = function()
        require("nvim-lastplace").setup({
            lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
            lastplace_ignore_filetype = {
                "gitcommit",
                "gitrebase",
                "svn",
                "hgcommit",
            },
            lastplace_open_folds = true,
        })
    end,
  },
  {
    "andymass/vim-matchup",
    -- Highlight, jump between pairs like if..else
    lazy = true,
    event = { "User FileOpened" },
    config = function()
        vim.g.matchup_matchparen_offscreen = { method = "popup" }
        lvim.builtin.treesitter.matchup.enable = true
    end,
 },
 {
    "zbirenbaum/neodim",
    lazy = true,
    event = "LspAttach",
    config = function()
        require("neodim").setup({
            alpha = 0.75,
            blend_color = "#000000",
            update_in_insert = {
                enable = true,
                delay = 100,
            },
            hide = {
                virtual_text = true,
                signs = false,
                underline = false,
            },
        })
    end,
  },
  -- {"wojciech-kulik/ios-dev-starter-nvim"},
  -- {
  --   "wojciech-kulik/xcodebuild.nvim",
  --   dependencies = {
  --     "nvim-telescope/telescope.nvim",
  --     "MunifTanjim/nui.nvim",
  --     "nvim-tree/nvim-tree.lua", -- (optional) to manage project files
  --     "stevearc/oil.nvim", -- (optional) to manage project files
  --     "nvim-treesitter/nvim-treesitter", -- (optional) for Quick tests support (required Swift parser)
  --   },
  --   config = function()
  --     require("xcodebuild").setup({
  --         -- put some options here or leave it empty to use default settings
  --     })
  --   end,
  -- },
  {
    "j-hui/fidget.nvim",
  },
  -- {
  --   "rcarriga/nvim-notify",
  --   lazy = true,
  --   event = "VeryLazy",
  --   config = function()
  --       local notify = require("notify")
  --       notify.setup({
  --           -- "fade", "slide", "fade_in_slide_out", "static"
  --           stages = "slide",
  --           on_open = nil,
  --           on_close = nil,
  --           timeout = 3000,
  --           fps = 1,
  --           render = "default",
  --           background_colour = "Normal",
  --           max_width = math.floor(vim.api.nvim_win_get_width(0) / 2),
  --           max_height = math.floor(vim.api.nvim_win_get_height(0) / 4),
  --           -- minimum_width = 50,
  --           -- ERROR > WARN > INFO > DEBUG > TRACE
  --           level = "TRACE",
  --       })

  --       vim.notify = notify
  --   end,
  -- },
  {
    "simrat39/symbols-outline.nvim",
        lazy = true,
        cmd = { "SymbolsOutline", "SymbolsOutlineOpen", "SymbolsOutlineClose" },
        config = function()
            local opts = {
                highlight_hovered_item = true,
                show_guides = true,
                auto_preview = false,
                position = "right",
                relative_width = true,
                width = 25,
                auto_close = false,
                show_numbers = false,
                show_relative_numbers = false,
                show_symbol_details = true,
                preview_bg_highlight = "Pmenu",
                autofold_depth = nil,
                auto_unfold_hover = true,
                fold_markers = { "", "" },
                wrap = false,
                keymaps = { -- These keymaps can be a string or a table for multiple keys
                    close = { "<Esc>", "q" },
                    goto_location = "<Cr>",
                    focus_location = "o",
                    hover_symbol = "<C-space>",
                    toggle_preview = "K",
                    rename_symbol = "r",
                    code_actions = "a",
                    fold = "h",
                    unfold = "l",
                    fold_all = "P",
                    unfold_all = "U",
                    fold_reset = "Q",
                },
                lsp_blacklist = {},
                symbol_blacklist = {},
                symbols = {
                    File = { icon = "", hl = "@text.uri" },
                    Module = { icon = "", hl = "@namespace" },
                    Namespace = { icon = "", hl = "@namespace" },
                    Package = { icon = "", hl = "@namespace" },
                    Class = { icon = "𝓒", hl = "@type" },
                    Method = { icon = "ƒ", hl = "@method" },
                    Property = { icon = "", hl = "@method" },
                    Field = { icon = "", hl = "@field" },
                    Constructor = { icon = "", hl = "@constructor" },
                    Enum = { icon = "", hl = "@type" },
                    Interface = { icon = "ﰮ", hl = "@type" },
                    Function = { icon = "", hl = "@function" },
                    Variable = { icon = "", hl = "@constant" },
                    Constant = { icon = "", hl = "@constant" },
                    String = { icon = "𝓐", hl = "@string" },
                    Number = { icon = "#", hl = "@number" },
                    Boolean = { icon = "", hl = "@boolean" },
                    Array = { icon = "", hl = "@constant" },
                    Object = { icon = "", hl = "@type" },
                    Key = { icon = "🔐", hl = "@type" },
                    Null = { icon = "NULL", hl = "@type" },
                    EnumMember = { icon = "", hl = "@field" },
                    Struct = { icon = "𝓢", hl = "@type" },
                    Event = { icon = "🗲", hl = "@type" },
                    Operator = { icon = "+", hl = "@operator" },
                    TypeParameter = { icon = "𝙏", hl = "@parameter" },
                    Component = { icon = "󰡀", hl = "@function" },
                    Fragment = { icon = "", hl = "@constant" },
                },
            }
            require("symbols-outline").setup(opts)
        end,
  },
  {
    "nvim-zh/colorful-winsep.nvim",
    lazy = true,
    event = "WinNew",
    config = function()
        require("colorful-winsep").setup()
    end,
  },
  {
    "karb94/neoscroll.nvim",
    lazy = true,
    -- event = "WinScrolled",
    keys = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
    config = function()
        require("neoscroll").setup({
            -- All these keys will be mapped to their corresponding default scrolling animation
            -- mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
            hide_cursor = true,
            stop_eof = true,
            use_local_scrolloff = false,
            respect_scrolloff = false,
            cursor_scrolls_alone = true,
            -- quadratic, cubic, quartic, quintic, circular, sine
            easing_function = "cubic",
            pre_hook = nil,
            post_hook = nil,
        })

        local t = {}
        t["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "50", [['cubic']] } }
        t["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "50", [['cubic']] } }
        t["<C-b>"] = { "scroll", { "-vim.api.nvim_win_get_height(0)", "true", "50", [['cubic']] } }
        t["<C-f>"] = { "scroll", { "vim.api.nvim_win_get_height(0)", "true", "50", [['cubic']] } }
        t["<C-y>"] = { "scroll", { "-0.10", "false", "50", [['cubic']] } }
        t["<C-e>"] = { "scroll", { "0.10", "false", "50", [['cubic']] } }
        t["zt"] = { "zt", { "100", [['cubic']] } }
        t["zz"] = { "zz", { "100", [['cubic']] } }
        t["zb"] = { "zb", { "100", [['cubic']] } }

        require("neoscroll.config").set_mappings(t)
    end,
  },
  {
    'akinsho/flutter-tools.nvim',
    lazy = false,
    dependencies = {
        'nvim-lua/plenary.nvim',
        "neovim/nvim-lspconfig",
        'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
    config = true,
  },
  {
    "ray-x/go.nvim",
    dependencies = {  -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup()
    end,
    event = {"CmdlineEnter"},
    ft = {"go", 'gomod'},
    build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
  },
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    -- branch = "develop", -- if you want develop branch
                           -- keep in mind, it might break everything
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "mfussenegger/nvim-dap", -- (optional) only if you use `gopher.dap`
    },
    -- (optional) will update plugin's deps on every update
    build = function()
      vim.cmd.GoInstallDeps()
    end,
    ---@type gopher.Config
    opts = {},
  },
  {
    "cuducos/yaml.nvim",
    ft = { "yaml" }, -- optional
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim", -- optional
    },
  },
  {'iamcco/markdown-preview.nvim'},
  { "ellisonleao/dotenv.nvim" },
  {"NvChad/nvim-colorizer.lua"},
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = {
      -- configurations go here
    },
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup {
        options = {
          -- theme = 'dracula',
          -- theme = 'github-nvim-theme',
          refresh = {
            statusline = 100,
          },
        },
        sections = {
          lualine_c = { { 'filename', path = 2 } }
        } 
      }
    end
  },
}

-- require('monokai').setup { italics = false }
-- require('monokai').load()
-- require('onedark').setup {
--   style = 'cool'
-- }
-- require('onedark').load()


require("filetype").setup({
  overrides = {
      extensions = {
          -- Set the filetype of *.pn files to potion
          pn = "potion",
      },
      literal = {
          -- Set the filetype of files named "MyBackupFile" to lua
          MyBackupFile = "lua",
      },
      complex = {
          -- Set the filetype of any full filename matching the regex to gitconfig
          [".*git/config"] = "gitconfig", -- Included in the plugin
      },

      -- The same as the ones above except the keys map to functions
      function_extensions = {
          ["cpp"] = function()
              vim.bo.filetype = "cpp"
              -- Remove annoying indent jumping
              vim.bo.cinoptions = vim.bo.cinoptions .. "L0"
          end,
          ["pdf"] = function()
              vim.bo.filetype = "pdf"
              -- Open in PDF viewer (Skim.app) automatically
              vim.fn.jobstart(
                  "open -a skim " .. '"' .. vim.fn.expand("%") .. '"'
              )
          end,
      },
      function_literal = {
          Brewfile = function()
              vim.cmd("syntax off")
          end,
      },
      function_complex = {
          ["*.math_notes/%w+"] = function()
              vim.cmd("iabbrev $ $$")
          end,
      },

      shebang = {
          -- Set the filetype of files with a dash shebang to sh
          dash = "sh",
      },
  },
})


local function cmd(command)
  return table.concat({ '<Cmd>', command, '<CR>' })
end

require('dotenv').setup({
  enable_on_load = true, -- will load your .env file upon loading a buffer
  verbose = false, -- show error notification if .env file is not found and if .env is loaded
})

require 'colorizer'.setup {
  filetypes = {
    '*',
    html = { mode = 'foreground'; }
  },
}

require('tsc').setup()

require("lvim.lsp.manager").setup("sourcekit", opts)

require('cmp').setup {
  enabled = true,
  autocomplete = true,
  source = {
    path = true,
    buffer = true,
    nvim_lsp = true,
    nvim_lua = true,
  },
}

require("flutter-tools").setup {}


require('spectre').setup({
  color_devicons=true,
  lnum_for_results = true,
  highlight = {
    ui = "String",
    search = "DiffChange",
    replace = "DiffDelete"
  },
  line_sep_start = '┌-----------------------------------------',
  result_padding = '¦  ',
  line_sep       = '└-----------------------------------------',
  live_update=true,
  is_insert_mode=true
})
lvim.keys.normal_mode["<leader>sg"] = ":Spectre<CR>"
function Spectre_search_current_file()
  local spectre = require("spectre")
  spectre.open_file_search({select_word=false})
end
lvim.keys.normal_mode["<leader>s/"] = ":lua Spectre_search_current_file()<CR>"
lvim.keys.normal_mode["<leader>r"] = ":e!<CR>"

vim.opt.foldmethod = 'expr'
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 9999
vim.wo.fillchars = "fold: "
vim.wo.foldtext = [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)']]


lvim.builtin.treesitter.context_commentstring.enable_autocmd = false
lvim.keys.insert_mode["<M-]>"] = { "<Plug>(copilot-next)", { silent = true } }

lvim.builtin.breadcrumbs.active = false


-- 设置 Space + 方向键来切换窗口
vim.api.nvim_set_keymap('n', '<Space><Left>', '<C-w>h', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Space><Down>', '<C-w>j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Space><Up>', '<C-w>k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Space><Right>', '<C-w>l', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<Space>]', ':vsp<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Space>[', ':sp<CR>', { noremap = true, silent = true })


-- vim.api.nvim_set_keymap('n', '<Space>.', ':lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<Space>,', '<C-t>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Space>.', ":lua require('goto-preview').goto_preview_definition()<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<Space>,', '<C-t>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'D-.', ':lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'D-,', '<C-t>', { noremap = true, silent = true })

vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

vim.keymap.set("n", "<Down>", "gj")
vim.keymap.set("n", "<Up>", "gk")


vim.keymap.set("v", "j", "gj")
vim.keymap.set("v", "k", "gk")

vim.keymap.set("v", "<Down>", "gj")
vim.keymap.set("v", "<Up>", "gk")

-- inoremap <Down> gj
-- inoremap <Up> gk
vim.api.nvim_set_keymap("i", "<Up>", "<C-o>gk", { noremap = true, silent = true })

vim.api.nvim_set_keymap("i", "<Down>", "<C-o>gj", { noremap = true, silent = true })



lvim.builtin.alpha.dashboard.section.header.val = {
  " ",
  " ",
  " ",
  " ",
  " ",
  " ",
  " ",
  " ",
  " ",
  " ",
  " ",
  " ",
  " ",
  " "
}

lvim.builtin.alpha.dashboard.section.footer.val = {
  " "
}

require("telescope").load_extension "file_browser"

lvim.keys.normal_mode["<leader>se"] = ":Telescope file_browser path=%:p:h select_buffer=true<CR>"

-- require('go').setup()

lvim.keys.normal_mode["<leader>sx"] = ":lua require('telescope.builtin').buffers({ sort_lastused = true, ignore_current_buffer = true, sort_mru = true })<CR>"

require("nvim-navic").setup {
  lsp = {
      auto_attach = true,
  },
}
require("typescript-tools").setup {
  settings = {
    -- spawn additional tsserver instance to calculate diagnostics on it
    separate_diagnostic_server = true,
    -- "change"|"insert_leave" determine when the client asks the server about diagnostic
    publish_diagnostic_on = "insert_leave",
    -- array of strings("fix_all"|"add_missing_imports"|"remove_unused"|
    -- "remove_unused_imports"|"organize_imports") -- or string "all"
    -- to include all supported code actions
    -- specify commands exposed as code_actions
    expose_as_code_action = {},
    -- string|nil - specify a custom path to `tsserver.js` file, if this is nil or file under path
    -- not exists then standard path resolution strategy is applied
    tsserver_path = nil,
    -- specify a list of plugins to load by tsserver, e.g., for support `styled-components`
    -- (see 💅 `styled-components` support section)
    tsserver_plugins = {},
    -- this value is passed to: https://nodejs.org/api/cli.html#--max-old-space-sizesize-in-megabytes
    -- memory limit in megabytes or "auto"(basically no limit)
    tsserver_max_memory = "auto",
    -- described below
    tsserver_format_options = {},
    tsserver_file_preferences = {},
    -- locale of all tsserver messages, supported locales you can find here:
    -- https://github.com/microsoft/TypeScript/blob/3c221fc086be52b19801f6e8d82596d04607ede6/src/compiler/utilitiesPublic.ts#L620
    tsserver_locale = "en",
    -- mirror of VSCode's `typescript.suggest.completeFunctionCalls`
    complete_function_calls = false,
    include_completions_with_insert_text = true,
    -- CodeLens
    -- WARNING: Experimental feature also in VSCode, because it might hit performance of server.
    -- possible values: ("off"|"all"|"implementations_only"|"references_only")
    code_lens = "off",
    -- by default code lenses are displayed on all referencable values and for some of you it can
    -- be too much this option reduce count of them by removing member references from lenses
    disable_member_code_lens = true,
    -- JSXCloseTag
    -- WARNING: it is disabled by default (maybe you configuration or distro already uses nvim-ts-autotag,
    -- that maybe have a conflict if enable this feature. )
    jsx_close_tag = {
        enable = false,
        filetypes = { "javascriptreact", "typescriptreact" },
    }
  },
}

-- vim.opt.guicursor = {
--   -- Normal mode
--   'n:block',       -- Block cursor for normal, visual, and command modes
--   -- Insert mode
--   'i:ver25',           -- Vertical bar cursor with 25% width for insert mode
--   -- Replace mode
--   'r:hor20',           -- Horizontal bar cursor with 20% height for replace mode
--   -- Visual mode
--   'v:block',           -- Horizontal bar cursor with 20% height for visual mode
--   -- Command-line mode
--   'c:ver25',           -- Horizontal bar cursor with 20% height for command-line mode
--   -- Select mode
--   'sm:block-blinkwait175-blinkoff150-blinkon175', -- Blinking block cursor for select mode
--   -- More modes and their cursor styles can be added here
-- }

-- require('nvim-cursorline').setup {
--   cursorline = {
--     enable = true,
--     timeout = 0,
--     number = false,
--   },
--   cursorword = {
--     enable = true,
--     min_length = 3,
--     hl = { underline = true }
--   }
-- }


vim.api.nvim_set_keymap('n', 'D-z', 'u', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'D-S-z', '<C-r>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', 'D-z', '<C-o>u', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', 'D-S-z', '<C-o><C-r>', { noremap = true, silent = true })
