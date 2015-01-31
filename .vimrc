" vim startup file of Amos Elliston

set vb		                        " visual Bell
set nocp	                        " use vim defaults, not vi ones
set bs=2	                        " smart backspace in insert mode
set dg		                        " use digraphs
set fo+=r	                        " auto-format comments while typing
set com-=:%	                      " '%' doesn't start comments
set hls		                        " highlight search pattern matches
set nojs	                        " join lines with only one space
set kp=		                        " no external help system
set mps+=<:>	                    " make % work with <>
set mls=1	                        " check one line for modelines
set nf-=octal	                    " ctrl-a doesn't increment octal numbers
set sb		                        " open new windows below the current one
set shm=a	                        " use the shortest messages
set sc		                        " show commands being typed
set sm		                        " show matching brackets when typing
set su+=.class	                  " skip Java class files for filename completion
set su-=.h	                      " but not C header files
set tw=150	                      " automatic line wrap 100 cols
set ul=200	                      " maximum number of forgiveable mistakes
set ai si ts=2 sts=2 sw=2 et      " default indent / tabs settings
set sbr=$ lcs=tab:!-,trail:~ wrap " list mode and non-text characters
set nodigraph
set history=1000
set pa=.,/etc,~,, cd=,,.,~	      " where to search for files and paths
set ls=2                          " always show status line
set tags=~/TAGS                   " tags
set suffixesadd=.rb,.rhtml        " suffixes for find
"set bg=dark                       " dark background
set bg=light                      " light background
set incsearch                     " incremental search
set scs		                        " smart case in search patterns when 'ignorecase' is on
set ignorecase                    " ignore case while searching
"set hidden                        " hide unwritten buffers

let mapleader = "," " hmmm... testing

if has('statusline')
    " status line detail:
    " %f		file path
    " %y		file type between braces (if defined)
    " %([%R%M]%)	read-only, modified and modifiable flags between braces
    " %{'!'[&ff=='default_file_format']}
    "			shows a '!' if the file format is not the platform
    "			default
    " %{'$'[!&list]}	shows a '*' if in list mode
    " %{'~'[&pm=='']}	shows a '~' if in patchmode
    " (%{synIDattr(synID(line('.'),col('.'),0),'name')})
    "			only for debug : display the current syntax item name
    " %=		right-align following items
    " #%n		buffer number
    " %l/%L,%c%V	line number, total number of lines, and column number
    function! SetStatusLineStyle()
      if &stl == '' || &stl =~ 'synID'
        let &stl="%F %y%([%R%M]%)%{'!'[&ff=='".&ff."']}%{'$'[!&list]}%{'~'[&pm=='']}%=#%n %l/%L,%c %{fugitive#statusline()} "
      else
        let &stl="%F %y%([%R%M]%)%{'!'[&ff=='".&ff."']}%{'$'[!&list]} (%{synIDattr(synID(line('.'),col('.'),0),'name')})%=#%n %l/%L,%c"
      endif
    endfunc

    " switch between the normal and vim-debug modes in the status line
    call SetStatusLineStyle()

    " window title
    if has('title')
		  set titlestring=%t%(\ [%R%M]%)
    endif
endif

" highlighting 
hi Search ctermbg=yellow ctermfg=black
syntax on
filetype plugin indent on

" map visual functions for html things
vmap sb "zdi<strong><C-R>z</strong><ESC>
vmap si "zdi<i><C-R>z</i><ESC>
vmap s" "zdi"<C-R>z"<ESC>
vmap s' "zdi'<C-R>z'<ESC>
vmap sf "zy:find <C-R>z<CR> 
vmap s} "zdi->{'<C-R>z'}<ESC>

" do a search on everything that matches the currently selected area
vmap * y:let@/=@"<CR>n

" no search highlight
nnoremap <Leader>n :noh<CR>

" source current file
nnoremap <Leader>ss :source %<CR>

" execute current file
nnoremap <Leader>xx :!./%<CR>

" start a newline in insert mode
nnoremap <Leader>o o<ESC>

" refresh file
nnoremap <f5> :e %<CR>

" edit this file
nnoremap <Leader>vv :sp ~/.vimrc<CR>

" edit scratch file
nnoremap <Leader>sc :set paste<CR>:e ~/scratch<CR>

" erase whole file
nnoremap <F10> ggdG             

" mappings for windows
nnoremap <Leader>wt :FirstExplorerWindow<cr>
nnoremap <Leader>ww :WMToggle<cr> 
nnoremap <Leader>wb :BottomExplorerWindow<cr>
nnoremap <Leader>wl <c-w>l
nnoremap <Leader>wk <c-w>k<c-w>c
nnoremap <Leader>wj <c-w>j<c-w>c
nnoremap <Leader>wc <c-w>c
nnoremap <Leader>wo <c-w>c:WMToggle<cr>
nnoremap <Leader>ee :Explore<cr>
nnoremap <Leader>es :Sexplore<cr>

nnoremap <Leader>ll :set invnumber<CR>

nnoremap <f6> :set paste<CR>
nnoremap <f7> :set nopaste<CR>

