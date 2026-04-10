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
    init = function()
      local highlight = function(bufnr, lang)
        -------------------[ treesitter highlights ]-------------------------------
        if not vim.treesitter.language.add(lang) then
          return vim.notify(
            string.format("Treesitter cannot load parser for language: %s", lang),
            vim.log.levels.INFO,
            { title = "Treesitter" }
          )
        end
        vim.treesitter.start(bufnr)
      end

      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          local ft = vim.bo.filetype
          local bt = vim.bo.buftype
          local buf = args.buf

          if bt ~= "" then
            return
          end -- don't run further.

          local ok, treesitter = pcall(require, "nvim-treesitter")
          if not ok then
            return
          end

          --------------------[ treesitter folds ]-------------------------------

          -- vim.opt_local.foldmethod = "expr"
          -- vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"

          -- vim.schedule(function()
          --   -- Only run normal if we're not in terminal mode
          --   if vim.fn.mode() ~= "t" then
          --     vim.cmd "silent! normal! zx"
          --   end
          -- end)

          ---------------------[ treesitter indent ]-------------------------------

          if not vim.tbl_contains({ "clojure", "python", "html", "yaml", "markdown" }, ft) then
            vim.bo.indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
          end

          --------------------[ treesitter parsers ]-------------------------------
          if vim.fn.executable "tree-sitter" ~= 1 then
            vim.api.nvim_echo({
              {
                "tree-sitter CLI not found. Parsers cannot be installed.",
                "ErrorMsg",
              },
            }, true, {})
            return false
          end

          if not vim.treesitter.language.get_lang(ft) then
            return
          end

          if vim.list_contains(treesitter.get_installed(), ft) then
            highlight(buf, ft)
          elseif vim.list_contains(treesitter.get_available(), ft) then
            treesitter.install(ft):await(function()
              highlight(buf, ft)
            end)
          end
        end,
      })
    end,
    config = function(_, opts)
      local treesitter = require "nvim-treesitter"
      treesitter.setup(opts)
      if vim.fn.executable "tree-sitter" ~= 1 then
        vim.api.nvim_echo({
          {
            "tree-sitter CLI not found. Parsers cannot be installed.",
            "ErrorMsg",
          },
        }, true, {})
        return false
      end
      treesitter.install(opts.install)
    end,
  },
  {
    'windwp/nvim-ts-autotag',
    ft = { 'typescript' }
  },
}
