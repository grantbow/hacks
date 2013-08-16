" local syntax file - set colors on a per-machine basis:
" vim: tw=0 ts=4 sw=4
" Vim color file
" Name: 	grant.vim
" Swiped by:    Grant Bowman 20040312
" Note:		the lack of use of Scrollbar guifg baffles me to no end!
"hi Scrollbar	  guifg=cyan	guibg=gray50
"hi Menu		  guifg=white	guibg=gray50
"
" Original:     koehler
" Maintainer:	Ron Aaron <ronaharon@yahoo.com>
" Last Change:	2003 May 02

" hi clear
set background=dark
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "grant"
hi Normal		  guifg=white  guibg=black
hi SpecialKey	  term=bold cterm=bold ctermfg=darkred ctermbg=darkgrey  guifg=Blue
hi NonText		  term=bold  cterm=bold ctermfg=darkred ctermbg=darkgrey  gui=bold	guifg=Blue
hi Directory	  term=bold  cterm=bold  ctermfg=brown	guifg=Blue
hi ErrorMsg		  term=standout  cterm=bold  ctermfg=grey  ctermbg=blue  guifg=White  guibg=Red
hi Search		  term=reverse  ctermfg=white  ctermbg=red	guifg=white  guibg=Red
hi MoreMsg		  term=bold  cterm=bold  ctermfg=darkgreen	gui=bold  guifg=SeaGreen
hi ModeMsg		  term=bold  cterm=bold  gui=bold  guifg=White	guibg=Blue
"hi LineNr		  term=underline  cterm=bold  ctermfg=darkcyan	guifg=Yellow
hi LineNr         term=underline cterm=bold ctermfg=darkcyan ctermbg=8 guifg=Yellow guibg=DarkGrey
hi Question		  term=standout  cterm=bold  ctermfg=darkgreen	gui=bold  guifg=Green
hi StatusLine	  term=bold  cterm=bold ctermfg=white ctermbg=darkblue gui=NONE guifg=white guibg=darkblue
hi StatusLineNC	  term=bold,reverse cterm=bold  ctermfg=white ctermbg=darkgrey gui=reverse guifg=white guibg=darkblue 
"  Userx ranges from 1-9, not all 16
"hi User1          term=inverse,bold cterm=inverse,bold ctermfg=magenta 
"hi User2          term=inverse,bold cterm=inverse,bold ctermfg=red

hi User1          term=bold cterm=bold ctermfg=magenta ctermbg=darkblue 
hi Ignore         term=reverse  ctermfg=darkcyan  ctermbg=black  guifg=Red  guibg=Black

hi Title		  term=bold  cterm=bold  ctermfg=darkmagenta  gui=bold	guifg=Magenta
hi Visual		  term=reverse  cterm=reverse  gui=reverse
hi Cursor                 guifg=bg      guibg=yellow
hi WarningMsg	  term=standout  cterm=bold  ctermfg=white ctermbg=Red  guifg=Red
hi Comment		  term=bold  cterm=bold ctermfg=cyan  guifg=#80a0ff
hi Constant		  term=underline  cterm=bold ctermfg=magenta  guifg=#ffa0a0
hi Special		  term=bold  cterm=bold ctermfg=red  guifg=Orange
hi Identifier	  term=underline   ctermfg=brown  guifg=#40ffff
hi Statement	  term=bold  cterm=bold ctermfg=yellow  gui=bold  guifg=#ffff60
hi PreProc		  term=underline  ctermfg=darkblue  guifg=#ff80ff
hi Type			  term=underline  cterm=bold ctermfg=lightgreen  gui=bold  guifg=#60ff60
hi Error		  term=reverse  ctermfg=darkcyan  ctermbg=black  guifg=Red  guibg=Black
hi Todo			  term=standout  ctermfg=black  ctermbg=darkcyan  guifg=Blue  guibg=Yellow
hi link IncSearch		Visual
hi link String			Constant
hi link Character		Constant
hi link Number			Constant
hi link Boolean			Constant
hi link Float			Number
hi link Function		Identifier
hi link Conditional		Statement
hi link Repeat			Statement
hi link Label			Statement
hi link Operator		Statement
hi link Keyword			Statement
hi link Exception		Statement
hi link Include			PreProc
hi link Define			PreProc
hi link Macro			PreProc
hi link PreCondit		PreProc
hi link StorageClass	Type
hi link Structure		Type
hi link Typedef			Type
hi link Tag				Special
hi link SpecialChar		Special
hi link Delimiter		Special
hi link SpecialComment	Special
hi link Debug			Special
