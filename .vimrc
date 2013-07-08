"{{{Auto Commands

" Automatically cd into the directory that the file is in
" autocmd BufEnter * execute "chdir ".escape(expand("%:p:h"), ' ')

" Remove any trailing whitespace that is in the file
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

" Restore cursor position to where it was before
augroup JumpCursorOnEdit
   au!
   autocmd BufReadPost *
            \ if expand("<afile>:p:h") !=? $TEMP |
            \   if line("'\"") > 1 && line("'\"") <= line("$") |
            \     let JumpCursorOnEdit_foo = line("'\"") |
            \     let b:doopenfold = 1 |
            \     if (foldlevel(JumpCursorOnEdit_foo) > foldlevel(JumpCursorOnEdit_foo - 1)) |
            \        let JumpCursorOnEdit_foo = JumpCursorOnEdit_foo - 1 |
            \        let b:doopenfold = 2 |
            \     endif |
            \     exe JumpCursorOnEdit_foo |
            \   endif |
            \ endif
   " Need to postpone using "zv" until after reading the modelines.
   autocmd BufWinEnter *
            \ if exists("b:doopenfold") |
            \   exe "normal zv" |
            \   if(b:doopenfold > 1) |
            \       exe  "+".1 |
            \   endif |
            \   unlet b:doopenfold |
            \ endif
augroup END

"}}}

"{{{Misc Settings

" Necesary  for lots of cool vim things
set nocompatible
set t_Co=256  " for mofo'ing 256 colors.
set magic
vnoremap < <gv
vnoremap > >gv
" noremap <silent><Leader>/ :nohls<CR>
" nnoremap / /\v



" This shows what you are typing as a command.  I love this!
set showcmd

" Folding Stuffs
set foldmethod=marker

" Needed for Syntax Highlighting and stuff
filetype off
filetype plugin on
syntax enable
set grepprg=grep\ -nH\ $*
" set tags=~/tags
set tagstack
set tags=./tags,tags,/Users/simlay/source/xnu-1699.22.81/tags

" Who doesn't like autoindent?
set autoindent

" Spaces are better than a tab character
" set expandtab
set smarttab

" Who wants an 8 character tab?  Not me!
set shiftwidth=4
"set softtabstop=4

" display tabs and trailing whitespace
"set list
set listchars=tab:⇥·,trail:·
match Error /\v\s+$/        " use the Error colors for trailing whitespace


" indents
set cindent
set autoindent
set indentkeys-=0#      " do not break indent on #
set tabstop=4

"set cursorline          " highlight the cursor line
set showmatch           " highlight block ends


" Use english for spellchecking, but don't spellcheck by default
if version >= 700
   set spl=en spell
   set nospell
endif

" Real men use gcc
"compiler gcc

" Cool tab completion stuff
set wildmenu
set wildmode=list:longest,full

" Enable mouse support in console
set mouse=a

" Got backspace?
set backspace=2

" Line Numbers PWN!
set number

" Ignoring case is a fun trick
set ignorecase

" And so is Artificial Intellegence!
set smartcase

" This is totally awesome - remap jj to escape in insert mode.  You'll never type jj anyway, so it's great!
"inoremap jj <Esc>

"nnoremap JJJJ <Nop>
map <leader>r A<CR>import ipdb; ipdb.set_trace()<ESC>

" Incremental searching is sexy
set incsearch

" Highlight things that we find with the search
set hlsearch

" Since I use linux, I want this
let g:clipbrdDefaultReg = '+'

" When I close a tab, remove the buffer
set nohidden

" Set off the other paren
highlight MatchParen ctermbg=4
" }}}

"{{{Look and Feel

" Favorite Color Scheme
if has("gui_running")
   colorscheme xoria256
   " Remove Toolbar
   set guioptions-=T
else
   "colorscheme default
   colorscheme xoria256
   set nonumber
endif

"Status line gnarliness
set laststatus=2
set statusline=%F%m%r%h%w\ (%{&ff}){%Y}\ [%l,%v][%p%%]

" }}}

"{{{ Functions


