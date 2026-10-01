" Vim syntax file for Gowin FPGA physical constraints (.cst) files.
" See: Gowin Design Physical Constraints User Guide (SUG935), Appendix A.

if exists("b:current_syntax")
  finish
endif

syntax case match

" Top-level constraint commands
syntax keyword gowinCstCommand IO_LOC IO_PORT INS_LOC GROUP GRP_LOC
syntax keyword gowinCstCommand REL_GROUP INS_RLOC LOC_RESERVE
syntax keyword gowinCstCommand USE_VREF_DRIVER CLOCK_LOC NET_LOC

" Modifiers / enumerated location and fanout keywords
syntax keyword gowinCstKeyword exclusive BUFS LOCAL_CLOCK
syntax keyword gowinCstKeyword CLK CE SR LOGIC
syntax keyword gowinCstKeyword LEFT RIGHT TOPLEFT TOPRIGHT BOTTOMLEFT BOTTOMRIGHT
syntax keyword gowinCstKeyword TOPSIDE BOTTOMSIDE LEFTSIDE RIGHTSIDE
syntax match gowinCstKeyword /\<BUFG\(\[[0-7]\]\)\?\>/
syntax match gowinCstKeyword /\<PLL_[LR]\(\[[0-9]\+\]\)\?\>/

" IO_PORT attribute=value pairs, e.g. IO_TYPE=LVCMOS33
syntax match gowinCstAttribute /\<[A-Z_][A-Z0-9_]*\ze\s*=/

syntax match gowinCstNumber /\<-\?\d\+\(\.\d\+\)\?\>/
syntax match gowinCstLocation /\<[A-Z]\+\d\+\>/
syntax region gowinCstString start=/"/ skip=/\\"/ end=/"/
syntax match gowinCstOperator /[=,;+]/
syntax match gowinCstComment "//.*$"

highlight default link gowinCstCommand   Statement
highlight default link gowinCstKeyword   Keyword
highlight default link gowinCstAttribute Identifier
highlight default link gowinCstNumber    Number
highlight default link gowinCstLocation  Constant
highlight default link gowinCstString    String
highlight default link gowinCstOperator  Operator
highlight default link gowinCstComment   Comment

let b:current_syntax = "gowin_cst"
