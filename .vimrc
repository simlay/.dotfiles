"{{{Auto Commands

" Automatically cd into the directory that the file is in
" autocmd BufEnter * execute "chdir ".escape(expand("%:p:h"), ' ')

" Remove any trailing whitespace that is in the file
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

au BufRead,BufNewFile *bash\-fc\-[0-9]\+ setfiletype sh


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
filetype plugin indent on
syntax on
syntax enable
set grepprg=grep\ -nH\ $*
" set tags=~/tags
set tagstack
" set tags=./tags
"set tags=./tags,tags,/Users/simlay/source/xnu-1699.22.81/tags

" Who doesn't like autoindent?
set autoindent

" Spaces are better than a tab character
set expandtab
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

" no backup
set nobackup
set nowritebackup
set noswapfile

" ignore these
" set wildignore=.svn,CVS,.git,.hg
set wildignore+=*.o,*.a,*.class,*.mo,*.la,*.so,*.obj
set wildignore+=*.sw*,*.jpg,*.png,*.xpm,*.gif
set wildignore+=*.pyc,*templates/*.py,*.log


" Enable mouse support in console
"set mouse=a

" Got backspace?
set backspace=2

" Line Numbers PWN!
set number

" Ignoring case is a fun trick
set ignorecase

" And so is Artificial Intellegence!
set smartcase

" This is totally awesome - remap jj to escape in insert mode.  You'll never type jj anyway, so it's great!
inoremap jj <Esc>




"nnoremap JJJJ <Nop>
"
au BufRead,BufNewFile,BufEnter *.py map <leader>r A<CR>import ipdb; ipdb.set_trace()<ESC>

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




if exists('+colorcolumn')
  set colorcolumn=80
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif



set nocompatible              " be iMproved, required
filetype off                  " required

if !isdirectory(expand("~/.vim/plugged"))
    !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
end

call plug#begin('~/.vim/plugged')
" Syntastic"{{{
    "Plugin 'scrooloose/syntastic'
    " au BufRead,BufNewFile,BufEnter *.py let g:syntastic_python_checkers = ['pyflakes', 'pep8']
    "au BufRead,BufNewFile,BufEnter *.js let g:syntastic_javascript_checkers = ['eslint']
    "au BufRead,BufNewFile,BufEnter *.jsx let g:syntastic_javascript_checkers = ['eslint']
"}}}

" Haskell Stuff"{{{
" ghcmod-vim
    " Bundle 'eagletmt/ghcmod-vim'
    " Bundle 'Shougo/vimproc.vim'
    " let g:ghcmod_ghc_options = ['-idir1', '-idir2']


" vim-hdevtools
    " Bundle 'bitc/vim-hdevtools'


" haskellmode-vim
    " Bundle 'lukerandall/haskellmode-vim'
    " let g:haddock_browser = "open"
    " let g:haddock_browser_callformat = "%s %s"
"}}}

" Surround.vim"{{{
    Plug 'tpope/vim-surround'
"}}}


Plug 'pest-parser/pest.vim'
Plug 'reasonml-editor/vim-reason-plus'
"Bundle 'vim-scripts/AutoComplPop'
let javascript_enable_domhtmlcss = 1
let g:jsx_pragma_required = 1
au BufRead,BufNewFile,BufEnter *.js map <leader>r A<CR>debugger;<ESC>
au BufRead,BufNewFile,BufEnter *.js set shiftwidth=2

au BufRead,BufNewFile,BufEnter *.rb map <leader>r A<CR>binding.pry<ESC>
au BufRead,BufNewFile,BufEnter *.rb set shiftwidth=2
" Fuck you
" au BufRead,BufNewFile,BufEnter *.jsx map <leader>r A<CR>debugger;<ESC>
"au BufRead,BufNewFile,BufEnter *.jsx set shiftwidth=2

"Plug 'Lokaltog/vim-easymotion'
Plug 'tpope/vim-fugitive'

" Rust!
Plug 'rust-lang/rust.vim'
Plug 'Shougo/deoplete.nvim'

"Plug 'autozimu/LanguageClient-neovim', {'branch': 'next', 'do': 'make release'}
"let g:LanguageClient_serverCommands = {
"    \ 'rust': ['rust-analyzer'],
"    \ 'python': ['pyls'],
"    \ 'javascript': ['node', '/Users/sebastian/projects/javascript-typescript-langserver/lib/language-server-stdio.js'],
"    \ 'reason': ['/usr/local/bin/ocaml-language-server'],
"    \ }
"
"let g:LanguageClient_rootMarkers = {
"    \ 'javascript': ['project.json'],
"    \ 'rust': ['Cargo.toml'],
"    \ }
"
"nmap <silent> K <Plug>(lcn-hover)
"nmap <silent> gd <Plug>(lcn-definition)
"nmap <silent> <F5> <Plug>(lcn-menu)
"nmap <silent> <F4> <Plug>(lcn-highlight)
"nmap <silent> <F3> <Plug>(lcn-references)
"nmap <silent> <F2> <Plug>(lcn-rename)
"nmap <silent> <F1> <Plug>(lcn-code-lens-action)
"let g:LanguageClient_autoStart = 1
"autocmd FileType python setlocal omnifunc=LanguageClient#complete

" Automatically start language servers.
"let g:LanguageClient_autoStart = 1

Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'

let g:asyncomplete_auto_popup = 0
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_virtual_text_enabled = 0
let g:lsp_log_verbose = 1
let g:lsp_log_file = expand('/tmp/vim-lsp.log')
"let g:asyncomplete_log_file = expand('/tmp/asyncomplete.log')
let g:lsp_hover_ui = 'preview'
let g:lsp_diagnostics_float_cursor = 1
let g:lsp_diagnostics_float_delay = 500
imap <c-space> <Plug>(asyncomplete_force_refresh)

" Go
au User lsp_setup call lsp#register_server({
            \ 'name': 'gopls',
            \ 'cmd': {server_info->['gopls']},
            \ 'allowlist': ['go']
            \ })
autocmd FileType go setlocal omnifunc=lsp#complete

" Javascript and Typescript
au User lsp_setup call lsp#register_server({
            \ 'name': 'javascript-ls',
            \ 'cmd': {server_info->['/home/simlay/projects/javascript-typescript-langserver/lib/language-server-stdio.js']},
            \ 'allowlist': ['javascript']
            \ })

au User lsp_setup call lsp#register_server({
            \ 'name': 'typescript-language-server',
            \ 'cmd': {server_info->['/Users/simlay/.local/share/vim-lsp-settings/servers/typescript-language-server/typescript-language-server', '--stdio']},
            \ 'allowlist': ['typescript']
            \ })
" autocmd FileType javascript setlocal omnifunc=lsp#complete
" autocmd FileType typescript setlocal omnifunc=lsp#complete
au User lsp_setup call lsp#register_server({
            \ 'name': 'vim-language-server',
            \ 'cmd': {server_info->['/home/simlay/.local/share/vim-lsp-settings/servers/vim-language-server/vim-language-server', '--stdio']},
            \ 'allowlist': ['vimscript', 'vim']
            \ })

" Rust
au User lsp_setup call lsp#register_server({
            \ 'name': 'rust-analyzer',
            \ 'cmd': {server_info->['rust-analyzer']},
            \ 'allowlist': ['rust']
            \ })
autocmd FileType rust setlocal omnifunc=lsp#complete

" au User lsp_setup call lsp#register_server({ 'name': 'pylsp', 'cmd': {server_info->['pylsp']}, 'allowlist': ['python'] })
au User lsp_setup call lsp#register_server({ 'name': 'pyright-langserver', 'cmd': {server_info->['pyright-langserver','--stdio']}, 'allowlist': ['python'] })
autocmd FileType go setlocal omnifunc=lsp#complete
setlocal omnifunc=lsp#complete
setlocal signcolumn=yes

" nmap <F5> :LspCodeAction<CR>
nmap <silent> <F6> <plug>(lsp-status)
nmap <silent> <F5> <plug>(lsp-code-action)
nmap <silent> <F4> <plug>(lsp-document-diagnostics)
nmap <silent> <F3> <Plug>(lsp-references)
nmap <silent> <F2> <Plug>(lsp-rename)
nmap <silent> <F1> <Plug>(lsp-code-lens)
nmap <silent> K <Plug>(lsp-hover)
nmap <silent> gd <Plug>(lsp-definition)
nmap <silent> gi <Plug>(lsp-implementation)
nmap <buffer> gc <Plug>(lsp-type-definition)
nmap <buffer> gs <Plug>(lsp-document-symbol-search)
nmap <buffer> gS <Plug>(lsp-workspace-symbol-search)
nmap <buffer> [g <plug>(lsp-previous-diagnostic)
nmap <buffer> ]g <plug>(lsp-next-diagnostic)

highlight lspReference ctermfg=red guifg=red ctermbg=green guibg=green

Plug 'pearofducks/ansible-vim'
Plug 'vim-scripts/applescript.vim'

Plug 'cespare/vim-toml', { 'branch': 'main' }

Plug 'Shougo/denite.nvim'
Plug 'Shougo/deoplete.nvim'

Plug 'scrooloose/nerdtree'

set hidden

" Plug 'pangloss/vim-javascript'
" Plug 'mxw/vim-jsx'

" TagBar "{{{
    " Bundle 'majutsushi/tagbar'
"}}}

" jedi-vim "{{{
    " Bundle 'davidhalter/jedi-vim'
    " let g:jedi#rename_command = "<leader>R"
"}}}

" YouCompleteMe "{{{
    " if has("gui_running")
    "     Bundle 'Valloric/YouCompleteMe'
    " endif
"}}}
"
" CtrlP {{{
    " Plug 'kien/ctrlp.vim'
    " let g:ctrlp_map = '<c-p>'
    " let g:ctrlp_custom_ignore = {
    "   \ 'dir':  '\v[\/]\.(git|hg|svn)$',
    "   \ }
    " let g:ctrlp_max_files = 200000
    " let g:ctrlp_reuse_window = 'netrw'
    " let g:ctrlp_clear_cache_on_exit = 0
    " "let g:ctrlp_switch_buffer = 'e'
    " map <leader>b :CtrlPBuffer<CR>
"}}}


Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

let g:fzf_colors =
            \ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

nmap <c-p> :Files<CR>

if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag --literal --files-with-matches --nocolor --hidden -g "" %s'

  " ag is fast enough that CtrlP doesn't need to cache
  "let g:ctrlp_use_caching = 0

  if !exists(":Ag")
    command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
    nnoremap \ :Ag<SPACE>
  endif
endif


" Rainbow Parens {{{

    Plug 'kien/rainbow_parentheses.vim'

    au VimEnter * RainbowParenthesesToggle
    au Syntax * RainbowParenthesesLoadRound
    au Syntax * RainbowParenthesesLoadSquare
    au Syntax * RainbowParenthesesLoadBraces

    let g:rbpt_colorpairs = [
        \ ['brown',       'RoyalBlue3'],
        \ ['Darkblue',    'SeaGreen3'],
        \ ['darkgray',    'DarkOrchid3'],
        \ ['darkgreen',   'firebrick3'],
        \ ['darkcyan',    'RoyalBlue3'],
        \ ['darkred',     'SeaGreen3'],
        \ ['darkmagenta', 'DarkOrchid3'],
        \ ['brown',       'firebrick3'],
        \ ['gray',        'RoyalBlue3'],
        \ ['darkmagenta', 'DarkOrchid3'],
        \ ['Darkblue',    'firebrick3'],
        \ ['darkgreen',   'RoyalBlue3'],
        \ ['darkcyan',    'SeaGreen3'],
        \ ['darkred',     'DarkOrchid3'],
        \ ['red',         'firebrick3'],
        \ ]

" }}}

Plug 'ekalinin/Dockerfile.vim'
Plug 'isRuslan/vim-es6'
Plug 'moll/vim-node'
Plug 'elzr/vim-json'
Plug 'fatih/vim-go'
Plug 'nsf/gocode', {'rtp': 'nvim/'}
Plug 'editorconfig/editorconfig-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'vim-ruby/vim-ruby'
Plug 'keith/swift.vim'


" Plug 'ternjs/tern_for_vim'
" autocmd BufReadPost *.{js,coffee} nnoremap <buffer> K :TernDoc<CR>
" autocmd BufReadPost *.{js,coffee} nmap \td :TernDef<CR>
" autocmd BufReadPost *.{js,coffee} nmap \tt :TernType<CR>
" autocmd BufReadPost *.{js,coffee} nmap \tf :TernRefs<CR>
" autocmd BufReadPost *.{js,coffee} nmap \tr :TernRename<CR>

"Plug 'heavenshell/vim-jsdoc'


" All of your Plugs must be added before the following line
call plug#end()

filetype plugin indent on    " required
