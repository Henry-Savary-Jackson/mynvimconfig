local ls = require "luasnip"

local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require "luasnip.util.types"
local conds = require "luasnip.extras.expand_conditions"

ls.add_snippets("tex", {

  s("note-template", {
    t {
      "\\documentclass{article}",
      "",
      "\\usepackage{amsmath}",
      "\\title{",
    },
    i(1),
    t { "}", "\\author{Henry Savary-Jackson}", "", "\\begin{document}", "    \\maketitle", "", "\\end{document}" },
  }),

  s("cos", { t "\\cos(", i(1), t ")" }),
  s("sin", { t "\\sin(", i(1), t ")" }),
  s("tan", { t "\\tan(", i(1), t ")" }),
  s("cot", { t "\\cot(", i(1), t ")" }),
  s("sec", { t "\\sec(", i(1), t ")" }),
  s("csc", { t "\\csc(", i(1), t ")" }),

  s("delta", { t "\\delta" }),
  s("theta", { t "\\theta" }),
  s("alpha", { t "\\alpha" }),
  s("pi", { t "\\pi" }),

  s("implies", { t "\\iff" }),
  s("equiv", { t "\\equiv" }),
  s("<", { t "\\lt" }),
  s(">", { t "\\gt" }),
  s(">=", { t "\\ge" }),
  s("<=", { t "\\le" }),
  s("!=", { t "\\ne" }),

  s("inf", { t "\\infty" }),
  s("Real", { t "\\Re" }),
  s("in", { t "\\in" }),
  s("union", { t "\\cup" }),
  s("inters", { t "\\cap" }),
  s("sset", { t "\\subset" }),
  s("psset", { t "\\subseteq" }),
  s("nil", { t "\\emptyset" }),

  s("lim", { t "\\lim_{", i(1), t "\\to", i(2), t "}" }),
  s("liminf", { t "\\lim_{", i(1), t "\\to \\infty", t "}" }),
  s("int", { t "\\int_{", i(1), t "}^{", i(2), t "}" }),
  s("iint", { t "\\int" }),
  s("sum", { t "\\sum_{", i(1), t "}^{", i(2), t "}" }),
  s("sum", { t "\\sum_{", i(1), t "}^{\\infty}" }),
  s("dx", { t "\\frac{", i(2), t "}{dx}" }),

  s("log", { t "\\log_{", i(1), t "}", i(2) }),
  s("ln", { t "\\ln_{", i(1), t "}" }),
  s("^", { t "^{", i(1), t "}" }),
  s("root", { t "\\sqrt[", i(1), t "]{", i(2), t "}" }),
  s("sqrt", { t "\\sqrt{", i(1), t "}" }),
  s("%", { t "\\mod" }),
  s("xx", { t "\\times" }),
  s("ff", { t "\\frac{", i(1), t "}{", i(2), t "}" }),

  s("equs", { t { "\\begin{align}", " " }, i(1), t { " ", "\\end{align}" } }),
  s("dm", { t { "\\begin{gather*}", " " }, i(1), t { " ", "\\end{gather*}" } }),
  s("im", { t "$", i(1), t "$" }),

  s("cases", { t { "\\begin{cases}", " " }, i(1), t "&", i(2), t { " ", "\\end{cases}" } }),
  s("circ", { t "\\circ" }),

  s("vec", { t "\\vec{", i(1), t "}" }),
  s("hat", { t "\\hat{", i(1), t "}" }),
  s("dot", { t "\\cdot" }),

  s("_", { t "_{", i(1), t "}" }),
  s("|", { t "\\vert ", i(1), t " \\vert" }),
})
