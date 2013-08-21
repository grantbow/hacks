" :read +/modeline /usr/share/vim/vimrc - filed followup to http://bugs.debian.org/205501
" :read $VIMRUNTIME/vimrc_example.vim  - filed followup to http://bugs.debian.org/127141
"
" using some of ~/debian/vim-6.2/upstream/tarballs/vim62/runtime/vimrc_example.vim but
" I also want to look at ~/debian/vim-6.2/upstream/tarballs/vim62/runtime/gvimrc_example.vim
" I have merged the settings of the Debian version and Bram's.

" some good ideas are at http://blog.sanctum.geek.nz/vim-annoyances/

" Section: set variables, plugins {{{1
"""""
"""""
"""""

" nocompatible, globals {{{2
"""""
"""""
"""""
" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" set this so all is read correctly
"set encoding=iso-8859-1
set encoding=utf-8

" set line numbering
set number

set notitle

" defaults to keep in mind
"
" Suffixes that get lower priority when doing tab completion for filenames.
" These are files we are not likely to want to edit or read.
"set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc
"
" new default, changed in /etc/vimrc
"set runtimepath=~/.vim,/etc/vim,/usr/share/vim/addons,/usr/share/vim/vim62,~/.vim/after
"
" old default
" runtimepath=~/.vim,/etc/vim,/usr/share/vim/vimfiles,/usr/share/vim/addons,
"             /usr/share/vim/vim62,/usr/share/vim/vimfiles,
"             /usr/share/vim/addons/after,~/.vim/after
" problems?   /usr/share/vim/vim          doesn't exist
"             /usr/share/vim/addons/after doesn't exist
"             /usr/share/vim/vimfiles     symlink to /etc/vim & repeated twice
"

" }}}2

" tabs {{{2
"""""
" automatically expand tabs by default to spaces 
" it seems like this is what I need most anyway      20040408
" to turn off expandtab, use :set noet
set expandtab
" useful with expandtab 20040419
set smarttab
" make defaults explicit
set shiftwidth=4
set tabstop=4
" to convert files with tabs to use 8 spaces, use :retab

" }}}2

" listchars {{{2
"""""
" setup for using the 'list' mode                    20130513
set listchars=eol:$,tab:>-,extends:>,precedes:<,trail:-

" utf-8 charset used system wide now.                20040416
" Files on disk are NOT expecting this.
" 8859-1 would be a better default, however I want to see Euros too.
" Yet I don't think this works since 8859-2 is again different than 8859-15
" system wide utf-8 would be ideal, but this is an aging system with lots of 
" crufty files hanging around that have some value to me.
set fileencodings=latin1
"set fileencoding=      " (lack of 's') used by current buffer

" }}}2

" backups, modelines, undo, hidden {{{2
"""""
set nobackup            " by default, do not keep a backup file (see ~/.vim/filetype.vim)
set modelines=5         " turn on modelines, the security risk isn't dire
set undofile
set undodir=/home/grantbow/.vim/undo/
set hidden              " allow BUFFERS to stay open even when no longer needed

" }}}2

" indent, textwidth, scrolloff {{{2
"""""
set autoindent		" always set autoindenting on
set textwidth=0         " usually used if filetype is not recognized.
set nostartofline       " on pageup, don't go to column 1
set scrolloff=10        " maintain 10 lines of context no matter what
set sidescrolloff=5     " horizontal version
set scrolljump=1        " Minimal number of lines to scroll vertically

" }}}2

" hlsearch, mouse, backspace, virtualedit {{{2
"""""
set hlsearch            " highlight all search matches
set mouse=a
set mousemodel=popup_setpos
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set virtualedit=all     " don't require the cursor to move on real characters.

" from Debian /etc/vimrc
set showcmd             " Show (partial/incomplete) commands in status line.
set showmatch           " Show matching brackets.
set ignorecase          " Do case insensitive matching
set incsearch           " Incremental search
set autowrite           " Automatically save before commands like :next and make
"set confirm            " prompt before exiting (experiment 20040424)

" }}}2

" wildmenu {{{2
"""""
" nice, I don't fully appreciate the subtleties yet
" too bad shift-Tab is only possible on the Amiga per :he, I wonder why...
set wildmenu
set wildmode=list:longest,full " by default it's just full.  I'll try this out now
set wildignore=*.o,*~,*.bak
"set complete=.,b,u,w,t,i,d

