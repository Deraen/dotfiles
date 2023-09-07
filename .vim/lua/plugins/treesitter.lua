return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },
    cmd = { 'TSUpdateSync' },
    opts = {
      -- One of "all", "maintained" (parsers with maintainers), or a list of languages
      ensure_installed = {
        "clojure",
        "typescript",
        "html", 
        "markdown",
        "markdown_inline"
      },

      -- Install languages synchronously (only applied to `ensure_installed`)
      -- sync_install = false,

      -- List of parsers to ignore installing
      ignore_install = {},

      highlight = {
        -- `false` will disable the whole extension
        enable = true,

        -- list of language that will be disabled
        disable = {},

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
      },
      incremental_selection = {
        enable = false,
        keymaps = {
          init_selection = "gnn",
          node_incremental = "grn",
          scope_incremental = "grc",
          node_decremental = "grm",
        },
      },
      -- Clojure doesn't support this?
      indent = {
        enable = true,
      },
      -- rainbow = {
      --   enable = {  },
      --   disable = { "clojure" },
      --   -- enable = { "clojure" },
      --   extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
      --   max_file_lines = nil, -- Do not enable for files with more than n lines, int
      --   colors = {
      --     '#d7875f',
      --     '#d75f87',
      --     '#d7d700',
      --     '#5fafff',
      --     '#87d75f'
      --   },
      --   termcolors = {
      --     '204', '179', '146', '72', '225', '113', '75'
      --   }
      -- },
      autotag = {
        enable = true,
      },
      -- matchup = {
      --   enable = true,              -- mandatory, false will disable the whole extension
      --   disable = {  },  -- optional, list of language that will be disabled
      --   -- [options]
      -- },
    },
  },
}
