-- Autopairs config for cmp
-- If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)

-- Disable autopair ' for clojure
local npairs = require('nvim-autopairs')
local cond = require('nvim-autopairs.conds')
local basic = require('nvim-autopairs.rules.basic')

npairs.setup {}
npairs.get_rules("'")[1].not_filetypes = { "clojure" }
npairs.get_rules("'")[1]:with_pair(cond.not_after_text("["))

local opt = require('nvim-autopairs').config
-- Add ( even if there is end ) already
opt.enable_check_bracket_line = false
npairs.add_rules({
  basic.bracket_creator(opt)("(", ")",{"clojure", "lisp"})
    :with_pair(cond.not_after_regex([=[[%w%%%'%[%"%.%`%$%+%-%/%*]]=])),
  basic.bracket_creator(opt)("{", "}",{"clojure", "lisp"})
    :with_pair(cond.not_after_regex([=[[%w%%%'%[%"%.%`%$%+%-%/%*]]=])),
  basic.bracket_creator(opt)("[", "]",{"clojure", "lisp"})
    :with_pair(cond.not_after_regex([=[[%w%%%'%[%"%.%`%$%+%-%/%*]]=]))
})

-- turn off the original rule for clojure and lisp
npairs.get_rule("(")[1].not_filetypes = {"clojure",  "lisp" }
npairs.get_rule("{")[1].not_filetypes = {"clojure",  "lisp" }
npairs.get_rule("[")[1].not_filetypes = {"clojure",  "lisp" }