" }}}2

" ruler, cmdheight, statusline {{{2
"""""
set ruler		" show the cursor position all the time
set cmdheight=3         " two lines for : mode, command mode
set laststatus=2        " always show a status line
set background=dark     " all my backgrounds are dark now, set early for safety

" turning this back on for eclipse work 20100801
"dagobah filetype plugin on

" my first function 20040417 & 20040516
function ShowModifiedFlag(val)
        if ( &modified == '1' ) && (&buftype != 'nowrite')
                return a:val
        else
                return ''
        endif
endfunction
        "debug line
        "echo "var is" a:var | if ( a:var == 'modified' ) | \
        
        "debug line
        "if (a:var == "modified" ) && (b:buftype != "nowrite" ) && \
        "(&write == "1") | return a:val | else | return '' | endif

        "
        " the trick?  modified is a "option" not a "variable", so use & to access it
        "
" my second function 20040430
function ShowFileFormatFlag(var)
        if ( a:var == 'dos' )
                return '[dos]'
        elseif ( a:var == 'mac' )
                return '[mac]'
        else
                return ''
        endif
endfunction

" show the file name (yellow)
" and vim's filetype (blue) and the current character code (black) all the time.
" use the tricky function to only show the magenta [+] when really modified.
set statusline=%<%3*%f%*\ %2*%y%*%1*%{ShowModifiedFlag('[+]')}%{ShowFileFormatFlag(&fileformat)}%*%2*%r%*%=%8*%-24.(%b%*\ %7*0x%*%8*%B%*%)\ %-24.(%7*col%*\ %v%7*,\ line%*\ %l%)\ %6*%p%*%5*%%%*
"set statusline=%<%f\ %y%1*%m%*%r%=%-24.(%b\ 0x%B%)\ %-14.(%l,%v%)\ %p%%
"set statusline=%<%f\ %y%1*[+]%*%r%=%-24.(%b\ 0x%B%)\ %-14.(%l,%v%)\ %p%%
"                       see ~/.vim/colors/grant.vim for color User1-9 definitions
"  Userx ranges from 1-9, not all 16
hi  User1 term=bold cterm=bold ctermfg=red ctermbg=darkblue
hi  User2 term=NONE cterm=NONE ctermfg=cyan ctermbg=darkblue
hi  User3 term=bold cterm=bold ctermfg=yellow ctermbg=darkblue
"hi  User4 term=NONE cterm=NONE ctermfg=black ctermbg=darkblue
hi  User5 term=bold cterm=bold ctermfg=darkgreen ctermbg=darkblue
hi  User6 term=bold cterm=bold ctermfg=green ctermbg=darkblue
hi  User7 term=NONE cterm=NONE ctermfg=black ctermbg=darkblue
hi  User8 term=bold cterm=bold ctermfg=darkgrey ctermbg=darkblue

" this should move to colors/grant.vim soon
hi StatusLineNC cterm=bold ctermfg=15 ctermbg=8

" http://vim.sourceforge.net/tip_view.php?tip_id=396
highlight WhitespaceEOL ctermbg=red guibg=red
"dagobah match WhitespaceEOL /\v((^\s*)@<!\s)+$/
"/\v^\s\+$/
"/\v(^\s*$)@!\s+$/
"/\s\+$/

" }}}2
       
" history, viminfo, shortmess {{{2
"""""
set history=100		" keep 100 lines of command line history
set viminfo='50,<1000,/100,n~/.vim/viminfo
	" '50		Marks will be remembered for the last 50 files you
	"		edited.
	" <1000		Contents of registers (up to 1000 lines each) will be
	"		remembered.
        "
	" :100		Command-line history omitted, see history variable above
	" %50		The buffer list will save 50 entries unless vim is
        "               started with a file name, then it is not restored.