"{{{Theme Rotating
let themeindex=0
function! RotateColorTheme()
   let y = -1
   while y == -1
      let colorstring = "inkpot#ron#blue#elflord#evening#koehler#murphy#pablo#desert#torte#"
      let x = match( colorstring, "#", g:themeindex )
      let y = match( colorstring, "#", x + 1 )
      let g:themeindex = x + 1
      if y == -1
         let g:themeindex = 0
      else
         let themestring = strpart(colorstring, x + 1, y - x - 1)
         return ":colorscheme ".themestring
      endif
   endwhile
endfunction
" }}}


"{{{ Write a session.
function! Wsession()
	return ":mksession! ~/.vim/mysession.vim"
endfunction
"}}}


"{{{ Load Session
function! Lsession()
	return ":mksession! ~/.vim/mysession.vim"
endfunction
"}}}

"}}}

"{{{ Mappings

" Open the TagList Plugin <F3>
nnoremap <silent> <F3> :Tlist<CR>

" New Tab
" nnoremap <silent> <C-t> :tabnew<CR>

" Rotate Color Scheme <F8>
nnoremap <silent> <F8> :execute RotateColorTheme()<CR>

" DOS is for fools.
nnoremap <silent> <F9> :%s/$//g<CR>:%s// /g<CR>

" Edit vimrc \ev
nnoremap <silent> <Leader>ev :tabnew<CR>:e ~/.vimrc<CR>
" cmap W w

" Up and down are more logical with g..
nnoremap <silent> k gk
nnoremap <silent> j gj
inoremap <silent> <Up> <Esc>gka
inoremap <silent> <Down> <Esc>gja

" Good call Benjie (r for i)
nnoremap <silent> <Home> i <Esc>r
nnoremap <silent> <End> a <Esc>r

" Create Blank Newlines and stay in Normal mode
nnoremap <silent> zj o<Esc>
nnoremap <silent> zk O<Esc>

" Space will toggle folds!
nnoremap <space> za

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
map N Nzz
map n nzz

" vnoremap <silent> <Leader> '<,'>w !cat | tmux load-buffer - <CR>

" Testing
set completeopt=longest,menuone,preview

" Swap ; and :  Convenient.
nnoremap ; :
vnoremap ; :
" nnoremap : ;

" Fix email paragraphs
nnoremap <leader>par :%s/^>$//<CR>

"ly$O#{{{ "lpjjj_%A#}}}jjzajj

" Make the cmd more like bash.
cnoremap <C-a>  <Home>
cnoremap <C-b>  <Left>
cnoremap <C-f>  <Right>
cnoremap <C-d>  <Delete>
cnoremap <M-b>  <S-Left>
cnoremap <M-f>  <S-Right>
cnoremap <M-d>  <S-right><Delete>
cnoremap <Esc>b <S-Left>
cnoremap <Esc>f <S-Right>
cnoremap <Esc>d <S-right><Delete>
cnoremap <C-g>  <C-c>

" Bindings for backslash.
nmap \l :setlocal number!<CR>
nmap \o :set paste!<CR>
nmap \q :nohlsearch<CR>
nmap \M :set noexpandtab tabstop=8 softtabstop=4 shiftwidth=4<CR>
nmap \m :set expandtab tabstop=2 shiftwidth=2 softtabstop=2<CR>
nmap \L :set list!<CR>

"}}}

"{{{Taglist configuration
let Tlist_Use_Right_Window = 1
let Tlist_Enable_Fold_Column = 0
let Tlist_Exit_OnlyWindow = 1
let Tlist_Use_SingleClick = 1
let Tlist_Inc_Winwidth = 0
"}}}


filetype plugin indent on
syntax on



if exists('+colorcolumn')
  set colorcolumn=80
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif


" CtrlP Options
let g:ctrlp_map = '<leader>t'
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_max_files = 200000
let g:ctrlp_clear_cache_on_exit = 0
"map <leader>b :CtrlPBuffer<CR>
let g:syntastic_python_checkers = ['pyflakes']

" Vundle setup
if !isdirectory(expand("~/.vim/bundle/vundle/.git"))
	!git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
endif

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'kien/rainbow_parentheses.vim'
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-surround'
Bundle 'vim-scripts/AutoComplPop'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'tpope/vim-fugitive'
Bundle 'kien/ctrlp.vim'

if has("gui_running")
    Bundle 'Valloric/YouCompleteMe'
endif
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
execute pathogen#infect()

