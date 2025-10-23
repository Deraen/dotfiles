return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    build = ':TSUpdate',
    -- Officially doesn't support lazy-load though LazyVim does use it?
    lazy = false,
    -- event = { 'BufReadPost', 'BufNewFile' },
    -- cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall" },
    opts_extend = { "ensure_installed" },
    opts = {
      -- One of "all", "maintained" (parsers with maintainers), or a list of languages
      ensure_installed = {
        "clojure",
        "typescript",
        "html",
        "markdown",
        "markdown_inline"
      },
    },
  },
  {
    'windwp/nvim-ts-autotag',
    ft = { 'typescript' }
  },
}