" WTF!
" file a Debian bug against it.  http://bugs.debian.org/
"
" Error detected while processing /home/grantbow/.vimrc:
" line   60:
" E527: Missing comma: viminfo='50,<1000,%50,/100,n/home/grantbow/.vim/viminfo
" Hit ENTER or type command to continue
"
" see line 4963 of src/option.c for this message.
"
	" n~/.vim/viminfo	The name of the file to use is "~/.vim/viminfo".
	" no /		Since '/' is not specified, the default will be used,
	"		that is, save all of the search history, and also the
	"		previous search and substitute patterns.
	" no h		'hlsearch' highlighting will be restored.

set shortmess="I"
" shortmess default is filnxtToO
" it is a list of flags, see :he 'shm'

" guifont is only for the GTK+ version of vim
"set guifont=Andale\ Mono\ 14
" I chose to set the guifontset in .Xresources to go with other settings.
"set guifontset=-misc-fixed-medium-r-normal-*-*-140-*-*-c-*-iso8859-15

" for plugin tagmenu.vim and taglist.vim
"dagobah let Tmenu_ctags_cmd = 'ctags'
"dagobah let winManagerWindowLayout = 'FileExplorer|TagList'
"dagobah let Tlist_Use_Right_Window = 1
"dagobah let Tlist_Use_SingleClick = 1

" odd, ^D doesn't work for value of cedit.  Using ^V instead for now.
" but ^V was too important to remap over, so trying ^D  20040408
" ^D now pops up the 'command window' from the : prompt
" default is <C-F>
set cedit=<C-F>


" This next variable disables auto-spellcheck.  see :he vimspell
"dagobah let spell_auto_type = ""
"set spellautoEnable=false
" since my machine performance sucks
"dagobah let spell_update_time = 20000

" note: for folding use normal mode zR (reduce) and zM (more)
"                                   zv (view) or movement
"set foldlevelstart=99

" want to set for default behavior
"winheight
"winwidth
set splitright
"set splitbelow     " annoying since help files split to top usually.  I would like
"                   " to splitbelow except for help files - will find a way later.

set grepprg=grep\ -E\ -i\ -n\ $*\ /dev/null " grep integration, see :he :make for details
"dagobah let b:sh_synwrite_au=1                      " turn on ~/.vim/after/ftplugin/  sh_synwrite.vim au's
"dagobah let b:perl_synwrite_au=1                    " turn on ~/.vim/after/ftplugin/perl_synwrite.vim au's
"let b:perl_synwrite_au

" }}}2

" }}}1

" Section: plugins {{{1
"""""
""""" 
"""""

"  vundle - plugin manager {{{2
"""""
""""" vim and git - sounds like a great system to me so I'll take a chance on vundle.
"""""
     "" https://github.com/Shougo/neobundle.vim
     "" Use:
     "" :NeoBundleList          - list configured bundles
     "" :NeoBundleInstall(!)    - install(update) bundles
     "" :NeoBundleClean(!)      - confirm(or auto-approve) removal of unused bundles
     "
     "
     "filetype off
     "if has('vim_starting')
     "   set runtimepath+=~/.vim/bundle/neobundle.vim/
     "endif
     "
     "call neobundle#rc(expand('~/.vim/bundle/'))
     "
     "" Let NeoBundle manage NeoBundle
     "NeoBundleFetch 'Shougo/neobundle.vim'
     "" for git
     "NeoBundle 'tpope/vim-fugitive'
     "" for PHP
     "NeoBundle 'spf13/PIV'
     "" visual undo tree
     "NeoBundle 'mbbill/undotree'
     "" debugging plugins like neobundle ;-)
     "NeoBundle 'bling/minivimrc'
     "" nerdtree
     ""NeoBundle 'scrooloose/nerdtree'
     "
     "" Installation check.
     ""NeoBundleCheck
     "filetype plugin indent on     " required! - run via /etc/vim/vimrc on ubuntu by default
     "
     " undotree

     "" vundle config 
     "filetype off                   " required!
     "set rtp+=~/.vim/bundle/vundle/
     ""call vundle#rc()
     "" let Vundle manage Vundle
     "" required! 
     "Bundle 'gmarik/vundle'
     "" duplicates functionality Bundle 'tpope/vim-pathogen'
     "" My Bundles here:
     ""
     "" original repos on github
     "Bundle 'tpope/vim-fugitive'
     "" for PHP
     "Bundle 'spf13/PIV'
     ""Bundle 'Lokaltog/vim-easymotion'
     ""Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
     ""Bundle 'tpope/vim-rails.git'
     "" vim-scripts repos
     ""Bundle 'L9'
     ""Bundle 'FuzzyFinder'
     "" non github repos
     ""Bundle 'git://git.wincent.com/command-t.git'
     "" git repos on your local machine (ie. when working on your own plugin)
     ""Bundle 'file:///Users/gmarik/path/to/plugin'
     "" ...
     "" visual undo tree
     "Bundle 'mbbill/undotree'
     "" debugging plugins like vundle, neobundle ;-)
     "Bundle 'bling/minivimrc'
     "" nerdtree
     ""NeoBundle 'scrooloose/nerdtree'

     "filetype plugin indent on     " required! - run via /etc/vim/vimrc on ubuntu by default
     ""
     "" Brief help
     "" :BundleList          - list configured bundles
     "" :BundleInstall(!)    - install(update) bundles
     "" :BundleSearch(!) foo - search(or refresh cache first) for foo
     "" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
     ""
     "" see :h vundle for more details or wiki for FAQ
     "" NOTE: comments after Bundle command are not allowed..