" paste
nnoremap <Leader>7 :set paste<CR>
nnoremap <Leader>8 :set nopaste<CR>

" http://vim.wikia.com/wiki/VimTip1142
nnoremap . .`[

nnoremap <Leader>as :AS<CR>
nnoremap <Leader>aa :A<CR>

" redefine Y to be more intuitive
nnoremap Y y$

nnoremap <C-J> <C-]>

" break the current line after the cursor
nnoremap <F3> a<CR><Esc>

nnoremap <F6> :set paste<CR>
nnoremap <F7> :set nopaste<CR>

" suppress all empty lines
nnoremap _em :g/^$/d<CR>

" change directory to the one of the current file
nnoremap _h :lcd%:p:h<CR>
nnoremap _H :cd%:p:h<CR>

" don't use the command-line window
nnoremap q: :q

" suppress all spaces at end/beginning of lines
nnoremap _s :%s/\s\+$//<CR>
nnoremap _S :%s/^\s\+//<CR>

" convert file format to unix
nnoremap <Leader>ux :se ff=unix<CR>

" execute current line as a vim command
nnoremap <Leader>xx "xyy:@x<CR>

nnoremap  i<CR><Esc>

imap  [C
imap  [A
imap <C-J> [B
imap <C-B> [D

" fix common typos and other abbreviations
iab varibale variable
iab varibales variables
iab pritn print
iab pirnt print
iab serach search
iab boolena boolean

" change directories when enterring a file
"autocmd BufEnter * silent! lcd %:p:h

" set filetype mappings
autocmd BufEnter *inc      set filetype=php
autocmd BufEnter *mas      set filetype=mason
autocmd BufEnter *xmi      set filetype=xpp
autocmd BufEnter *tt2      set filetype=tt2html
autocmd BufEnter *xpml     set filetype=xpp
autocmd BufEnter *\.t      set filetype=perl
autocmd BufEnter *\.txt    set filetype=help
autocmd BufEnter *\.pm     set tw=100
autocmd BufEnter *\.xmi    set tw=100
autocmd BufEnter *\.conf   set filetype=perl 
autocmd BufEnter *\.liquid set filetype=liquid 
autocmd BufEnter *\.md     set filetype=markdown 
autocmd BufEnter *\.rc     set filetype=sh 
autocmd BufEnter *\.lookml set filetype=yaml
autocmd BufEnter *\.scss.erb set filetype=scss.css
autocmd BufEnter *\.css.erb set filetype=css

" execute code
autocmd BufEnter *.py   nmap <Leader>xx :!python %<CR>
autocmd BufEnter *.rb   nmap <Leader>xx :!ruby %<CR>
autocmd BufEnter *.rake set filetype=ruby
autocmd BufEnter *.sql  set nowrap
autocmd BufEnter *.slim set tw=0

" whitespace
autocmd BufWritePre *.rb :%s/\s\+$//e
autocmd BufWritePre *.slim :%s/\s\+$//e
autocmd BufWritePre *.rake :%s/\s\+$//e
autocmd BufWritePre *.js :%s/\s\+$//e
autocmd BufWritePre *.erb :%s/\s\+$//e

" plugin settings
let Tlist_Show_One_File      = 1
let g:winManagerWindowLayout = 'TagList,FileExplorer'
let loaded_matchparen        = 1
let Tlist_Ctags_Cmd          = 'ctags'
let VCSCommandEdit           = 'edit'
let VCSCommandDeleteOnHide   = 1
let g:netrw_keepdir	         = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" folding
"    enable folding, but by default make it act like folding is off,
"    because folding is annoying in anything but a few rare cases
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set foldenable " Turn on folding
set foldmethod=indent " Make folding indent sensitive
set foldlevel=100 " Don't autofold anything (but I can still fold manually)
set foldopen-=search " don't open folds when you search into them
set foldopen-=undo " don't open folds when you undo stuff

" fuzzy finder
nnoremap <Leader>ff :FufFile **/<CR>

" pathogen
call pathogen#infect() 

" escape mode for vim
:imap jk <Esc>
:imap jj <Esc>

" markdown preview
imap <F8> <ESC>:w!<CR>:!rdiscount % > /tmp/%.html && open /tmp/%.html<CR><CR>a
map <F8> :w!<CR>:!rdiscount % > /tmp/%.html && open /tmp/%.html<CR><CR>

" gists
let g:gist_open_browser_after_post = 1
let g:gist_clip_command = 'pbcopy'

" open quickfix after all greps
autocmd QuickFixCmdPost *grep* cwindow

" nice newlines
map <Leader>o o<Esc>
map <Leader>O O<Esc>

" nerd tree
map <C-n> :NERDTreeToggle<CR>
map <C-h> :NERDTreeFind<CR>

" rspec
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

" open file in chrome
nmap <silent> <leader>w :exec 'silent !/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome %'<CR>

" ctags in ctrlp
nnoremap <leader>. :CtrlPTag<cr>

" tests
nnoremap <leader>um :.Rake<cr>
nnoremap <leader>uu :Rake<cr>
nnoremap <leader>ua :A<cr>
nnoremap <leader>us :AS<cr>