" }}}2

" interesting plugin ShowMarks
" use :ShowMarksToggle or \mt to toggle on and off
" http://vim.sourceforge.net/scripts/script.php?script_id=152, see
" highlighting commands below
"  enabled by default for now  20040411
" disabled by default for now  20040512
"dagobah let g:showmarks_enable=0
" which marks to show, left side takes precedence over right side if conflict.
"let g:showmarks_include="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.'`^<>[]{}()\""
"dagobah let g:showmarks_include="'.^[]<>\"01abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ{}()"

" vimirc settings
"dagobah let g:vimirc_nick      ="GrantBow"
"dagobah let g:vimirc_user      ="grant"
"dagobah let g:vimirc_realname  ="Grant"
"dagobah let g:vimirc_server    ="zelazny.freenode.net"
"dagobah let g:vimirc_umode     ="+i"
"dagobah let g:vimirc_autojoin  ="#vim"

" minibufexp.vim - I've been looking for something like this for awhile.
" see also ~/.vim/dl/vimrc-metacosm +101
"dagobah let g:miniBufExplorerMoreThanOne=2   " 0 means always keep it open
"dagobah let g:miniBufExplSplitBelow=1        " display below
"dagobah let g:miniBufExplTabWrap=1           " make tabs show complete (not broken on two lines) fixed with 6.2.3?
"let g:miniBufExplMapWindowNavVim = 1       " C- vim keys move to next buffers (in normal mode)
"let g:miniBufExplMapWindowNavArrows = 1    " C- arrow keys move to next buffers
"let g:miniBufExplMapCTabSwitchBufs = 1     " C- tab and shift-tab move to next buffers
"let g:miniBufExplMapCTabSwitchWindows = 1  " C- tab and shift-tab move to next windows
"map <right> <ESC>:MBEbn<RETURN>     " right arrow (normal mode) switches buffers (excluding minibuf)
"map  <left> <ESC>:MBEbp<RETURN>     "  left arrow (normal mode) switches buffers (excluding minibuf)
"map    <up> <ESC>:Sexplore<RETURN><ESC><C-W><C-W> " up arrow (normal mode) brings up a file list

" The most important variable!
"dagobah let g:SokobanLevelDirectory="/usr/share/doc/vim-scripts/examples/games/VimSokoban/"

" netrw.vim - 
let g:netrw_preview   =  1
let g:netrw_liststyle =  2
let g:netrw_winsize   = 85

" }}}1

" Section: map keys {{{1
"""""
"""""
"""""

" set a mark just before joining lines and jump back there
nnoremap J mzJ`z

" from a cool tips page at http://www.vim.org/tips/tip.php?tip_id=305
" wrap <b></b> around VISUALLY selected Text
vmap sb \"zdi<b><C-R>z</b><ESC>
" wrap <?=   ?> around VISUALLY selected Text
vmap st \"zdi<?= <C-R>z ?><ESC>

" don't show man pages for key under the cursor
nnoremap K <nop>

" Don't use Ex mode, use Q for formatting
map Q gq

" Give all mappings - just like mutt & irssi
map <F1> :map<CR>
" darn gnome intercepts F1
" Help in another screen
" :!xterm vim +help +:only
map <F2> :!screen -t vhelp vim +help +:only<CR>
map <F3> :Sexplore
"dagobah let Grep_Key = '<F4>'
" http://vim.sourceforge.net/tip_view.php?tip_id=36
nnoremap <F5> :exe ":!info ".expand("<cword>")<cr>
map <F6> :set invlist<cr>
map <F7> :Tlist<cr>
map <F8> :!/usr/bin/aspell -c %<cr>


" personal mappings to move around buffers comfortably.
" moving windows, toggling between buffers
"map <M-<> :bprev<CR>
map <M-<> :MBEbp<CR>
"map <M->> :bnext<CR>
map <M->> :MBEbn<CR>
" buffer recall list
map <M-b> :ls!<CR>:buffer

" tag recall list, use CTRL-T (aka :pop) back and C-] follow
map <M-q> :tags<CR>:pop
" jump recall list, use C-o older and C-i new tag
map <M-j> :jumps<CR>
" mark recall list, use ' to recall one
map <M-m> :marks<CR>
" register recall list, use " to use for the next delete, yank or put
" use @ to execute register
map <M-r> :registers<CR>
" There are nine types of registers:                      *registers* *E354*
"   1. The unnamed register             ""
"   2. 10 numbered registers            "0 to "9
"   3. The small delete register        "-
"   4. 26 named registers               "a to "z or "A to "Z
"   5. four read-only registers         ":, "., "% and "#
"   6. the expression register          "=
"   7. The selection and drop registers "*, "+ and "~
"   8. The black hole register          "_
"   9. Last search pattern register     "/
"
"
"
" A similar study of marks is useful to put here as well.
" Showmarks I think has a complete list I can use.
" Each can be called via ` or ' for |exclusive| motion or linewise
"
"let g:showmarks_include="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.'`^<>[]{}()\""
"let g:showmarks_include="'.^[]<>\"01abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ{}()"
"   1.  Last jump or previous m' command |restore-position| given ''
"   2.  Last change made                                          '.
"   3.  Last insert mode stopped                                  '^
"   4.  Yanked or changed text first & last character             '[ ']
"   5.  Visual mode beginning and ending                          '< '>
"   6.  Last exit from current buffer                             '"
"   7.  Numbered marks previous file exit points from .viminfo    '0-'9
"   8.  Lowercase marks valid within the file                     'a-'z
"   9.  Uppercase (file) marks valid between files                'A-'Z
"   10. Object sentence & paragraph beginning & ending            '( ') '{ '}


" make Y default to end of line instead of linewise
map Y y$

" side note, \ is the default <Leader> character

" allow Meta (as well as Ctrl) -] and -T to activate tag jumping
map <M-t> <C-t>
" damn, the M-] isn't responding and
" typing a ] into the file generates an error 'Error: extra ]'
" map <M-]> <C-]>

" allows undo/redo without letting up C- key
nmap <C-u> :undo<CR>
" <C-r> is already nmap :redo<CR>

" quick editing and sourcing of vimrc.
"nmap ,v :e $VIM/_vimrc
"nmap ,s :source $VIM/_vimrc


" remap home & end keys
" so they do home/end of file
" instead of home/end of line - can use ^ and $ instead
"nmap <home> :1go<CR>
"nmap <end> <C-End>
" While I tried it it didn't seem natural after a month - going back 20040408

" }}}1

" Section: abbrev - : command aliases {{{1
"""""
""""" similar to ~/.bash_aliases for bash
"""""

"cabbrev man !info
cabbrev wdiff w !diff -u % -
cabbrev Q! q!
iabbrev :q! <esc>:q!
cabbrev grepdpkg !grepdpkg
cabbrev grepbook !grepbook
cabbrev grepexcuses !grepexcuses
cabbrev grepgnufans !grepgnufans
cabbrev grephurd !grephurd
cabbrev grepgnu !grepgnu
cabbrev grepgroup !grepgroup
cabbrev grepiso !grepiso
cabbrev grepjava !grepjava
cabbrev greposaf !greposaf
cabbrev greptwiki !greptwiki
cabbrev grepvim !grepvim
cabbrev grepwnpp !grepwnpp

if has("unix")
     map ,e :e <C-R>=expand("%:p:h") . "/" <CR>
else
     map ,e :e <C-R>=expand("%:p:h") . "\" <CR>
endif

" }}}1

" Section: term, terminfo, color & autocommands {{{1
"""""
""""" terminals & colors, colors & terminals, oh joy
""""" syntax and most highlighting
"""""

" ttymouse term, terminfo, color {{{2
"""""
""""" all kinds of setup and configuration

set ttymouse=xterm2    " not auto-detected unless $TERM=xterm*, I use $TERM=screen

" now more, let's use 16 colors instead of 8, see :he xfree-xterm
if has("terminfo")
    set t_Co=16
    set t_AB=[%?%p1%{8}%<%t%p1%{40}%+%e%p1%{92}%+%;%dm
    set t_AF=[%?%p1%{8}%<%t%p1%{30}%+%e%p1%{82}%+%;%dm
    " says perhaps 256 colors with :he
    "set t_AB=[48;5;%dm
    "set t_AF=[38;5;%dm
else

    set t_Co=16
    "set t_Sf=[3%dm
    "set t_Sb=[4%dm
endif

"
" Colo(u)red or not colo(u)red
" If you want color you should set this to true
"
let color="true"
"
if has("syntax")
    if color == "true"
	" This will switch colors ON
        syntax enable
	" aka :so ${VIMRUNTIME}/syntax/syntax.vim
    else
	" this switches colors OFF
	set t_Co=0
	syntax off
    endif
endif

" nice color scheme to begin with
colorscheme grant

""""" YES, I FOUND AND REMOVED "hi clear" in ~/.vim/colors/grant.vim

" Switch syntax highlighting on - done in /etc/vim/vimrc
" when the terminal has colors
" Also switch on highlighting the last used search pattern.
"if &t_Co > 2 || has("gui_running")
"  syntax on
"endif
" }}}2

" autocommands and other {{{2
"""""
"""""
"""""

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

" Enable file type detection.     - done in /etc/vim/vimrc
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
" runs $VIMRUNTIME/*/ftplugin.vim - done in /etc/vim/vimrc
"filetype plugin indent on

" Put these in an autocmd group, so that we can delete them easily.
"dagobah augroup vimrcEx
"dagobah         " avoid sourcing this augroup twice by resetting previous loads
"dagobah         "au!
"dagobah 
"dagobah         " For all text files set 'textwidth' to 78 characters.
"dagobah         "autocmd FileType text setlocal textwidth=78
"dagobah 
"dagobah         " When editing a file, always jump to the last known cursor position.
"dagobah         " Don't do it when the position is invalid or when inside an event handler
"dagobah         " (happens when dropping a file on gvim).
"dagobah         autocmd! BufReadPost *
"dagobah           \ if line("'\"") > 0 && line("'\"") <= line("$") |
"dagobah           \   exe "normal g`\"" |
"dagobah           \ endif
"dagobah 
"dagobah augroup end

" Some Debian-specific things from http://bugs.debian.org/219386
" already included in /etc/vimrc
"augroup filetype
"        au BufRead reportbug.*          set ft=mail
"        au BufRead reportbug-*          set ft=mail
"augroup end

" colors for ShowMarks
" colors stolen from the plugin file itself ~/.vim/plugin/showmarks.vim
" since setting them here didn't work, I edited the plugin itself
" maybe we just need an augroup to help in the plugin and here?
"hi ShowMarksHLl ctermfg=Grey ctermbg=black cterm=NONE guifg=Grey guibg=black cterm=NONE
"hi ShowMarksHLu ctermfg=Grey ctermbg=black cterm=NONE guifg=Grey guibg=black cterm=NONE
"hi ShowMarksHLo ctermfg=Grey ctermbg=black cterm=NONE guifg=Grey guibg=black cterm=NONE
"hi ShowMarksHLm ctermfg=Grey ctermbg=black cterm=NONE guifg=Grey guibg=black cterm=NONE

" This is disabled by default in /etc/vim/vimrc so I'm enabling it here.
" It comes straight from :he last-position-jump
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
" }}}2

" }}}1

" ~/.vimrc ends here

" vim:foldmethod=marker:foldcolumn=2:tw=100

